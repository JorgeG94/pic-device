# The generated backend bindings are listed unconditionally: each is wrapped in
# the #ifdef its build already sets, so the unselected one compiles to nothing.
# That keeps this list identical to what fpm sees, which compiles every file
# under src/ regardless.
target_sources(${main_lib} PRIVATE
  pic_cuda_runtime.F90
  pic_hip_runtime.F90
  pic_gpu_runtime.F90
  pic_device.f90)
