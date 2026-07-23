/* Shim: the real file is in ROCm/clr. Only compiler decorations, which a
   binding generator strips regardless. */
#pragma once
#define __host__
#define __device__
#define __global__
#define __shared__
#define __constant__
#define __managed__
#define __forceinline__ inline
#define __align__(x)
#define __maybe_unused
#define DEPRECATED(msg)
#define DEPRECATED_MSG ""
#define __HIP_DEPRECATED
#define __HIP_DEPRECATED_MSG(msg)
