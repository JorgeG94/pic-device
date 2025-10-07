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
   end interface

#elif defined(HIP)
   interface
      function hipMemGetInfo(freeMem, totalMem) bind(C, name="hipMemGetInfo")
         use iso_c_binding
         integer(c_int) :: hipMemGetInfo
         integer(c_size_t), intent(out) :: freeMem, totalMem
      end function
   end interface

#endif

contains

   subroutine backend_meminfo(freeMem, totalMem, ierr)
      implicit none
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

end module pic_gpu_runtime
