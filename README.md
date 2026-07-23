# GPU device manager but in Fortran
A template repository for modern fortran projects

This is a sample and work in progress to manage certain device aspects from
a simple Fortran interface kinda way.

To build, depending on your GPU runtime you can use: `cmake -DGPU_RUNTIME=CUDA/HIP ../` 

I have not added support for using HIP with a CUDA backend. Feel free to add that!

A simple way to use the module is 

``` 
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
```

Which will result in:

```
 Device count            4
 Device ID:   0
Free memory: 32167.56 MB
Total memory: 32498.56 MB
Used memory:  331.00 MB
```

## Two layers

The project is deliberately split in two:

| layer | file | what it is |
|---|---|---|
| raw bindings | `src/pic_cuda_runtime.F90`, `src/pic_hip_runtime.F90` | the vendor APIs verbatim — **318 CUDA** and **467 HIP** entry points, plus their enums, flag constants and `BIND(C)` derived types. **Generated — do not edit.** |
| abstraction | `src/pic_gpu_runtime.F90` | the `backend_*` API that hides which of the two you built against |
| convenience | `src/pic_device.f90` | `pic_device_type` and its `to_string` |

The raw layer is generated from the vendor headers by
`tools/generate_gpu_bindings.py`:

```sh
python3 tools/generate_gpu_bindings.py --api both \
        --cuda $CUDA_HOME --hip /path/to/ROCm/hip
```

Both generated files are checked in, so building needs neither toolkit's
headers. Each is wrapped in the `#ifdef` the build already sets, so the
unselected backend compiles to nothing — which is why both can be listed
unconditionally, as fpm requires.

The generator is not a transliteration: it preprocesses the headers with a real
`cpp`, resolves versioned symbol aliases, and verifies every emitted derived
type against `sizeof`/`offsetof` from a compiled C probe, dropping anything it
cannot confirm rather than emitting a layout that might be wrong. See
`tools/generate_gpu_bindings.py` for the details, and `tools/hip_compat/` for
why HIP needs three small shim headers to preprocess from a plain ROCm/hip
checkout.

**Why not hipfort?** hipfort is large and covers the whole ROCm stack. If all
you want is the runtime API behind a portable Fortran interface, generating it
is a few hundred lines of Python and yields exactly the surface you use.

Adding a call means adding a `backend_*` wrapper — not writing another
interface block. Whatever you need is almost certainly already bound.

## The abstraction layer

The `pic_device_type` derived type provides a convenient container that carries the variables around. However, the module
`pic_gpu_runtime` contains the interfaces to the cuda/hip runtime to achieve similar functionality:

```
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
```

Which can be called independently like:

```
block 
integer(c_int) :: ierr
integer(c_size_t) :: free_memory, total_memory 

call backend_meminfo(free_memory, total_memory, ierr)

end block
```

The full `backend_*` surface:

| | |
|---|---|
| `backend_get_device_count(n, ierr)` | number of visible devices |
| `backend_get_device(id, ierr)` / `backend_set_device(id, ierr)` | current device |
| `backend_meminfo(free, total, ierr)` | device memory |
| `backend_synchronize(ierr)` | block until the device is idle |
| `backend_error_string(ierr)` | decode a status code to text |
| `backend_name()` | `"CUDA"`, `"HIP"` or `"none"` |
| `BACKEND_SUCCESS`, `BACKEND_UNAVAILABLE` | compare against these, not `0` / `-1` |

`BACKEND_UNAVAILABLE` is returned by every wrapper in a CPU-only build, so "no
GPU runtime was compiled in" stays distinguishable from "the runtime returned
an error". `backend_error_string` matters more than it looks: without it a
caller can only report *"GPU error 35"* rather than *"CUDA driver version is
insufficient for CUDA runtime version"*.

## How to install the FPM

See the instructions [here](https://fpm.fortran-lang.org/install/index.html)

If you are on a Linux distro and have any Fortran compiler installed, do:

```
git clone https://github.com/fortran-lang/fpm
cd fpm
./install.sh
```

This will put the fpm in your `$HOME/.local/bin`

## How to change the FPM config

Basically just remove my name and add yours. Also just add your project name.

To build, simply: `fpm build`

To test, `fpm test`

To see my super cool printout: `fpm run`

## How to change the CMake config

At the very top you have to change:

```
project(
  "demo"
  LANGUAGES Fortran
  VERSION 0.0
  DESCRIPTION "ADD YOUR DESCRIPTION HERE")


set(project_name demo)
set(main_lib ${project_name})
set(exe_name exe_${project_name})
set(all_targets ${main_lib} ${exe_name})
```

Replace `"demo"` with the name of your project.

For the `set` commands, change the name on the RIGHT, i.e. `demo`. This will
cascade down.

At the very bottom, change

```
# RENAME YOUR demoConfig.cmake.in to match ${your_new_name}Config.cmake
# and change here sampleConfig.cmake.in to xyzConfig.cmake.in
configure_package_config_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/sampleConfig.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/${project_name}Config.cmake"
  INSTALL_DESTINATION lib/cmake/${project_name})
```


## How to use the CMake build system

Everything is set up so that you will load `test-drive` for unit-tests in a nice portable way. Also, I've set
all you need so that you package is findable by other cmake packages. To install to a known location simply do:

```
mkdir build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/demo/ ../
make -j install
```

To run the tests, from the build dir run: `ctest`


## CI/CD

This repo contains a very powerful CI/CD workflow based on gha3mi's work, which you can find [here](https://github.com/gha3mi/setup-fortran-conda/tree/main)


## pre-commit hooks

The repo also comes with a pre-commit that will ensure a formatting for your Fortran files. You can install pre-commits by using:

```
python3 -m pip install pre-commit
pre-commit install
```

## Using your template repo in another project.

This repo will install everything CMake needs to find the project. THe only thing you need to set is  `YOUR_PROJECT_NAME_ROOT=/path/to/install/location`

And in your new project set `find_package(demo REQUIRED)`

To then link to demo, you can simply add `demo::demo` to you `target_link_libraries(${tgt} PRIVATE demo::demo)`
