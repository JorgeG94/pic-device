program main
   use pic_device
   implicit none
   type(pic_device_type) :: device_info
   type(pic_device_type) :: device_info_two

   call device_info%get_device_info()

   !you can use it either as an object that you can carry around
   print *, device_info%free_mb, " MB"

   ! you can just call this and set it too. this is callable from C ish, careful with derived typew
   call get_gpu_memory_info(device_info_two)

   print *, device_info_two%free_mb, " MB 2"

end program main
