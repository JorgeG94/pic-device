/*
 * hip_shim.c -- a stand-in libamdhip64 that forwards to the CUDA runtime.
 *
 * PURPOSE: validation only, on machines with no AMD GPU.
 *
 * The generated src/pic_hip_runtime.F90 binds hip* symbols by name. Without
 * ROCm there is nothing to link, so the HIP backend could previously only be
 * compiled, never run -- leaving its signatures (argument order, by-value vs
 * by-reference, types) unexercised. Those are exactly what a generated binding
 * can get wrong.
 *
 * This exports the hip* entry points that pic_gpu_runtime uses, implemented by
 * calling the CUDA equivalent. Linking the HIP build against it runs the whole
 * backend_* surface on an NVIDIA GPU and would catch a mis-declared interface
 * immediately.
 *
 * It does NOT substitute for testing on real AMD hardware: it proves the
 * Fortran side calls these functions correctly, not that ROCm behaves as
 * assumed. hipError_t values are passed through as CUDA's; only hipSuccess == 0
 * is relied upon.
 */
#include <cuda_runtime.h>
#include <stddef.h>

#define FWD(hip_name, cuda_call) int hip_name

int hipGetDeviceCount(int *c)                 { return cudaGetDeviceCount(c); }
int hipGetDevice(int *d)                      { return cudaGetDevice(d); }
int hipSetDevice(int d)                       { return cudaSetDevice(d); }
int hipMemGetInfo(size_t *f, size_t *t)       { return cudaMemGetInfo(f, t); }
int hipDeviceSynchronize(void)                { return cudaDeviceSynchronize(); }
int hipDeviceReset(void)                      { return cudaDeviceReset(); }

int hipMalloc(void **p, size_t n)             { return cudaMalloc(p, n); }
int hipFree(void *p)                          { return cudaFree(p); }
/* NOTE the two real divergences this shim must honour: hipHostMalloc takes a
   flags argument cudaMallocHost does not, and the free is spelled differently. */
int hipHostMalloc(void **p, size_t n, unsigned int flags)
                                              { (void)flags; return cudaMallocHost(p, n); }
int hipHostFree(void *p)                      { return cudaFreeHost(p); }

int hipMemset(void *p, int v, size_t n)       { return cudaMemset(p, v, n); }
int hipMemsetAsync(void *p, int v, size_t n, cudaStream_t s)
                                              { return cudaMemsetAsync(p, v, n, s); }
int hipMemcpy(void *d, const void *s, size_t n, int k)
                                              { return cudaMemcpy(d, s, n, (enum cudaMemcpyKind)k); }
int hipMemcpyAsync(void *d, const void *s, size_t n, int k, cudaStream_t st)
                                              { return cudaMemcpyAsync(d, s, n, (enum cudaMemcpyKind)k, st); }

int hipStreamCreateWithFlags(cudaStream_t *s, unsigned int f)
                                              { return cudaStreamCreateWithFlags(s, f); }
int hipStreamDestroy(cudaStream_t s)          { return cudaStreamDestroy(s); }
int hipStreamSynchronize(cudaStream_t s)      { return cudaStreamSynchronize(s); }
int hipStreamQuery(cudaStream_t s)            { return cudaStreamQuery(s); }

int hipEventCreate(cudaEvent_t *e)            { return cudaEventCreate(e); }
int hipEventDestroy(cudaEvent_t e)            { return cudaEventDestroy(e); }
int hipEventRecord(cudaEvent_t e, cudaStream_t s) { return cudaEventRecord(e, s); }
int hipEventSynchronize(cudaEvent_t e)        { return cudaEventSynchronize(e); }
int hipEventElapsedTime(float *ms, cudaEvent_t a, cudaEvent_t b)
                                              { return cudaEventElapsedTime(ms, a, b); }

int hipGetLastError(void)                     { return cudaGetLastError(); }
int hipPeekAtLastError(void)                  { return cudaPeekAtLastError(); }
const char *hipGetErrorString(int e)          { return cudaGetErrorString((cudaError_t)e); }
