program main
   use iso_c_binding
   use iso_fortran_env, only: real64, real32
   use pic_device
   use pic_gpu_runtime
   implicit none

   type(pic_device_type) :: device_info
   integer(c_int) :: device_count, ierr
   integer :: failures = 0

   write (*, '(A,A)') "backend: ", backend_name()
   call backend_get_device_count(device_count, ierr)
   call ck(ierr, "get_device_count")
   write (*, '(A,I0)') "device count: ", device_count
   if (device_count <= 0) then
      write (*, '(A)') "no devices -- skipping the runtime exercise"
      stop
   end if

   call device_info%get_device_info()
   write (*, '(A)') to_string(device_info)
   write (*, '(A)') ""

   call exercise_runtime()

   write (*, '(A)') ""
   if (failures == 0) then
      write (*, '(A)') "all runtime checks passed"
   else
      write (*, '(A,I0)') "FAILURES: ", failures
      error stop 1
   end if

contains

   subroutine ck(ierr, what)
      integer(c_int), intent(in) :: ierr
      character(*), intent(in) :: what
      if (ierr /= BACKEND_SUCCESS) then
         write (*, '(A,A,A,I0,A,A)') "  [FAIL] ", what, " (", ierr, "): ", &
            backend_error_string(ierr)
         failures = failures + 1
      else
         write (*, '(A,A)') "  [ ok ] ", what
      end if
   end subroutine ck

   subroutine okay(cond, what)
      logical, intent(in) :: cond
      character(*), intent(in) :: what
      if (cond) then
         write (*, '(A,A)') "  [ ok ] ", what
      else
         write (*, '(A,A)') "  [FAIL] ", what
         failures = failures + 1
      end if
   end subroutine okay

   subroutine exercise_runtime()
      integer, parameter :: n = 4096
      real(real64), allocatable :: host(:), back(:)
      real(real64), pointer :: pinned(:)
      type(c_ptr) :: dev = c_null_ptr, hostp = c_null_ptr
      type(c_ptr) :: stream = c_null_ptr, e0 = c_null_ptr, e1 = c_null_ptr
      real(real32) :: ms
      integer :: i

      allocate (host(n), back(n))
      do i = 1, n
         host(i) = real(i, real64)*0.25_real64
      end do
      back = -1.0_real64

      write (*, '(A)') "device memory:"
      call backend_malloc(dev, int(n, c_size_t)*8_c_size_t, ierr)
      call ck(ierr, "malloc")
      call backend_copy_to_device(dev, host, ierr)
      call ck(ierr, "copy_to_device (size from the array)")
      call backend_copy_to_host(back, dev, ierr)
      call ck(ierr, "copy_to_host")
      call okay(all(abs(back - host) < 1.0e-15_real64), "round trip preserved data")

      call backend_memset(dev, 0_c_int, int(n, c_size_t)*8_c_size_t, ierr)
      call ck(ierr, "memset")
      call backend_copy_to_host(back, dev, ierr)
      call okay(all(back == 0.0_real64), "memset zeroed the buffer")

      write (*, '(A)') "pinned host memory:"
      call backend_malloc_host(hostp, int(n, c_size_t)*8_c_size_t, ierr)
      call ck(ierr, "malloc_host")
      call c_f_pointer(hostp, pinned, [n])
      pinned = 7.5_real64

      write (*, '(A)') "streams and async transfer:"
      call backend_stream_create(stream, ierr, BACKEND_STREAM_NON_BLOCKING)
      call ck(ierr, "stream_create(non-blocking)")
      call backend_memcpy_async(dev, hostp, int(n, c_size_t)*8_c_size_t, &
                                BACKEND_MEMCPY_HOST_TO_DEVICE, stream, ierr)
      call ck(ierr, "memcpy_async H2D")
      call backend_stream_synchronize(stream, ierr)
      call ck(ierr, "stream_synchronize")
      call backend_copy_to_host(back, dev, ierr)
      call okay(all(back == 7.5_real64), "async transfer landed")

      write (*, '(A)') "events:"
      call backend_event_create(e0, ierr); call ck(ierr, "event_create")
      call backend_event_create(e1, ierr)
      call backend_event_record(e0, ierr, stream)
      call backend_memset_async(dev, 1_c_int, int(n, c_size_t)*8_c_size_t, stream, ierr)
      call ck(ierr, "memset_async")
      call backend_event_record(e1, ierr, stream)
      call backend_event_synchronize(e1, ierr); call ck(ierr, "event_synchronize")
      call backend_event_elapsed_time(ms, e0, e1, ierr)
      call ck(ierr, "event_elapsed_time")
      call okay(ms >= 0.0_real32, "elapsed time is non-negative")
      write (*, '(A,F8.4,A)') "         measured ", ms, " ms"

      write (*, '(A)') "teardown:"
      call backend_event_destroy(e0, ierr)
      call backend_event_destroy(e1, ierr); call ck(ierr, "event_destroy")
      call backend_stream_destroy(stream, ierr); call ck(ierr, "stream_destroy")
      call backend_free_host(hostp, ierr); call ck(ierr, "free_host")
      call backend_free(dev, ierr); call ck(ierr, "free")
      call backend_free(dev, ierr); call ck(ierr, "free is idempotent on null")
      call backend_synchronize(ierr); call ck(ierr, "device synchronize")
      call backend_get_last_error(ierr); call ck(ierr, "no sticky error left behind")

      deallocate (host, back)
   end subroutine exercise_runtime

end program main
