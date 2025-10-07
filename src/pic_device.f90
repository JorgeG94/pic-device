module pic_device
   use iso_c_binding
   use iso_fortran_env, only: real64
   use pic_gpu_runtime, only: backend_meminfo, backend_get_device, backend_get_device_count
   implicit none

   type :: pic_device_type
      real(real64) :: free_mb = 0.0_real64
      real(real64) :: total_mb = 0.0_real64
      real(real64) :: used_mb = 0.0_real64
      integer(c_int) :: device_id = -1_c_int
   contains
      procedure, non_overridable :: get_device_info => get_gpu_information
   end type pic_device_type

   interface to_string
      procedure :: to_string_device
   end interface

contains

   subroutine get_gpu_information(self)
      class(pic_device_type), intent(inout) :: self

      call get_gpu_memory_info(self)
      call get_device_id(self)

   end subroutine get_gpu_information

   function to_string_device(self) result(str)
      class(pic_device_type), intent(in) :: self
      character(len=:), allocatable :: str
      character(len=100) :: temp_str
      integer :: total_len

      total_len = len("Device ID:   ") + 6 + &
                  len("Free memory: ") + 20 + &
                  len("Total memory:") + 20 + &
                  len("Used memory: ") + 20 + 3*len(new_line('a'))

      allocate (character(len=total_len) :: str)

      write (temp_str, '(I0)') self%device_id
      str = "Device ID:   "//trim(temp_str)//new_line('a')

      write (temp_str, '(F10.2)') self%free_mb
      str = str//"Free memory: "//trim(adjustl(temp_str))//" MB"//new_line('a')

      write (temp_str, '(F10.2)') self%total_mb
      str = str//"Total memory: "//trim(adjustl(temp_str))//" MB"//new_line('a')

      write (temp_str, '(F10.2)') self%used_mb
      str = str//"Used memory:  "//trim(adjustl(temp_str))//" MB"
   end function to_string_device

   subroutine get_device_id(mem)
      type(pic_device_type), intent(inout) :: mem
      integer(c_int) :: ierr, device_id

      call backend_get_device(device_id, ierr)

      if (ierr == 0_c_int) then
         mem%device_id = device_id
      else
         mem%device_id = -1_c_int
      end if

   end subroutine get_device_id

   subroutine get_gpu_memory_info(mem)
      type(pic_device_type), intent(inout) :: mem
      integer(c_size_t) :: freeMem, totalMem
      integer(c_int)    :: ierr

      call backend_meminfo(freeMem, totalMem, ierr)

      if (ierr == 0_c_int) then
         mem%free_mb = real(freeMem, kind=real64)/1024.0_real64/1024.0_real64
         mem%total_mb = real(totalMem, kind=real64)/1024.0_real64/1024.0_real64
         mem%used_mb = mem%total_mb - mem%free_mb
      else
         mem = pic_device_type()   ! zero it
      end if

   end subroutine get_gpu_memory_info

end module pic_device
