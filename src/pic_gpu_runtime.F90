module pic_gpu_runtime
   use iso_c_binding
   implicit none

#ifdef CUDA
   interface
      function cudaMemGetInfo(freeMem, totalMem) bind(C, name="cudaMemGetInfo")
         use iso_c_binding
         integer(c_int) :: cudaMemGetInfo
         integer(c_size_t), intent(out) :: freeMem, totalMem
      end function
      function cudaGetDevice(device) bind(C, name="cudaGetDevice")
         use iso_c_binding
         integer(c_int) :: cudaGetDevice
         integer(c_int), intent(out) :: device
      end function
      function cudaGetDeviceCount(count) bind(C, name="cudaGetDeviceCount")
         use iso_c_binding
         integer(c_int) :: cudaGetDeviceCount
         integer(c_int), intent(out) :: count
      end function
   end interface

#elif defined(HIP)
   interface
      function hipMemGetInfo(freeMem, totalMem) bind(C, name="hipMemGetInfo")
         use iso_c_binding
         integer(c_int) :: hipMemGetInfo
         integer(c_size_t), intent(out) :: freeMem, totalMem
      end function
      function hipGetDevice(device) bind(C, name="hipGetDevice")
         use iso_c_binding
         integer(c_int) :: hipGetDevice
         integer(c_int), intent(out) :: device
      end function
      function hipGetDeviceCount(count) bind(C, name="hipGetDeviceCount")
         use iso_c_binding
         integer(c_int) :: hipGetDeviceCount
         integer(c_int), intent(out) :: count
      end function
   end interface

#endif

contains

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
      ierr = -1
#endif
   end subroutine backend_meminfo

   subroutine backend_get_device(device_id, ierr)
      integer(c_int), intent(out) :: device_id, ierr
#ifdef CUDA
      ierr = cudaGetDevice(device_id)
#elif defined(HIP)
      ierr = hipGetDevice(device_id)
#else
      ierr = -1_c_int
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
      ierr = -1_c_int
      device_count = 0_c_int
#endif
   end subroutine backend_get_device_count

end module pic_gpu_runtime
