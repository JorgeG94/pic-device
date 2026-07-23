!> Backend-agnostic GPU runtime layer.
!!
!! This module is the abstraction; the raw C interfaces live in the generated
!! modules `pic_cuda_runtime` and `pic_hip_runtime` (see
!! `tools/generate_gpu_bindings.py`), which expose the vendor APIs verbatim --
!! 318 CUDA and 467 HIP entry points with their enums, flag constants and
!! BIND(C) derived types. Everything here exists to hide the choice between
!! them behind one Fortran API.
!!
!! Adding a call means adding a `backend_*` wrapper here, not writing another
!! interface block: whatever you need is almost certainly already bound.
!!
!! HIP mirrors the CUDA runtime API closely, so most wrappers are a one-line
!! `#ifdef`. Where the two genuinely differ, the difference belongs here rather
!! than in calling code. The cases that are NOT one-liners are flagged in
!! comments below -- `hipHostMalloc` taking a flags argument that
!! `cudaMallocHost` does not is the main one.
!!
!! Every wrapper returns the backend's own status in `ierr`; compare it against
!! `BACKEND_SUCCESS`, and decode it with `backend_error_string`. In a build with
!! no GPU backend every wrapper returns `BACKEND_UNAVAILABLE` and leaves its
!! outputs benign, so "not compiled with a GPU" stays distinguishable from "the
!! runtime failed".
module pic_gpu_runtime
   use iso_c_binding
   use iso_fortran_env, only: real32, real64, int32, int64
#ifdef CUDA
   use pic_cuda_runtime
#elif defined(HIP)
   use pic_hip_runtime
#endif
   implicit none
   private

   ! -- status / identity -------------------------------------------------
   public :: BACKEND_SUCCESS, BACKEND_UNAVAILABLE
   public :: backend_name, backend_error_string
   public :: backend_get_last_error, backend_peek_last_error

   ! -- device ------------------------------------------------------------
   public :: backend_get_device_count, backend_get_device, backend_set_device
   public :: backend_meminfo, backend_synchronize, backend_device_reset

   ! -- memory ------------------------------------------------------------
   public :: backend_malloc, backend_free
   public :: backend_malloc_host, backend_free_host
   public :: backend_memset, backend_memset_async

   ! -- transfers ---------------------------------------------------------
   public :: backend_memcpy, backend_memcpy_async
   public :: backend_copy_to_device, backend_copy_to_host
   public :: BACKEND_MEMCPY_HOST_TO_HOST, BACKEND_MEMCPY_HOST_TO_DEVICE
   public :: BACKEND_MEMCPY_DEVICE_TO_HOST, BACKEND_MEMCPY_DEVICE_TO_DEVICE
   public :: BACKEND_MEMCPY_DEFAULT

   ! -- streams -----------------------------------------------------------
   public :: backend_stream_create, backend_stream_destroy
   public :: backend_stream_synchronize, backend_stream_query
   public :: BACKEND_STREAM_DEFAULT, BACKEND_STREAM_NON_BLOCKING

   ! -- events ------------------------------------------------------------
   public :: backend_event_create, backend_event_destroy
   public :: backend_event_record, backend_event_synchronize
   public :: backend_event_elapsed_time

   !> Success as reported by the selected backend. Both runtimes use 0, but
   !! callers should compare against this rather than a bare literal.
#ifdef CUDA
   integer(c_int), parameter :: BACKEND_SUCCESS = cudaSuccess
#elif defined(HIP)
   integer(c_int), parameter :: BACKEND_SUCCESS = hipSuccess
#else
   integer(c_int), parameter :: BACKEND_SUCCESS = 0_c_int
#endif

   !> Returned by every wrapper when the build has no GPU backend.
   integer(c_int), parameter :: BACKEND_UNAVAILABLE = -1_c_int

   ! Transfer directions and flags, re-exported under backend-neutral names so
   ! calling code never mentions cuda* or hip*. The two runtimes happen to use
   ! the same numeric values, but that is not something to rely on.
#ifdef CUDA
   integer(c_int), parameter :: BACKEND_MEMCPY_HOST_TO_HOST = cudaMemcpyHostToHost
   integer(c_int), parameter :: BACKEND_MEMCPY_HOST_TO_DEVICE = cudaMemcpyHostToDevice
   integer(c_int), parameter :: BACKEND_MEMCPY_DEVICE_TO_HOST = cudaMemcpyDeviceToHost
   integer(c_int), parameter :: BACKEND_MEMCPY_DEVICE_TO_DEVICE = cudaMemcpyDeviceToDevice
   integer(c_int), parameter :: BACKEND_MEMCPY_DEFAULT = cudaMemcpyDefault
   integer(c_int), parameter :: BACKEND_STREAM_DEFAULT = cudaStreamDefault
   integer(c_int), parameter :: BACKEND_STREAM_NON_BLOCKING = cudaStreamNonBlocking
#elif defined(HIP)
   integer(c_int), parameter :: BACKEND_MEMCPY_HOST_TO_HOST = hipMemcpyHostToHost
   integer(c_int), parameter :: BACKEND_MEMCPY_HOST_TO_DEVICE = hipMemcpyHostToDevice
   integer(c_int), parameter :: BACKEND_MEMCPY_DEVICE_TO_HOST = hipMemcpyDeviceToHost
   integer(c_int), parameter :: BACKEND_MEMCPY_DEVICE_TO_DEVICE = hipMemcpyDeviceToDevice
   integer(c_int), parameter :: BACKEND_MEMCPY_DEFAULT = hipMemcpyDefault
   integer(c_int), parameter :: BACKEND_STREAM_DEFAULT = hipStreamDefault
   integer(c_int), parameter :: BACKEND_STREAM_NON_BLOCKING = hipStreamNonBlocking
#else
   integer(c_int), parameter :: BACKEND_MEMCPY_HOST_TO_HOST = 0_c_int
   integer(c_int), parameter :: BACKEND_MEMCPY_HOST_TO_DEVICE = 1_c_int
   integer(c_int), parameter :: BACKEND_MEMCPY_DEVICE_TO_HOST = 2_c_int
   integer(c_int), parameter :: BACKEND_MEMCPY_DEVICE_TO_DEVICE = 3_c_int
   integer(c_int), parameter :: BACKEND_MEMCPY_DEFAULT = 4_c_int
   integer(c_int), parameter :: BACKEND_STREAM_DEFAULT = 0_c_int
   integer(c_int), parameter :: BACKEND_STREAM_NON_BLOCKING = 1_c_int
#endif

   !> Copy a whole Fortran array to a device buffer. The size is taken from the
   !! array, which removes the commonest source of transfer bugs -- a byte count
   !! computed by hand.
   interface backend_copy_to_device
      module procedure copy_h2d_r64_1, copy_h2d_r64_2
      module procedure copy_h2d_r32_1, copy_h2d_i32_1
   end interface

   !> Copy a device buffer back into a whole Fortran array.
   interface backend_copy_to_host
      module procedure copy_d2h_r64_1, copy_d2h_r64_2
      module procedure copy_d2h_r32_1, copy_d2h_i32_1
   end interface

contains

   ! =======================================================================
   !  Status and identity
   ! =======================================================================

   !> "CUDA", "HIP", or "none" -- which backend this build was compiled against.
   pure function backend_name() result(name)
      character(len=:), allocatable :: name
#ifdef CUDA
      name = "CUDA"
#elif defined(HIP)
      name = "HIP"
#else
      name = "none"
#endif
   end function backend_name

   !> Decode a backend status code into a human-readable message.
   !!
   !! Without this a caller can only report "GPU error 35" rather than "CUDA
   !! driver version is insufficient", which is the difference between a usable
   !! bug report and a puzzled one.
   function backend_error_string(ierr) result(str)
      integer(c_int), intent(in) :: ierr
      character(len=:), allocatable :: str
#if defined(CUDA) || defined(HIP)
      type(c_ptr) :: p
      character(kind=c_char), pointer :: buf(:)
      integer :: i, n
#ifdef CUDA
      p = cudaGetErrorString(ierr)
#else
      p = hipGetErrorString(ierr)
#endif
      if (.not. c_associated(p)) then
         str = "<no message>"
         return
      end if
      call c_f_pointer(p, buf, [huge(0_c_int)])
      n = 0
      do while (buf(n + 1) /= c_null_char)
         n = n + 1
         if (n > 4096) exit
      end do
      allocate (character(len=n) :: str)
      do i = 1, n
         str(i:i) = buf(i)
      end do
#else
      if (ierr == BACKEND_UNAVAILABLE) then
         str = "no GPU backend compiled in"
      else
         str = "<no backend>"
      end if
#endif
   end function backend_error_string

   !> Return and CLEAR the last error. Use after a launch or an async call,
   !! whose failures are not reported by the call that queued them.
   subroutine backend_get_last_error(ierr)
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaGetLastError()
#elif defined(HIP)
      ierr = hipGetLastError()
#else
      ierr = BACKEND_UNAVAILABLE
#endif
   end subroutine backend_get_last_error

   !> Return the last error WITHOUT clearing it.
   subroutine backend_peek_last_error(ierr)
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaPeekAtLastError()
#elif defined(HIP)
      ierr = hipPeekAtLastError()
#else
      ierr = BACKEND_UNAVAILABLE
#endif
   end subroutine backend_peek_last_error

   ! =======================================================================
   !  Device
   ! =======================================================================

   subroutine backend_get_device_count(device_count, ierr)
      integer(c_int), intent(out) :: device_count, ierr
#ifdef CUDA
      ierr = cudaGetDeviceCount(device_count)
#elif defined(HIP)
      ierr = hipGetDeviceCount(device_count)
#else
      ierr = BACKEND_UNAVAILABLE
      device_count = 0_c_int
#endif
   end subroutine backend_get_device_count

   subroutine backend_get_device(device_id, ierr)
      integer(c_int), intent(out) :: device_id, ierr
#ifdef CUDA
      ierr = cudaGetDevice(device_id)
#elif defined(HIP)
      ierr = hipGetDevice(device_id)
#else
      ierr = BACKEND_UNAVAILABLE
      device_id = -1_c_int
#endif
   end subroutine backend_get_device

   subroutine backend_set_device(device_id, ierr)
      integer(c_int), intent(in)  :: device_id
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaSetDevice(device_id)
#elif defined(HIP)
      ierr = hipSetDevice(device_id)
#else
      ierr = BACKEND_UNAVAILABLE
      if (device_id < 0) continue
#endif
   end subroutine backend_set_device

   subroutine backend_meminfo(freeMem, totalMem, ierr)
      integer(c_size_t), intent(out) :: freeMem, totalMem
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaMemGetInfo(freeMem, totalMem)
#elif defined(HIP)
      ierr = hipMemGetInfo(freeMem, totalMem)
#else
      freeMem = 0_c_size_t
      totalMem = 0_c_size_t
      ierr = BACKEND_UNAVAILABLE
#endif
   end subroutine backend_meminfo

   !> Block until every previously queued operation on the device has finished.
   subroutine backend_synchronize(ierr)
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaDeviceSynchronize()
#elif defined(HIP)
      ierr = hipDeviceSynchronize()
#else
      ierr = BACKEND_UNAVAILABLE
#endif
   end subroutine backend_synchronize

   !> Destroy all allocations and contexts on the current device.
   !!
   !! Every device pointer, stream and event becomes invalid. Useful before
   !! exit so profilers flush, and rarely appropriate anywhere else.
   subroutine backend_device_reset(ierr)
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaDeviceReset()
#elif defined(HIP)
      ierr = hipDeviceReset()
#else
      ierr = BACKEND_UNAVAILABLE
#endif
   end subroutine backend_device_reset

   ! =======================================================================
   !  Memory
   ! =======================================================================

   !> Allocate `nbytes` of device memory.
   subroutine backend_malloc(ptr, nbytes, ierr)
      type(c_ptr),        intent(out) :: ptr
      integer(c_size_t),  intent(in)  :: nbytes
      integer(c_int),     intent(out) :: ierr
      ptr = c_null_ptr
#ifdef CUDA
      ierr = cudaMalloc(ptr, nbytes)
#elif defined(HIP)
      ierr = hipMalloc(ptr, nbytes)
#else
      ierr = BACKEND_UNAVAILABLE
      if (nbytes < 0) continue
#endif
   end subroutine backend_malloc

   !> Free device memory and null the pointer. Freeing c_null_ptr is a no-op,
   !! so this is safe to call unconditionally in a cleanup path.
   subroutine backend_free(ptr, ierr)
      type(c_ptr),    intent(inout) :: ptr
      integer(c_int), intent(out)   :: ierr
      ierr = BACKEND_SUCCESS
      if (.not. c_associated(ptr)) return
#ifdef CUDA
      ierr = cudaFree(ptr)
#elif defined(HIP)
      ierr = hipFree(ptr)
#else
      ierr = BACKEND_UNAVAILABLE
#endif
      ptr = c_null_ptr
   end subroutine backend_free

   !> Allocate `nbytes` of page-locked host memory, which is what makes
   !! `backend_memcpy_async` genuinely asynchronous.
   !!
   !! NOT a one-line difference: hipHostMalloc takes a flags argument that
   !! cudaMallocHost does not, so the HIP branch passes hipHostMallocDefault.
   subroutine backend_malloc_host(ptr, nbytes, ierr)
      type(c_ptr),       intent(out) :: ptr
      integer(c_size_t), intent(in)  :: nbytes
      integer(c_int),    intent(out) :: ierr
      ptr = c_null_ptr
#ifdef CUDA
      ierr = cudaMallocHost(ptr, nbytes)
#elif defined(HIP)
      ierr = hipHostMalloc(ptr, nbytes, hipHostMallocDefault)
#else
      ierr = BACKEND_UNAVAILABLE
      if (nbytes < 0) continue
#endif
   end subroutine backend_malloc_host

   !> Free page-locked host memory. Note the backends spell this differently:
   !! cudaFreeHost vs hipHostFree.
   subroutine backend_free_host(ptr, ierr)
      type(c_ptr),    intent(inout) :: ptr
      integer(c_int), intent(out)   :: ierr
      ierr = BACKEND_SUCCESS
      if (.not. c_associated(ptr)) return
#ifdef CUDA
      ierr = cudaFreeHost(ptr)
#elif defined(HIP)
      ierr = hipHostFree(ptr)
#else
      ierr = BACKEND_UNAVAILABLE
#endif
      ptr = c_null_ptr
   end subroutine backend_free_host

   !> Set `nbytes` of device memory to a byte value.
   subroutine backend_memset(ptr, value, nbytes, ierr)
      type(c_ptr),       intent(in)  :: ptr
      integer(c_int),    intent(in)  :: value
      integer(c_size_t), intent(in)  :: nbytes
      integer(c_int),    intent(out) :: ierr
#ifdef CUDA
      ierr = cudaMemset(ptr, value, nbytes)
#elif defined(HIP)
      ierr = hipMemset(ptr, value, nbytes)
#else
      ierr = BACKEND_UNAVAILABLE
      if (nbytes < 0 .or. value < 0 .or. .not. c_associated(ptr)) continue
#endif
   end subroutine backend_memset

   subroutine backend_memset_async(ptr, value, nbytes, stream, ierr)
      type(c_ptr),       intent(in)  :: ptr, stream
      integer(c_int),    intent(in)  :: value
      integer(c_size_t), intent(in)  :: nbytes
      integer(c_int),    intent(out) :: ierr
#ifdef CUDA
      ierr = cudaMemsetAsync(ptr, value, nbytes, stream)
#elif defined(HIP)
      ierr = hipMemsetAsync(ptr, value, nbytes, stream)
#else
      ierr = BACKEND_UNAVAILABLE
      if (nbytes < 0 .or. value < 0 .or. .not. c_associated(ptr) &
          .or. .not. c_associated(stream)) continue
#endif
   end subroutine backend_memset_async

   ! =======================================================================
   !  Transfers
   ! =======================================================================

   !> Raw byte-count copy. `kind` is one of the BACKEND_MEMCPY_* parameters.
   subroutine backend_memcpy(dst, src, nbytes, kind, ierr)
      type(c_ptr),       intent(in)  :: dst, src
      integer(c_size_t), intent(in)  :: nbytes
      integer(c_int),    intent(in)  :: kind
      integer(c_int),    intent(out) :: ierr
#ifdef CUDA
      ierr = cudaMemcpy(dst, src, nbytes, kind)
#elif defined(HIP)
      ierr = hipMemcpy(dst, src, nbytes, kind)
#else
      ierr = BACKEND_UNAVAILABLE
      if (nbytes < 0 .or. kind < 0 .or. .not. c_associated(dst) &
          .or. .not. c_associated(src)) continue
#endif
   end subroutine backend_memcpy

   !> Asynchronous copy on a stream. Only actually asynchronous when the host
   !! side is page-locked -- see backend_malloc_host.
   subroutine backend_memcpy_async(dst, src, nbytes, kind, stream, ierr)
      type(c_ptr),       intent(in)  :: dst, src, stream
      integer(c_size_t), intent(in)  :: nbytes
      integer(c_int),    intent(in)  :: kind
      integer(c_int),    intent(out) :: ierr
#ifdef CUDA
      ierr = cudaMemcpyAsync(dst, src, nbytes, kind, stream)
#elif defined(HIP)
      ierr = hipMemcpyAsync(dst, src, nbytes, kind, stream)
#else
      ierr = BACKEND_UNAVAILABLE
      if (nbytes < 0 .or. kind < 0 .or. .not. c_associated(dst) &
          .or. .not. c_associated(src) .or. .not. c_associated(stream)) continue
#endif
   end subroutine backend_memcpy_async

   ! ---- typed whole-array copies -----------------------------------------
   ! The byte count comes from the array itself. Hand-computed sizes are the
   ! commonest transfer bug, and `size(a) * 8` is wrong the moment someone
   ! changes a kind.

   subroutine copy_h2d_r64_1(dev, host, ierr)
      type(c_ptr),    intent(in)  :: dev
      real(real64),   intent(in), target :: host(:)
      integer(c_int), intent(out) :: ierr
      call backend_memcpy(dev, c_loc(host), &
                          int(size(host), c_size_t)*int(storage_size(host)/8, c_size_t), &
                          BACKEND_MEMCPY_HOST_TO_DEVICE, ierr)
   end subroutine copy_h2d_r64_1

   subroutine copy_h2d_r64_2(dev, host, ierr)
      type(c_ptr),    intent(in)  :: dev
      real(real64),   intent(in), target :: host(:, :)
      integer(c_int), intent(out) :: ierr
      call backend_memcpy(dev, c_loc(host), &
                          int(size(host), c_size_t)*int(storage_size(host)/8, c_size_t), &
                          BACKEND_MEMCPY_HOST_TO_DEVICE, ierr)
   end subroutine copy_h2d_r64_2

   subroutine copy_h2d_r32_1(dev, host, ierr)
      type(c_ptr),    intent(in)  :: dev
      real(real32),   intent(in), target :: host(:)
      integer(c_int), intent(out) :: ierr
      call backend_memcpy(dev, c_loc(host), &
                          int(size(host), c_size_t)*int(storage_size(host)/8, c_size_t), &
                          BACKEND_MEMCPY_HOST_TO_DEVICE, ierr)
   end subroutine copy_h2d_r32_1

   subroutine copy_h2d_i32_1(dev, host, ierr)
      type(c_ptr),     intent(in)  :: dev
      integer(int32),  intent(in), target :: host(:)
      integer(c_int),  intent(out) :: ierr
      call backend_memcpy(dev, c_loc(host), &
                          int(size(host), c_size_t)*int(storage_size(host)/8, c_size_t), &
                          BACKEND_MEMCPY_HOST_TO_DEVICE, ierr)
   end subroutine copy_h2d_i32_1

   subroutine copy_d2h_r64_1(host, dev, ierr)
      real(real64),   intent(out), target :: host(:)
      type(c_ptr),    intent(in)  :: dev
      integer(c_int), intent(out) :: ierr
      call backend_memcpy(c_loc(host), dev, &
                          int(size(host), c_size_t)*int(storage_size(host)/8, c_size_t), &
                          BACKEND_MEMCPY_DEVICE_TO_HOST, ierr)
   end subroutine copy_d2h_r64_1

   subroutine copy_d2h_r64_2(host, dev, ierr)
      real(real64),   intent(out), target :: host(:, :)
      type(c_ptr),    intent(in)  :: dev
      integer(c_int), intent(out) :: ierr
      call backend_memcpy(c_loc(host), dev, &
                          int(size(host), c_size_t)*int(storage_size(host)/8, c_size_t), &
                          BACKEND_MEMCPY_DEVICE_TO_HOST, ierr)
   end subroutine copy_d2h_r64_2

   subroutine copy_d2h_r32_1(host, dev, ierr)
      real(real32),   intent(out), target :: host(:)
      type(c_ptr),    intent(in)  :: dev
      integer(c_int), intent(out) :: ierr
      call backend_memcpy(c_loc(host), dev, &
                          int(size(host), c_size_t)*int(storage_size(host)/8, c_size_t), &
                          BACKEND_MEMCPY_DEVICE_TO_HOST, ierr)
   end subroutine copy_d2h_r32_1

   subroutine copy_d2h_i32_1(host, dev, ierr)
      integer(int32), intent(out), target :: host(:)
      type(c_ptr),    intent(in)  :: dev
      integer(c_int), intent(out) :: ierr
      call backend_memcpy(c_loc(host), dev, &
                          int(size(host), c_size_t)*int(storage_size(host)/8, c_size_t), &
                          BACKEND_MEMCPY_DEVICE_TO_HOST, ierr)
   end subroutine copy_d2h_i32_1

   ! =======================================================================
   !  Streams
   ! =======================================================================

   !> Create a stream. `flags` defaults to BACKEND_STREAM_DEFAULT; pass
   !! BACKEND_STREAM_NON_BLOCKING for one that does not synchronise with the
   !! legacy default stream.
   subroutine backend_stream_create(stream, ierr, flags)
      type(c_ptr),    intent(out) :: stream
      integer(c_int), intent(out) :: ierr
      integer(c_int), intent(in), optional :: flags
      integer(c_int) :: f
      f = BACKEND_STREAM_DEFAULT
      if (present(flags)) f = flags
      stream = c_null_ptr
#ifdef CUDA
      ierr = cudaStreamCreateWithFlags(stream, f)
#elif defined(HIP)
      ierr = hipStreamCreateWithFlags(stream, f)
#else
      ierr = BACKEND_UNAVAILABLE
#endif
   end subroutine backend_stream_create

   subroutine backend_stream_destroy(stream, ierr)
      type(c_ptr),    intent(inout) :: stream
      integer(c_int), intent(out)   :: ierr
      ierr = BACKEND_SUCCESS
      if (.not. c_associated(stream)) return
#ifdef CUDA
      ierr = cudaStreamDestroy(stream)
#elif defined(HIP)
      ierr = hipStreamDestroy(stream)
#else
      ierr = BACKEND_UNAVAILABLE
#endif
      stream = c_null_ptr
   end subroutine backend_stream_destroy

   subroutine backend_stream_synchronize(stream, ierr)
      type(c_ptr),    intent(in)  :: stream
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaStreamSynchronize(stream)
#elif defined(HIP)
      ierr = hipStreamSynchronize(stream)
#else
      ierr = BACKEND_UNAVAILABLE
      if (.not. c_associated(stream)) continue
#endif
   end subroutine backend_stream_synchronize

   !> Non-blocking test. `ierr == BACKEND_SUCCESS` means the stream is idle;
   !! a "not ready" status is normal and not an error.
   subroutine backend_stream_query(stream, ierr)
      type(c_ptr),    intent(in)  :: stream
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaStreamQuery(stream)
#elif defined(HIP)
      ierr = hipStreamQuery(stream)
#else
      ierr = BACKEND_UNAVAILABLE
      if (.not. c_associated(stream)) continue
#endif
   end subroutine backend_stream_query

   ! =======================================================================
   !  Events
   ! =======================================================================

   subroutine backend_event_create(event, ierr)
      type(c_ptr),    intent(out) :: event
      integer(c_int), intent(out) :: ierr
      event = c_null_ptr
#ifdef CUDA
      ierr = cudaEventCreate(event)
#elif defined(HIP)
      ierr = hipEventCreate(event)
#else
      ierr = BACKEND_UNAVAILABLE
#endif
   end subroutine backend_event_create

   subroutine backend_event_destroy(event, ierr)
      type(c_ptr),    intent(inout) :: event
      integer(c_int), intent(out)   :: ierr
      ierr = BACKEND_SUCCESS
      if (.not. c_associated(event)) return
#ifdef CUDA
      ierr = cudaEventDestroy(event)
#elif defined(HIP)
      ierr = hipEventDestroy(event)
#else
      ierr = BACKEND_UNAVAILABLE
#endif
      event = c_null_ptr
   end subroutine backend_event_destroy

   !> Record an event. Omit `stream` for the default stream.
   subroutine backend_event_record(event, ierr, stream)
      type(c_ptr),    intent(in)  :: event
      integer(c_int), intent(out) :: ierr
      type(c_ptr),    intent(in), optional :: stream
      type(c_ptr) :: s
      s = c_null_ptr
      if (present(stream)) s = stream
#ifdef CUDA
      ierr = cudaEventRecord(event, s)
#elif defined(HIP)
      ierr = hipEventRecord(event, s)
#else
      ierr = BACKEND_UNAVAILABLE
      if (.not. c_associated(event) .or. .not. c_associated(s)) continue
#endif
   end subroutine backend_event_record

   subroutine backend_event_synchronize(event, ierr)
      type(c_ptr),    intent(in)  :: event
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaEventSynchronize(event)
#elif defined(HIP)
      ierr = hipEventSynchronize(event)
#else
      ierr = BACKEND_UNAVAILABLE
      if (.not. c_associated(event)) continue
#endif
   end subroutine backend_event_synchronize

   !> Milliseconds between two recorded events. Both must have completed --
   !! call backend_event_synchronize on the later one first.
   subroutine backend_event_elapsed_time(ms, start_event, end_event, ierr)
      real(real32),   intent(out) :: ms
      type(c_ptr),    intent(in)  :: start_event, end_event
      integer(c_int), intent(out) :: ierr
      real(c_float) :: t
      t = 0.0_c_float
#ifdef CUDA
      ierr = cudaEventElapsedTime(t, start_event, end_event)
#elif defined(HIP)
      ierr = hipEventElapsedTime(t, start_event, end_event)
#else
      ierr = BACKEND_UNAVAILABLE
      if (.not. c_associated(start_event) .or. .not. c_associated(end_event)) continue
#endif
      ms = real(t, real32)
   end subroutine backend_event_elapsed_time

end module pic_gpu_runtime
