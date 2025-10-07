program main
   use pic_device
   implicit none
   type(pic_device_type) :: device_info
   integer(c_int) :: device_count, ierr

   call backend_get_device_count(device_count, ierr)

   print *, "Device count ", device_count

   call device_info%get_device_info()

   print *, to_string(device_info)

end program main
