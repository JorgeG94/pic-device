!> Backend-agnostic GPU runtime layer.
!!
!! This module is the abstraction; the raw C interfaces live in the generated
!! modules `pic_cuda_runtime` and `pic_hip_runtime` (see
!! `tools/generate_gpu_bindings.py`). Those expose the vendor APIs verbatim --
!! 318 CUDA and 467 HIP entry points, with their enums, flag constants and
!! BIND(C) derived types. Everything here exists to hide the choice between
!! them behind one Fortran API.
!!
!! Adding a call therefore means adding a `backend_*` wrapper here, not writing
!! another interface block: whatever you need is almost certainly already bound.
!!
!! HIP mirrors the CUDA runtime API closely enough that most wrappers are a
!! one-line `#ifdef`. Where the two genuinely differ, that difference belongs
!! here rather than in calling code.
module pic_gpu_runtime
   use iso_c_binding
#ifdef CUDA
   use pic_cuda_runtime
#elif defined(HIP)
   use pic_hip_runtime
#endif
   implicit none
   private

   public :: backend_meminfo, backend_get_device, backend_get_device_count
   public :: backend_set_device, backend_synchronize
   public :: backend_error_string, backend_name
   public :: BACKEND_SUCCESS, BACKEND_UNAVAILABLE

   !> Success as reported by the selected backend. Both runtimes use 0, but
   !! callers should compare against this rather than a bare literal.
#ifdef CUDA
   integer(c_int), parameter :: BACKEND_SUCCESS = cudaSuccess
#elif defined(HIP)
   integer(c_int), parameter :: BACKEND_SUCCESS = hipSuccess
#else
   integer(c_int), parameter :: BACKEND_SUCCESS = 0_c_int
#endif

   !> Returned by every wrapper when the build has no GPU backend, so "no
   !! runtime" is distinguishable from "the runtime returned an error".
   integer(c_int), parameter :: BACKEND_UNAVAILABLE = -1_c_int

contains

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
   !! Worth having even for a thin wrapper: without it a caller can only report
   !! "GPU error 35" rather than "CUDA driver version is insufficient", which is
   !! the difference between a usable bug report and a puzzled one.
   function backend_error_string(ierr) result(str)
      integer(c_int), intent(in) :: ierr
      character(len=:), allocatable :: str
#if defined(CUDA) || defined(HIP)
      type(c_ptr) :: p
      character(kind=c_char), pointer :: buf(:)
      integer :: n
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
      block
         integer :: i
         do i = 1, n
            str(i:i) = buf(i)
         end do
      end block
#else
      if (ierr == BACKEND_UNAVAILABLE) then
         str = "no GPU backend compiled in"
      else
         str = "<no backend>"
      end if
#endif
   end function backend_error_string

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

   subroutine backend_set_device(device_id, ierr)
      integer(c_int), intent(in)  :: device_id
      integer(c_int), intent(out) :: ierr
#ifdef CUDA
      ierr = cudaSetDevice(device_id)
#elif defined(HIP)
      ierr = hipSetDevice(device_id)
#else
      ierr = BACKEND_UNAVAILABLE
#endif
   end subroutine backend_set_device

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

end module pic_gpu_runtime
