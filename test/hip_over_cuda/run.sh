#!/usr/bin/env bash
# Run the HIP backend on an NVIDIA GPU, to exercise bindings that would
# otherwise only ever be compiled. See hip_shim.c for what this does and does
# not prove.
#
#   ./test/hip_over_cuda/run.sh [work_dir]
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HERE/../../src"
APP="$HERE/../../app"
W="${1:-$HERE/build}"
: "${CUDA_HOME:?set CUDA_HOME}"
mkdir -p "$W" && cd "$W"

gcc -shared -fPIC -I"$CUDA_HOME/include" "$HERE/hip_shim.c" \
    -o libamdhip64.so -L"$CUDA_HOME/lib64" -lcudart

for f in pic_hip_runtime.F90 pic_gpu_runtime.F90 pic_device.f90; do
    gfortran -std=f2008 -Wall -cpp -DHIP -c "$SRC/$f"
done
gfortran -std=f2008 -Wall -cpp -DHIP "$APP/main.f90" ./*.o -o exe_hip \
    -L"$W" -lamdhip64 -L"$CUDA_HOME/lib64" -lcudart \
    -Wl,-rpath,"$W" -Wl,-rpath,"$CUDA_HOME/lib64"

echo "== HIP backend, running against the CUDA-forwarding shim =="
./exe_hip
