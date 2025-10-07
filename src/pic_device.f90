module pic_device
   use iso_c_binding
   use iso_fortran_env, only: real64
   use pic_gpu_runtime, only: backend_meminfo
   implicit none

   type :: pic_device_type
      real(real64) :: free_mb = 0.0_real64
      real(real64) :: total_mb = 0.0_real64
      real(real64) :: used_mb = 0.0_real64
   contains
      procedure, non_overridable :: get_device_info => get_gpu_information
   end type pic_device_type

contains

   subroutine get_gpu_information(self)
      class(pic_device_type), intent(inout) :: self

      call get_gpu_memory_info(self)

   end subroutine get_gpu_information

   subroutine get_gpu_memory_info(mem)
      type(pic_device_type), intent(out) :: mem
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
