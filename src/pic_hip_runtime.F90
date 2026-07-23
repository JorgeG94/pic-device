! Compiled only when the HIP backend is selected, so that a
! build system which compiles every file under src/ (fpm) can
! carry both backends' bindings without needing both toolkits.
#ifdef HIP
! ==========================================================================
!  pic_hip_runtime.F90 -- Fortran 2008 iso_c_binding interface to the CUDA Runtime API
!
!  GENERATED FILE -- do not edit by hand.
!  Regenerate with:  python3 generate_cuda_fortran.py
!  Generated from CUDA unknown headers at:
!      /scratch/bm55/jlv900/dev/hip/include
!
!  Standard Fortran 2008 only -- no compiler extensions. Builds with
!  gfortran, ifx, flang and nvfortran, and is independent of cudafor.
!
!  Conventions
!  -----------
!  * Every entry point returns its C status code as an INTEGER(c_int)
!    function result (cudaError_t / CUresult).
!  * Opaque handles (streams, events, graphs, arrays, ...) are pointers
!    in C and map to TYPE(c_ptr): by VALUE when passed in, INTENT(OUT)
!    when returned (C  T*  where T is itself a pointer typedef).
!  * Device and host buffers (void*, T*) are TYPE(c_ptr), VALUE. Pass a
!    device address, or C_LOC(host_array) for host data.
!  * Enumerators are PUBLIC INTEGER(c_int) PARAMETERs with their C names.
!  * Structs are BIND(C) derived types whose layout has been verified
!    against sizeof/offsetof from a compiled C probe. C unions have no
!    Fortran equivalent and appear as INTEGER(c_int8_t) byte arrays of
!    the correct size.
!  * Fortran is case-insensitive; the C names are preserved verbatim and
!    checked for case-insensitive collisions at generation time.
! ==========================================================================
module pic_hip_runtime
    use, intrinsic :: iso_c_binding
    implicit none
    public

    ! ======================================================================
    !  Enumerations
    ! ======================================================================
    ! ---- hipJitOption
    integer(c_int), parameter :: hipJitOptionMaxRegisters = 0
    integer(c_int), parameter :: hipJitOptionThreadsPerBlock = 1
    integer(c_int), parameter :: hipJitOptionWallTime = 2
    integer(c_int), parameter :: hipJitOptionInfoLogBuffer = 3
    integer(c_int), parameter :: hipJitOptionInfoLogBufferSizeBytes = 4
    integer(c_int), parameter :: hipJitOptionErrorLogBuffer = 5
    integer(c_int), parameter :: hipJitOptionErrorLogBufferSizeBytes = 6
    integer(c_int), parameter :: hipJitOptionOptimizationLevel = 7
    integer(c_int), parameter :: hipJitOptionTargetFromContext = 8
    integer(c_int), parameter :: hipJitOptionTarget = 9
    integer(c_int), parameter :: hipJitOptionFallbackStrategy = 10
    integer(c_int), parameter :: hipJitOptionGenerateDebugInfo = 11
    integer(c_int), parameter :: hipJitOptionLogVerbose = 12
    integer(c_int), parameter :: hipJitOptionGenerateLineInfo = 13
    integer(c_int), parameter :: hipJitOptionCacheMode = 14
    integer(c_int), parameter :: hipJitOptionSm3xOpt = 15
    integer(c_int), parameter :: hipJitOptionFastCompile = 16
    integer(c_int), parameter :: hipJitOptionGlobalSymbolNames = 17
    integer(c_int), parameter :: hipJitOptionGlobalSymbolAddresses = 18
    integer(c_int), parameter :: hipJitOptionGlobalSymbolCount = 19
    integer(c_int), parameter :: hipJitOptionLto = 20
    integer(c_int), parameter :: hipJitOptionFtz = 21
    integer(c_int), parameter :: hipJitOptionPrecDiv = 22
    integer(c_int), parameter :: hipJitOptionPrecSqrt = 23
    integer(c_int), parameter :: hipJitOptionFma = 24
    integer(c_int), parameter :: hipJitOptionPositionIndependentCode = 25
    integer(c_int), parameter :: hipJitOptionMinCTAPerSM = 26
    integer(c_int), parameter :: hipJitOptionMaxThreadsPerBlock = 27
    integer(c_int), parameter :: hipJitOptionOverrideDirectiveValues = 28
    integer(c_int), parameter :: hipJitOptionNumOptions = 29
    integer(c_int), parameter :: hipJitOptionIRtoISAOptExt = 10000
    integer(c_int), parameter :: hipJitOptionIRtoISAOptCountExt = 10001

    ! ---- hipJitInputType
    integer(c_int), parameter :: hipJitInputCubin = 0
    integer(c_int), parameter :: hipJitInputPtx = 1
    integer(c_int), parameter :: hipJitInputFatBinary = 2
    integer(c_int), parameter :: hipJitInputObject = 3
    integer(c_int), parameter :: hipJitInputLibrary = 4
    integer(c_int), parameter :: hipJitInputNvvm = 5
    integer(c_int), parameter :: hipJitNumLegacyInputTypes = 6
    integer(c_int), parameter :: hipJitInputLLVMBitcode = 100
    integer(c_int), parameter :: hipJitInputLLVMBundledBitcode = 101
    integer(c_int), parameter :: hipJitInputLLVMArchivesOfBundledBitcode = 102
    integer(c_int), parameter :: hipJitInputSpirv = 103
    integer(c_int), parameter :: hipJitNumInputTypes = 10

    ! ---- hipJitCacheMode
    integer(c_int), parameter :: hipJitCacheOptionNone = 0
    integer(c_int), parameter :: hipJitCacheOptionCG = 1
    integer(c_int), parameter :: hipJitCacheOptionCA = 2

    ! ---- hipJitFallback
    integer(c_int), parameter :: hipJitPreferPTX = 0
    integer(c_int), parameter :: hipJitPreferBinary = 1

    ! ---- hipLibraryOption
    integer(c_int), parameter :: hipLibraryHostUniversalFunctionAndDataTable = 0
    integer(c_int), parameter :: hipLibraryBinaryIsPreserved = 1

    integer(c_int), parameter :: HIP_SUCCESS = 0
    integer(c_int), parameter :: HIP_ERROR_INVALID_VALUE = 1
    integer(c_int), parameter :: HIP_ERROR_NOT_INITIALIZED = 2
    integer(c_int), parameter :: HIP_ERROR_LAUNCH_OUT_OF_RESOURCES = 3

    ! ---- hipMemoryType
    integer(c_int), parameter :: hipMemoryTypeUnregistered = 0
    integer(c_int), parameter :: hipMemoryTypeHost = 1
    integer(c_int), parameter :: hipMemoryTypeDevice = 2
    integer(c_int), parameter :: hipMemoryTypeManaged = 3
    integer(c_int), parameter :: hipMemoryTypeArray = 10
    integer(c_int), parameter :: hipMemoryTypeUnified = 11

    ! ---- hipError_t
    integer(c_int), parameter :: hipSuccess = 0
    integer(c_int), parameter :: hipErrorInvalidValue = 1
    integer(c_int), parameter :: hipErrorOutOfMemory = 2
    integer(c_int), parameter :: hipErrorMemoryAllocation = 2
    integer(c_int), parameter :: hipErrorNotInitialized = 3
    integer(c_int), parameter :: hipErrorInitializationError = 3
    integer(c_int), parameter :: hipErrorDeinitialized = 4
    integer(c_int), parameter :: hipErrorProfilerDisabled = 5
    integer(c_int), parameter :: hipErrorProfilerNotInitialized = 6
    integer(c_int), parameter :: hipErrorProfilerAlreadyStarted = 7
    integer(c_int), parameter :: hipErrorProfilerAlreadyStopped = 8
    integer(c_int), parameter :: hipErrorInvalidConfiguration = 9
    integer(c_int), parameter :: hipErrorInvalidPitchValue = 12
    integer(c_int), parameter :: hipErrorInvalidSymbol = 13
    integer(c_int), parameter :: hipErrorInvalidDevicePointer = 17
    integer(c_int), parameter :: hipErrorInvalidMemcpyDirection = 21
    integer(c_int), parameter :: hipErrorInsufficientDriver = 35
    integer(c_int), parameter :: hipErrorMissingConfiguration = 52
    integer(c_int), parameter :: hipErrorPriorLaunchFailure = 53
    integer(c_int), parameter :: hipErrorInvalidDeviceFunction = 98
    integer(c_int), parameter :: hipErrorNoDevice = 100
    integer(c_int), parameter :: hipErrorInvalidDevice = 101
    integer(c_int), parameter :: hipErrorInvalidImage = 200
    integer(c_int), parameter :: hipErrorInvalidContext = 201
    integer(c_int), parameter :: hipErrorContextAlreadyCurrent = 202
    integer(c_int), parameter :: hipErrorMapFailed = 205
    integer(c_int), parameter :: hipErrorMapBufferObjectFailed = 205
    integer(c_int), parameter :: hipErrorUnmapFailed = 206
    integer(c_int), parameter :: hipErrorArrayIsMapped = 207
    integer(c_int), parameter :: hipErrorAlreadyMapped = 208
    integer(c_int), parameter :: hipErrorNoBinaryForGpu = 209
    integer(c_int), parameter :: hipErrorAlreadyAcquired = 210
    integer(c_int), parameter :: hipErrorNotMapped = 211
    integer(c_int), parameter :: hipErrorNotMappedAsArray = 212
    integer(c_int), parameter :: hipErrorNotMappedAsPointer = 213
    integer(c_int), parameter :: hipErrorECCNotCorrectable = 214
    integer(c_int), parameter :: hipErrorUnsupportedLimit = 215
    integer(c_int), parameter :: hipErrorContextAlreadyInUse = 216
    integer(c_int), parameter :: hipErrorPeerAccessUnsupported = 217
    integer(c_int), parameter :: hipErrorInvalidKernelFile = 218
    integer(c_int), parameter :: hipErrorInvalidGraphicsContext = 219
    integer(c_int), parameter :: hipErrorInvalidSource = 300
    integer(c_int), parameter :: hipErrorFileNotFound = 301
    integer(c_int), parameter :: hipErrorSharedObjectSymbolNotFound = 302
    integer(c_int), parameter :: hipErrorSharedObjectInitFailed = 303
    integer(c_int), parameter :: hipErrorOperatingSystem = 304
    integer(c_int), parameter :: hipErrorInvalidHandle = 400
    integer(c_int), parameter :: hipErrorInvalidResourceHandle = 400
    integer(c_int), parameter :: hipErrorIllegalState = 401
    integer(c_int), parameter :: hipErrorNotFound = 500
    integer(c_int), parameter :: hipErrorNotReady = 600
    integer(c_int), parameter :: hipErrorIllegalAddress = 700
    integer(c_int), parameter :: hipErrorLaunchOutOfResources = 701
    integer(c_int), parameter :: hipErrorLaunchTimeOut = 702
    integer(c_int), parameter :: hipErrorPeerAccessAlreadyEnabled = 704
    integer(c_int), parameter :: hipErrorPeerAccessNotEnabled = 705
    integer(c_int), parameter :: hipErrorSetOnActiveProcess = 708
    integer(c_int), parameter :: hipErrorContextIsDestroyed = 709
    integer(c_int), parameter :: hipErrorAssert = 710
    integer(c_int), parameter :: hipErrorHostMemoryAlreadyRegistered = 712
    integer(c_int), parameter :: hipErrorHostMemoryNotRegistered = 713
    integer(c_int), parameter :: hipErrorLaunchFailure = 719
    integer(c_int), parameter :: hipErrorCooperativeLaunchTooLarge = 720
    integer(c_int), parameter :: hipErrorNotSupported = 801
    integer(c_int), parameter :: hipErrorStreamCaptureUnsupported = 900
    integer(c_int), parameter :: hipErrorStreamCaptureInvalidated = 901
    integer(c_int), parameter :: hipErrorStreamCaptureMerge = 902
    integer(c_int), parameter :: hipErrorStreamCaptureUnmatched = 903
    integer(c_int), parameter :: hipErrorStreamCaptureUnjoined = 904
    integer(c_int), parameter :: hipErrorStreamCaptureIsolation = 905
    integer(c_int), parameter :: hipErrorStreamCaptureImplicit = 906
    integer(c_int), parameter :: hipErrorCapturedEvent = 907
    integer(c_int), parameter :: hipErrorStreamCaptureWrongThread = 908
    integer(c_int), parameter :: hipErrorGraphExecUpdateFailure = 910
    integer(c_int), parameter :: hipErrorInvalidChannelDescriptor = 911
    integer(c_int), parameter :: hipErrorInvalidTexture = 912
    integer(c_int), parameter :: hipErrorUnknown = 999
    integer(c_int), parameter :: hipErrorRuntimeMemory = 1052
    integer(c_int), parameter :: hipErrorRuntimeOther = 1053
    integer(c_int), parameter :: hipErrorTbd = 1054

    ! ---- hipDeviceAttribute_t
    integer(c_int), parameter :: hipDeviceAttributeCudaCompatibleBegin = 0
    integer(c_int), parameter :: hipDeviceAttributeEccEnabled = 0
    integer(c_int), parameter :: hipDeviceAttributeAccessPolicyMaxWindowSize = 1
    integer(c_int), parameter :: hipDeviceAttributeAsyncEngineCount = 2
    integer(c_int), parameter :: hipDeviceAttributeCanMapHostMemory = 3
    integer(c_int), parameter :: hipDeviceAttributeCanUseHostPointerForRegisteredMem = 4
    integer(c_int), parameter :: hipDeviceAttributeClockRate = 5
    integer(c_int), parameter :: hipDeviceAttributeComputeMode = 6
    integer(c_int), parameter :: hipDeviceAttributeComputePreemptionSupported = 7
    integer(c_int), parameter :: hipDeviceAttributeConcurrentKernels = 8
    integer(c_int), parameter :: hipDeviceAttributeConcurrentManagedAccess = 9
    integer(c_int), parameter :: hipDeviceAttributeCooperativeLaunch = 10
    integer(c_int), parameter :: hipDeviceAttributeCooperativeMultiDeviceLaunch = 11
    integer(c_int), parameter :: hipDeviceAttributeDeviceOverlap = 12
    integer(c_int), parameter :: hipDeviceAttributeDirectManagedMemAccessFromHost = 13
    integer(c_int), parameter :: hipDeviceAttributeGlobalL1CacheSupported = 14
    integer(c_int), parameter :: hipDeviceAttributeHostNativeAtomicSupported = 15
    integer(c_int), parameter :: hipDeviceAttributeIntegrated = 16
    integer(c_int), parameter :: hipDeviceAttributeIsMultiGpuBoard = 17
    integer(c_int), parameter :: hipDeviceAttributeKernelExecTimeout = 18
    integer(c_int), parameter :: hipDeviceAttributeL2CacheSize = 19
    integer(c_int), parameter :: hipDeviceAttributeLocalL1CacheSupported = 20
    integer(c_int), parameter :: hipDeviceAttributeLuid = 21
    integer(c_int), parameter :: hipDeviceAttributeLuidDeviceNodeMask = 22
    integer(c_int), parameter :: hipDeviceAttributeComputeCapabilityMajor = 23
    integer(c_int), parameter :: hipDeviceAttributeManagedMemory = 24
    integer(c_int), parameter :: hipDeviceAttributeMaxBlocksPerMultiProcessor = 25
    integer(c_int), parameter :: hipDeviceAttributeMaxBlockDimX = 26
    integer(c_int), parameter :: hipDeviceAttributeMaxBlockDimY = 27
    integer(c_int), parameter :: hipDeviceAttributeMaxBlockDimZ = 28
    integer(c_int), parameter :: hipDeviceAttributeMaxGridDimX = 29
    integer(c_int), parameter :: hipDeviceAttributeMaxGridDimY = 30
    integer(c_int), parameter :: hipDeviceAttributeMaxGridDimZ = 31
    integer(c_int), parameter :: hipDeviceAttributeMaxSurface1D = 32
    integer(c_int), parameter :: hipDeviceAttributeMaxSurface1DLayered = 33
    integer(c_int), parameter :: hipDeviceAttributeMaxSurface2D = 34
    integer(c_int), parameter :: hipDeviceAttributeMaxSurface2DLayered = 35
    integer(c_int), parameter :: hipDeviceAttributeMaxSurface3D = 36
    integer(c_int), parameter :: hipDeviceAttributeMaxSurfaceCubemap = 37
    integer(c_int), parameter :: hipDeviceAttributeMaxSurfaceCubemapLayered = 38
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture1DWidth = 39
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture1DLayered = 40
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture1DLinear = 41
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture1DMipmap = 42
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture2DWidth = 43
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture2DHeight = 44
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture2DGather = 45
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture2DLayered = 46
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture2DLinear = 47
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture2DMipmap = 48
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture3DWidth = 49
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture3DHeight = 50
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture3DDepth = 51
    integer(c_int), parameter :: hipDeviceAttributeMaxTexture3DAlt = 52
    integer(c_int), parameter :: hipDeviceAttributeMaxTextureCubemap = 53
    integer(c_int), parameter :: hipDeviceAttributeMaxTextureCubemapLayered = 54
    integer(c_int), parameter :: hipDeviceAttributeMaxThreadsDim = 55
    integer(c_int), parameter :: hipDeviceAttributeMaxThreadsPerBlock = 56
    integer(c_int), parameter :: hipDeviceAttributeMaxThreadsPerMultiProcessor = 57
    integer(c_int), parameter :: hipDeviceAttributeMaxPitch = 58
    integer(c_int), parameter :: hipDeviceAttributeMemoryBusWidth = 59
    integer(c_int), parameter :: hipDeviceAttributeMemoryClockRate = 60
    integer(c_int), parameter :: hipDeviceAttributeComputeCapabilityMinor = 61
    integer(c_int), parameter :: hipDeviceAttributeMultiGpuBoardGroupID = 62
    integer(c_int), parameter :: hipDeviceAttributeMultiprocessorCount = 63
    integer(c_int), parameter :: hipDeviceAttributeUnused1 = 64
    integer(c_int), parameter :: hipDeviceAttributePageableMemoryAccess = 65
    integer(c_int), parameter :: hipDeviceAttributePageableMemoryAccessUsesHostPageTables = 66
    integer(c_int), parameter :: hipDeviceAttributePciBusId = 67
    integer(c_int), parameter :: hipDeviceAttributePciDeviceId = 68
    integer(c_int), parameter :: hipDeviceAttributePciDomainId = 69
    integer(c_int), parameter :: hipDeviceAttributePersistingL2CacheMaxSize = 70
    integer(c_int), parameter :: hipDeviceAttributeMaxRegistersPerBlock = 71
    integer(c_int), parameter :: hipDeviceAttributeMaxRegistersPerMultiprocessor = 72
    integer(c_int), parameter :: hipDeviceAttributeReservedSharedMemPerBlock = 73
    integer(c_int), parameter :: hipDeviceAttributeMaxSharedMemoryPerBlock = 74
    integer(c_int), parameter :: hipDeviceAttributeSharedMemPerBlockOptin = 75
    integer(c_int), parameter :: hipDeviceAttributeSharedMemPerMultiprocessor = 76
    integer(c_int), parameter :: hipDeviceAttributeSingleToDoublePrecisionPerfRatio = 77
    integer(c_int), parameter :: hipDeviceAttributeStreamPrioritiesSupported = 78
    integer(c_int), parameter :: hipDeviceAttributeSurfaceAlignment = 79
    integer(c_int), parameter :: hipDeviceAttributeTccDriver = 80
    integer(c_int), parameter :: hipDeviceAttributeTextureAlignment = 81
    integer(c_int), parameter :: hipDeviceAttributeTexturePitchAlignment = 82
    integer(c_int), parameter :: hipDeviceAttributeTotalConstantMemory = 83
    integer(c_int), parameter :: hipDeviceAttributeTotalGlobalMem = 84
    integer(c_int), parameter :: hipDeviceAttributeUnifiedAddressing = 85
    integer(c_int), parameter :: hipDeviceAttributeUnused2 = 86
    integer(c_int), parameter :: hipDeviceAttributeWarpSize = 87
    integer(c_int), parameter :: hipDeviceAttributeMemoryPoolsSupported = 88
    integer(c_int), parameter :: hipDeviceAttributeVirtualMemoryManagementSupported = 89
    integer(c_int), parameter :: hipDeviceAttributeHostRegisterSupported = 90
    integer(c_int), parameter :: hipDeviceAttributeMemoryPoolSupportedHandleTypes = 91
    integer(c_int), parameter :: hipDeviceAttributeHostNumaId = 92
    integer(c_int), parameter :: hipDeviceAttributeDmaBufSupported = 93
    integer(c_int), parameter :: hipDeviceAttributeGPUDirectRDMAWithHipVMMSupported = 94
    integer(c_int), parameter :: hipDeviceAttributeHandleTypeFabricSupported = 95
    integer(c_int), parameter :: hipDeviceAttributeCudaCompatibleEnd = 9999
    integer(c_int), parameter :: hipDeviceAttributeAmdSpecificBegin = 10000
    integer(c_int), parameter :: hipDeviceAttributeClockInstructionRate = 10000
    integer(c_int), parameter :: hipDeviceAttributeUnused3 = 10001
    integer(c_int), parameter :: hipDeviceAttributeMaxSharedMemoryPerMultiprocessor = 10002
    integer(c_int), parameter :: hipDeviceAttributeUnused4 = 10003
    integer(c_int), parameter :: hipDeviceAttributeUnused5 = 10004
    integer(c_int), parameter :: hipDeviceAttributeHdpMemFlushCntl = 10005
    integer(c_int), parameter :: hipDeviceAttributeHdpRegFlushCntl = 10006
    integer(c_int), parameter :: hipDeviceAttributeCooperativeMultiDeviceUnmatchedFunc = 10007
    integer(c_int), parameter :: hipDeviceAttributeCooperativeMultiDeviceUnmatchedGridDim = 10008
    integer(c_int), parameter :: hipDeviceAttributeCooperativeMultiDeviceUnmatchedBlockDim = 10009
    integer(c_int), parameter :: hipDeviceAttributeCooperativeMultiDeviceUnmatchedSharedMem = 10010
    integer(c_int), parameter :: hipDeviceAttributeIsLargeBar = 10011
    integer(c_int), parameter :: hipDeviceAttributeAsicRevision = 10012
    integer(c_int), parameter :: hipDeviceAttributeCanUseStreamWaitValue = 10013
    integer(c_int), parameter :: hipDeviceAttributeImageSupport = 10014
    integer(c_int), parameter :: hipDeviceAttributePhysicalMultiProcessorCount = 10015
    integer(c_int), parameter :: hipDeviceAttributeFineGrainSupport = 10016
    integer(c_int), parameter :: hipDeviceAttributeWallClockRate = 10017
    integer(c_int), parameter :: hipDeviceAttributeNumberOfXccs = 10018
    integer(c_int), parameter :: hipDeviceAttributeMaxAvailableVgprsPerThread = 10019
    integer(c_int), parameter :: hipDeviceAttributePciChipId = 10020
    integer(c_int), parameter :: hipDeviceAttributeExpertSchedMode = 10021
    integer(c_int), parameter :: hipDeviceAttributeAmdSpecificEnd = 19999
    integer(c_int), parameter :: hipDeviceAttributeVendorSpecificBegin = 20000

    ! ---- hipDriverProcAddressQueryResult
    integer(c_int), parameter :: HIP_GET_PROC_ADDRESS_SUCCESS = 0
    integer(c_int), parameter :: HIP_GET_PROC_ADDRESS_SYMBOL_NOT_FOUND = 1
    integer(c_int), parameter :: HIP_GET_PROC_ADDRESS_VERSION_NOT_SUFFICIENT = 2

    ! ---- hipComputeMode
    integer(c_int), parameter :: hipComputeModeDefault = 0
    integer(c_int), parameter :: hipComputeModeExclusive = 1
    integer(c_int), parameter :: hipComputeModeProhibited = 2
    integer(c_int), parameter :: hipComputeModeExclusiveProcess = 3

    ! ---- hipFlushGPUDirectRDMAWritesOptions
    integer(c_int), parameter :: hipFlushGPUDirectRDMAWritesOptionHost = 1
    integer(c_int), parameter :: hipFlushGPUDirectRDMAWritesOptionMemOps = 2

    ! ---- hipGPUDirectRDMAWritesOrdering
    integer(c_int), parameter :: hipGPUDirectRDMAWritesOrderingNone = 0
    integer(c_int), parameter :: hipGPUDirectRDMAWritesOrderingOwner = 100
    integer(c_int), parameter :: hipGPUDirectRDMAWritesOrderingAllDevices = 200

    ! ---- hipChannelFormatKind
    integer(c_int), parameter :: hipChannelFormatKindSigned = 0
    integer(c_int), parameter :: hipChannelFormatKindUnsigned = 1
    integer(c_int), parameter :: hipChannelFormatKindFloat = 2
    integer(c_int), parameter :: hipChannelFormatKindNone = 3

    ! ---- hipArray_Format
    integer(c_int), parameter :: HIP_AD_FORMAT_UNSIGNED_INT8 = 1
    integer(c_int), parameter :: HIP_AD_FORMAT_UNSIGNED_INT16 = 2
    integer(c_int), parameter :: HIP_AD_FORMAT_UNSIGNED_INT32 = 3
    integer(c_int), parameter :: HIP_AD_FORMAT_SIGNED_INT8 = 8
    integer(c_int), parameter :: HIP_AD_FORMAT_SIGNED_INT16 = 9
    integer(c_int), parameter :: HIP_AD_FORMAT_SIGNED_INT32 = 10
    integer(c_int), parameter :: HIP_AD_FORMAT_HALF = 16
    integer(c_int), parameter :: HIP_AD_FORMAT_FLOAT = 32

    ! ---- hipResourceType
    integer(c_int), parameter :: hipResourceTypeArray = 0
    integer(c_int), parameter :: hipResourceTypeMipmappedArray = 1
    integer(c_int), parameter :: hipResourceTypeLinear = 2
    integer(c_int), parameter :: hipResourceTypePitch2D = 3

    ! ---- HIPaddress_mode
    integer(c_int), parameter :: HIP_RESOURCE_TYPE_ARRAY = 0
    integer(c_int), parameter :: HIP_RESOURCE_TYPE_MIPMAPPED_ARRAY = 1
    integer(c_int), parameter :: HIP_RESOURCE_TYPE_LINEAR = 2
    integer(c_int), parameter :: HIP_TR_ADDRESS_MODE_CLAMP = 1
    integer(c_int), parameter :: HIP_TR_ADDRESS_MODE_MIRROR = 2
    integer(c_int), parameter :: HIP_TR_ADDRESS_MODE_BORDER = 3

    ! ---- HIPfilter_mode
    integer(c_int), parameter :: HIP_TR_FILTER_MODE_POINT = 0
    integer(c_int), parameter :: HIP_TR_FILTER_MODE_LINEAR = 1

    ! ---- hipResourceViewFormat
    integer(c_int), parameter :: hipResViewFormatNone = 0
    integer(c_int), parameter :: hipResViewFormatUnsignedChar1 = 1
    integer(c_int), parameter :: hipResViewFormatUnsignedChar2 = 2
    integer(c_int), parameter :: hipResViewFormatUnsignedChar4 = 3
    integer(c_int), parameter :: hipResViewFormatSignedChar1 = 4
    integer(c_int), parameter :: hipResViewFormatSignedChar2 = 5
    integer(c_int), parameter :: hipResViewFormatSignedChar4 = 6
    integer(c_int), parameter :: hipResViewFormatUnsignedShort1 = 7
    integer(c_int), parameter :: hipResViewFormatUnsignedShort2 = 8
    integer(c_int), parameter :: hipResViewFormatUnsignedShort4 = 9
    integer(c_int), parameter :: hipResViewFormatSignedShort1 = 10
    integer(c_int), parameter :: hipResViewFormatSignedShort2 = 11
    integer(c_int), parameter :: hipResViewFormatSignedShort4 = 12
    integer(c_int), parameter :: hipResViewFormatUnsignedInt1 = 13
    integer(c_int), parameter :: hipResViewFormatUnsignedInt2 = 14
    integer(c_int), parameter :: hipResViewFormatUnsignedInt4 = 15
    integer(c_int), parameter :: hipResViewFormatSignedInt1 = 16
    integer(c_int), parameter :: hipResViewFormatSignedInt2 = 17
    integer(c_int), parameter :: hipResViewFormatSignedInt4 = 18
    integer(c_int), parameter :: hipResViewFormatHalf1 = 19
    integer(c_int), parameter :: hipResViewFormatHalf2 = 20
    integer(c_int), parameter :: hipResViewFormatHalf4 = 21
    integer(c_int), parameter :: hipResViewFormatFloat1 = 22
    integer(c_int), parameter :: hipResViewFormatFloat2 = 23
    integer(c_int), parameter :: hipResViewFormatFloat4 = 24
    integer(c_int), parameter :: hipResViewFormatUnsignedBlockCompressed1 = 25
    integer(c_int), parameter :: hipResViewFormatUnsignedBlockCompressed2 = 26
    integer(c_int), parameter :: hipResViewFormatUnsignedBlockCompressed3 = 27
    integer(c_int), parameter :: hipResViewFormatUnsignedBlockCompressed4 = 28
    integer(c_int), parameter :: hipResViewFormatSignedBlockCompressed4 = 29
    integer(c_int), parameter :: hipResViewFormatUnsignedBlockCompressed5 = 30
    integer(c_int), parameter :: hipResViewFormatSignedBlockCompressed5 = 31
    integer(c_int), parameter :: hipResViewFormatUnsignedBlockCompressed6H = 32
    integer(c_int), parameter :: hipResViewFormatSignedBlockCompressed6H = 33
    integer(c_int), parameter :: hipResViewFormatUnsignedBlockCompressed7 = 34

    ! ---- HIPresourceViewFormat
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_NONE = 0
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UINT_1X8 = 1
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UINT_2X8 = 2
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UINT_4X8 = 3
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SINT_1X8 = 4
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SINT_2X8 = 5
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SINT_4X8 = 6
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UINT_1X16 = 7
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UINT_2X16 = 8
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UINT_4X16 = 9
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SINT_1X16 = 10
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SINT_2X16 = 11
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SINT_4X16 = 12
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UINT_1X32 = 13
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UINT_2X32 = 14
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UINT_4X32 = 15
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SINT_1X32 = 16
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SINT_2X32 = 17
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SINT_4X32 = 18
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_FLOAT_1X16 = 19
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_FLOAT_2X16 = 20
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_FLOAT_4X16 = 21
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_FLOAT_1X32 = 22
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_FLOAT_2X32 = 23
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_FLOAT_4X32 = 24
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UNSIGNED_BC1 = 25
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UNSIGNED_BC2 = 26
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UNSIGNED_BC3 = 27
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UNSIGNED_BC4 = 28
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SIGNED_BC4 = 29
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UNSIGNED_BC5 = 30
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SIGNED_BC5 = 31
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UNSIGNED_BC6H = 32
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_SIGNED_BC6H = 33
    integer(c_int), parameter :: HIP_RES_VIEW_FORMAT_UNSIGNED_BC7 = 34

    ! ---- hipMemcpyKind
    integer(c_int), parameter :: hipMemcpyHostToHost = 0
    integer(c_int), parameter :: hipMemcpyHostToDevice = 1
    integer(c_int), parameter :: hipMemcpyDeviceToHost = 2
    integer(c_int), parameter :: hipMemcpyDeviceToDevice = 3
    integer(c_int), parameter :: hipMemcpyDefault = 4
    integer(c_int), parameter :: hipMemcpyDeviceToDeviceNoCU = 1024

    ! ---- hipMemLocationType
    integer(c_int), parameter :: hipMemLocationTypeInvalid = 0
    integer(c_int), parameter :: hipMemLocationTypeNone = 0
    integer(c_int), parameter :: hipMemLocationTypeDevice = 1
    integer(c_int), parameter :: hipMemLocationTypeHost = 2
    integer(c_int), parameter :: hipMemLocationTypeHostNuma = 3
    integer(c_int), parameter :: hipMemLocationTypeHostNumaCurrent = 4

    ! ---- hipMemcpyFlags
    integer(c_int), parameter :: hipMemcpyFlagDefault = 0
    integer(c_int), parameter :: hipMemcpyFlagPreferOverlapWithCompute = 1
    integer(c_int), parameter :: hipMemcpyFlagExtPreferCE = 256
    integer(c_int), parameter :: hipMemcpyFlagExtOpSwap = 512

    ! ---- hipMemcpySrcAccessOrder
    integer(c_int), parameter :: hipMemcpySrcAccessOrderInvalid = 0
    integer(c_int), parameter :: hipMemcpySrcAccessOrderStream = 1
    integer(c_int), parameter :: hipMemcpySrcAccessOrderDuringApiCall = 2
    integer(c_int), parameter :: hipMemcpySrcAccessOrderAny = 3
    integer(c_int), parameter :: hipMemcpySrcAccessOrderMax = 2147483647

    ! ---- hipMemcpy3DOperandType
    integer(c_int), parameter :: hipMemcpyOperandTypePointer = 1
    integer(c_int), parameter :: hipMemcpyOperandTypeArray = 2
    integer(c_int), parameter :: hipMemcpyOperandTypeMax = 2147483647

    ! ---- hipFunction_attribute
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK = 0
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES = 1
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_CONST_SIZE_BYTES = 2
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES = 3
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_NUM_REGS = 4
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_PTX_VERSION = 5
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_BINARY_VERSION = 6
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_CACHE_MODE_CA = 7
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_MAX_DYNAMIC_SHARED_SIZE_BYTES = 8
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT = 9
    integer(c_int), parameter :: HIP_FUNC_ATTRIBUTE_MAX = 10

    ! ---- hipPointer_attribute
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_CONTEXT = 1
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_MEMORY_TYPE = 2
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_DEVICE_POINTER = 3
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_HOST_POINTER = 4
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_P2P_TOKENS = 5
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_SYNC_MEMOPS = 6
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_BUFFER_ID = 7
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_IS_MANAGED = 8
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_DEVICE_ORDINAL = 9
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_IS_LEGACY_HIP_IPC_CAPABLE = 10
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_RANGE_START_ADDR = 11
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_RANGE_SIZE = 12
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_MAPPED = 13
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_ALLOWED_HANDLE_TYPES = 14
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_IS_GPU_DIRECT_RDMA_CAPABLE = 15
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_ACCESS_FLAGS = 16
    integer(c_int), parameter :: HIP_POINTER_ATTRIBUTE_MEMPOOL_HANDLE = 17

    ! ---- hipTextureAddressMode
    integer(c_int), parameter :: hipAddressModeWrap = 0
    integer(c_int), parameter :: hipAddressModeClamp = 1
    integer(c_int), parameter :: hipAddressModeMirror = 2
    integer(c_int), parameter :: hipAddressModeBorder = 3

    ! ---- hipTextureFilterMode
    integer(c_int), parameter :: hipFilterModePoint = 0
    integer(c_int), parameter :: hipFilterModeLinear = 1

    ! ---- hipTextureReadMode
    integer(c_int), parameter :: hipReadModeElementType = 0
    integer(c_int), parameter :: hipReadModeNormalizedFloat = 1

    ! ---- hipSurfaceBoundaryMode
    integer(c_int), parameter :: hipBoundaryModeZero = 0
    integer(c_int), parameter :: hipBoundaryModeTrap = 1
    integer(c_int), parameter :: hipBoundaryModeClamp = 2

    ! ---- hipDeviceP2PAttr
    integer(c_int), parameter :: hipDevP2PAttrPerformanceRank = 0
    integer(c_int), parameter :: hipDevP2PAttrAccessSupported = 1
    integer(c_int), parameter :: hipDevP2PAttrNativeAtomicSupported = 2
    integer(c_int), parameter :: hipDevP2PAttrHipArrayAccessSupported = 3

    ! ---- hipDriverEntryPointQueryResult
    integer(c_int), parameter :: hipDriverEntryPointSuccess = 0
    integer(c_int), parameter :: hipDriverEntryPointSymbolNotFound = 1
    integer(c_int), parameter :: hipDriverEntryPointVersionNotSufficent = 2

    ! ---- hipLimit_t
    integer(c_int), parameter :: hipLimitStackSize = 0
    integer(c_int), parameter :: hipLimitPrintfFifoSize = 1
    integer(c_int), parameter :: hipLimitMallocHeapSize = 2
    integer(c_int), parameter :: hipExtLimitScratchMin = 4096
    integer(c_int), parameter :: hipExtLimitScratchMax = 4097
    integer(c_int), parameter :: hipExtLimitScratchCurrent = 4098
    integer(c_int), parameter :: hipLimitRange = 4099

    ! ---- hipStreamBatchMemOpType
    integer(c_int), parameter :: hipStreamMemOpWaitValue32 = 1
    integer(c_int), parameter :: hipStreamMemOpWriteValue32 = 2
    integer(c_int), parameter :: hipStreamMemOpWaitValue64 = 4
    integer(c_int), parameter :: hipStreamMemOpWriteValue64 = 5
    integer(c_int), parameter :: hipStreamMemOpBarrier = 6
    integer(c_int), parameter :: hipStreamMemOpFlushRemoteWrites = 3

    ! ---- hipMemoryAdvise
    integer(c_int), parameter :: hipMemAdviseSetReadMostly = 1
    integer(c_int), parameter :: hipMemAdviseUnsetReadMostly = 2
    integer(c_int), parameter :: hipMemAdviseSetPreferredLocation = 3
    integer(c_int), parameter :: hipMemAdviseUnsetPreferredLocation = 4
    integer(c_int), parameter :: hipMemAdviseSetAccessedBy = 5
    integer(c_int), parameter :: hipMemAdviseUnsetAccessedBy = 6
    integer(c_int), parameter :: hipMemAdviseSetCoarseGrain = 100
    integer(c_int), parameter :: hipMemAdviseUnsetCoarseGrain = 101

    ! ---- hipMemRangeCoherencyMode
    integer(c_int), parameter :: hipMemRangeCoherencyModeFineGrain = 0
    integer(c_int), parameter :: hipMemRangeCoherencyModeCoarseGrain = 1
    integer(c_int), parameter :: hipMemRangeCoherencyModeIndeterminate = 2

    ! ---- hipMemRangeAttribute
    integer(c_int), parameter :: hipMemRangeAttributeReadMostly = 1
    integer(c_int), parameter :: hipMemRangeAttributePreferredLocation = 2
    integer(c_int), parameter :: hipMemRangeAttributeAccessedBy = 3
    integer(c_int), parameter :: hipMemRangeAttributeLastPrefetchLocation = 4
    integer(c_int), parameter :: hipMemRangeAttributeCoherencyMode = 100

    ! ---- hipMemPoolAttr
    integer(c_int), parameter :: hipMemPoolReuseFollowEventDependencies = 1
    integer(c_int), parameter :: hipMemPoolReuseAllowOpportunistic = 2
    integer(c_int), parameter :: hipMemPoolReuseAllowInternalDependencies = 3
    integer(c_int), parameter :: hipMemPoolAttrReleaseThreshold = 4
    integer(c_int), parameter :: hipMemPoolAttrReservedMemCurrent = 5
    integer(c_int), parameter :: hipMemPoolAttrReservedMemHigh = 6
    integer(c_int), parameter :: hipMemPoolAttrUsedMemCurrent = 7
    integer(c_int), parameter :: hipMemPoolAttrUsedMemHigh = 8

    ! ---- hipMemAccessFlags
    integer(c_int), parameter :: hipMemAccessFlagsProtNone = 0
    integer(c_int), parameter :: hipMemAccessFlagsProtRead = 1
    integer(c_int), parameter :: hipMemAccessFlagsProtReadWrite = 3

    ! ---- hipMemAllocationType
    integer(c_int), parameter :: hipMemAllocationTypeInvalid = 0
    integer(c_int), parameter :: hipMemAllocationTypePinned = 1
    integer(c_int), parameter :: hipMemAllocationTypeManaged = 2
    integer(c_int), parameter :: hipMemAllocationTypeUncached = 1073741824
    integer(c_int), parameter :: hipMemAllocationTypeMax = 2147483647

    ! ---- hipMemAllocationHandleType
    integer(c_int), parameter :: hipMemHandleTypeNone = 0
    integer(c_int), parameter :: hipMemHandleTypePosixFileDescriptor = 1
    integer(c_int), parameter :: hipMemHandleTypeWin32 = 2
    integer(c_int), parameter :: hipMemHandleTypeWin32Kmt = 4
    integer(c_int), parameter :: hipMemHandleTypeFabric = 8

    ! ---- hipFuncAttribute
    integer(c_int), parameter :: hipFuncAttributeMaxDynamicSharedMemorySize = 8
    integer(c_int), parameter :: hipFuncAttributePreferredSharedMemoryCarveout = 9
    integer(c_int), parameter :: hipFuncAttributeMax = 10

    ! ---- hipFuncCache_t
    integer(c_int), parameter :: hipFuncCachePreferNone = 0
    integer(c_int), parameter :: hipFuncCachePreferShared = 1
    integer(c_int), parameter :: hipFuncCachePreferL1 = 2
    integer(c_int), parameter :: hipFuncCachePreferEqual = 3

    ! ---- hipSharedMemConfig
    integer(c_int), parameter :: hipSharedMemBankSizeDefault = 0
    integer(c_int), parameter :: hipSharedMemBankSizeFourByte = 1
    integer(c_int), parameter :: hipSharedMemBankSizeEightByte = 2

    ! ---- hipExternalMemoryHandleType
    integer(c_int), parameter :: hipExternalMemoryHandleTypeOpaqueFd = 1
    integer(c_int), parameter :: hipExternalMemoryHandleTypeOpaqueWin32 = 2
    integer(c_int), parameter :: hipExternalMemoryHandleTypeOpaqueWin32Kmt = 3
    integer(c_int), parameter :: hipExternalMemoryHandleTypeD3D12Heap = 4
    integer(c_int), parameter :: hipExternalMemoryHandleTypeD3D12Resource = 5
    integer(c_int), parameter :: hipExternalMemoryHandleTypeD3D11Resource = 6
    integer(c_int), parameter :: hipExternalMemoryHandleTypeD3D11ResourceKmt = 7
    integer(c_int), parameter :: hipExternalMemoryHandleTypeNvSciBuf = 8

    ! ---- hipExternalSemaphoreHandleType
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeOpaqueFd = 1
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeOpaqueWin32 = 2
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeOpaqueWin32Kmt = 3
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeD3D12Fence = 4
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeD3D11Fence = 5
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeNvSciSync = 6
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeKeyedMutex = 7
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeKeyedMutexKmt = 8
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeTimelineSemaphoreFd = 9
    integer(c_int), parameter :: hipExternalSemaphoreHandleTypeTimelineSemaphoreWin32 = 10

    ! ---- hipGraphicsRegisterFlags
    integer(c_int), parameter :: hipGraphicsRegisterFlagsNone = 0
    integer(c_int), parameter :: hipGraphicsRegisterFlagsReadOnly = 1
    integer(c_int), parameter :: hipGraphicsRegisterFlagsWriteDiscard = 2
    integer(c_int), parameter :: hipGraphicsRegisterFlagsSurfaceLoadStore = 4
    integer(c_int), parameter :: hipGraphicsRegisterFlagsTextureGather = 8

    ! ---- hipGraphNodeType
    integer(c_int), parameter :: hipGraphNodeTypeKernel = 0
    integer(c_int), parameter :: hipGraphNodeTypeMemcpy = 1
    integer(c_int), parameter :: hipGraphNodeTypeMemset = 2
    integer(c_int), parameter :: hipGraphNodeTypeHost = 3
    integer(c_int), parameter :: hipGraphNodeTypeGraph = 4
    integer(c_int), parameter :: hipGraphNodeTypeEmpty = 5
    integer(c_int), parameter :: hipGraphNodeTypeWaitEvent = 6
    integer(c_int), parameter :: hipGraphNodeTypeEventRecord = 7
    integer(c_int), parameter :: hipGraphNodeTypeExtSemaphoreSignal = 8
    integer(c_int), parameter :: hipGraphNodeTypeExtSemaphoreWait = 9
    integer(c_int), parameter :: hipGraphNodeTypeMemAlloc = 10
    integer(c_int), parameter :: hipGraphNodeTypeMemFree = 11
    integer(c_int), parameter :: hipGraphNodeTypeMemcpyFromSymbol = 12
    integer(c_int), parameter :: hipGraphNodeTypeMemcpyToSymbol = 13
    integer(c_int), parameter :: hipGraphNodeTypeBatchMemOp = 14
    integer(c_int), parameter :: hipGraphNodeTypeCount = 15

    ! ---- hipAccessProperty
    integer(c_int), parameter :: hipAccessPropertyNormal = 0
    integer(c_int), parameter :: hipAccessPropertyStreaming = 1
    integer(c_int), parameter :: hipAccessPropertyPersisting = 2

    ! ---- hipLaunchMemSyncDomain
    integer(c_int), parameter :: hipLaunchMemSyncDomainDefault = 0
    integer(c_int), parameter :: hipLaunchMemSyncDomainRemote = 1

    ! ---- hipSynchronizationPolicy
    integer(c_int), parameter :: hipSyncPolicyAuto = 1
    integer(c_int), parameter :: hipSyncPolicySpin = 2
    integer(c_int), parameter :: hipSyncPolicyYield = 3
    integer(c_int), parameter :: hipSyncPolicyBlockingSync = 4

    ! ---- hipLaunchAttributeID
    integer(c_int), parameter :: hipLaunchAttributeAccessPolicyWindow = 1
    integer(c_int), parameter :: hipLaunchAttributeCooperative = 2
    integer(c_int), parameter :: hipLaunchAttributeSynchronizationPolicy = 3
    integer(c_int), parameter :: hipLaunchAttributePriority = 8
    integer(c_int), parameter :: hipLaunchAttributeMemSyncDomainMap = 9
    integer(c_int), parameter :: hipLaunchAttributeMemSyncDomain = 10
    integer(c_int), parameter :: hipLaunchAttributeMax = 11

    ! ---- hipGraphExecUpdateResult
    integer(c_int), parameter :: hipGraphExecUpdateSuccess = 0
    integer(c_int), parameter :: hipGraphExecUpdateError = 1
    integer(c_int), parameter :: hipGraphExecUpdateErrorTopologyChanged = 2
    integer(c_int), parameter :: hipGraphExecUpdateErrorNodeTypeChanged = 3
    integer(c_int), parameter :: hipGraphExecUpdateErrorFunctionChanged = 4
    integer(c_int), parameter :: hipGraphExecUpdateErrorParametersChanged = 5
    integer(c_int), parameter :: hipGraphExecUpdateErrorNotSupported = 6
    integer(c_int), parameter :: hipGraphExecUpdateErrorUnsupportedFunctionChange = 7

    ! ---- hipStreamCaptureMode
    integer(c_int), parameter :: hipStreamCaptureModeGlobal = 0
    integer(c_int), parameter :: hipStreamCaptureModeThreadLocal = 1
    integer(c_int), parameter :: hipStreamCaptureModeRelaxed = 2

    ! ---- hipStreamCaptureStatus
    integer(c_int), parameter :: hipStreamCaptureStatusNone = 0
    integer(c_int), parameter :: hipStreamCaptureStatusActive = 1
    integer(c_int), parameter :: hipStreamCaptureStatusInvalidated = 2

    ! ---- hipStreamUpdateCaptureDependenciesFlags
    integer(c_int), parameter :: hipStreamAddCaptureDependencies = 0
    integer(c_int), parameter :: hipStreamSetCaptureDependencies = 1

    ! ---- hipGraphMemAttributeType
    integer(c_int), parameter :: hipGraphMemAttrUsedMemCurrent = 0
    integer(c_int), parameter :: hipGraphMemAttrUsedMemHigh = 1
    integer(c_int), parameter :: hipGraphMemAttrReservedMemCurrent = 2
    integer(c_int), parameter :: hipGraphMemAttrReservedMemHigh = 3

    ! ---- hipUserObjectFlags
    integer(c_int), parameter :: hipUserObjectNoDestructorSync = 1

    ! ---- hipUserObjectRetainFlags
    integer(c_int), parameter :: hipGraphUserObjectMove = 1

    ! ---- hipGraphInstantiateFlags
    integer(c_int), parameter :: hipGraphInstantiateFlagAutoFreeOnLaunch = 1
    integer(c_int), parameter :: hipGraphInstantiateFlagUpload = 2
    integer(c_int), parameter :: hipGraphInstantiateFlagDeviceLaunch = 4
    integer(c_int), parameter :: hipGraphInstantiateFlagUseNodePriority = 8

    ! ---- hipGraphDebugDotFlags
    integer(c_int), parameter :: hipGraphDebugDotFlagsVerbose = 1
    integer(c_int), parameter :: hipGraphDebugDotFlagsKernelNodeParams = 4
    integer(c_int), parameter :: hipGraphDebugDotFlagsMemcpyNodeParams = 8
    integer(c_int), parameter :: hipGraphDebugDotFlagsMemsetNodeParams = 16
    integer(c_int), parameter :: hipGraphDebugDotFlagsHostNodeParams = 32
    integer(c_int), parameter :: hipGraphDebugDotFlagsEventNodeParams = 64
    integer(c_int), parameter :: hipGraphDebugDotFlagsExtSemasSignalNodeParams = 128
    integer(c_int), parameter :: hipGraphDebugDotFlagsExtSemasWaitNodeParams = 256
    integer(c_int), parameter :: hipGraphDebugDotFlagsKernelNodeAttributes = 512
    integer(c_int), parameter :: hipGraphDebugDotFlagsHandles = 1024

    ! ---- hipGraphInstantiateResult
    integer(c_int), parameter :: hipGraphInstantiateSuccess = 0
    integer(c_int), parameter :: hipGraphInstantiateError = 1
    integer(c_int), parameter :: hipGraphInstantiateInvalidStructure = 2
    integer(c_int), parameter :: hipGraphInstantiateNodeOperationNotSupported = 3
    integer(c_int), parameter :: hipGraphInstantiateMultipleDevicesNotSupported = 4

    ! ---- hipMemAllocationGranularity_flags
    integer(c_int), parameter :: hipMemAllocationGranularityMinimum = 0
    integer(c_int), parameter :: hipMemAllocationGranularityRecommended = 1

    ! ---- hipMemHandleType
    integer(c_int), parameter :: hipMemHandleTypeGeneric = 0

    ! ---- hipMemOperationType
    integer(c_int), parameter :: hipMemOperationTypeMap = 1
    integer(c_int), parameter :: hipMemOperationTypeUnmap = 2

    ! ---- hipArraySparseSubresourceType
    integer(c_int), parameter :: hipArraySparseSubresourceTypeSparseLevel = 0
    integer(c_int), parameter :: hipArraySparseSubresourceTypeMiptail = 1

    ! ---- hipGraphDependencyType
    integer(c_int), parameter :: hipGraphDependencyTypeDefault = 0
    integer(c_int), parameter :: hipGraphDependencyTypeProgrammatic = 1

    ! ---- hipMemRangeHandleType
    integer(c_int), parameter :: hipMemRangeHandleTypeDmaBufFd = 1
    integer(c_int), parameter :: hipMemRangeHandleTypeMax = 2147483647

    ! ---- hipMemRangeFlags
    integer(c_int), parameter :: hipMemRangeFlagDmaBufMappingTypePcie = 1
    integer(c_int), parameter :: hipMemRangeFlagsMax = 2147483647

    ! ---- hipChannelFormatKind

    ! ---- hipArray_Format

    ! ---- hipResourceType

    ! ---- HIPaddress_mode

    ! ---- HIPfilter_mode

    ! ---- hipResourceViewFormat

    ! ---- HIPresourceViewFormat

    ! ---- hipMemcpyKind

    ! ---- hipMemLocationType

    ! ---- hipMemcpyFlags

    ! ---- hipMemcpySrcAccessOrder

    ! ---- hipMemcpy3DOperandType

    ! ---- hipFunction_attribute

    ! ---- hipPointer_attribute

    ! ---- hipChannelFormatKind

    ! ---- hipArray_Format

    ! ---- hipResourceType

    ! ---- HIPaddress_mode

    ! ---- HIPfilter_mode

    ! ---- hipResourceViewFormat

    ! ---- HIPresourceViewFormat

    ! ---- hipMemcpyKind

    ! ---- hipMemLocationType

    ! ---- hipMemcpyFlags

    ! ---- hipMemcpySrcAccessOrder

    ! ---- hipMemcpy3DOperandType

    ! ---- hipFunction_attribute

    ! ---- hipPointer_attribute

    ! ---- hipTextureAddressMode

    ! ---- hipTextureFilterMode

    ! ---- hipTextureReadMode

    ! ---- hipChannelFormatKind

    ! ---- hipArray_Format

    ! ---- hipResourceType

    ! ---- HIPaddress_mode

    ! ---- HIPfilter_mode

    ! ---- hipResourceViewFormat

    ! ---- HIPresourceViewFormat

    ! ---- hipMemcpyKind

    ! ---- hipMemLocationType

    ! ---- hipMemcpyFlags

    ! ---- hipMemcpySrcAccessOrder

    ! ---- hipMemcpy3DOperandType

    ! ---- hipFunction_attribute

    ! ---- hipPointer_attribute

    ! ---- hipSurfaceBoundaryMode

    ! ---- hipDataType
    integer(c_int), parameter :: HIP_R_32F = 0
    integer(c_int), parameter :: HIP_R_64F = 1
    integer(c_int), parameter :: HIP_R_16F = 2
    integer(c_int), parameter :: HIP_R_8I = 3
    integer(c_int), parameter :: HIP_C_32F = 4
    integer(c_int), parameter :: HIP_C_64F = 5
    integer(c_int), parameter :: HIP_C_16F = 6
    integer(c_int), parameter :: HIP_C_8I = 7
    integer(c_int), parameter :: HIP_R_8U = 8
    integer(c_int), parameter :: HIP_C_8U = 9
    integer(c_int), parameter :: HIP_R_32I = 10
    integer(c_int), parameter :: HIP_C_32I = 11
    integer(c_int), parameter :: HIP_R_32U = 12
    integer(c_int), parameter :: HIP_C_32U = 13
    integer(c_int), parameter :: HIP_R_16BF = 14
    integer(c_int), parameter :: HIP_C_16BF = 15
    integer(c_int), parameter :: HIP_R_4I = 16
    integer(c_int), parameter :: HIP_C_4I = 17
    integer(c_int), parameter :: HIP_R_4U = 18
    integer(c_int), parameter :: HIP_C_4U = 19
    integer(c_int), parameter :: HIP_R_16I = 20
    integer(c_int), parameter :: HIP_C_16I = 21
    integer(c_int), parameter :: HIP_R_16U = 22
    integer(c_int), parameter :: HIP_C_16U = 23
    integer(c_int), parameter :: HIP_R_64I = 24
    integer(c_int), parameter :: HIP_C_64I = 25
    integer(c_int), parameter :: HIP_R_64U = 26
    integer(c_int), parameter :: HIP_C_64U = 27
    integer(c_int), parameter :: HIP_R_8F_E4M3 = 28
    integer(c_int), parameter :: HIP_R_8F_E5M2 = 29
    integer(c_int), parameter :: HIP_R_8F_UE8M0 = 30
    integer(c_int), parameter :: HIP_R_6F_E2M3 = 31
    integer(c_int), parameter :: HIP_R_6F_E3M2 = 32
    integer(c_int), parameter :: HIP_R_4F_E2M1 = 33
    integer(c_int), parameter :: HIP_R_8F_E4M3_FNUZ = 1000
    integer(c_int), parameter :: HIP_R_8F_E5M2_FNUZ = 1001

    ! ---- hipLibraryPropertyType
    integer(c_int), parameter :: HIP_LIBRARY_MAJOR_VERSION = 0
    integer(c_int), parameter :: HIP_LIBRARY_MINOR_VERSION = 1
    integer(c_int), parameter :: HIP_LIBRARY_PATCH_LEVEL = 2

    ! ======================================================================
    !  Flag constants defined as C macros rather than enumerators
    !  (stream/event/host-alloc/device-schedule flags, ...)
    ! ======================================================================
    integer(c_int), parameter :: HIP_GET_PROC_ADDRESS_DEFAULT = 0
    integer(c_int), parameter :: HIP_GET_PROC_ADDRESS_LEGACY_STREAM = 1
    integer(c_int), parameter :: HIP_GET_PROC_ADDRESS_PER_THREAD_DEFAULT_STREAM = 2
    integer(c_int), parameter :: HIP_IMAGE_OBJECT_SIZE_DWORD = 12
    integer(c_int), parameter :: HIP_IPC_HANDLE_SIZE = 64
    integer(c_int), parameter :: HIP_SAMPLER_OBJECT_OFFSET_DWORD = 12
    integer(c_int), parameter :: HIP_SAMPLER_OBJECT_SIZE_DWORD = 8
    integer(c_int), parameter :: HIP_TEXTURE_OBJECT_SIZE_DWORD = 20
    integer(c_int), parameter :: HIP_TRSA_OVERRIDE_FORMAT = 1
    integer(c_int), parameter :: HIP_TRSF_NORMALIZED_COORDINATES = 2
    integer(c_int), parameter :: HIP_TRSF_READ_AS_INTEGER = 1
    integer(c_int), parameter :: HIP_TRSF_SRGB = 16
    integer(c_int), parameter :: HIP_VERSION = 71300000
    integer(c_int), parameter :: HIP_VERSION_BUILD_ID = 0
    integer(c_int), parameter :: HIP_VERSION_MAJOR = 7
    integer(c_int), parameter :: HIP_VERSION_MINOR = 13
    integer(c_int), parameter :: HIP_VERSION_PATCH = 0
    integer(c_int), parameter :: hipArrayCubemap = 4
    integer(c_int), parameter :: hipArrayDefault = 0
    integer(c_int), parameter :: hipArrayLayered = 1
    integer(c_int), parameter :: hipArraySurfaceLoadStore = 2
    integer(c_int), parameter :: hipArrayTextureGather = 8
    integer(c_int), parameter :: hipCooperativeLaunchMultiDeviceNoPostSync = 2
    integer(c_int), parameter :: hipCooperativeLaunchMultiDeviceNoPreSync = 1
    integer(c_int), parameter :: hipDeviceLmemResizeToMax = 16
    integer(c_int), parameter :: hipDeviceMallocContiguous = 4
    integer(c_int), parameter :: hipDeviceMallocDefault = 0
    integer(c_int), parameter :: hipDeviceMallocFinegrained = 1
    integer(c_int), parameter :: hipDeviceMallocUncached = 3
    integer(c_int), parameter :: hipDeviceMapHost = 8
    integer(c_int), parameter :: hipDeviceScheduleAuto = 0
    integer(c_int), parameter :: hipDeviceScheduleBlockingSync = 4
    integer(c_int), parameter :: hipDeviceScheduleMask = 7
    integer(c_int), parameter :: hipDeviceScheduleSpin = 1
    integer(c_int), parameter :: hipDeviceScheduleYield = 2
    integer(c_int), parameter :: hipEnableDefault = 0
    integer(c_int), parameter :: hipEnableLegacyStream = 1
    integer(c_int), parameter :: hipEnablePerThreadDefaultStream = 2
    integer(c_int), parameter :: hipEventBlockingSync = 1
    integer(c_int), parameter :: hipEventDefault = 0
    integer(c_int), parameter :: hipEventDisableSystemFence = 536870912
    integer(c_int), parameter :: hipEventDisableTiming = 2
    integer(c_int), parameter :: hipEventInterprocess = 4
    integer(c_int), parameter :: hipEventRecordDefault = 0
    integer(c_int), parameter :: hipEventRecordExternal = 1
    integer(c_int), parameter :: hipEventReleaseToDevice = 1073741824
    integer(c_int64_t), parameter :: hipEventReleaseToSystem = 2147483648_c_int64_t
    integer(c_int), parameter :: hipEventWaitDefault = 0
    integer(c_int), parameter :: hipEventWaitExternal = 1
    integer(c_int), parameter :: hipExtAnyOrderLaunch = 1
    integer(c_int), parameter :: hipExtHostRegisterCoarseGrained = 8
    integer(c_int64_t), parameter :: hipExtHostRegisterUncached = 2147483648_c_int64_t
    integer(c_int), parameter :: hipExtStreamWriteValueDecrement = 4097
    integer(c_int), parameter :: hipExtStreamWriteValueIncrement = 4096
    integer(c_int), parameter :: hipExternalMemoryDedicated = 1
    integer(c_int), parameter :: hipGraphKernelNodePortDefault = 0
    integer(c_int), parameter :: hipGraphKernelNodePortLaunchCompletion = 2
    integer(c_int), parameter :: hipGraphKernelNodePortProgrammatic = 1
    integer(c_int), parameter :: hipHostAllocDefault = 0
    integer(c_int), parameter :: hipHostAllocMapped = 2
    integer(c_int), parameter :: hipHostAllocPortable = 1
    integer(c_int), parameter :: hipHostAllocUncached = 268435456
    integer(c_int), parameter :: hipHostAllocWriteCombined = 4
    integer(c_int), parameter :: hipHostMallocCoherent = 1073741824
    integer(c_int), parameter :: hipHostMallocDefault = 0
    integer(c_int), parameter :: hipHostMallocMapped = 2
    integer(c_int64_t), parameter :: hipHostMallocNonCoherent = 2147483648_c_int64_t
    integer(c_int), parameter :: hipHostMallocNumaUser = 536870912
    integer(c_int), parameter :: hipHostMallocPortable = 1
    integer(c_int), parameter :: hipHostMallocUncached = 268435456
    integer(c_int), parameter :: hipHostMallocWriteCombined = 4
    integer(c_int), parameter :: hipHostRegisterDefault = 0
    integer(c_int), parameter :: hipHostRegisterIoMemory = 4
    integer(c_int), parameter :: hipHostRegisterMapped = 2
    integer(c_int), parameter :: hipHostRegisterPortable = 1
    integer(c_int), parameter :: hipHostRegisterReadOnly = 8
    integer(c_int), parameter :: hipIpcMemLazyEnablePeerAccess = 1
    integer(c_int), parameter :: hipMallocSignalMemory = 2
    integer(c_int), parameter :: hipMemAttachGlobal = 1
    integer(c_int), parameter :: hipMemAttachHost = 2
    integer(c_int), parameter :: hipMemAttachSingle = 4
    integer(c_int), parameter :: hipOccupancyDefault = 0
    integer(c_int), parameter :: hipOccupancyDisableCachingOverride = 1
    integer(c_int), parameter :: hipStreamDefault = 0
    integer(c_int), parameter :: hipStreamNonBlocking = 1
    integer(c_int), parameter :: hipStreamWaitValueAnd = 2
    integer(c_int), parameter :: hipStreamWaitValueEq = 1
    integer(c_int), parameter :: hipStreamWaitValueGte = 0
    integer(c_int), parameter :: hipStreamWaitValueNor = 3
    integer(c_int), parameter :: hipStreamWriteValueDefault = 0
    integer(c_int), parameter :: hipTextureType1D = 1
    integer(c_int), parameter :: hipTextureType1DLayered = 241
    integer(c_int), parameter :: hipTextureType2D = 2
    integer(c_int), parameter :: hipTextureType2DLayered = 242
    integer(c_int), parameter :: hipTextureType3D = 3
    integer(c_int), parameter :: hipTextureTypeCubemap = 12
    integer(c_int), parameter :: hipTextureTypeCubemapLayered = 252

    ! ======================================================================
    !  Interoperable derived types
    ! ======================================================================
    ! hipDeviceArch_t is a C union: no Fortran equivalent, so it is
    ! declared as an opaque 4-byte buffer (size measured by the C probe).
    type, bind(C) :: hipDeviceArch_t
        integer(c_int32_t) :: raw(1)
    end type hipDeviceArch_t

    ! hipStreamBatchMemOpParams_union is a C union: no Fortran equivalent, so it is
    ! declared as an opaque 48-byte buffer (size measured by the C probe).
    type, bind(C) :: hipStreamBatchMemOpParams_union
        integer(c_int64_t) :: raw(6)
    end type hipStreamBatchMemOpParams_union

    ! hipLaunchAttributeValue is a C union: no Fortran equivalent, so it is
    ! declared as an opaque 64-byte buffer (size measured by the C probe).
    type, bind(C) :: hipLaunchAttributeValue
        integer(c_int64_t) :: raw(8)
    end type hipLaunchAttributeValue

    type, bind(C) :: hipUUID_t
        character(kind=c_char) :: bytes(16)
    end type hipUUID_t

    type, bind(C) :: hipDeviceProp_tR0600
        character(kind=c_char) :: name(256)
        type(hipUUID_t) :: uuid
        character(kind=c_char) :: luid(8)
        integer(c_int) :: luidDeviceNodeMask
        integer(c_size_t) :: totalGlobalMem
        integer(c_size_t) :: sharedMemPerBlock
        integer(c_int) :: regsPerBlock
        integer(c_int) :: warpSize
        integer(c_size_t) :: memPitch
        integer(c_int) :: maxThreadsPerBlock
        integer(c_int) :: maxThreadsDim(3)
        integer(c_int) :: maxGridSize(3)
        integer(c_int) :: clockRate
        integer(c_size_t) :: totalConstMem
        integer(c_int) :: major
        integer(c_int) :: minor
        integer(c_size_t) :: textureAlignment
        integer(c_size_t) :: texturePitchAlignment
        integer(c_int) :: deviceOverlap
        integer(c_int) :: multiProcessorCount
        integer(c_int) :: kernelExecTimeoutEnabled
        integer(c_int) :: integrated
        integer(c_int) :: canMapHostMemory
        integer(c_int) :: computeMode
        integer(c_int) :: maxTexture1D
        integer(c_int) :: maxTexture1DMipmap
        integer(c_int) :: maxTexture1DLinear
        integer(c_int) :: maxTexture2D(2)
        integer(c_int) :: maxTexture2DMipmap(2)
        integer(c_int) :: maxTexture2DLinear(3)
        integer(c_int) :: maxTexture2DGather(2)
        integer(c_int) :: maxTexture3D(3)
        integer(c_int) :: maxTexture3DAlt(3)
        integer(c_int) :: maxTextureCubemap
        integer(c_int) :: maxTexture1DLayered(2)
        integer(c_int) :: maxTexture2DLayered(3)
        integer(c_int) :: maxTextureCubemapLayered(2)
        integer(c_int) :: maxSurface1D
        integer(c_int) :: maxSurface2D(2)
        integer(c_int) :: maxSurface3D(3)
        integer(c_int) :: maxSurface1DLayered(2)
        integer(c_int) :: maxSurface2DLayered(3)
        integer(c_int) :: maxSurfaceCubemap
        integer(c_int) :: maxSurfaceCubemapLayered(2)
        integer(c_size_t) :: surfaceAlignment
        integer(c_int) :: concurrentKernels
        integer(c_int) :: ECCEnabled
        integer(c_int) :: pciBusID
        integer(c_int) :: pciDeviceID
        integer(c_int) :: pciDomainID
        integer(c_int) :: tccDriver
        integer(c_int) :: asyncEngineCount
        integer(c_int) :: unifiedAddressing
        integer(c_int) :: memoryClockRate
        integer(c_int) :: memoryBusWidth
        integer(c_int) :: l2CacheSize
        integer(c_int) :: persistingL2CacheMaxSize
        integer(c_int) :: maxThreadsPerMultiProcessor
        integer(c_int) :: streamPrioritiesSupported
        integer(c_int) :: globalL1CacheSupported
        integer(c_int) :: localL1CacheSupported
        integer(c_size_t) :: sharedMemPerMultiprocessor
        integer(c_int) :: regsPerMultiprocessor
        integer(c_int) :: managedMemory
        integer(c_int) :: isMultiGpuBoard
        integer(c_int) :: multiGpuBoardGroupID
        integer(c_int) :: hostNativeAtomicSupported
        integer(c_int) :: singleToDoublePrecisionPerfRatio
        integer(c_int) :: pageableMemoryAccess
        integer(c_int) :: concurrentManagedAccess
        integer(c_int) :: computePreemptionSupported
        integer(c_int) :: canUseHostPointerForRegisteredMem
        integer(c_int) :: cooperativeLaunch
        integer(c_int) :: cooperativeMultiDeviceLaunch
        integer(c_size_t) :: sharedMemPerBlockOptin
        integer(c_int) :: pageableMemoryAccessUsesHostPageTables
        integer(c_int) :: directManagedMemAccessFromHost
        integer(c_int) :: maxBlocksPerMultiProcessor
        integer(c_int) :: accessPolicyMaxWindowSize
        integer(c_size_t) :: reservedSharedMemPerBlock
        integer(c_int) :: hostRegisterSupported
        integer(c_int) :: sparseHipArraySupported
        integer(c_int) :: hostRegisterReadOnlySupported
        integer(c_int) :: timelineSemaphoreInteropSupported
        integer(c_int) :: memoryPoolsSupported
        integer(c_int) :: gpuDirectRDMASupported
        integer(c_int) :: gpuDirectRDMAFlushWritesOptions
        integer(c_int) :: gpuDirectRDMAWritesOrdering
        integer(c_int) :: memoryPoolSupportedHandleTypes
        integer(c_int) :: deferredMappingHipArraySupported
        integer(c_int) :: ipcEventSupported
        integer(c_int) :: clusterLaunch
        integer(c_int) :: unifiedFunctionPointers
        integer(c_int) :: reserved(63)
        integer(c_int) :: hipReserved(32)
        character(kind=c_char) :: gcnArchName(256)
        integer(c_size_t) :: maxSharedMemoryPerMultiProcessor
        integer(c_int) :: clockInstructionRate
        type(hipDeviceArch_t) :: arch
        type(c_ptr) :: hdpMemFlushCntl
        type(c_ptr) :: hdpRegFlushCntl
        integer(c_int) :: cooperativeMultiDeviceUnmatchedFunc
        integer(c_int) :: cooperativeMultiDeviceUnmatchedGridDim
        integer(c_int) :: cooperativeMultiDeviceUnmatchedBlockDim
        integer(c_int) :: cooperativeMultiDeviceUnmatchedSharedMem
        integer(c_int) :: isLargeBar
        integer(c_int) :: asicRevision
    end type hipDeviceProp_tR0600

    type, bind(C) :: hipPointerAttribute_t
        integer(c_int) :: type
        integer(c_int) :: device
        type(c_ptr) :: devicePointer
        type(c_ptr) :: hostPointer
        integer(c_int) :: isManaged
        integer(c_int) :: allocationFlags
    end type hipPointerAttribute_t

    type, bind(C) :: hipChannelFormatDesc
        integer(c_int) :: x
        integer(c_int) :: y
        integer(c_int) :: z
        integer(c_int) :: w
        integer(c_int) :: f
    end type hipChannelFormatDesc

    type, bind(C) :: HIP_ARRAY_DESCRIPTOR
        integer(c_size_t) :: Width
        integer(c_size_t) :: Height
        integer(c_int) :: Format
        integer(c_int) :: NumChannels
    end type HIP_ARRAY_DESCRIPTOR

    type, bind(C) :: HIP_ARRAY3D_DESCRIPTOR
        integer(c_size_t) :: Width
        integer(c_size_t) :: Height
        integer(c_size_t) :: Depth
        integer(c_int) :: Format
        integer(c_int) :: NumChannels
        integer(c_int) :: Flags
    end type HIP_ARRAY3D_DESCRIPTOR

    type, bind(C) :: hip_Memcpy2D
        integer(c_size_t) :: srcXInBytes
        integer(c_size_t) :: srcY
        integer(c_int) :: srcMemoryType
        type(c_ptr) :: srcHost
        type(c_ptr) :: srcDevice
        type(c_ptr) :: srcArray
        integer(c_size_t) :: srcPitch
        integer(c_size_t) :: dstXInBytes
        integer(c_size_t) :: dstY
        integer(c_int) :: dstMemoryType
        type(c_ptr) :: dstHost
        type(c_ptr) :: dstDevice
        type(c_ptr) :: dstArray
        integer(c_size_t) :: dstPitch
        integer(c_size_t) :: WidthInBytes
        integer(c_size_t) :: Height
    end type hip_Memcpy2D

    type, bind(C) :: hipMipmappedArray
        type(c_ptr) :: data
        type(hipChannelFormatDesc) :: desc
        integer(c_int) :: type
        integer(c_int) :: width
        integer(c_int) :: height
        integer(c_int) :: depth
        integer(c_int) :: min_mipmap_level
        integer(c_int) :: max_mipmap_level
        integer(c_int) :: flags
        integer(c_int) :: format
        integer(c_int) :: num_channels
    end type hipMipmappedArray

    type, bind(C) :: HIP_TEXTURE_DESC_st
        integer(c_int) :: addressMode(3)
        integer(c_int) :: filterMode
        integer(c_int) :: flags
        integer(c_int) :: maxAnisotropy
        integer(c_int) :: mipmapFilterMode
        real(c_float) :: mipmapLevelBias
        real(c_float) :: minMipmapLevelClamp
        real(c_float) :: maxMipmapLevelClamp
        real(c_float) :: borderColor(4)
        integer(c_int) :: reserved(12)
    end type HIP_TEXTURE_DESC_st

    type, bind(C) :: hipResourceDesc
        integer(c_int) :: resType
        integer(c_int64_t) :: res(7)   ! C union / anonymous struct
    end type hipResourceDesc

    type, bind(C) :: hipResourceViewDesc
        integer(c_int) :: format
        integer(c_size_t) :: width
        integer(c_size_t) :: height
        integer(c_size_t) :: depth
        integer(c_int) :: firstMipmapLevel
        integer(c_int) :: lastMipmapLevel
        integer(c_int) :: firstLayer
        integer(c_int) :: lastLayer
    end type hipResourceViewDesc

    type, bind(C) :: HIP_RESOURCE_VIEW_DESC_st
        integer(c_int) :: format
        integer(c_size_t) :: width
        integer(c_size_t) :: height
        integer(c_size_t) :: depth
        integer(c_int) :: firstMipmapLevel
        integer(c_int) :: lastMipmapLevel
        integer(c_int) :: firstLayer
        integer(c_int) :: lastLayer
        integer(c_int) :: reserved(16)
    end type HIP_RESOURCE_VIEW_DESC_st

    type, bind(C) :: hipPitchedPtr
        type(c_ptr) :: ptr
        integer(c_size_t) :: pitch
        integer(c_size_t) :: xsize
        integer(c_size_t) :: ysize
    end type hipPitchedPtr

    type, bind(C) :: hipExtent
        integer(c_size_t) :: width
        integer(c_size_t) :: height
        integer(c_size_t) :: depth
    end type hipExtent

    type, bind(C) :: hipPos
        integer(c_size_t) :: x
        integer(c_size_t) :: y
        integer(c_size_t) :: z
    end type hipPos

    type, bind(C) :: hipMemcpy3DParms
        type(c_ptr) :: srcArray
        type(hipPos) :: srcPos
        type(hipPitchedPtr) :: srcPtr
        type(c_ptr) :: dstArray
        type(hipPos) :: dstPos
        type(hipPitchedPtr) :: dstPtr
        type(hipExtent) :: extent
        integer(c_int) :: kind
    end type hipMemcpy3DParms

    type, bind(C) :: HIP_MEMCPY3D
        integer(c_size_t) :: srcXInBytes
        integer(c_size_t) :: srcY
        integer(c_size_t) :: srcZ
        integer(c_size_t) :: srcLOD
        integer(c_int) :: srcMemoryType
        type(c_ptr) :: srcHost
        type(c_ptr) :: srcDevice
        type(c_ptr) :: srcArray
        integer(c_size_t) :: srcPitch
        integer(c_size_t) :: srcHeight
        integer(c_size_t) :: dstXInBytes
        integer(c_size_t) :: dstY
        integer(c_size_t) :: dstZ
        integer(c_size_t) :: dstLOD
        integer(c_int) :: dstMemoryType
        type(c_ptr) :: dstHost
        type(c_ptr) :: dstDevice
        type(c_ptr) :: dstArray
        integer(c_size_t) :: dstPitch
        integer(c_size_t) :: dstHeight
        integer(c_size_t) :: WidthInBytes
        integer(c_size_t) :: Height
        integer(c_size_t) :: Depth
    end type HIP_MEMCPY3D

    type, bind(C) :: hipMemLocation
        integer(c_int) :: type
        integer(c_int) :: id
    end type hipMemLocation

    type, bind(C) :: hipMemcpyAttributes
        integer(c_int) :: srcAccessOrder
        type(hipMemLocation) :: srcLocHint
        type(hipMemLocation) :: dstLocHint
        integer(c_int) :: flags
    end type hipMemcpyAttributes

    type, bind(C) :: hipOffset3D
        integer(c_size_t) :: x
        integer(c_size_t) :: y
        integer(c_size_t) :: z
    end type hipOffset3D

    type, bind(C) :: hipMemcpy3DOperand
        integer(c_int) :: type
        integer(c_int64_t) :: op(4)   ! C union / anonymous struct
    end type hipMemcpy3DOperand

    type, bind(C) :: hipMemcpy3DBatchOp
        type(hipMemcpy3DOperand) :: src
        type(hipMemcpy3DOperand) :: dst
        type(hipExtent) :: extent
        integer(c_int) :: srcAccessOrder
        integer(c_int) :: flags
    end type hipMemcpy3DBatchOp

    type, bind(C) :: hipMemcpy3DPeerParms
        type(c_ptr) :: srcArray
        type(hipPos) :: srcPos
        type(hipPitchedPtr) :: srcPtr
        integer(c_int) :: srcDevice
        type(c_ptr) :: dstArray
        type(hipPos) :: dstPos
        type(hipPitchedPtr) :: dstPtr
        integer(c_int) :: dstDevice
        type(hipExtent) :: extent
    end type hipMemcpy3DPeerParms

    type, bind(C) :: textureReference
        integer(c_int) :: normalized
        integer(c_int) :: readMode
        integer(c_int) :: filterMode
        integer(c_int) :: addressMode(3)
        type(hipChannelFormatDesc) :: channelDesc
        integer(c_int) :: sRGB
        integer(c_int) :: maxAnisotropy
        integer(c_int) :: mipmapFilterMode
        real(c_float) :: mipmapLevelBias
        real(c_float) :: minMipmapLevelClamp
        real(c_float) :: maxMipmapLevelClamp
        type(c_ptr) :: textureObject
        integer(c_int) :: numChannels
        integer(c_int) :: format
    end type textureReference

    type, bind(C) :: hipTextureDesc
        integer(c_int) :: addressMode(3)
        integer(c_int) :: filterMode
        integer(c_int) :: readMode
        integer(c_int) :: sRGB
        real(c_float) :: borderColor(4)
        integer(c_int) :: normalizedCoords
        integer(c_int) :: maxAnisotropy
        integer(c_int) :: mipmapFilterMode
        real(c_float) :: mipmapLevelBias
        real(c_float) :: minMipmapLevelClamp
        real(c_float) :: maxMipmapLevelClamp
    end type hipTextureDesc

    type, bind(C) :: surfaceReference
        type(c_ptr) :: surfaceObject
    end type surfaceReference

    type, bind(C) :: hipIpcMemHandle_st
        character(kind=c_char) :: reserved(64)
    end type hipIpcMemHandle_st

    type, bind(C) :: hipIpcEventHandle_st
        character(kind=c_char) :: reserved(64)
    end type hipIpcEventHandle_st

    type, bind(C) :: hipMemFabricHandle_st
        integer(c_signed_char) :: data(64)
    end type hipMemFabricHandle_st

    type, bind(C) :: hipFuncAttributes
        integer(c_int) :: binaryVersion
        integer(c_int) :: cacheModeCA
        integer(c_size_t) :: constSizeBytes
        integer(c_size_t) :: localSizeBytes
        integer(c_int) :: maxDynamicSharedSizeBytes
        integer(c_int) :: maxThreadsPerBlock
        integer(c_int) :: numRegs
        integer(c_int) :: preferredShmemCarveout
        integer(c_int) :: ptxVersion
        integer(c_size_t) :: sharedSizeBytes
    end type hipFuncAttributes

    type, bind(C) :: hipBatchMemOpNodeParams
        type(c_ptr) :: ctx
        integer(c_int) :: count
        type(c_ptr) :: paramArray
        integer(c_int) :: flags
    end type hipBatchMemOpNodeParams

    type, bind(C) :: hipMemAccessDesc
        type(hipMemLocation) :: location
        integer(c_int) :: flags
    end type hipMemAccessDesc

    type, bind(C) :: hipMemPoolProps
        integer(c_int) :: allocType
        integer(c_int) :: handleTypes
        type(hipMemLocation) :: location
        type(c_ptr) :: win32SecurityAttributes
        integer(c_size_t) :: maxSize
        integer(c_signed_char) :: reserved(56)
    end type hipMemPoolProps

    type, bind(C) :: hipMemPoolPtrExportData
        integer(c_signed_char) :: reserved(64)
    end type hipMemPoolPtrExportData

    type, bind(C) :: dim3
        integer(c_int32_t) :: x
        integer(c_int32_t) :: y
        integer(c_int32_t) :: z
    end type dim3

    type, bind(C) :: hipLaunchParams_t
        type(c_ptr) :: func
        type(dim3) :: gridDim
        type(dim3) :: blockDim
        type(c_ptr) :: args
        integer(c_size_t) :: sharedMem
        type(c_ptr) :: stream
    end type hipLaunchParams_t

    type, bind(C) :: hipFunctionLaunchParams_t
        type(c_ptr) :: function
        integer(c_int) :: gridDimX
        integer(c_int) :: gridDimY
        integer(c_int) :: gridDimZ
        integer(c_int) :: blockDimX
        integer(c_int) :: blockDimY
        integer(c_int) :: blockDimZ
        integer(c_int) :: sharedMemBytes
        type(c_ptr) :: hStream
        type(c_ptr) :: kernelParams
    end type hipFunctionLaunchParams_t

    type, bind(C) :: hipExternalMemoryHandleDesc_st
        integer(c_int) :: type
        integer(c_int64_t) :: handle(2)   ! C union / anonymous struct
        integer(c_long_long) :: size
        integer(c_int) :: flags
        integer(c_int) :: reserved(16)
    end type hipExternalMemoryHandleDesc_st

    type, bind(C) :: hipExternalMemoryBufferDesc_st
        integer(c_long_long) :: offset
        integer(c_long_long) :: size
        integer(c_int) :: flags
        integer(c_int) :: reserved(16)
    end type hipExternalMemoryBufferDesc_st

    type, bind(C) :: hipExternalMemoryMipmappedArrayDesc_st
        integer(c_long_long) :: offset
        type(hipChannelFormatDesc) :: formatDesc
        type(hipExtent) :: extent
        integer(c_int) :: flags
        integer(c_int) :: numLevels
    end type hipExternalMemoryMipmappedArrayDesc_st

    type, bind(C) :: hipExternalSemaphoreHandleDesc_st
        integer(c_int) :: type
        integer(c_int64_t) :: handle(2)   ! C union / anonymous struct
        integer(c_int) :: flags
        integer(c_int) :: reserved(16)
    end type hipExternalSemaphoreHandleDesc_st

    type, bind(C) :: hipExternalSemaphoreSignalParams_st
        integer(c_int64_t) :: params(9)   ! C union / anonymous struct
        integer(c_int) :: flags
        integer(c_int) :: reserved(16)
    end type hipExternalSemaphoreSignalParams_st

    type, bind(C) :: hipExternalSemaphoreWaitParams_st
        integer(c_int64_t) :: params(9)   ! C union / anonymous struct
        integer(c_int) :: flags
        integer(c_int) :: reserved(16)
    end type hipExternalSemaphoreWaitParams_st

    type, bind(C) :: hipHostNodeParams
        type(c_ptr) :: fn
        type(c_ptr) :: userData
    end type hipHostNodeParams

    type, bind(C) :: hipKernelNodeParams
        type(dim3) :: blockDim
        type(c_ptr) :: extra
        type(c_ptr) :: func
        type(dim3) :: gridDim
        type(c_ptr) :: kernelParams
        integer(c_int) :: sharedMemBytes
    end type hipKernelNodeParams

    type, bind(C) :: hipMemsetParams
        type(c_ptr) :: dst
        integer(c_int) :: elementSize
        integer(c_size_t) :: height
        integer(c_size_t) :: pitch
        integer(c_int) :: value
        integer(c_size_t) :: width
    end type hipMemsetParams

    type, bind(C) :: hipMemAllocNodeParams
        type(hipMemPoolProps) :: poolProps
        type(c_ptr) :: accessDescs
        integer(c_size_t) :: accessDescCount
        integer(c_size_t) :: bytesize
        type(c_ptr) :: dptr
    end type hipMemAllocNodeParams

    type, bind(C) :: hipAccessPolicyWindow
        type(c_ptr) :: base_ptr
        integer(c_int) :: hitProp
        real(c_float) :: hitRatio
        integer(c_int) :: missProp
        integer(c_size_t) :: num_bytes
    end type hipAccessPolicyWindow

    type, bind(C) :: hipLaunchMemSyncDomainMap
        integer(c_signed_char) :: default_
        integer(c_signed_char) :: remote
    end type hipLaunchMemSyncDomainMap

    type, bind(C) :: hipGraphInstantiateParams
        type(c_ptr) :: errNode_out
        integer(c_long_long) :: flags
        integer(c_int) :: result_out
        type(c_ptr) :: uploadStream
    end type hipGraphInstantiateParams

    type, bind(C) :: hipMemAllocationProp
        integer(c_int) :: type
        integer(c_int8_t) :: anon1(4)   ! anonymous C union (+ padding)
        type(hipMemLocation) :: location
        type(c_ptr) :: win32HandleMetaData
        integer(c_int32_t) :: allocFlags(1)   ! C union / anonymous struct
    end type hipMemAllocationProp

    type, bind(C) :: hipExternalSemaphoreSignalNodeParams
        type(c_ptr) :: extSemArray
        type(c_ptr) :: paramsArray
        integer(c_int) :: numExtSems
    end type hipExternalSemaphoreSignalNodeParams

    type, bind(C) :: hipExternalSemaphoreWaitNodeParams
        type(c_ptr) :: extSemArray
        type(c_ptr) :: paramsArray
        integer(c_int) :: numExtSems
    end type hipExternalSemaphoreWaitNodeParams

    type, bind(C) :: hipArrayMapInfo
        integer(c_int) :: resourceType
        integer(c_int64_t) :: resource(8)   ! C union / anonymous struct
        integer(c_int) :: subresourceType
        integer(c_int64_t) :: subresource(4)   ! C union / anonymous struct
        integer(c_int) :: memOperationType
        integer(c_int) :: memHandleType
        integer(c_int64_t) :: memHandle(1)   ! C union / anonymous struct
        integer(c_long_long) :: offset
        integer(c_int) :: deviceBitMask
        integer(c_int) :: flags
        integer(c_int) :: reserved(2)
    end type hipArrayMapInfo

    type, bind(C) :: hipMemcpyNodeParams
        integer(c_int) :: flags
        integer(c_int) :: reserved(3)
        type(hipMemcpy3DParms) :: copyParams
    end type hipMemcpyNodeParams

    type, bind(C) :: hipChildGraphNodeParams
        type(c_ptr) :: graph
    end type hipChildGraphNodeParams

    type, bind(C) :: hipEventWaitNodeParams
        type(c_ptr) :: event
    end type hipEventWaitNodeParams

    type, bind(C) :: hipEventRecordNodeParams
        type(c_ptr) :: event
    end type hipEventRecordNodeParams

    type, bind(C) :: hipMemFreeNodeParams
        type(c_ptr) :: dptr
    end type hipMemFreeNodeParams

    type, bind(C) :: hipGraphNodeParams
        integer(c_int) :: type
        integer(c_int) :: reserved0(3)
        integer(c_int8_t) :: anon2(232)   ! anonymous C union (+ padding)
        integer(c_long_long) :: reserved2
    end type hipGraphNodeParams

    type, bind(C) :: hipGraphEdgeData
        integer(c_signed_char) :: from_port
        integer(c_signed_char) :: reserved(5)
        integer(c_signed_char) :: to_port
        integer(c_signed_char) :: type
    end type hipGraphEdgeData

    type, bind(C) :: hipLaunchConfig_st
        type(dim3) :: gridDim
        type(dim3) :: blockDim
        integer(c_size_t) :: dynamicSmemBytes
        type(c_ptr) :: stream
        type(c_ptr) :: attrs
        integer(c_int) :: numAttrs
    end type hipLaunchConfig_st

    type, bind(C) :: HIP_LAUNCH_CONFIG_st
        integer(c_int) :: gridDimX
        integer(c_int) :: gridDimY
        integer(c_int) :: gridDimZ
        integer(c_int) :: blockDimX
        integer(c_int) :: blockDimY
        integer(c_int) :: blockDimZ
        integer(c_int) :: sharedMemBytes
        type(c_ptr) :: hStream
        type(c_ptr) :: attrs
        integer(c_int) :: numAttrs
    end type HIP_LAUNCH_CONFIG_st

    type, bind(C) :: hipArrayMemoryRequirements
        integer(c_size_t) :: alignment
        integer(c_size_t) :: size
    end type hipArrayMemoryRequirements

    ! ======================================================================
    !  C entry points
    ! ======================================================================
    interface

        type(c_ptr) function hipApiName(id) &
                bind(C, name="hipApiName")
            import
            integer(c_int32_t), value :: id
        end function hipApiName

        integer(c_int) function hipArray3DCreate(array, pAllocateArray) &
                bind(C, name="hipArray3DCreate")
            import
            type(c_ptr), intent(out) :: array
            type(HIP_ARRAY3D_DESCRIPTOR), intent(in) :: pAllocateArray
        end function hipArray3DCreate

        integer(c_int) function hipArray3DGetDescriptor(pArrayDescriptor, array) &
                bind(C, name="hipArray3DGetDescriptor")
            import
            type(HIP_ARRAY3D_DESCRIPTOR), intent(inout) :: pArrayDescriptor
            type(c_ptr), value :: array
        end function hipArray3DGetDescriptor

        integer(c_int) function hipArrayCreate(pHandle, pAllocateArray) &
                bind(C, name="hipArrayCreate")
            import
            type(c_ptr), intent(out) :: pHandle
            type(HIP_ARRAY_DESCRIPTOR), intent(in) :: pAllocateArray
        end function hipArrayCreate

        integer(c_int) function hipArrayDestroy(array) &
                bind(C, name="hipArrayDestroy")
            import
            type(c_ptr), value :: array
        end function hipArrayDestroy

        integer(c_int) function hipArrayGetDescriptor(pArrayDescriptor, array) &
                bind(C, name="hipArrayGetDescriptor")
            import
            type(HIP_ARRAY_DESCRIPTOR), intent(inout) :: pArrayDescriptor
            type(c_ptr), value :: array
        end function hipArrayGetDescriptor

        integer(c_int) function hipArrayGetInfo(desc, extent, flags, array) &
                bind(C, name="hipArrayGetInfo")
            import
            type(hipChannelFormatDesc), intent(inout) :: desc
            type(hipExtent), intent(inout) :: extent
            integer(c_int), intent(inout) :: flags
            type(c_ptr), value :: array
        end function hipArrayGetInfo

        integer(c_int) function hipBindTexture(offset, tex, devPtr, desc, size) &
                bind(C, name="hipBindTexture")
            import
            integer(c_size_t), intent(inout) :: offset
            type(textureReference), intent(in) :: tex
            type(c_ptr), value :: devPtr
            type(hipChannelFormatDesc), intent(in) :: desc
            integer(c_size_t), value :: size
        end function hipBindTexture

        integer(c_int) function hipBindTexture2D(offset, tex, devPtr, desc, width, height, pitch) &
                bind(C, name="hipBindTexture2D")
            import
            integer(c_size_t), intent(inout) :: offset
            type(textureReference), intent(in) :: tex
            type(c_ptr), value :: devPtr
            type(hipChannelFormatDesc), intent(in) :: desc
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            integer(c_size_t), value :: pitch
        end function hipBindTexture2D

        integer(c_int) function hipBindTextureToArray(tex, array, desc) &
                bind(C, name="hipBindTextureToArray")
            import
            type(textureReference), intent(in) :: tex
            type(c_ptr), value :: array
            type(hipChannelFormatDesc), intent(in) :: desc
        end function hipBindTextureToArray

        integer(c_int) function hipBindTextureToMipmappedArray(tex, mipmappedArray, desc) &
                bind(C, name="hipBindTextureToMipmappedArray")
            import
            type(textureReference), intent(in) :: tex
            type(c_ptr), value :: mipmappedArray
            type(hipChannelFormatDesc), intent(in) :: desc
        end function hipBindTextureToMipmappedArray

        integer(c_int) function hipChooseDeviceR0600(device, prop) &
                bind(C, name="hipChooseDeviceR0600")
            import
            integer(c_int), intent(inout) :: device
            type(hipDeviceProp_tR0600), intent(in) :: prop
        end function hipChooseDeviceR0600

        integer(c_int) function hipConfigureCall(gridDim, blockDim, sharedMem, stream) &
                bind(C, name="hipConfigureCall")
            import
            type(dim3), value :: gridDim
            type(dim3), value :: blockDim
            integer(c_size_t), value :: sharedMem
            type(c_ptr), value :: stream
        end function hipConfigureCall

        integer(c_int) function hipCreateSurfaceObject(pSurfObject, pResDesc) &
                bind(C, name="hipCreateSurfaceObject")
            import
            type(c_ptr), intent(out) :: pSurfObject
            type(hipResourceDesc), intent(in) :: pResDesc
        end function hipCreateSurfaceObject

        integer(c_int) function hipCreateTextureObject(pTexObject, pResDesc, pTexDesc, pResViewDesc) &
                bind(C, name="hipCreateTextureObject")
            import
            type(c_ptr), intent(out) :: pTexObject
            type(hipResourceDesc), intent(in) :: pResDesc
            type(hipTextureDesc), intent(in) :: pTexDesc
            type(hipResourceViewDesc), intent(in) :: pResViewDesc
        end function hipCreateTextureObject

        integer(c_int) function hipCtxCreate(ctx, flags, device) &
                bind(C, name="hipCtxCreate")
            import
            type(c_ptr), intent(out) :: ctx
            integer(c_int), value :: flags
            integer(c_int), value :: device
        end function hipCtxCreate

        integer(c_int) function hipCtxDestroy(ctx) &
                bind(C, name="hipCtxDestroy")
            import
            type(c_ptr), value :: ctx
        end function hipCtxDestroy

        integer(c_int) function hipCtxDisablePeerAccess(peerCtx) &
                bind(C, name="hipCtxDisablePeerAccess")
            import
            type(c_ptr), value :: peerCtx
        end function hipCtxDisablePeerAccess

        integer(c_int) function hipCtxEnablePeerAccess(peerCtx, flags) &
                bind(C, name="hipCtxEnablePeerAccess")
            import
            type(c_ptr), value :: peerCtx
            integer(c_int), value :: flags
        end function hipCtxEnablePeerAccess

        integer(c_int) function hipCtxGetApiVersion(ctx, apiVersion) &
                bind(C, name="hipCtxGetApiVersion")
            import
            type(c_ptr), value :: ctx
            integer(c_int), intent(inout) :: apiVersion
        end function hipCtxGetApiVersion

        integer(c_int) function hipCtxGetCacheConfig(cacheConfig) &
                bind(C, name="hipCtxGetCacheConfig")
            import
            integer(c_int), intent(out) :: cacheConfig
        end function hipCtxGetCacheConfig

        integer(c_int) function hipCtxGetCurrent(ctx) &
                bind(C, name="hipCtxGetCurrent")
            import
            type(c_ptr), intent(out) :: ctx
        end function hipCtxGetCurrent

        integer(c_int) function hipCtxGetDevice(device) &
                bind(C, name="hipCtxGetDevice")
            import
            integer(c_int), intent(inout) :: device
        end function hipCtxGetDevice

        integer(c_int) function hipCtxGetFlags(flags) &
                bind(C, name="hipCtxGetFlags")
            import
            integer(c_int), intent(inout) :: flags
        end function hipCtxGetFlags

        integer(c_int) function hipCtxGetSharedMemConfig(pConfig) &
                bind(C, name="hipCtxGetSharedMemConfig")
            import
            integer(c_int), intent(out) :: pConfig
        end function hipCtxGetSharedMemConfig

        integer(c_int) function hipCtxPopCurrent(ctx) &
                bind(C, name="hipCtxPopCurrent")
            import
            type(c_ptr), intent(out) :: ctx
        end function hipCtxPopCurrent

        integer(c_int) function hipCtxPushCurrent(ctx) &
                bind(C, name="hipCtxPushCurrent")
            import
            type(c_ptr), value :: ctx
        end function hipCtxPushCurrent

        integer(c_int) function hipCtxSetCacheConfig(cacheConfig) &
                bind(C, name="hipCtxSetCacheConfig")
            import
            integer(c_int), value :: cacheConfig
        end function hipCtxSetCacheConfig

        integer(c_int) function hipCtxSetCurrent(ctx) &
                bind(C, name="hipCtxSetCurrent")
            import
            type(c_ptr), value :: ctx
        end function hipCtxSetCurrent

        integer(c_int) function hipCtxSetSharedMemConfig(config) &
                bind(C, name="hipCtxSetSharedMemConfig")
            import
            integer(c_int), value :: config
        end function hipCtxSetSharedMemConfig

        integer(c_int) function hipCtxSynchronize() &
                bind(C, name="hipCtxSynchronize")
            import
        end function hipCtxSynchronize

        integer(c_int) function hipDestroyExternalMemory(extMem) &
                bind(C, name="hipDestroyExternalMemory")
            import
            type(c_ptr), value :: extMem
        end function hipDestroyExternalMemory

        integer(c_int) function hipDestroyExternalSemaphore(extSem) &
                bind(C, name="hipDestroyExternalSemaphore")
            import
            type(c_ptr), value :: extSem
        end function hipDestroyExternalSemaphore

        integer(c_int) function hipDestroySurfaceObject(surfaceObject) &
                bind(C, name="hipDestroySurfaceObject")
            import
            type(c_ptr), value :: surfaceObject
        end function hipDestroySurfaceObject

        integer(c_int) function hipDestroyTextureObject(textureObject) &
                bind(C, name="hipDestroyTextureObject")
            import
            type(c_ptr), value :: textureObject
        end function hipDestroyTextureObject

        integer(c_int) function hipDeviceCanAccessPeer(canAccessPeer, deviceId, peerDeviceId) &
                bind(C, name="hipDeviceCanAccessPeer")
            import
            integer(c_int), intent(inout) :: canAccessPeer
            integer(c_int), value :: deviceId
            integer(c_int), value :: peerDeviceId
        end function hipDeviceCanAccessPeer

        integer(c_int) function hipDeviceComputeCapability(major, minor, device) &
                bind(C, name="hipDeviceComputeCapability")
            import
            integer(c_int), intent(inout) :: major
            integer(c_int), intent(inout) :: minor
            integer(c_int), value :: device
        end function hipDeviceComputeCapability

        integer(c_int) function hipDeviceDisablePeerAccess(peerDeviceId) &
                bind(C, name="hipDeviceDisablePeerAccess")
            import
            integer(c_int), value :: peerDeviceId
        end function hipDeviceDisablePeerAccess

        integer(c_int) function hipDeviceEnablePeerAccess(peerDeviceId, flags) &
                bind(C, name="hipDeviceEnablePeerAccess")
            import
            integer(c_int), value :: peerDeviceId
            integer(c_int), value :: flags
        end function hipDeviceEnablePeerAccess

        integer(c_int) function hipDeviceGet(device, ordinal) &
                bind(C, name="hipDeviceGet")
            import
            integer(c_int), intent(inout) :: device
            integer(c_int), value :: ordinal
        end function hipDeviceGet

        integer(c_int) function hipDeviceGetAttribute(pi, attr, deviceId) &
                bind(C, name="hipDeviceGetAttribute")
            import
            integer(c_int), intent(inout) :: pi
            integer(c_int), value :: attr
            integer(c_int), value :: deviceId
        end function hipDeviceGetAttribute

        integer(c_int) function hipDeviceGetByPCIBusId(device, pciBusId) &
                bind(C, name="hipDeviceGetByPCIBusId")
            import
            integer(c_int), intent(inout) :: device
            character(kind=c_char), dimension(*), intent(in) :: pciBusId
        end function hipDeviceGetByPCIBusId

        integer(c_int) function hipDeviceGetCacheConfig(cacheConfig) &
                bind(C, name="hipDeviceGetCacheConfig")
            import
            integer(c_int), intent(out) :: cacheConfig
        end function hipDeviceGetCacheConfig

        integer(c_int) function hipDeviceGetDefaultMemPool(mem_pool, device) &
                bind(C, name="hipDeviceGetDefaultMemPool")
            import
            type(c_ptr), intent(out) :: mem_pool
            integer(c_int), value :: device
        end function hipDeviceGetDefaultMemPool

        integer(c_int) function hipDeviceGetGraphMemAttribute(device, attr, value) &
                bind(C, name="hipDeviceGetGraphMemAttribute")
            import
            integer(c_int), value :: device
            integer(c_int), value :: attr
            type(c_ptr), value :: value
        end function hipDeviceGetGraphMemAttribute

        integer(c_int) function hipDeviceGetLimit(pValue, limit) &
                bind(C, name="hipDeviceGetLimit")
            import
            integer(c_size_t), intent(inout) :: pValue
            integer(c_int), value :: limit
        end function hipDeviceGetLimit

        integer(c_int) function hipDeviceGetMemPool(mem_pool, device) &
                bind(C, name="hipDeviceGetMemPool")
            import
            type(c_ptr), intent(out) :: mem_pool
            integer(c_int), value :: device
        end function hipDeviceGetMemPool

        integer(c_int) function hipDeviceGetName(name, len, device) &
                bind(C, name="hipDeviceGetName")
            import
            character(kind=c_char), dimension(*), intent(in) :: name
            integer(c_int), value :: len
            integer(c_int), value :: device
        end function hipDeviceGetName

        integer(c_int) function hipDeviceGetP2PAttribute(value, attr, srcDevice, dstDevice) &
                bind(C, name="hipDeviceGetP2PAttribute")
            import
            integer(c_int), intent(inout) :: value
            integer(c_int), value :: attr
            integer(c_int), value :: srcDevice
            integer(c_int), value :: dstDevice
        end function hipDeviceGetP2PAttribute

        integer(c_int) function hipDeviceGetPCIBusId(pciBusId, len, device) &
                bind(C, name="hipDeviceGetPCIBusId")
            import
            character(kind=c_char), dimension(*), intent(in) :: pciBusId
            integer(c_int), value :: len
            integer(c_int), value :: device
        end function hipDeviceGetPCIBusId

        integer(c_int) function hipDeviceGetSharedMemConfig(pConfig) &
                bind(C, name="hipDeviceGetSharedMemConfig")
            import
            integer(c_int), intent(out) :: pConfig
        end function hipDeviceGetSharedMemConfig

        integer(c_int) function hipDeviceGetStreamPriorityRange(leastPriority, greatestPriority) &
                bind(C, name="hipDeviceGetStreamPriorityRange")
            import
            integer(c_int), intent(inout) :: leastPriority
            integer(c_int), intent(inout) :: greatestPriority
        end function hipDeviceGetStreamPriorityRange

        integer(c_int) function hipDeviceGetTexture1DLinearMaxWidth(max_width, desc, device) &
                bind(C, name="hipDeviceGetTexture1DLinearMaxWidth")
            import
            integer(c_size_t), intent(inout) :: max_width
            type(hipChannelFormatDesc), intent(in) :: desc
            integer(c_int), value :: device
        end function hipDeviceGetTexture1DLinearMaxWidth

        integer(c_int) function hipDeviceGetUuid(uuid, device) &
                bind(C, name="hipDeviceGetUuid")
            import
            type(hipUUID_t), intent(inout) :: uuid
            integer(c_int), value :: device
        end function hipDeviceGetUuid

        integer(c_int) function hipDeviceGraphMemTrim(device) &
                bind(C, name="hipDeviceGraphMemTrim")
            import
            integer(c_int), value :: device
        end function hipDeviceGraphMemTrim

        integer(c_int) function hipDevicePrimaryCtxGetState(dev, flags, active) &
                bind(C, name="hipDevicePrimaryCtxGetState")
            import
            integer(c_int), value :: dev
            integer(c_int), intent(inout) :: flags
            integer(c_int), intent(inout) :: active
        end function hipDevicePrimaryCtxGetState

        integer(c_int) function hipDevicePrimaryCtxRelease(dev) &
                bind(C, name="hipDevicePrimaryCtxRelease")
            import
            integer(c_int), value :: dev
        end function hipDevicePrimaryCtxRelease

        integer(c_int) function hipDevicePrimaryCtxReset(dev) &
                bind(C, name="hipDevicePrimaryCtxReset")
            import
            integer(c_int), value :: dev
        end function hipDevicePrimaryCtxReset

        integer(c_int) function hipDevicePrimaryCtxRetain(pctx, dev) &
                bind(C, name="hipDevicePrimaryCtxRetain")
            import
            type(c_ptr), intent(out) :: pctx
            integer(c_int), value :: dev
        end function hipDevicePrimaryCtxRetain

        integer(c_int) function hipDevicePrimaryCtxSetFlags(dev, flags) &
                bind(C, name="hipDevicePrimaryCtxSetFlags")
            import
            integer(c_int), value :: dev
            integer(c_int), value :: flags
        end function hipDevicePrimaryCtxSetFlags

        integer(c_int) function hipDeviceReset() &
                bind(C, name="hipDeviceReset")
            import
        end function hipDeviceReset

        integer(c_int) function hipDeviceSetCacheConfig(cacheConfig) &
                bind(C, name="hipDeviceSetCacheConfig")
            import
            integer(c_int), value :: cacheConfig
        end function hipDeviceSetCacheConfig

        integer(c_int) function hipDeviceSetGraphMemAttribute(device, attr, value) &
                bind(C, name="hipDeviceSetGraphMemAttribute")
            import
            integer(c_int), value :: device
            integer(c_int), value :: attr
            type(c_ptr), value :: value
        end function hipDeviceSetGraphMemAttribute

        integer(c_int) function hipDeviceSetLimit(limit, value) &
                bind(C, name="hipDeviceSetLimit")
            import
            integer(c_int), value :: limit
            integer(c_size_t), value :: value
        end function hipDeviceSetLimit

        integer(c_int) function hipDeviceSetMemPool(device, mem_pool) &
                bind(C, name="hipDeviceSetMemPool")
            import
            integer(c_int), value :: device
            type(c_ptr), value :: mem_pool
        end function hipDeviceSetMemPool

        integer(c_int) function hipDeviceSetSharedMemConfig(config) &
                bind(C, name="hipDeviceSetSharedMemConfig")
            import
            integer(c_int), value :: config
        end function hipDeviceSetSharedMemConfig

        integer(c_int) function hipDeviceSynchronize() &
                bind(C, name="hipDeviceSynchronize")
            import
        end function hipDeviceSynchronize

        integer(c_int) function hipDeviceTotalMem(bytes, device) &
                bind(C, name="hipDeviceTotalMem")
            import
            integer(c_size_t), intent(inout) :: bytes
            integer(c_int), value :: device
        end function hipDeviceTotalMem

        integer(c_int) function hipDriverGetVersion(driverVersion) &
                bind(C, name="hipDriverGetVersion")
            import
            integer(c_int), intent(inout) :: driverVersion
        end function hipDriverGetVersion

        integer(c_int) function hipDrvGetErrorName(hipError, errorString) &
                bind(C, name="hipDrvGetErrorName")
            import
            integer(c_int), value :: hipError
            type(c_ptr), intent(out) :: errorString
        end function hipDrvGetErrorName

        integer(c_int) function hipDrvGetErrorString(hipError, errorString) &
                bind(C, name="hipDrvGetErrorString")
            import
            integer(c_int), value :: hipError
            type(c_ptr), intent(out) :: errorString
        end function hipDrvGetErrorString

        integer(c_int) function hipDrvGraphAddMemFreeNode(phGraphNode, hGraph, dependencies, numDependencies, dptr) &
                bind(C, name="hipDrvGraphAddMemFreeNode")
            import
            type(c_ptr), intent(out) :: phGraphNode
            type(c_ptr), value :: hGraph
            type(c_ptr), intent(out) :: dependencies
            integer(c_size_t), value :: numDependencies
            type(c_ptr), value :: dptr
        end function hipDrvGraphAddMemFreeNode

        integer(c_int) function hipDrvGraphAddMemcpyNode( &
                phGraphNode, hGraph, dependencies, numDependencies, copyParams, ctx) &
                bind(C, name="hipDrvGraphAddMemcpyNode")
            import
            type(c_ptr), intent(out) :: phGraphNode
            type(c_ptr), value :: hGraph
            type(c_ptr), intent(out) :: dependencies
            integer(c_size_t), value :: numDependencies
            type(HIP_MEMCPY3D), intent(in) :: copyParams
            type(c_ptr), value :: ctx
        end function hipDrvGraphAddMemcpyNode

        integer(c_int) function hipDrvGraphAddMemsetNode( &
                phGraphNode, hGraph, dependencies, numDependencies, memsetParams, ctx) &
                bind(C, name="hipDrvGraphAddMemsetNode")
            import
            type(c_ptr), intent(out) :: phGraphNode
            type(c_ptr), value :: hGraph
            type(c_ptr), intent(out) :: dependencies
            integer(c_size_t), value :: numDependencies
            type(hipMemsetParams), intent(in) :: memsetParams
            type(c_ptr), value :: ctx
        end function hipDrvGraphAddMemsetNode

        integer(c_int) function hipDrvGraphExecMemcpyNodeSetParams(hGraphExec, hNode, copyParams, ctx) &
                bind(C, name="hipDrvGraphExecMemcpyNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hNode
            type(HIP_MEMCPY3D), intent(in) :: copyParams
            type(c_ptr), value :: ctx
        end function hipDrvGraphExecMemcpyNodeSetParams

        integer(c_int) function hipDrvGraphExecMemsetNodeSetParams(hGraphExec, hNode, memsetParams, ctx) &
                bind(C, name="hipDrvGraphExecMemsetNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hNode
            type(hipMemsetParams), intent(in) :: memsetParams
            type(c_ptr), value :: ctx
        end function hipDrvGraphExecMemsetNodeSetParams

        integer(c_int) function hipDrvGraphMemcpyNodeGetParams(hNode, nodeParams) &
                bind(C, name="hipDrvGraphMemcpyNodeGetParams")
            import
            type(c_ptr), value :: hNode
            type(HIP_MEMCPY3D), intent(inout) :: nodeParams
        end function hipDrvGraphMemcpyNodeGetParams

        integer(c_int) function hipDrvGraphMemcpyNodeSetParams(hNode, nodeParams) &
                bind(C, name="hipDrvGraphMemcpyNodeSetParams")
            import
            type(c_ptr), value :: hNode
            type(HIP_MEMCPY3D), intent(in) :: nodeParams
        end function hipDrvGraphMemcpyNodeSetParams

        integer(c_int) function hipDrvLaunchKernelEx(config, f, params, extra) &
                bind(C, name="hipDrvLaunchKernelEx")
            import
            type(HIP_LAUNCH_CONFIG_st), intent(in) :: config
            type(c_ptr), value :: f
            type(c_ptr), intent(out) :: params
            type(c_ptr), dimension(*), intent(in) :: extra
        end function hipDrvLaunchKernelEx

        integer(c_int) function hipDrvMemcpy2DUnaligned(pCopy) &
                bind(C, name="hipDrvMemcpy2DUnaligned")
            import
            type(hip_Memcpy2D), intent(in) :: pCopy
        end function hipDrvMemcpy2DUnaligned

        integer(c_int) function hipDrvMemcpy3D(pCopy) &
                bind(C, name="hipDrvMemcpy3D")
            import
            type(HIP_MEMCPY3D), intent(in) :: pCopy
        end function hipDrvMemcpy3D

        integer(c_int) function hipDrvMemcpy3DAsync(pCopy, stream) &
                bind(C, name="hipDrvMemcpy3DAsync")
            import
            type(HIP_MEMCPY3D), intent(in) :: pCopy
            type(c_ptr), value :: stream
        end function hipDrvMemcpy3DAsync

        integer(c_int) function hipDrvPointerGetAttributes(numAttributes, attributes, data, ptr) &
                bind(C, name="hipDrvPointerGetAttributes")
            import
            integer(c_int), value :: numAttributes
            integer(c_int), intent(out) :: attributes
            type(c_ptr), intent(out) :: data
            type(c_ptr), value :: ptr
        end function hipDrvPointerGetAttributes

        integer(c_int) function hipEventCreate(event) &
                bind(C, name="hipEventCreate")
            import
            type(c_ptr), intent(out) :: event
        end function hipEventCreate

        integer(c_int) function hipEventCreateWithFlags(event, flags) &
                bind(C, name="hipEventCreateWithFlags")
            import
            type(c_ptr), intent(out) :: event
            integer(c_int), value :: flags
        end function hipEventCreateWithFlags

        integer(c_int) function hipEventDestroy(event) &
                bind(C, name="hipEventDestroy")
            import
            type(c_ptr), value :: event
        end function hipEventDestroy

        integer(c_int) function hipEventElapsedTime(ms, start, stop) &
                bind(C, name="hipEventElapsedTime")
            import
            real(c_float), intent(inout) :: ms
            type(c_ptr), value :: start
            type(c_ptr), value :: stop
        end function hipEventElapsedTime

        integer(c_int) function hipEventQuery(event) &
                bind(C, name="hipEventQuery")
            import
            type(c_ptr), value :: event
        end function hipEventQuery

        integer(c_int) function hipEventRecord(event, stream) &
                bind(C, name="hipEventRecord")
            import
            type(c_ptr), value :: event
            type(c_ptr), value :: stream
        end function hipEventRecord

        integer(c_int) function hipEventRecordWithFlags(event, stream, flags) &
                bind(C, name="hipEventRecordWithFlags")
            import
            type(c_ptr), value :: event
            type(c_ptr), value :: stream
            integer(c_int), value :: flags
        end function hipEventRecordWithFlags

        integer(c_int) function hipEventSynchronize(event) &
                bind(C, name="hipEventSynchronize")
            import
            type(c_ptr), value :: event
        end function hipEventSynchronize

        integer(c_int) function hipExtDisableLogging() &
                bind(C, name="hipExtDisableLogging")
            import
        end function hipExtDisableLogging

        integer(c_int) function hipExtEnableLogging() &
                bind(C, name="hipExtEnableLogging")
            import
        end function hipExtEnableLogging

        integer(c_int) function hipExtGetLastError() &
                bind(C, name="hipExtGetLastError")
            import
        end function hipExtGetLastError

        integer(c_int) function hipExtGetLinkTypeAndHopCount(device1, device2, linktype, hopcount) &
                bind(C, name="hipExtGetLinkTypeAndHopCount")
            import
            integer(c_int), value :: device1
            integer(c_int), value :: device2
            integer(c_int32_t), intent(inout) :: linktype
            integer(c_int32_t), intent(inout) :: hopcount
        end function hipExtGetLinkTypeAndHopCount

        integer(c_int) function hipExtLaunchKernel( &
                function_address, numBlocks, dimBlocks, args, sharedMemBytes, stream, startEvent, stopEvent, flags) &
                bind(C, name="hipExtLaunchKernel")
            import
            type(c_ptr), value :: function_address
            type(dim3), value :: numBlocks
            type(dim3), value :: dimBlocks
            type(c_ptr), dimension(*), intent(in) :: args
            integer(c_size_t), value :: sharedMemBytes
            type(c_ptr), value :: stream
            type(c_ptr), value :: startEvent
            type(c_ptr), value :: stopEvent
            integer(c_int), value :: flags
        end function hipExtLaunchKernel

        integer(c_int) function hipExtLaunchMultiKernelMultiDevice(launchParamsList, numDevices, flags) &
                bind(C, name="hipExtLaunchMultiKernelMultiDevice")
            import
            type(hipLaunchParams_t), intent(inout) :: launchParamsList
            integer(c_int), value :: numDevices
            integer(c_int), value :: flags
        end function hipExtLaunchMultiKernelMultiDevice

        integer(c_int) function hipExtMallocWithFlags(ptr, sizeBytes, flags) &
                bind(C, name="hipExtMallocWithFlags")
            import
            type(c_ptr), intent(out) :: ptr
            integer(c_size_t), value :: sizeBytes
            integer(c_int), value :: flags
        end function hipExtMallocWithFlags

        integer(c_int) function hipExtSetLoggingParams(log_level, log_size, log_mask) &
                bind(C, name="hipExtSetLoggingParams")
            import
            integer(c_size_t), value :: log_level
            integer(c_size_t), value :: log_size
            integer(c_size_t), value :: log_mask
        end function hipExtSetLoggingParams

        integer(c_int) function hipExtStreamCreateWithCUMask(stream, cuMaskSize, cuMask) &
                bind(C, name="hipExtStreamCreateWithCUMask")
            import
            type(c_ptr), intent(out) :: stream
            integer(c_int32_t), value :: cuMaskSize
            integer(c_int32_t), dimension(*), intent(in) :: cuMask
        end function hipExtStreamCreateWithCUMask

        integer(c_int) function hipExtStreamGetCUMask(stream, cuMaskSize, cuMask) &
                bind(C, name="hipExtStreamGetCUMask")
            import
            type(c_ptr), value :: stream
            integer(c_int32_t), value :: cuMaskSize
            integer(c_int32_t), intent(inout) :: cuMask
        end function hipExtStreamGetCUMask

        integer(c_int) function hipExternalMemoryGetMappedBuffer(devPtr, extMem, bufferDesc) &
                bind(C, name="hipExternalMemoryGetMappedBuffer")
            import
            type(c_ptr), intent(out) :: devPtr
            type(c_ptr), value :: extMem
            type(hipExternalMemoryBufferDesc_st), intent(in) :: bufferDesc
        end function hipExternalMemoryGetMappedBuffer

        integer(c_int) function hipExternalMemoryGetMappedMipmappedArray(mipmap, extMem, mipmapDesc) &
                bind(C, name="hipExternalMemoryGetMappedMipmappedArray")
            import
            type(c_ptr), intent(out) :: mipmap
            type(c_ptr), value :: extMem
            type(hipExternalMemoryMipmappedArrayDesc_st), intent(in) :: mipmapDesc
        end function hipExternalMemoryGetMappedMipmappedArray

        integer(c_int) function hipFree(ptr) &
                bind(C, name="hipFree")
            import
            type(c_ptr), value :: ptr
        end function hipFree

        integer(c_int) function hipFreeArray(array) &
                bind(C, name="hipFreeArray")
            import
            type(c_ptr), value :: array
        end function hipFreeArray

        integer(c_int) function hipFreeAsync(dev_ptr, stream) &
                bind(C, name="hipFreeAsync")
            import
            type(c_ptr), value :: dev_ptr
            type(c_ptr), value :: stream
        end function hipFreeAsync

        integer(c_int) function hipFreeHost(ptr) &
                bind(C, name="hipFreeHost")
            import
            type(c_ptr), value :: ptr
        end function hipFreeHost

        integer(c_int) function hipFreeMipmappedArray(mipmappedArray) &
                bind(C, name="hipFreeMipmappedArray")
            import
            type(c_ptr), value :: mipmappedArray
        end function hipFreeMipmappedArray

        integer(c_int) function hipFuncGetAttribute(value, attrib, hfunc) &
                bind(C, name="hipFuncGetAttribute")
            import
            integer(c_int), intent(inout) :: value
            integer(c_int), value :: attrib
            type(c_ptr), value :: hfunc
        end function hipFuncGetAttribute

        integer(c_int) function hipFuncGetAttributes(attr, func) &
                bind(C, name="hipFuncGetAttributes")
            import
            type(hipFuncAttributes), intent(inout) :: attr
            type(c_ptr), value :: func
        end function hipFuncGetAttributes

        integer(c_int) function hipFuncSetAttribute(func, attr, value) &
                bind(C, name="hipFuncSetAttribute")
            import
            type(c_ptr), value :: func
            integer(c_int), value :: attr
            integer(c_int), value :: value
        end function hipFuncSetAttribute

        integer(c_int) function hipFuncSetCacheConfig(func, config) &
                bind(C, name="hipFuncSetCacheConfig")
            import
            type(c_ptr), value :: func
            integer(c_int), value :: config
        end function hipFuncSetCacheConfig

        integer(c_int) function hipFuncSetSharedMemConfig(func, config) &
                bind(C, name="hipFuncSetSharedMemConfig")
            import
            type(c_ptr), value :: func
            integer(c_int), value :: config
        end function hipFuncSetSharedMemConfig

        integer(c_int) function hipGetChannelDesc(desc, array) &
                bind(C, name="hipGetChannelDesc")
            import
            type(hipChannelFormatDesc), intent(inout) :: desc
            type(c_ptr), value :: array
        end function hipGetChannelDesc

        integer(c_int) function hipGetDevice(deviceId) &
                bind(C, name="hipGetDevice")
            import
            integer(c_int), intent(inout) :: deviceId
        end function hipGetDevice

        integer(c_int) function hipGetDeviceCount(count) &
                bind(C, name="hipGetDeviceCount")
            import
            integer(c_int), intent(inout) :: count
        end function hipGetDeviceCount

        integer(c_int) function hipGetDeviceFlags(flags) &
                bind(C, name="hipGetDeviceFlags")
            import
            integer(c_int), intent(inout) :: flags
        end function hipGetDeviceFlags

        integer(c_int) function hipGetDevicePropertiesR0600(prop, deviceId) &
                bind(C, name="hipGetDevicePropertiesR0600")
            import
            type(hipDeviceProp_tR0600), intent(inout) :: prop
            integer(c_int), value :: deviceId
        end function hipGetDevicePropertiesR0600

        integer(c_int) function hipGetDriverEntryPoint(symbol, funcPtr, flags, driverStatus) &
                bind(C, name="hipGetDriverEntryPoint")
            import
            character(kind=c_char), dimension(*), intent(in) :: symbol
            type(c_ptr), intent(out) :: funcPtr
            integer(c_long_long), value :: flags
            integer(c_int), intent(out) :: driverStatus
        end function hipGetDriverEntryPoint

        type(c_ptr) function hipGetErrorName(hip_error) &
                bind(C, name="hipGetErrorName")
            import
            integer(c_int), value :: hip_error
        end function hipGetErrorName

        type(c_ptr) function hipGetErrorString(hipError) &
                bind(C, name="hipGetErrorString")
            import
            integer(c_int), value :: hipError
        end function hipGetErrorString

        integer(c_int) function hipGetFuncBySymbol(functionPtr, symbolPtr) &
                bind(C, name="hipGetFuncBySymbol")
            import
            type(c_ptr), intent(out) :: functionPtr
            type(c_ptr), value :: symbolPtr
        end function hipGetFuncBySymbol

        integer(c_int) function hipGetLastError() &
                bind(C, name="hipGetLastError")
            import
        end function hipGetLastError

        integer(c_int) function hipGetMipmappedArrayLevel(levelArray, mipmappedArray, level) &
                bind(C, name="hipGetMipmappedArrayLevel")
            import
            type(c_ptr), intent(out) :: levelArray
            type(c_ptr), value :: mipmappedArray
            integer(c_int), value :: level
        end function hipGetMipmappedArrayLevel

        integer(c_int) function hipGetProcAddress(symbol, pfn, hipVersion, flags, symbolStatus) &
                bind(C, name="hipGetProcAddress")
            import
            character(kind=c_char), dimension(*), intent(in) :: symbol
            type(c_ptr), intent(out) :: pfn
            integer(c_int), value :: hipVersion
            integer(c_int64_t), value :: flags
            integer(c_int), intent(out) :: symbolStatus
        end function hipGetProcAddress

        integer(c_int) function hipGetSymbolAddress(devPtr, symbol) &
                bind(C, name="hipGetSymbolAddress")
            import
            type(c_ptr), intent(out) :: devPtr
            type(c_ptr), value :: symbol
        end function hipGetSymbolAddress

        integer(c_int) function hipGetSymbolSize(size, symbol) &
                bind(C, name="hipGetSymbolSize")
            import
            integer(c_size_t), intent(inout) :: size
            type(c_ptr), value :: symbol
        end function hipGetSymbolSize

        integer(c_int) function hipGetTextureAlignmentOffset(offset, texref) &
                bind(C, name="hipGetTextureAlignmentOffset")
            import
            integer(c_size_t), intent(inout) :: offset
            type(textureReference), intent(in) :: texref
        end function hipGetTextureAlignmentOffset

        integer(c_int) function hipGetTextureObjectResourceDesc(pResDesc, textureObject) &
                bind(C, name="hipGetTextureObjectResourceDesc")
            import
            type(hipResourceDesc), intent(inout) :: pResDesc
            type(c_ptr), value :: textureObject
        end function hipGetTextureObjectResourceDesc

        integer(c_int) function hipGetTextureObjectResourceViewDesc(pResViewDesc, textureObject) &
                bind(C, name="hipGetTextureObjectResourceViewDesc")
            import
            type(hipResourceViewDesc), intent(inout) :: pResViewDesc
            type(c_ptr), value :: textureObject
        end function hipGetTextureObjectResourceViewDesc

        integer(c_int) function hipGetTextureObjectTextureDesc(pTexDesc, textureObject) &
                bind(C, name="hipGetTextureObjectTextureDesc")
            import
            type(hipTextureDesc), intent(inout) :: pTexDesc
            type(c_ptr), value :: textureObject
        end function hipGetTextureObjectTextureDesc

        integer(c_int) function hipGetTextureReference(texref, symbol) &
                bind(C, name="hipGetTextureReference")
            import
            type(textureReference), intent(in) :: texref
            type(c_ptr), value :: symbol
        end function hipGetTextureReference

        integer(c_int) function hipGraphAddBatchMemOpNode( &
                phGraphNode, hGraph, dependencies, numDependencies, nodeParams) &
                bind(C, name="hipGraphAddBatchMemOpNode")
            import
            type(c_ptr), intent(out) :: phGraphNode
            type(c_ptr), value :: hGraph
            type(c_ptr), intent(out) :: dependencies
            integer(c_size_t), value :: numDependencies
            type(hipBatchMemOpNodeParams), intent(in) :: nodeParams
        end function hipGraphAddBatchMemOpNode

        integer(c_int) function hipGraphAddChildGraphNode( &
                pGraphNode, graph, pDependencies, numDependencies, childGraph) &
                bind(C, name="hipGraphAddChildGraphNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(c_ptr), value :: childGraph
        end function hipGraphAddChildGraphNode

        integer(c_int) function hipGraphAddDependencies(graph, from, to, numDependencies) &
                bind(C, name="hipGraphAddDependencies")
            import
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: from
            type(c_ptr), intent(out) :: to
            integer(c_size_t), value :: numDependencies
        end function hipGraphAddDependencies

        integer(c_int) function hipGraphAddEmptyNode(pGraphNode, graph, pDependencies, numDependencies) &
                bind(C, name="hipGraphAddEmptyNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
        end function hipGraphAddEmptyNode

        integer(c_int) function hipGraphAddEventRecordNode(pGraphNode, graph, pDependencies, numDependencies, event) &
                bind(C, name="hipGraphAddEventRecordNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(c_ptr), value :: event
        end function hipGraphAddEventRecordNode

        integer(c_int) function hipGraphAddEventWaitNode(pGraphNode, graph, pDependencies, numDependencies, event) &
                bind(C, name="hipGraphAddEventWaitNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(c_ptr), value :: event
        end function hipGraphAddEventWaitNode

        integer(c_int) function hipGraphAddExternalSemaphoresSignalNode( &
                pGraphNode, graph, pDependencies, numDependencies, nodeParams) &
                bind(C, name="hipGraphAddExternalSemaphoresSignalNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(hipExternalSemaphoreSignalNodeParams), intent(in) :: nodeParams
        end function hipGraphAddExternalSemaphoresSignalNode

        integer(c_int) function hipGraphAddExternalSemaphoresWaitNode( &
                pGraphNode, graph, pDependencies, numDependencies, nodeParams) &
                bind(C, name="hipGraphAddExternalSemaphoresWaitNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(hipExternalSemaphoreWaitNodeParams), intent(in) :: nodeParams
        end function hipGraphAddExternalSemaphoresWaitNode

        integer(c_int) function hipGraphAddHostNode(pGraphNode, graph, pDependencies, numDependencies, pNodeParams) &
                bind(C, name="hipGraphAddHostNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(hipHostNodeParams), intent(in) :: pNodeParams
        end function hipGraphAddHostNode

        integer(c_int) function hipGraphAddKernelNode(pGraphNode, graph, pDependencies, numDependencies, pNodeParams) &
                bind(C, name="hipGraphAddKernelNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(hipKernelNodeParams), intent(in) :: pNodeParams
        end function hipGraphAddKernelNode

        integer(c_int) function hipGraphAddMemAllocNode( &
                pGraphNode, graph, pDependencies, numDependencies, pNodeParams) &
                bind(C, name="hipGraphAddMemAllocNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(hipMemAllocNodeParams), intent(inout) :: pNodeParams
        end function hipGraphAddMemAllocNode

        integer(c_int) function hipGraphAddMemFreeNode(pGraphNode, graph, pDependencies, numDependencies, dev_ptr) &
                bind(C, name="hipGraphAddMemFreeNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(c_ptr), value :: dev_ptr
        end function hipGraphAddMemFreeNode

        integer(c_int) function hipGraphAddMemcpyNode(pGraphNode, graph, pDependencies, numDependencies, pCopyParams) &
                bind(C, name="hipGraphAddMemcpyNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(hipMemcpy3DParms), intent(in) :: pCopyParams
        end function hipGraphAddMemcpyNode

        integer(c_int) function hipGraphAddMemcpyNode1D( &
                pGraphNode, graph, pDependencies, numDependencies, dst, src, count, kind) &
                bind(C, name="hipGraphAddMemcpyNode1D")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: count
            integer(c_int), value :: kind
        end function hipGraphAddMemcpyNode1D

        integer(c_int) function hipGraphAddMemcpyNodeFromSymbol( &
                pGraphNode, graph, pDependencies, numDependencies, dst, symbol, count, offset, kind) &
                bind(C, name="hipGraphAddMemcpyNodeFromSymbol")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(c_ptr), value :: dst
            type(c_ptr), value :: symbol
            integer(c_size_t), value :: count
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
        end function hipGraphAddMemcpyNodeFromSymbol

        integer(c_int) function hipGraphAddMemcpyNodeToSymbol( &
                pGraphNode, graph, pDependencies, numDependencies, symbol, src, count, offset, kind) &
                bind(C, name="hipGraphAddMemcpyNodeToSymbol")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(c_ptr), value :: symbol
            type(c_ptr), value :: src
            integer(c_size_t), value :: count
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
        end function hipGraphAddMemcpyNodeToSymbol

        integer(c_int) function hipGraphAddMemsetNode( &
                pGraphNode, graph, pDependencies, numDependencies, pMemsetParams) &
                bind(C, name="hipGraphAddMemsetNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(hipMemsetParams), intent(in) :: pMemsetParams
        end function hipGraphAddMemsetNode

        integer(c_int) function hipGraphAddNode(pGraphNode, graph, pDependencies, numDependencies, nodeParams) &
                bind(C, name="hipGraphAddNode")
            import
            type(c_ptr), intent(out) :: pGraphNode
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), value :: numDependencies
            type(hipGraphNodeParams), intent(inout) :: nodeParams
        end function hipGraphAddNode

        integer(c_int) function hipGraphBatchMemOpNodeGetParams(hNode, nodeParams_out) &
                bind(C, name="hipGraphBatchMemOpNodeGetParams")
            import
            type(c_ptr), value :: hNode
            type(hipBatchMemOpNodeParams), intent(inout) :: nodeParams_out
        end function hipGraphBatchMemOpNodeGetParams

        integer(c_int) function hipGraphBatchMemOpNodeSetParams(hNode, nodeParams) &
                bind(C, name="hipGraphBatchMemOpNodeSetParams")
            import
            type(c_ptr), value :: hNode
            type(hipBatchMemOpNodeParams), intent(inout) :: nodeParams
        end function hipGraphBatchMemOpNodeSetParams

        integer(c_int) function hipGraphChildGraphNodeGetGraph(node, pGraph) &
                bind(C, name="hipGraphChildGraphNodeGetGraph")
            import
            type(c_ptr), value :: node
            type(c_ptr), intent(out) :: pGraph
        end function hipGraphChildGraphNodeGetGraph

        integer(c_int) function hipGraphClone(pGraphClone, originalGraph) &
                bind(C, name="hipGraphClone")
            import
            type(c_ptr), intent(out) :: pGraphClone
            type(c_ptr), value :: originalGraph
        end function hipGraphClone

        integer(c_int) function hipGraphCreate(pGraph, flags) &
                bind(C, name="hipGraphCreate")
            import
            type(c_ptr), intent(out) :: pGraph
            integer(c_int), value :: flags
        end function hipGraphCreate

        integer(c_int) function hipGraphDebugDotPrint(graph, path, flags) &
                bind(C, name="hipGraphDebugDotPrint")
            import
            type(c_ptr), value :: graph
            character(kind=c_char), dimension(*), intent(in) :: path
            integer(c_int), value :: flags
        end function hipGraphDebugDotPrint

        integer(c_int) function hipGraphDestroy(graph) &
                bind(C, name="hipGraphDestroy")
            import
            type(c_ptr), value :: graph
        end function hipGraphDestroy

        integer(c_int) function hipGraphDestroyNode(node) &
                bind(C, name="hipGraphDestroyNode")
            import
            type(c_ptr), value :: node
        end function hipGraphDestroyNode

        integer(c_int) function hipGraphEventRecordNodeGetEvent(node, event_out) &
                bind(C, name="hipGraphEventRecordNodeGetEvent")
            import
            type(c_ptr), value :: node
            type(c_ptr), intent(out) :: event_out
        end function hipGraphEventRecordNodeGetEvent

        integer(c_int) function hipGraphEventRecordNodeSetEvent(node, event) &
                bind(C, name="hipGraphEventRecordNodeSetEvent")
            import
            type(c_ptr), value :: node
            type(c_ptr), value :: event
        end function hipGraphEventRecordNodeSetEvent

        integer(c_int) function hipGraphEventWaitNodeGetEvent(node, event_out) &
                bind(C, name="hipGraphEventWaitNodeGetEvent")
            import
            type(c_ptr), value :: node
            type(c_ptr), intent(out) :: event_out
        end function hipGraphEventWaitNodeGetEvent

        integer(c_int) function hipGraphEventWaitNodeSetEvent(node, event) &
                bind(C, name="hipGraphEventWaitNodeSetEvent")
            import
            type(c_ptr), value :: node
            type(c_ptr), value :: event
        end function hipGraphEventWaitNodeSetEvent

        integer(c_int) function hipGraphExecBatchMemOpNodeSetParams(hGraphExec, hNode, nodeParams) &
                bind(C, name="hipGraphExecBatchMemOpNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hNode
            type(hipBatchMemOpNodeParams), intent(in) :: nodeParams
        end function hipGraphExecBatchMemOpNodeSetParams

        integer(c_int) function hipGraphExecChildGraphNodeSetParams(hGraphExec, node, childGraph) &
                bind(C, name="hipGraphExecChildGraphNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: node
            type(c_ptr), value :: childGraph
        end function hipGraphExecChildGraphNodeSetParams

        integer(c_int) function hipGraphExecDestroy(graphExec) &
                bind(C, name="hipGraphExecDestroy")
            import
            type(c_ptr), value :: graphExec
        end function hipGraphExecDestroy

        integer(c_int) function hipGraphExecEventRecordNodeSetEvent(hGraphExec, hNode, event) &
                bind(C, name="hipGraphExecEventRecordNodeSetEvent")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hNode
            type(c_ptr), value :: event
        end function hipGraphExecEventRecordNodeSetEvent

        integer(c_int) function hipGraphExecEventWaitNodeSetEvent(hGraphExec, hNode, event) &
                bind(C, name="hipGraphExecEventWaitNodeSetEvent")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hNode
            type(c_ptr), value :: event
        end function hipGraphExecEventWaitNodeSetEvent

        integer(c_int) function hipGraphExecExternalSemaphoresSignalNodeSetParams(hGraphExec, hNode, nodeParams) &
                bind(C, name="hipGraphExecExternalSemaphoresSignalNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hNode
            type(hipExternalSemaphoreSignalNodeParams), intent(in) :: nodeParams
        end function hipGraphExecExternalSemaphoresSignalNodeSetParams

        integer(c_int) function hipGraphExecExternalSemaphoresWaitNodeSetParams(hGraphExec, hNode, nodeParams) &
                bind(C, name="hipGraphExecExternalSemaphoresWaitNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hNode
            type(hipExternalSemaphoreWaitNodeParams), intent(in) :: nodeParams
        end function hipGraphExecExternalSemaphoresWaitNodeSetParams

        integer(c_int) function hipGraphExecGetFlags(graphExec, flags) &
                bind(C, name="hipGraphExecGetFlags")
            import
            type(c_ptr), value :: graphExec
            integer(c_long_long), intent(inout) :: flags
        end function hipGraphExecGetFlags

        integer(c_int) function hipGraphExecHostNodeSetParams(hGraphExec, node, pNodeParams) &
                bind(C, name="hipGraphExecHostNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: node
            type(hipHostNodeParams), intent(in) :: pNodeParams
        end function hipGraphExecHostNodeSetParams

        integer(c_int) function hipGraphExecKernelNodeSetParams(hGraphExec, node, pNodeParams) &
                bind(C, name="hipGraphExecKernelNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: node
            type(hipKernelNodeParams), intent(in) :: pNodeParams
        end function hipGraphExecKernelNodeSetParams

        integer(c_int) function hipGraphExecMemcpyNodeSetParams(hGraphExec, node, pNodeParams) &
                bind(C, name="hipGraphExecMemcpyNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: node
            type(hipMemcpy3DParms), intent(inout) :: pNodeParams
        end function hipGraphExecMemcpyNodeSetParams

        integer(c_int) function hipGraphExecMemcpyNodeSetParams1D(hGraphExec, node, dst, src, count, kind) &
                bind(C, name="hipGraphExecMemcpyNodeSetParams1D")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: node
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: count
            integer(c_int), value :: kind
        end function hipGraphExecMemcpyNodeSetParams1D

        integer(c_int) function hipGraphExecMemcpyNodeSetParamsFromSymbol( &
                hGraphExec, node, dst, symbol, count, offset, kind) &
                bind(C, name="hipGraphExecMemcpyNodeSetParamsFromSymbol")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: node
            type(c_ptr), value :: dst
            type(c_ptr), value :: symbol
            integer(c_size_t), value :: count
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
        end function hipGraphExecMemcpyNodeSetParamsFromSymbol

        integer(c_int) function hipGraphExecMemcpyNodeSetParamsToSymbol( &
                hGraphExec, node, symbol, src, count, offset, kind) &
                bind(C, name="hipGraphExecMemcpyNodeSetParamsToSymbol")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: node
            type(c_ptr), value :: symbol
            type(c_ptr), value :: src
            integer(c_size_t), value :: count
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
        end function hipGraphExecMemcpyNodeSetParamsToSymbol

        integer(c_int) function hipGraphExecMemsetNodeSetParams(hGraphExec, node, pNodeParams) &
                bind(C, name="hipGraphExecMemsetNodeSetParams")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: node
            type(hipMemsetParams), intent(in) :: pNodeParams
        end function hipGraphExecMemsetNodeSetParams

        integer(c_int) function hipGraphExecNodeSetParams(graphExec, node, nodeParams) &
                bind(C, name="hipGraphExecNodeSetParams")
            import
            type(c_ptr), value :: graphExec
            type(c_ptr), value :: node
            type(hipGraphNodeParams), intent(inout) :: nodeParams
        end function hipGraphExecNodeSetParams

        integer(c_int) function hipGraphExecUpdate(hGraphExec, hGraph, hErrorNode_out, updateResult_out) &
                bind(C, name="hipGraphExecUpdate")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hGraph
            type(c_ptr), intent(out) :: hErrorNode_out
            integer(c_int), intent(out) :: updateResult_out
        end function hipGraphExecUpdate

        integer(c_int) function hipGraphExternalSemaphoresSignalNodeGetParams(hNode, params_out) &
                bind(C, name="hipGraphExternalSemaphoresSignalNodeGetParams")
            import
            type(c_ptr), value :: hNode
            type(hipExternalSemaphoreSignalNodeParams), intent(inout) :: params_out
        end function hipGraphExternalSemaphoresSignalNodeGetParams

        integer(c_int) function hipGraphExternalSemaphoresSignalNodeSetParams(hNode, nodeParams) &
                bind(C, name="hipGraphExternalSemaphoresSignalNodeSetParams")
            import
            type(c_ptr), value :: hNode
            type(hipExternalSemaphoreSignalNodeParams), intent(in) :: nodeParams
        end function hipGraphExternalSemaphoresSignalNodeSetParams

        integer(c_int) function hipGraphExternalSemaphoresWaitNodeGetParams(hNode, params_out) &
                bind(C, name="hipGraphExternalSemaphoresWaitNodeGetParams")
            import
            type(c_ptr), value :: hNode
            type(hipExternalSemaphoreWaitNodeParams), intent(inout) :: params_out
        end function hipGraphExternalSemaphoresWaitNodeGetParams

        integer(c_int) function hipGraphExternalSemaphoresWaitNodeSetParams(hNode, nodeParams) &
                bind(C, name="hipGraphExternalSemaphoresWaitNodeSetParams")
            import
            type(c_ptr), value :: hNode
            type(hipExternalSemaphoreWaitNodeParams), intent(in) :: nodeParams
        end function hipGraphExternalSemaphoresWaitNodeSetParams

        integer(c_int) function hipGraphGetEdges(graph, from, to, numEdges) &
                bind(C, name="hipGraphGetEdges")
            import
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: from
            type(c_ptr), intent(out) :: to
            integer(c_size_t), intent(inout) :: numEdges
        end function hipGraphGetEdges

        integer(c_int) function hipGraphGetNodes(graph, nodes, numNodes) &
                bind(C, name="hipGraphGetNodes")
            import
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: nodes
            integer(c_size_t), intent(inout) :: numNodes
        end function hipGraphGetNodes

        integer(c_int) function hipGraphGetRootNodes(graph, pRootNodes, pNumRootNodes) &
                bind(C, name="hipGraphGetRootNodes")
            import
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pRootNodes
            integer(c_size_t), intent(inout) :: pNumRootNodes
        end function hipGraphGetRootNodes

        integer(c_int) function hipGraphHostNodeGetParams(node, pNodeParams) &
                bind(C, name="hipGraphHostNodeGetParams")
            import
            type(c_ptr), value :: node
            type(hipHostNodeParams), intent(inout) :: pNodeParams
        end function hipGraphHostNodeGetParams

        integer(c_int) function hipGraphHostNodeSetParams(node, pNodeParams) &
                bind(C, name="hipGraphHostNodeSetParams")
            import
            type(c_ptr), value :: node
            type(hipHostNodeParams), intent(in) :: pNodeParams
        end function hipGraphHostNodeSetParams

        integer(c_int) function hipGraphInstantiate(pGraphExec, graph, pErrorNode, pLogBuffer, bufferSize) &
                bind(C, name="hipGraphInstantiate")
            import
            type(c_ptr), intent(out) :: pGraphExec
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: pErrorNode
            character(kind=c_char), dimension(*), intent(in) :: pLogBuffer
            integer(c_size_t), value :: bufferSize
        end function hipGraphInstantiate

        integer(c_int) function hipGraphInstantiateWithFlags(pGraphExec, graph, flags) &
                bind(C, name="hipGraphInstantiateWithFlags")
            import
            type(c_ptr), intent(out) :: pGraphExec
            type(c_ptr), value :: graph
            integer(c_long_long), value :: flags
        end function hipGraphInstantiateWithFlags

        integer(c_int) function hipGraphInstantiateWithParams(pGraphExec, graph, instantiateParams) &
                bind(C, name="hipGraphInstantiateWithParams")
            import
            type(c_ptr), intent(out) :: pGraphExec
            type(c_ptr), value :: graph
            type(hipGraphInstantiateParams), intent(inout) :: instantiateParams
        end function hipGraphInstantiateWithParams

        integer(c_int) function hipGraphKernelNodeCopyAttributes(hSrc, hDst) &
                bind(C, name="hipGraphKernelNodeCopyAttributes")
            import
            type(c_ptr), value :: hSrc
            type(c_ptr), value :: hDst
        end function hipGraphKernelNodeCopyAttributes

        integer(c_int) function hipGraphKernelNodeGetAttribute(hNode, attr, value) &
                bind(C, name="hipGraphKernelNodeGetAttribute")
            import
            type(c_ptr), value :: hNode
            integer(c_int), value :: attr
            type(hipLaunchAttributeValue), intent(inout) :: value
        end function hipGraphKernelNodeGetAttribute

        integer(c_int) function hipGraphKernelNodeGetParams(node, pNodeParams) &
                bind(C, name="hipGraphKernelNodeGetParams")
            import
            type(c_ptr), value :: node
            type(hipKernelNodeParams), intent(inout) :: pNodeParams
        end function hipGraphKernelNodeGetParams

        integer(c_int) function hipGraphKernelNodeSetAttribute(hNode, attr, value) &
                bind(C, name="hipGraphKernelNodeSetAttribute")
            import
            type(c_ptr), value :: hNode
            integer(c_int), value :: attr
            type(hipLaunchAttributeValue), intent(in) :: value
        end function hipGraphKernelNodeSetAttribute

        integer(c_int) function hipGraphKernelNodeSetParams(node, pNodeParams) &
                bind(C, name="hipGraphKernelNodeSetParams")
            import
            type(c_ptr), value :: node
            type(hipKernelNodeParams), intent(in) :: pNodeParams
        end function hipGraphKernelNodeSetParams

        integer(c_int) function hipGraphLaunch(graphExec, stream) &
                bind(C, name="hipGraphLaunch")
            import
            type(c_ptr), value :: graphExec
            type(c_ptr), value :: stream
        end function hipGraphLaunch

        integer(c_int) function hipGraphMemAllocNodeGetParams(node, pNodeParams) &
                bind(C, name="hipGraphMemAllocNodeGetParams")
            import
            type(c_ptr), value :: node
            type(hipMemAllocNodeParams), intent(inout) :: pNodeParams
        end function hipGraphMemAllocNodeGetParams

        integer(c_int) function hipGraphMemFreeNodeGetParams(node, dev_ptr) &
                bind(C, name="hipGraphMemFreeNodeGetParams")
            import
            type(c_ptr), value :: node
            type(c_ptr), value :: dev_ptr
        end function hipGraphMemFreeNodeGetParams

        integer(c_int) function hipGraphMemcpyNodeGetParams(node, pNodeParams) &
                bind(C, name="hipGraphMemcpyNodeGetParams")
            import
            type(c_ptr), value :: node
            type(hipMemcpy3DParms), intent(inout) :: pNodeParams
        end function hipGraphMemcpyNodeGetParams

        integer(c_int) function hipGraphMemcpyNodeSetParams(node, pNodeParams) &
                bind(C, name="hipGraphMemcpyNodeSetParams")
            import
            type(c_ptr), value :: node
            type(hipMemcpy3DParms), intent(in) :: pNodeParams
        end function hipGraphMemcpyNodeSetParams

        integer(c_int) function hipGraphMemcpyNodeSetParams1D(node, dst, src, count, kind) &
                bind(C, name="hipGraphMemcpyNodeSetParams1D")
            import
            type(c_ptr), value :: node
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: count
            integer(c_int), value :: kind
        end function hipGraphMemcpyNodeSetParams1D

        integer(c_int) function hipGraphMemcpyNodeSetParamsFromSymbol(node, dst, symbol, count, offset, kind) &
                bind(C, name="hipGraphMemcpyNodeSetParamsFromSymbol")
            import
            type(c_ptr), value :: node
            type(c_ptr), value :: dst
            type(c_ptr), value :: symbol
            integer(c_size_t), value :: count
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
        end function hipGraphMemcpyNodeSetParamsFromSymbol

        integer(c_int) function hipGraphMemcpyNodeSetParamsToSymbol(node, symbol, src, count, offset, kind) &
                bind(C, name="hipGraphMemcpyNodeSetParamsToSymbol")
            import
            type(c_ptr), value :: node
            type(c_ptr), value :: symbol
            type(c_ptr), value :: src
            integer(c_size_t), value :: count
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
        end function hipGraphMemcpyNodeSetParamsToSymbol

        integer(c_int) function hipGraphMemsetNodeGetParams(node, pNodeParams) &
                bind(C, name="hipGraphMemsetNodeGetParams")
            import
            type(c_ptr), value :: node
            type(hipMemsetParams), intent(inout) :: pNodeParams
        end function hipGraphMemsetNodeGetParams

        integer(c_int) function hipGraphMemsetNodeSetParams(node, pNodeParams) &
                bind(C, name="hipGraphMemsetNodeSetParams")
            import
            type(c_ptr), value :: node
            type(hipMemsetParams), intent(in) :: pNodeParams
        end function hipGraphMemsetNodeSetParams

        integer(c_int) function hipGraphNodeFindInClone(pNode, originalNode, clonedGraph) &
                bind(C, name="hipGraphNodeFindInClone")
            import
            type(c_ptr), intent(out) :: pNode
            type(c_ptr), value :: originalNode
            type(c_ptr), value :: clonedGraph
        end function hipGraphNodeFindInClone

        integer(c_int) function hipGraphNodeGetDependencies(node, pDependencies, pNumDependencies) &
                bind(C, name="hipGraphNodeGetDependencies")
            import
            type(c_ptr), value :: node
            type(c_ptr), intent(out) :: pDependencies
            integer(c_size_t), intent(inout) :: pNumDependencies
        end function hipGraphNodeGetDependencies

        integer(c_int) function hipGraphNodeGetDependentNodes(node, pDependentNodes, pNumDependentNodes) &
                bind(C, name="hipGraphNodeGetDependentNodes")
            import
            type(c_ptr), value :: node
            type(c_ptr), intent(out) :: pDependentNodes
            integer(c_size_t), intent(inout) :: pNumDependentNodes
        end function hipGraphNodeGetDependentNodes

        integer(c_int) function hipGraphNodeGetEnabled(hGraphExec, hNode, isEnabled) &
                bind(C, name="hipGraphNodeGetEnabled")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hNode
            integer(c_int), intent(inout) :: isEnabled
        end function hipGraphNodeGetEnabled

        integer(c_int) function hipGraphNodeGetType(node, pType) &
                bind(C, name="hipGraphNodeGetType")
            import
            type(c_ptr), value :: node
            integer(c_int), intent(out) :: pType
        end function hipGraphNodeGetType

        integer(c_int) function hipGraphNodeSetEnabled(hGraphExec, hNode, isEnabled) &
                bind(C, name="hipGraphNodeSetEnabled")
            import
            type(c_ptr), value :: hGraphExec
            type(c_ptr), value :: hNode
            integer(c_int), value :: isEnabled
        end function hipGraphNodeSetEnabled

        integer(c_int) function hipGraphNodeSetParams(node, nodeParams) &
                bind(C, name="hipGraphNodeSetParams")
            import
            type(c_ptr), value :: node
            type(hipGraphNodeParams), intent(inout) :: nodeParams
        end function hipGraphNodeSetParams

        integer(c_int) function hipGraphReleaseUserObject(graph, object, count) &
                bind(C, name="hipGraphReleaseUserObject")
            import
            type(c_ptr), value :: graph
            type(c_ptr), value :: object
            integer(c_int), value :: count
        end function hipGraphReleaseUserObject

        integer(c_int) function hipGraphRemoveDependencies(graph, from, to, numDependencies) &
                bind(C, name="hipGraphRemoveDependencies")
            import
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: from
            type(c_ptr), intent(out) :: to
            integer(c_size_t), value :: numDependencies
        end function hipGraphRemoveDependencies

        integer(c_int) function hipGraphRetainUserObject(graph, object, count, flags) &
                bind(C, name="hipGraphRetainUserObject")
            import
            type(c_ptr), value :: graph
            type(c_ptr), value :: object
            integer(c_int), value :: count
            integer(c_int), value :: flags
        end function hipGraphRetainUserObject

        integer(c_int) function hipGraphUpload(graphExec, stream) &
                bind(C, name="hipGraphUpload")
            import
            type(c_ptr), value :: graphExec
            type(c_ptr), value :: stream
        end function hipGraphUpload

        integer(c_int) function hipGraphicsMapResources(count, resources, stream) &
                bind(C, name="hipGraphicsMapResources")
            import
            integer(c_int), value :: count
            type(c_ptr), intent(out) :: resources
            type(c_ptr), value :: stream
        end function hipGraphicsMapResources

        integer(c_int) function hipGraphicsResourceGetMappedPointer(devPtr, size, resource) &
                bind(C, name="hipGraphicsResourceGetMappedPointer")
            import
            type(c_ptr), intent(out) :: devPtr
            integer(c_size_t), intent(inout) :: size
            type(c_ptr), value :: resource
        end function hipGraphicsResourceGetMappedPointer

        integer(c_int) function hipGraphicsSubResourceGetMappedArray(array, resource, arrayIndex, mipLevel) &
                bind(C, name="hipGraphicsSubResourceGetMappedArray")
            import
            type(c_ptr), intent(out) :: array
            type(c_ptr), value :: resource
            integer(c_int), value :: arrayIndex
            integer(c_int), value :: mipLevel
        end function hipGraphicsSubResourceGetMappedArray

        integer(c_int) function hipGraphicsUnmapResources(count, resources, stream) &
                bind(C, name="hipGraphicsUnmapResources")
            import
            integer(c_int), value :: count
            type(c_ptr), intent(out) :: resources
            type(c_ptr), value :: stream
        end function hipGraphicsUnmapResources

        integer(c_int) function hipGraphicsUnregisterResource(resource) &
                bind(C, name="hipGraphicsUnregisterResource")
            import
            type(c_ptr), value :: resource
        end function hipGraphicsUnregisterResource

        integer(c_int) function hipHostAlloc(ptr, size, flags) &
                bind(C, name="hipHostAlloc")
            import
            type(c_ptr), intent(out) :: ptr
            integer(c_size_t), value :: size
            integer(c_int), value :: flags
        end function hipHostAlloc

        integer(c_int) function hipHostFree(ptr) &
                bind(C, name="hipHostFree")
            import
            type(c_ptr), value :: ptr
        end function hipHostFree

        integer(c_int) function hipHostGetDevicePointer(devPtr, hstPtr, flags) &
                bind(C, name="hipHostGetDevicePointer")
            import
            type(c_ptr), intent(out) :: devPtr
            type(c_ptr), value :: hstPtr
            integer(c_int), value :: flags
        end function hipHostGetDevicePointer

        integer(c_int) function hipHostGetFlags(flagsPtr, hostPtr) &
                bind(C, name="hipHostGetFlags")
            import
            integer(c_int), intent(inout) :: flagsPtr
            type(c_ptr), value :: hostPtr
        end function hipHostGetFlags

        integer(c_int) function hipHostMalloc(ptr, size, flags) &
                bind(C, name="hipHostMalloc")
            import
            type(c_ptr), intent(out) :: ptr
            integer(c_size_t), value :: size
            integer(c_int), value :: flags
        end function hipHostMalloc

        integer(c_int) function hipHostRegister(hostPtr, sizeBytes, flags) &
                bind(C, name="hipHostRegister")
            import
            type(c_ptr), value :: hostPtr
            integer(c_size_t), value :: sizeBytes
            integer(c_int), value :: flags
        end function hipHostRegister

        integer(c_int) function hipHostUnregister(hostPtr) &
                bind(C, name="hipHostUnregister")
            import
            type(c_ptr), value :: hostPtr
        end function hipHostUnregister

        integer(c_int) function hipImportExternalMemory(extMem_out, memHandleDesc) &
                bind(C, name="hipImportExternalMemory")
            import
            type(c_ptr), intent(out) :: extMem_out
            type(hipExternalMemoryHandleDesc_st), intent(in) :: memHandleDesc
        end function hipImportExternalMemory

        integer(c_int) function hipImportExternalSemaphore(extSem_out, semHandleDesc) &
                bind(C, name="hipImportExternalSemaphore")
            import
            type(c_ptr), intent(out) :: extSem_out
            type(hipExternalSemaphoreHandleDesc_st), intent(in) :: semHandleDesc
        end function hipImportExternalSemaphore

        integer(c_int) function hipInit(flags) &
                bind(C, name="hipInit")
            import
            integer(c_int), value :: flags
        end function hipInit

        integer(c_int) function hipIpcCloseMemHandle(devPtr) &
                bind(C, name="hipIpcCloseMemHandle")
            import
            type(c_ptr), value :: devPtr
        end function hipIpcCloseMemHandle

        integer(c_int) function hipIpcGetEventHandle(handle, event) &
                bind(C, name="hipIpcGetEventHandle")
            import
            type(hipIpcEventHandle_st), intent(inout) :: handle
            type(c_ptr), value :: event
        end function hipIpcGetEventHandle

        integer(c_int) function hipIpcGetMemHandle(handle, devPtr) &
                bind(C, name="hipIpcGetMemHandle")
            import
            type(hipIpcMemHandle_st), intent(inout) :: handle
            type(c_ptr), value :: devPtr
        end function hipIpcGetMemHandle

        integer(c_int) function hipIpcOpenEventHandle(event, handle) &
                bind(C, name="hipIpcOpenEventHandle")
            import
            type(c_ptr), intent(out) :: event
            type(hipIpcEventHandle_st), value :: handle
        end function hipIpcOpenEventHandle

        integer(c_int) function hipIpcOpenMemHandle(devPtr, handle, flags) &
                bind(C, name="hipIpcOpenMemHandle")
            import
            type(c_ptr), intent(out) :: devPtr
            type(hipIpcMemHandle_st), value :: handle
            integer(c_int), value :: flags
        end function hipIpcOpenMemHandle

        integer(c_int) function hipKernelGetAttribute(pi, attrib, kernel, dev) &
                bind(C, name="hipKernelGetAttribute")
            import
            integer(c_int), intent(inout) :: pi
            integer(c_int), value :: attrib
            type(c_ptr), value :: kernel
            integer(c_int), value :: dev
        end function hipKernelGetAttribute

        integer(c_int) function hipKernelGetFunction(pFunc, kernel) &
                bind(C, name="hipKernelGetFunction")
            import
            type(c_ptr), intent(out) :: pFunc
            type(c_ptr), value :: kernel
        end function hipKernelGetFunction

        integer(c_int) function hipKernelGetLibrary(library, kernel) &
                bind(C, name="hipKernelGetLibrary")
            import
            type(c_ptr), intent(out) :: library
            type(c_ptr), value :: kernel
        end function hipKernelGetLibrary

        integer(c_int) function hipKernelGetName(name, kernel) &
                bind(C, name="hipKernelGetName")
            import
            type(c_ptr), intent(out) :: name
            type(c_ptr), value :: kernel
        end function hipKernelGetName

        integer(c_int) function hipKernelGetParamInfo(kernel, paramIndex, paramOffset, paramSize) &
                bind(C, name="hipKernelGetParamInfo")
            import
            type(c_ptr), value :: kernel
            integer(c_size_t), value :: paramIndex
            integer(c_size_t), intent(inout) :: paramOffset
            integer(c_size_t), intent(inout) :: paramSize
        end function hipKernelGetParamInfo

        type(c_ptr) function hipKernelNameRef(f) &
                bind(C, name="hipKernelNameRef")
            import
            type(c_ptr), value :: f
        end function hipKernelNameRef

        type(c_ptr) function hipKernelNameRefByPtr(hostFunction, stream) &
                bind(C, name="hipKernelNameRefByPtr")
            import
            type(c_ptr), value :: hostFunction
            type(c_ptr), value :: stream
        end function hipKernelNameRefByPtr

        integer(c_int) function hipKernelSetAttribute(attrib, value, kernel, dev) &
                bind(C, name="hipKernelSetAttribute")
            import
            integer(c_int), value :: attrib
            integer(c_int), value :: value
            type(c_ptr), value :: kernel
            integer(c_int), value :: dev
        end function hipKernelSetAttribute

        integer(c_int) function hipLaunchByPtr(func) &
                bind(C, name="hipLaunchByPtr")
            import
            type(c_ptr), value :: func
        end function hipLaunchByPtr

        integer(c_int) function hipLaunchCooperativeKernel( &
                f, gridDim, blockDimX, kernelParams, sharedMemBytes, stream) &
                bind(C, name="hipLaunchCooperativeKernel")
            import
            type(c_ptr), value :: f
            type(dim3), value :: gridDim
            type(dim3), value :: blockDimX
            type(c_ptr), dimension(*), intent(in) :: kernelParams
            integer(c_int), value :: sharedMemBytes
            type(c_ptr), value :: stream
        end function hipLaunchCooperativeKernel

        integer(c_int) function hipLaunchCooperativeKernelMultiDevice(launchParamsList, numDevices, flags) &
                bind(C, name="hipLaunchCooperativeKernelMultiDevice")
            import
            type(hipLaunchParams_t), intent(inout) :: launchParamsList
            integer(c_int), value :: numDevices
            integer(c_int), value :: flags
        end function hipLaunchCooperativeKernelMultiDevice

        integer(c_int) function hipLaunchHostFunc(stream, fn, userData) &
                bind(C, name="hipLaunchHostFunc")
            import
            type(c_ptr), value :: stream
            type(c_funptr), value :: fn
            type(c_ptr), value :: userData
        end function hipLaunchHostFunc

        integer(c_int) function hipLaunchKernel(function_address, numBlocks, dimBlocks, args, sharedMemBytes, stream) &
                bind(C, name="hipLaunchKernel")
            import
            type(c_ptr), value :: function_address
            type(dim3), value :: numBlocks
            type(dim3), value :: dimBlocks
            type(c_ptr), dimension(*), intent(in) :: args
            integer(c_size_t), value :: sharedMemBytes
            type(c_ptr), value :: stream
        end function hipLaunchKernel

        integer(c_int) function hipLaunchKernelExC(config, fPtr, args) &
                bind(C, name="hipLaunchKernelExC")
            import
            type(hipLaunchConfig_st), intent(in) :: config
            type(c_ptr), value :: fPtr
            type(c_ptr), dimension(*), intent(in) :: args
        end function hipLaunchKernelExC

        integer(c_int) function hipLibraryEnumerateKernels(kernels, numKernels, library) &
                bind(C, name="hipLibraryEnumerateKernels")
            import
            type(c_ptr), intent(out) :: kernels
            integer(c_int), value :: numKernels
            type(c_ptr), value :: library
        end function hipLibraryEnumerateKernels

        integer(c_int) function hipLibraryGetKernel(pKernel, library, name) &
                bind(C, name="hipLibraryGetKernel")
            import
            type(c_ptr), intent(out) :: pKernel
            type(c_ptr), value :: library
            character(kind=c_char), dimension(*), intent(in) :: name
        end function hipLibraryGetKernel

        integer(c_int) function hipLibraryGetKernelCount(count, library) &
                bind(C, name="hipLibraryGetKernelCount")
            import
            integer(c_int), intent(inout) :: count
            type(c_ptr), value :: library
        end function hipLibraryGetKernelCount

        integer(c_int) function hipLibraryLoadData( &
                library, code, jitOptions, jitOptionsValues, numJitOptions, libraryOptions, libraryOptionValues, &
                numLibraryOptions) &
                bind(C, name="hipLibraryLoadData")
            import
            type(c_ptr), intent(out) :: library
            type(c_ptr), value :: code
            integer(c_int), intent(out) :: jitOptions
            type(c_ptr), intent(out) :: jitOptionsValues
            integer(c_int), value :: numJitOptions
            integer(c_int), intent(out) :: libraryOptions
            type(c_ptr), intent(out) :: libraryOptionValues
            integer(c_int), value :: numLibraryOptions
        end function hipLibraryLoadData

        integer(c_int) function hipLibraryLoadFromFile( &
                library, fileName, jitOptions, jitOptionsValues, numJitOptions, libraryOptions, libraryOptionValues, &
                numLibraryOptions) &
                bind(C, name="hipLibraryLoadFromFile")
            import
            type(c_ptr), intent(out) :: library
            character(kind=c_char), dimension(*), intent(in) :: fileName
            integer(c_int), intent(out) :: jitOptions
            type(c_ptr), intent(out) :: jitOptionsValues
            integer(c_int), value :: numJitOptions
            integer(c_int), intent(out) :: libraryOptions
            type(c_ptr), intent(out) :: libraryOptionValues
            integer(c_int), value :: numLibraryOptions
        end function hipLibraryLoadFromFile

        integer(c_int) function hipLibraryUnload(library) &
                bind(C, name="hipLibraryUnload")
            import
            type(c_ptr), value :: library
        end function hipLibraryUnload

        integer(c_int) function hipLinkAddData(state, type, data, size, name, numOptions, options, optionValues) &
                bind(C, name="hipLinkAddData")
            import
            type(c_ptr), value :: state
            integer(c_int), value :: type
            type(c_ptr), value :: data
            integer(c_size_t), value :: size
            character(kind=c_char), dimension(*), intent(in) :: name
            integer(c_int), value :: numOptions
            integer(c_int), intent(out) :: options
            type(c_ptr), intent(out) :: optionValues
        end function hipLinkAddData

        integer(c_int) function hipLinkAddFile(state, type, path, numOptions, options, optionValues) &
                bind(C, name="hipLinkAddFile")
            import
            type(c_ptr), value :: state
            integer(c_int), value :: type
            character(kind=c_char), dimension(*), intent(in) :: path
            integer(c_int), value :: numOptions
            integer(c_int), intent(out) :: options
            type(c_ptr), intent(out) :: optionValues
        end function hipLinkAddFile

        integer(c_int) function hipLinkComplete(state, hipBinOut, sizeOut) &
                bind(C, name="hipLinkComplete")
            import
            type(c_ptr), value :: state
            type(c_ptr), intent(out) :: hipBinOut
            integer(c_size_t), intent(inout) :: sizeOut
        end function hipLinkComplete

        integer(c_int) function hipLinkCreate(numOptions, options, optionValues, stateOut) &
                bind(C, name="hipLinkCreate")
            import
            integer(c_int), value :: numOptions
            integer(c_int), intent(out) :: options
            type(c_ptr), intent(out) :: optionValues
            type(c_ptr), intent(out) :: stateOut
        end function hipLinkCreate

        integer(c_int) function hipLinkDestroy(state) &
                bind(C, name="hipLinkDestroy")
            import
            type(c_ptr), value :: state
        end function hipLinkDestroy

        integer(c_int) function hipMalloc(ptr, size) &
                bind(C, name="hipMalloc")
            import
            type(c_ptr), intent(out) :: ptr
            integer(c_size_t), value :: size
        end function hipMalloc

        integer(c_int) function hipMalloc3D(pitchedDevPtr, extent) &
                bind(C, name="hipMalloc3D")
            import
            type(hipPitchedPtr), intent(inout) :: pitchedDevPtr
            type(hipExtent), value :: extent
        end function hipMalloc3D

        integer(c_int) function hipMalloc3DArray(array, desc, extent, flags) &
                bind(C, name="hipMalloc3DArray")
            import
            type(c_ptr), intent(out) :: array
            type(hipChannelFormatDesc), intent(in) :: desc
            type(hipExtent), value :: extent
            integer(c_int), value :: flags
        end function hipMalloc3DArray

        integer(c_int) function hipMallocArray(array, desc, width, height, flags) &
                bind(C, name="hipMallocArray")
            import
            type(c_ptr), intent(out) :: array
            type(hipChannelFormatDesc), intent(in) :: desc
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            integer(c_int), value :: flags
        end function hipMallocArray

        integer(c_int) function hipMallocAsync(dev_ptr, size, stream) &
                bind(C, name="hipMallocAsync")
            import
            type(c_ptr), intent(out) :: dev_ptr
            integer(c_size_t), value :: size
            type(c_ptr), value :: stream
        end function hipMallocAsync

        integer(c_int) function hipMallocFromPoolAsync(dev_ptr, size, mem_pool, stream) &
                bind(C, name="hipMallocFromPoolAsync")
            import
            type(c_ptr), intent(out) :: dev_ptr
            integer(c_size_t), value :: size
            type(c_ptr), value :: mem_pool
            type(c_ptr), value :: stream
        end function hipMallocFromPoolAsync

        integer(c_int) function hipMallocHost(ptr, size) &
                bind(C, name="hipMallocHost")
            import
            type(c_ptr), intent(out) :: ptr
            integer(c_size_t), value :: size
        end function hipMallocHost

        integer(c_int) function hipMallocManaged(dev_ptr, size, flags) &
                bind(C, name="hipMallocManaged")
            import
            type(c_ptr), intent(out) :: dev_ptr
            integer(c_size_t), value :: size
            integer(c_int), value :: flags
        end function hipMallocManaged

        integer(c_int) function hipMallocMipmappedArray(mipmappedArray, desc, extent, numLevels, flags) &
                bind(C, name="hipMallocMipmappedArray")
            import
            type(c_ptr), intent(out) :: mipmappedArray
            type(hipChannelFormatDesc), intent(in) :: desc
            type(hipExtent), value :: extent
            integer(c_int), value :: numLevels
            integer(c_int), value :: flags
        end function hipMallocMipmappedArray

        integer(c_int) function hipMallocPitch(ptr, pitch, width, height) &
                bind(C, name="hipMallocPitch")
            import
            type(c_ptr), intent(out) :: ptr
            integer(c_size_t), intent(inout) :: pitch
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
        end function hipMallocPitch

        integer(c_int) function hipMemAddressFree(devPtr, size) &
                bind(C, name="hipMemAddressFree")
            import
            type(c_ptr), value :: devPtr
            integer(c_size_t), value :: size
        end function hipMemAddressFree

        integer(c_int) function hipMemAddressReserve(ptr, size, alignment, addr, flags) &
                bind(C, name="hipMemAddressReserve")
            import
            type(c_ptr), intent(out) :: ptr
            integer(c_size_t), value :: size
            integer(c_size_t), value :: alignment
            type(c_ptr), value :: addr
            integer(c_long_long), value :: flags
        end function hipMemAddressReserve

        integer(c_int) function hipMemAdvise(dev_ptr, count, advice, device) &
                bind(C, name="hipMemAdvise")
            import
            type(c_ptr), value :: dev_ptr
            integer(c_size_t), value :: count
            integer(c_int), value :: advice
            integer(c_int), value :: device
        end function hipMemAdvise

        integer(c_int) function hipMemAdvise_v2(dev_ptr, count, advice, location) &
                bind(C, name="hipMemAdvise_v2")
            import
            type(c_ptr), value :: dev_ptr
            integer(c_size_t), value :: count
            integer(c_int), value :: advice
            type(hipMemLocation), value :: location
        end function hipMemAdvise_v2

        integer(c_int) function hipMemAllocHost(ptr, size) &
                bind(C, name="hipMemAllocHost")
            import
            type(c_ptr), intent(out) :: ptr
            integer(c_size_t), value :: size
        end function hipMemAllocHost

        integer(c_int) function hipMemAllocPitch(dptr, pitch, widthInBytes, height, elementSizeBytes) &
                bind(C, name="hipMemAllocPitch")
            import
            type(c_ptr), intent(out) :: dptr
            integer(c_size_t), intent(inout) :: pitch
            integer(c_size_t), value :: widthInBytes
            integer(c_size_t), value :: height
            integer(c_int), value :: elementSizeBytes
        end function hipMemAllocPitch

        integer(c_int) function hipMemCreate(handle, size, prop, flags) &
                bind(C, name="hipMemCreate")
            import
            type(c_ptr), intent(out) :: handle
            integer(c_size_t), value :: size
            type(hipMemAllocationProp), intent(in) :: prop
            integer(c_long_long), value :: flags
        end function hipMemCreate

        integer(c_int) function hipMemExportToShareableHandle(shareableHandle, handle, handleType, flags) &
                bind(C, name="hipMemExportToShareableHandle")
            import
            type(c_ptr), value :: shareableHandle
            type(c_ptr), value :: handle
            integer(c_int), value :: handleType
            integer(c_long_long), value :: flags
        end function hipMemExportToShareableHandle

        integer(c_int) function hipMemGetAccess(flags, location, ptr) &
                bind(C, name="hipMemGetAccess")
            import
            integer(c_long_long), intent(inout) :: flags
            type(hipMemLocation), intent(in) :: location
            type(c_ptr), value :: ptr
        end function hipMemGetAccess

        integer(c_int) function hipMemGetAddressRange(pbase, psize, dptr) &
                bind(C, name="hipMemGetAddressRange")
            import
            type(c_ptr), intent(out) :: pbase
            integer(c_size_t), intent(inout) :: psize
            type(c_ptr), value :: dptr
        end function hipMemGetAddressRange

        integer(c_int) function hipMemGetAllocationGranularity(granularity, prop, option) &
                bind(C, name="hipMemGetAllocationGranularity")
            import
            integer(c_size_t), intent(inout) :: granularity
            type(hipMemAllocationProp), intent(in) :: prop
            integer(c_int), value :: option
        end function hipMemGetAllocationGranularity

        integer(c_int) function hipMemGetAllocationPropertiesFromHandle(prop, handle) &
                bind(C, name="hipMemGetAllocationPropertiesFromHandle")
            import
            type(hipMemAllocationProp), intent(inout) :: prop
            type(c_ptr), value :: handle
        end function hipMemGetAllocationPropertiesFromHandle

        integer(c_int) function hipMemGetHandleForAddressRange(handle, dptr, size, handleType, flags) &
                bind(C, name="hipMemGetHandleForAddressRange")
            import
            type(c_ptr), value :: handle
            type(c_ptr), value :: dptr
            integer(c_size_t), value :: size
            integer(c_int), value :: handleType
            integer(c_long_long), value :: flags
        end function hipMemGetHandleForAddressRange

        integer(c_int) function hipMemGetInfo(free, total) &
                bind(C, name="hipMemGetInfo")
            import
            integer(c_size_t), intent(inout) :: free
            integer(c_size_t), intent(inout) :: total
        end function hipMemGetInfo

        integer(c_int) function hipMemGetMemPool(pool, location, type) &
                bind(C, name="hipMemGetMemPool")
            import
            type(c_ptr), intent(out) :: pool
            type(hipMemLocation), intent(inout) :: location
            integer(c_int), value :: type
        end function hipMemGetMemPool

        integer(c_int) function hipMemImportFromShareableHandle(handle, osHandle, shHandleType) &
                bind(C, name="hipMemImportFromShareableHandle")
            import
            type(c_ptr), intent(out) :: handle
            type(c_ptr), value :: osHandle
            integer(c_int), value :: shHandleType
        end function hipMemImportFromShareableHandle

        integer(c_int) function hipMemMap(ptr, size, offset, handle, flags) &
                bind(C, name="hipMemMap")
            import
            type(c_ptr), value :: ptr
            integer(c_size_t), value :: size
            integer(c_size_t), value :: offset
            type(c_ptr), value :: handle
            integer(c_long_long), value :: flags
        end function hipMemMap

        integer(c_int) function hipMemMapArrayAsync(mapInfoList, count, stream) &
                bind(C, name="hipMemMapArrayAsync")
            import
            type(hipArrayMapInfo), intent(inout) :: mapInfoList
            integer(c_int), value :: count
            type(c_ptr), value :: stream
        end function hipMemMapArrayAsync

        integer(c_int) function hipMemPoolCreate(mem_pool, pool_props) &
                bind(C, name="hipMemPoolCreate")
            import
            type(c_ptr), intent(out) :: mem_pool
            type(hipMemPoolProps), intent(in) :: pool_props
        end function hipMemPoolCreate

        integer(c_int) function hipMemPoolDestroy(mem_pool) &
                bind(C, name="hipMemPoolDestroy")
            import
            type(c_ptr), value :: mem_pool
        end function hipMemPoolDestroy

        integer(c_int) function hipMemPoolExportPointer(export_data, dev_ptr) &
                bind(C, name="hipMemPoolExportPointer")
            import
            type(hipMemPoolPtrExportData), intent(inout) :: export_data
            type(c_ptr), value :: dev_ptr
        end function hipMemPoolExportPointer

        integer(c_int) function hipMemPoolExportToShareableHandle(shared_handle, mem_pool, handle_type, flags) &
                bind(C, name="hipMemPoolExportToShareableHandle")
            import
            type(c_ptr), value :: shared_handle
            type(c_ptr), value :: mem_pool
            integer(c_int), value :: handle_type
            integer(c_int), value :: flags
        end function hipMemPoolExportToShareableHandle

        integer(c_int) function hipMemPoolGetAccess(flags, mem_pool, location) &
                bind(C, name="hipMemPoolGetAccess")
            import
            integer(c_int), intent(out) :: flags
            type(c_ptr), value :: mem_pool
            type(hipMemLocation), intent(inout) :: location
        end function hipMemPoolGetAccess

        integer(c_int) function hipMemPoolGetAttribute(mem_pool, attr, value) &
                bind(C, name="hipMemPoolGetAttribute")
            import
            type(c_ptr), value :: mem_pool
            integer(c_int), value :: attr
            type(c_ptr), value :: value
        end function hipMemPoolGetAttribute

        integer(c_int) function hipMemPoolImportFromShareableHandle(mem_pool, shared_handle, handle_type, flags) &
                bind(C, name="hipMemPoolImportFromShareableHandle")
            import
            type(c_ptr), intent(out) :: mem_pool
            type(c_ptr), value :: shared_handle
            integer(c_int), value :: handle_type
            integer(c_int), value :: flags
        end function hipMemPoolImportFromShareableHandle

        integer(c_int) function hipMemPoolImportPointer(dev_ptr, mem_pool, export_data) &
                bind(C, name="hipMemPoolImportPointer")
            import
            type(c_ptr), intent(out) :: dev_ptr
            type(c_ptr), value :: mem_pool
            type(hipMemPoolPtrExportData), intent(inout) :: export_data
        end function hipMemPoolImportPointer

        integer(c_int) function hipMemPoolSetAccess(mem_pool, desc_list, count) &
                bind(C, name="hipMemPoolSetAccess")
            import
            type(c_ptr), value :: mem_pool
            type(hipMemAccessDesc), intent(in) :: desc_list
            integer(c_size_t), value :: count
        end function hipMemPoolSetAccess

        integer(c_int) function hipMemPoolSetAttribute(mem_pool, attr, value) &
                bind(C, name="hipMemPoolSetAttribute")
            import
            type(c_ptr), value :: mem_pool
            integer(c_int), value :: attr
            type(c_ptr), value :: value
        end function hipMemPoolSetAttribute

        integer(c_int) function hipMemPoolTrimTo(mem_pool, min_bytes_to_hold) &
                bind(C, name="hipMemPoolTrimTo")
            import
            type(c_ptr), value :: mem_pool
            integer(c_size_t), value :: min_bytes_to_hold
        end function hipMemPoolTrimTo

        integer(c_int) function hipMemPrefetchAsync(dev_ptr, count, device, stream) &
                bind(C, name="hipMemPrefetchAsync")
            import
            type(c_ptr), value :: dev_ptr
            integer(c_size_t), value :: count
            integer(c_int), value :: device
            type(c_ptr), value :: stream
        end function hipMemPrefetchAsync

        integer(c_int) function hipMemPrefetchAsync_v2(dev_ptr, count, location, flags, stream) &
                bind(C, name="hipMemPrefetchAsync_v2")
            import
            type(c_ptr), value :: dev_ptr
            integer(c_size_t), value :: count
            type(hipMemLocation), value :: location
            integer(c_int), value :: flags
            type(c_ptr), value :: stream
        end function hipMemPrefetchAsync_v2

        integer(c_int) function hipMemPrefetchBatchAsync( &
                dev_ptrs, sizes, count, prefetch_locs, prefetch_loc_idxs, num_prefetch_locs, flags, stream) &
                bind(C, name="hipMemPrefetchBatchAsync")
            import
            type(c_ptr), intent(out) :: dev_ptrs
            integer(c_size_t), intent(inout) :: sizes
            integer(c_size_t), value :: count
            type(hipMemLocation), intent(inout) :: prefetch_locs
            integer(c_size_t), intent(inout) :: prefetch_loc_idxs
            integer(c_size_t), value :: num_prefetch_locs
            integer(c_long_long), value :: flags
            type(c_ptr), value :: stream
        end function hipMemPrefetchBatchAsync

        integer(c_int) function hipMemPtrGetInfo(ptr, size) &
                bind(C, name="hipMemPtrGetInfo")
            import
            type(c_ptr), value :: ptr
            integer(c_size_t), intent(inout) :: size
        end function hipMemPtrGetInfo

        integer(c_int) function hipMemRangeGetAttribute(data, data_size, attribute, dev_ptr, count) &
                bind(C, name="hipMemRangeGetAttribute")
            import
            type(c_ptr), value :: data
            integer(c_size_t), value :: data_size
            integer(c_int), value :: attribute
            type(c_ptr), value :: dev_ptr
            integer(c_size_t), value :: count
        end function hipMemRangeGetAttribute

        integer(c_int) function hipMemRangeGetAttributes(data, data_sizes, attributes, num_attributes, dev_ptr, count) &
                bind(C, name="hipMemRangeGetAttributes")
            import
            type(c_ptr), intent(out) :: data
            integer(c_size_t), intent(inout) :: data_sizes
            integer(c_int), intent(out) :: attributes
            integer(c_size_t), value :: num_attributes
            type(c_ptr), value :: dev_ptr
            integer(c_size_t), value :: count
        end function hipMemRangeGetAttributes

        integer(c_int) function hipMemRelease(handle) &
                bind(C, name="hipMemRelease")
            import
            type(c_ptr), value :: handle
        end function hipMemRelease

        integer(c_int) function hipMemRetainAllocationHandle(handle, addr) &
                bind(C, name="hipMemRetainAllocationHandle")
            import
            type(c_ptr), intent(out) :: handle
            type(c_ptr), value :: addr
        end function hipMemRetainAllocationHandle

        integer(c_int) function hipMemSetAccess(ptr, size, desc, count) &
                bind(C, name="hipMemSetAccess")
            import
            type(c_ptr), value :: ptr
            integer(c_size_t), value :: size
            type(hipMemAccessDesc), intent(in) :: desc
            integer(c_size_t), value :: count
        end function hipMemSetAccess

        integer(c_int) function hipMemSetMemPool(location, type, pool) &
                bind(C, name="hipMemSetMemPool")
            import
            type(hipMemLocation), intent(inout) :: location
            integer(c_int), value :: type
            type(c_ptr), value :: pool
        end function hipMemSetMemPool

        integer(c_int) function hipMemUnmap(ptr, size) &
                bind(C, name="hipMemUnmap")
            import
            type(c_ptr), value :: ptr
            integer(c_size_t), value :: size
        end function hipMemUnmap

        integer(c_int) function hipMemcpy(dst, src, sizeBytes, kind) &
                bind(C, name="hipMemcpy")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
            integer(c_int), value :: kind
        end function hipMemcpy

        integer(c_int) function hipMemcpy2D(dst, dpitch, src, spitch, width, height, kind) &
                bind(C, name="hipMemcpy2D")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dpitch
            type(c_ptr), value :: src
            integer(c_size_t), value :: spitch
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            integer(c_int), value :: kind
        end function hipMemcpy2D

        integer(c_int) function hipMemcpy2DArrayToArray( &
                dst, wOffsetDst, hOffsetDst, src, wOffsetSrc, hOffsetSrc, width, height, kind) &
                bind(C, name="hipMemcpy2DArrayToArray")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: wOffsetDst
            integer(c_size_t), value :: hOffsetDst
            type(c_ptr), value :: src
            integer(c_size_t), value :: wOffsetSrc
            integer(c_size_t), value :: hOffsetSrc
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            integer(c_int), value :: kind
        end function hipMemcpy2DArrayToArray

        integer(c_int) function hipMemcpy2DAsync(dst, dpitch, src, spitch, width, height, kind, stream) &
                bind(C, name="hipMemcpy2DAsync")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dpitch
            type(c_ptr), value :: src
            integer(c_size_t), value :: spitch
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            integer(c_int), value :: kind
            type(c_ptr), value :: stream
        end function hipMemcpy2DAsync

        integer(c_int) function hipMemcpy2DFromArray(dst, dpitch, src, wOffset, hOffset, width, height, kind) &
                bind(C, name="hipMemcpy2DFromArray")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dpitch
            type(c_ptr), value :: src
            integer(c_size_t), value :: wOffset
            integer(c_size_t), value :: hOffset
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            integer(c_int), value :: kind
        end function hipMemcpy2DFromArray

        integer(c_int) function hipMemcpy2DFromArrayAsync( &
                dst, dpitch, src, wOffset, hOffset, width, height, kind, stream) &
                bind(C, name="hipMemcpy2DFromArrayAsync")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dpitch
            type(c_ptr), value :: src
            integer(c_size_t), value :: wOffset
            integer(c_size_t), value :: hOffset
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            integer(c_int), value :: kind
            type(c_ptr), value :: stream
        end function hipMemcpy2DFromArrayAsync

        integer(c_int) function hipMemcpy2DToArray(dst, wOffset, hOffset, src, spitch, width, height, kind) &
                bind(C, name="hipMemcpy2DToArray")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: wOffset
            integer(c_size_t), value :: hOffset
            type(c_ptr), value :: src
            integer(c_size_t), value :: spitch
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            integer(c_int), value :: kind
        end function hipMemcpy2DToArray

        integer(c_int) function hipMemcpy2DToArrayAsync( &
                dst, wOffset, hOffset, src, spitch, width, height, kind, stream) &
                bind(C, name="hipMemcpy2DToArrayAsync")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: wOffset
            integer(c_size_t), value :: hOffset
            type(c_ptr), value :: src
            integer(c_size_t), value :: spitch
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            integer(c_int), value :: kind
            type(c_ptr), value :: stream
        end function hipMemcpy2DToArrayAsync

        integer(c_int) function hipMemcpy3D(p) &
                bind(C, name="hipMemcpy3D")
            import
            type(hipMemcpy3DParms), intent(in) :: p
        end function hipMemcpy3D

        integer(c_int) function hipMemcpy3DAsync(p, stream) &
                bind(C, name="hipMemcpy3DAsync")
            import
            type(hipMemcpy3DParms), intent(in) :: p
            type(c_ptr), value :: stream
        end function hipMemcpy3DAsync

        integer(c_int) function hipMemcpy3DBatchAsync(numOps, opList, failIdx, flags, stream) &
                bind(C, name="hipMemcpy3DBatchAsync")
            import
            integer(c_size_t), value :: numOps
            type(hipMemcpy3DBatchOp), intent(inout) :: opList
            integer(c_size_t), intent(inout) :: failIdx
            integer(c_long_long), value :: flags
            type(c_ptr), value :: stream
        end function hipMemcpy3DBatchAsync

        integer(c_int) function hipMemcpy3DPeer(p) &
                bind(C, name="hipMemcpy3DPeer")
            import
            type(hipMemcpy3DPeerParms), intent(inout) :: p
        end function hipMemcpy3DPeer

        integer(c_int) function hipMemcpy3DPeerAsync(p, stream) &
                bind(C, name="hipMemcpy3DPeerAsync")
            import
            type(hipMemcpy3DPeerParms), intent(inout) :: p
            type(c_ptr), value :: stream
        end function hipMemcpy3DPeerAsync

        integer(c_int) function hipMemcpyAsync(dst, src, sizeBytes, kind, stream) &
                bind(C, name="hipMemcpyAsync")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
            integer(c_int), value :: kind
            type(c_ptr), value :: stream
        end function hipMemcpyAsync

        integer(c_int) function hipMemcpyAtoA(dstArray, dstOffset, srcArray, srcOffset, ByteCount) &
                bind(C, name="hipMemcpyAtoA")
            import
            type(c_ptr), value :: dstArray
            integer(c_size_t), value :: dstOffset
            type(c_ptr), value :: srcArray
            integer(c_size_t), value :: srcOffset
            integer(c_size_t), value :: ByteCount
        end function hipMemcpyAtoA

        integer(c_int) function hipMemcpyAtoD(dstDevice, srcArray, srcOffset, ByteCount) &
                bind(C, name="hipMemcpyAtoD")
            import
            type(c_ptr), value :: dstDevice
            type(c_ptr), value :: srcArray
            integer(c_size_t), value :: srcOffset
            integer(c_size_t), value :: ByteCount
        end function hipMemcpyAtoD

        integer(c_int) function hipMemcpyAtoH(dst, srcArray, srcOffset, count) &
                bind(C, name="hipMemcpyAtoH")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: srcArray
            integer(c_size_t), value :: srcOffset
            integer(c_size_t), value :: count
        end function hipMemcpyAtoH

        integer(c_int) function hipMemcpyAtoHAsync(dstHost, srcArray, srcOffset, ByteCount, stream) &
                bind(C, name="hipMemcpyAtoHAsync")
            import
            type(c_ptr), value :: dstHost
            type(c_ptr), value :: srcArray
            integer(c_size_t), value :: srcOffset
            integer(c_size_t), value :: ByteCount
            type(c_ptr), value :: stream
        end function hipMemcpyAtoHAsync

        integer(c_int) function hipMemcpyBatchAsync( &
                dsts, srcs, sizes, count, attrs, attrsIdxs, numAttrs, failIdx, stream) &
                bind(C, name="hipMemcpyBatchAsync")
            import
            type(c_ptr), intent(out) :: dsts
            type(c_ptr), intent(out) :: srcs
            integer(c_size_t), intent(inout) :: sizes
            integer(c_size_t), value :: count
            type(hipMemcpyAttributes), intent(inout) :: attrs
            integer(c_size_t), intent(inout) :: attrsIdxs
            integer(c_size_t), value :: numAttrs
            integer(c_size_t), intent(inout) :: failIdx
            type(c_ptr), value :: stream
        end function hipMemcpyBatchAsync

        integer(c_int) function hipMemcpyDtoA(dstArray, dstOffset, srcDevice, ByteCount) &
                bind(C, name="hipMemcpyDtoA")
            import
            type(c_ptr), value :: dstArray
            integer(c_size_t), value :: dstOffset
            type(c_ptr), value :: srcDevice
            integer(c_size_t), value :: ByteCount
        end function hipMemcpyDtoA

        integer(c_int) function hipMemcpyDtoD(dst, src, sizeBytes) &
                bind(C, name="hipMemcpyDtoD")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
        end function hipMemcpyDtoD

        integer(c_int) function hipMemcpyDtoDAsync(dst, src, sizeBytes, stream) &
                bind(C, name="hipMemcpyDtoDAsync")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
            type(c_ptr), value :: stream
        end function hipMemcpyDtoDAsync

        integer(c_int) function hipMemcpyDtoH(dst, src, sizeBytes) &
                bind(C, name="hipMemcpyDtoH")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
        end function hipMemcpyDtoH

        integer(c_int) function hipMemcpyDtoHAsync(dst, src, sizeBytes, stream) &
                bind(C, name="hipMemcpyDtoHAsync")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
            type(c_ptr), value :: stream
        end function hipMemcpyDtoHAsync

        integer(c_int) function hipMemcpyFromArray(dst, srcArray, wOffset, hOffset, count, kind) &
                bind(C, name="hipMemcpyFromArray")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: srcArray
            integer(c_size_t), value :: wOffset
            integer(c_size_t), value :: hOffset
            integer(c_size_t), value :: count
            integer(c_int), value :: kind
        end function hipMemcpyFromArray

        integer(c_int) function hipMemcpyFromSymbol(dst, symbol, sizeBytes, offset, kind) &
                bind(C, name="hipMemcpyFromSymbol")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: symbol
            integer(c_size_t), value :: sizeBytes
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
        end function hipMemcpyFromSymbol

        integer(c_int) function hipMemcpyFromSymbolAsync(dst, symbol, sizeBytes, offset, kind, stream) &
                bind(C, name="hipMemcpyFromSymbolAsync")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: symbol
            integer(c_size_t), value :: sizeBytes
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
            type(c_ptr), value :: stream
        end function hipMemcpyFromSymbolAsync

        integer(c_int) function hipMemcpyHtoA(dstArray, dstOffset, srcHost, count) &
                bind(C, name="hipMemcpyHtoA")
            import
            type(c_ptr), value :: dstArray
            integer(c_size_t), value :: dstOffset
            type(c_ptr), value :: srcHost
            integer(c_size_t), value :: count
        end function hipMemcpyHtoA

        integer(c_int) function hipMemcpyHtoAAsync(dstArray, dstOffset, srcHost, ByteCount, stream) &
                bind(C, name="hipMemcpyHtoAAsync")
            import
            type(c_ptr), value :: dstArray
            integer(c_size_t), value :: dstOffset
            type(c_ptr), value :: srcHost
            integer(c_size_t), value :: ByteCount
            type(c_ptr), value :: stream
        end function hipMemcpyHtoAAsync

        integer(c_int) function hipMemcpyHtoD(dst, src, sizeBytes) &
                bind(C, name="hipMemcpyHtoD")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
        end function hipMemcpyHtoD

        integer(c_int) function hipMemcpyHtoDAsync(dst, src, sizeBytes, stream) &
                bind(C, name="hipMemcpyHtoDAsync")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
            type(c_ptr), value :: stream
        end function hipMemcpyHtoDAsync

        integer(c_int) function hipMemcpyParam2D(pCopy) &
                bind(C, name="hipMemcpyParam2D")
            import
            type(hip_Memcpy2D), intent(in) :: pCopy
        end function hipMemcpyParam2D

        integer(c_int) function hipMemcpyParam2DAsync(pCopy, stream) &
                bind(C, name="hipMemcpyParam2DAsync")
            import
            type(hip_Memcpy2D), intent(in) :: pCopy
            type(c_ptr), value :: stream
        end function hipMemcpyParam2DAsync

        integer(c_int) function hipMemcpyPeer(dst, dstDeviceId, src, srcDeviceId, sizeBytes) &
                bind(C, name="hipMemcpyPeer")
            import
            type(c_ptr), value :: dst
            integer(c_int), value :: dstDeviceId
            type(c_ptr), value :: src
            integer(c_int), value :: srcDeviceId
            integer(c_size_t), value :: sizeBytes
        end function hipMemcpyPeer

        integer(c_int) function hipMemcpyPeerAsync(dst, dstDeviceId, src, srcDevice, sizeBytes, stream) &
                bind(C, name="hipMemcpyPeerAsync")
            import
            type(c_ptr), value :: dst
            integer(c_int), value :: dstDeviceId
            type(c_ptr), value :: src
            integer(c_int), value :: srcDevice
            integer(c_size_t), value :: sizeBytes
            type(c_ptr), value :: stream
        end function hipMemcpyPeerAsync

        integer(c_int) function hipMemcpyToArray(dst, wOffset, hOffset, src, count, kind) &
                bind(C, name="hipMemcpyToArray")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: wOffset
            integer(c_size_t), value :: hOffset
            type(c_ptr), value :: src
            integer(c_size_t), value :: count
            integer(c_int), value :: kind
        end function hipMemcpyToArray

        integer(c_int) function hipMemcpyToSymbol(symbol, src, sizeBytes, offset, kind) &
                bind(C, name="hipMemcpyToSymbol")
            import
            type(c_ptr), value :: symbol
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
        end function hipMemcpyToSymbol

        integer(c_int) function hipMemcpyToSymbolAsync(symbol, src, sizeBytes, offset, kind, stream) &
                bind(C, name="hipMemcpyToSymbolAsync")
            import
            type(c_ptr), value :: symbol
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
            integer(c_size_t), value :: offset
            integer(c_int), value :: kind
            type(c_ptr), value :: stream
        end function hipMemcpyToSymbolAsync

        integer(c_int) function hipMemcpyWithStream(dst, src, sizeBytes, kind, stream) &
                bind(C, name="hipMemcpyWithStream")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
            integer(c_size_t), value :: sizeBytes
            integer(c_int), value :: kind
            type(c_ptr), value :: stream
        end function hipMemcpyWithStream

        integer(c_int) function hipMemset(dst, value, sizeBytes) &
                bind(C, name="hipMemset")
            import
            type(c_ptr), value :: dst
            integer(c_int), value :: value
            integer(c_size_t), value :: sizeBytes
        end function hipMemset

        integer(c_int) function hipMemset2D(dst, pitch, value, width, height) &
                bind(C, name="hipMemset2D")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: pitch
            integer(c_int), value :: value
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
        end function hipMemset2D

        integer(c_int) function hipMemset2DAsync(dst, pitch, value, width, height, stream) &
                bind(C, name="hipMemset2DAsync")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: pitch
            integer(c_int), value :: value
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            type(c_ptr), value :: stream
        end function hipMemset2DAsync

        integer(c_int) function hipMemset3D(pitchedDevPtr, value, extent) &
                bind(C, name="hipMemset3D")
            import
            type(hipPitchedPtr), value :: pitchedDevPtr
            integer(c_int), value :: value
            type(hipExtent), value :: extent
        end function hipMemset3D

        integer(c_int) function hipMemset3DAsync(pitchedDevPtr, value, extent, stream) &
                bind(C, name="hipMemset3DAsync")
            import
            type(hipPitchedPtr), value :: pitchedDevPtr
            integer(c_int), value :: value
            type(hipExtent), value :: extent
            type(c_ptr), value :: stream
        end function hipMemset3DAsync

        integer(c_int) function hipMemsetAsync(dst, value, sizeBytes, stream) &
                bind(C, name="hipMemsetAsync")
            import
            type(c_ptr), value :: dst
            integer(c_int), value :: value
            integer(c_size_t), value :: sizeBytes
            type(c_ptr), value :: stream
        end function hipMemsetAsync

        integer(c_int) function hipMemsetD16(dest, value, count) &
                bind(C, name="hipMemsetD16")
            import
            type(c_ptr), value :: dest
            integer(c_short), value :: value
            integer(c_size_t), value :: count
        end function hipMemsetD16

        integer(c_int) function hipMemsetD16Async(dest, value, count, stream) &
                bind(C, name="hipMemsetD16Async")
            import
            type(c_ptr), value :: dest
            integer(c_short), value :: value
            integer(c_size_t), value :: count
            type(c_ptr), value :: stream
        end function hipMemsetD16Async

        integer(c_int) function hipMemsetD2D16(dst, dstPitch, value, width, height) &
                bind(C, name="hipMemsetD2D16")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dstPitch
            integer(c_short), value :: value
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
        end function hipMemsetD2D16

        integer(c_int) function hipMemsetD2D16Async(dst, dstPitch, value, width, height, stream) &
                bind(C, name="hipMemsetD2D16Async")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dstPitch
            integer(c_short), value :: value
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            type(c_ptr), value :: stream
        end function hipMemsetD2D16Async

        integer(c_int) function hipMemsetD2D32(dst, dstPitch, value, width, height) &
                bind(C, name="hipMemsetD2D32")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dstPitch
            integer(c_int), value :: value
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
        end function hipMemsetD2D32

        integer(c_int) function hipMemsetD2D32Async(dst, dstPitch, value, width, height, stream) &
                bind(C, name="hipMemsetD2D32Async")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dstPitch
            integer(c_int), value :: value
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            type(c_ptr), value :: stream
        end function hipMemsetD2D32Async

        integer(c_int) function hipMemsetD2D8(dst, dstPitch, value, width, height) &
                bind(C, name="hipMemsetD2D8")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dstPitch
            integer(c_signed_char), value :: value
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
        end function hipMemsetD2D8

        integer(c_int) function hipMemsetD2D8Async(dst, dstPitch, value, width, height, stream) &
                bind(C, name="hipMemsetD2D8Async")
            import
            type(c_ptr), value :: dst
            integer(c_size_t), value :: dstPitch
            integer(c_signed_char), value :: value
            integer(c_size_t), value :: width
            integer(c_size_t), value :: height
            type(c_ptr), value :: stream
        end function hipMemsetD2D8Async

        integer(c_int) function hipMemsetD32(dest, value, count) &
                bind(C, name="hipMemsetD32")
            import
            type(c_ptr), value :: dest
            integer(c_int), value :: value
            integer(c_size_t), value :: count
        end function hipMemsetD32

        integer(c_int) function hipMemsetD32Async(dst, value, count, stream) &
                bind(C, name="hipMemsetD32Async")
            import
            type(c_ptr), value :: dst
            integer(c_int), value :: value
            integer(c_size_t), value :: count
            type(c_ptr), value :: stream
        end function hipMemsetD32Async

        integer(c_int) function hipMemsetD8(dest, value, count) &
                bind(C, name="hipMemsetD8")
            import
            type(c_ptr), value :: dest
            integer(c_signed_char), value :: value
            integer(c_size_t), value :: count
        end function hipMemsetD8

        integer(c_int) function hipMemsetD8Async(dest, value, count, stream) &
                bind(C, name="hipMemsetD8Async")
            import
            type(c_ptr), value :: dest
            integer(c_signed_char), value :: value
            integer(c_size_t), value :: count
            type(c_ptr), value :: stream
        end function hipMemsetD8Async

        integer(c_int) function hipMipmappedArrayCreate(pHandle, pMipmappedArrayDesc, numMipmapLevels) &
                bind(C, name="hipMipmappedArrayCreate")
            import
            type(c_ptr), intent(out) :: pHandle
            type(HIP_ARRAY3D_DESCRIPTOR), intent(inout) :: pMipmappedArrayDesc
            integer(c_int), value :: numMipmapLevels
        end function hipMipmappedArrayCreate

        integer(c_int) function hipMipmappedArrayDestroy(hMipmappedArray) &
                bind(C, name="hipMipmappedArrayDestroy")
            import
            type(c_ptr), value :: hMipmappedArray
        end function hipMipmappedArrayDestroy

        integer(c_int) function hipMipmappedArrayGetLevel(pLevelArray, hMipMappedArray, level) &
                bind(C, name="hipMipmappedArrayGetLevel")
            import
            type(c_ptr), intent(out) :: pLevelArray
            type(c_ptr), value :: hMipMappedArray
            integer(c_int), value :: level
        end function hipMipmappedArrayGetLevel

        integer(c_int) function hipMipmappedArrayGetMemoryRequirements(memoryRequirements, mipmap, device) &
                bind(C, name="hipMipmappedArrayGetMemoryRequirements")
            import
            type(hipArrayMemoryRequirements), intent(inout) :: memoryRequirements
            type(c_ptr), value :: mipmap
            integer(c_int), value :: device
        end function hipMipmappedArrayGetMemoryRequirements

        integer(c_int) function hipModuleGetFunction(function, module, kname) &
                bind(C, name="hipModuleGetFunction")
            import
            type(c_ptr), intent(out) :: function
            type(c_ptr), value :: module
            character(kind=c_char), dimension(*), intent(in) :: kname
        end function hipModuleGetFunction

        integer(c_int) function hipModuleGetFunctionCount(count, mod) &
                bind(C, name="hipModuleGetFunctionCount")
            import
            integer(c_int), intent(inout) :: count
            type(c_ptr), value :: mod
        end function hipModuleGetFunctionCount

        integer(c_int) function hipModuleGetGlobal(dptr, bytes, hmod, name) &
                bind(C, name="hipModuleGetGlobal")
            import
            type(c_ptr), intent(out) :: dptr
            integer(c_size_t), intent(inout) :: bytes
            type(c_ptr), value :: hmod
            character(kind=c_char), dimension(*), intent(in) :: name
        end function hipModuleGetGlobal

        integer(c_int) function hipModuleGetTexRef(texRef, hmod, name) &
                bind(C, name="hipModuleGetTexRef")
            import
            type(textureReference), intent(inout) :: texRef
            type(c_ptr), value :: hmod
            character(kind=c_char), dimension(*), intent(in) :: name
        end function hipModuleGetTexRef

        integer(c_int) function hipModuleLaunchCooperativeKernel( &
                f, gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY, blockDimZ, sharedMemBytes, stream, kernelParams) &
                bind(C, name="hipModuleLaunchCooperativeKernel")
            import
            type(c_ptr), value :: f
            integer(c_int), value :: gridDimX
            integer(c_int), value :: gridDimY
            integer(c_int), value :: gridDimZ
            integer(c_int), value :: blockDimX
            integer(c_int), value :: blockDimY
            integer(c_int), value :: blockDimZ
            integer(c_int), value :: sharedMemBytes
            type(c_ptr), value :: stream
            type(c_ptr), dimension(*), intent(in) :: kernelParams
        end function hipModuleLaunchCooperativeKernel

        integer(c_int) function hipModuleLaunchCooperativeKernelMultiDevice(launchParamsList, numDevices, flags) &
                bind(C, name="hipModuleLaunchCooperativeKernelMultiDevice")
            import
            type(hipFunctionLaunchParams_t), intent(inout) :: launchParamsList
            integer(c_int), value :: numDevices
            integer(c_int), value :: flags
        end function hipModuleLaunchCooperativeKernelMultiDevice

        integer(c_int) function hipModuleLaunchKernel( &
                f, gridDimX, gridDimY, gridDimZ, blockDimX, blockDimY, blockDimZ, sharedMemBytes, stream, &
                kernelParams, extra) &
                bind(C, name="hipModuleLaunchKernel")
            import
            type(c_ptr), value :: f
            integer(c_int), value :: gridDimX
            integer(c_int), value :: gridDimY
            integer(c_int), value :: gridDimZ
            integer(c_int), value :: blockDimX
            integer(c_int), value :: blockDimY
            integer(c_int), value :: blockDimZ
            integer(c_int), value :: sharedMemBytes
            type(c_ptr), value :: stream
            type(c_ptr), dimension(*), intent(in) :: kernelParams
            type(c_ptr), dimension(*), intent(in) :: extra
        end function hipModuleLaunchKernel

        integer(c_int) function hipModuleLoad(module, fname) &
                bind(C, name="hipModuleLoad")
            import
            type(c_ptr), intent(out) :: module
            character(kind=c_char), dimension(*), intent(in) :: fname
        end function hipModuleLoad

        integer(c_int) function hipModuleLoadData(module, image) &
                bind(C, name="hipModuleLoadData")
            import
            type(c_ptr), intent(out) :: module
            type(c_ptr), value :: image
        end function hipModuleLoadData

        integer(c_int) function hipModuleLoadDataEx(module, image, numOptions, options, optionValues) &
                bind(C, name="hipModuleLoadDataEx")
            import
            type(c_ptr), intent(out) :: module
            type(c_ptr), value :: image
            integer(c_int), value :: numOptions
            integer(c_int), intent(out) :: options
            type(c_ptr), intent(out) :: optionValues
        end function hipModuleLoadDataEx

        integer(c_int) function hipModuleLoadFatBinary(module, fatbin) &
                bind(C, name="hipModuleLoadFatBinary")
            import
            type(c_ptr), intent(out) :: module
            type(c_ptr), value :: fatbin
        end function hipModuleLoadFatBinary

        integer(c_int) function hipModuleOccupancyMaxActiveBlocksPerMultiprocessor( &
                numBlocks, f, blockSize, dynSharedMemPerBlk) &
                bind(C, name="hipModuleOccupancyMaxActiveBlocksPerMultiprocessor")
            import
            integer(c_int), intent(inout) :: numBlocks
            type(c_ptr), value :: f
            integer(c_int), value :: blockSize
            integer(c_size_t), value :: dynSharedMemPerBlk
        end function hipModuleOccupancyMaxActiveBlocksPerMultiprocessor

        integer(c_int) function hipModuleOccupancyMaxActiveBlocksPerMultiprocessorWithFlags( &
                numBlocks, f, blockSize, dynSharedMemPerBlk, flags) &
                bind(C, name="hipModuleOccupancyMaxActiveBlocksPerMultiprocessorWithFlags")
            import
            integer(c_int), intent(inout) :: numBlocks
            type(c_ptr), value :: f
            integer(c_int), value :: blockSize
            integer(c_size_t), value :: dynSharedMemPerBlk
            integer(c_int), value :: flags
        end function hipModuleOccupancyMaxActiveBlocksPerMultiprocessorWithFlags

        integer(c_int) function hipModuleOccupancyMaxPotentialBlockSize( &
                gridSize, blockSize, f, dynSharedMemPerBlk, blockSizeLimit) &
                bind(C, name="hipModuleOccupancyMaxPotentialBlockSize")
            import
            integer(c_int), intent(inout) :: gridSize
            integer(c_int), intent(inout) :: blockSize
            type(c_ptr), value :: f
            integer(c_size_t), value :: dynSharedMemPerBlk
            integer(c_int), value :: blockSizeLimit
        end function hipModuleOccupancyMaxPotentialBlockSize

        integer(c_int) function hipModuleOccupancyMaxPotentialBlockSizeWithFlags( &
                gridSize, blockSize, f, dynSharedMemPerBlk, blockSizeLimit, flags) &
                bind(C, name="hipModuleOccupancyMaxPotentialBlockSizeWithFlags")
            import
            integer(c_int), intent(inout) :: gridSize
            integer(c_int), intent(inout) :: blockSize
            type(c_ptr), value :: f
            integer(c_size_t), value :: dynSharedMemPerBlk
            integer(c_int), value :: blockSizeLimit
            integer(c_int), value :: flags
        end function hipModuleOccupancyMaxPotentialBlockSizeWithFlags

        integer(c_int) function hipModuleUnload(module) &
                bind(C, name="hipModuleUnload")
            import
            type(c_ptr), value :: module
        end function hipModuleUnload

        integer(c_int) function hipOccupancyAvailableDynamicSMemPerBlock(dynamicSmemSize, f, numBlocks, blockSize) &
                bind(C, name="hipOccupancyAvailableDynamicSMemPerBlock")
            import
            integer(c_size_t), intent(inout) :: dynamicSmemSize
            type(c_ptr), value :: f
            integer(c_int), value :: numBlocks
            integer(c_int), value :: blockSize
        end function hipOccupancyAvailableDynamicSMemPerBlock

        integer(c_int) function hipOccupancyMaxActiveBlocksPerMultiprocessor( &
                numBlocks, f, blockSize, dynSharedMemPerBlk) &
                bind(C, name="hipOccupancyMaxActiveBlocksPerMultiprocessor")
            import
            integer(c_int), intent(inout) :: numBlocks
            type(c_ptr), value :: f
            integer(c_int), value :: blockSize
            integer(c_size_t), value :: dynSharedMemPerBlk
        end function hipOccupancyMaxActiveBlocksPerMultiprocessor

        integer(c_int) function hipOccupancyMaxActiveBlocksPerMultiprocessorWithFlags( &
                numBlocks, f, blockSize, dynSharedMemPerBlk, flags) &
                bind(C, name="hipOccupancyMaxActiveBlocksPerMultiprocessorWithFlags")
            import
            integer(c_int), intent(inout) :: numBlocks
            type(c_ptr), value :: f
            integer(c_int), value :: blockSize
            integer(c_size_t), value :: dynSharedMemPerBlk
            integer(c_int), value :: flags
        end function hipOccupancyMaxActiveBlocksPerMultiprocessorWithFlags

        integer(c_int) function hipOccupancyMaxPotentialBlockSize( &
                gridSize, blockSize, f, dynSharedMemPerBlk, blockSizeLimit) &
                bind(C, name="hipOccupancyMaxPotentialBlockSize")
            import
            integer(c_int), intent(inout) :: gridSize
            integer(c_int), intent(inout) :: blockSize
            type(c_ptr), value :: f
            integer(c_size_t), value :: dynSharedMemPerBlk
            integer(c_int), value :: blockSizeLimit
        end function hipOccupancyMaxPotentialBlockSize

        integer(c_int) function hipPeekAtLastError() &
                bind(C, name="hipPeekAtLastError")
            import
        end function hipPeekAtLastError

        integer(c_int) function hipPointerGetAttribute(data, attribute, ptr) &
                bind(C, name="hipPointerGetAttribute")
            import
            type(c_ptr), value :: data
            integer(c_int), value :: attribute
            type(c_ptr), value :: ptr
        end function hipPointerGetAttribute

        integer(c_int) function hipPointerGetAttributes(attributes, ptr) &
                bind(C, name="hipPointerGetAttributes")
            import
            type(hipPointerAttribute_t), intent(inout) :: attributes
            type(c_ptr), value :: ptr
        end function hipPointerGetAttributes

        integer(c_int) function hipPointerSetAttribute(value, attribute, ptr) &
                bind(C, name="hipPointerSetAttribute")
            import
            type(c_ptr), value :: value
            integer(c_int), value :: attribute
            type(c_ptr), value :: ptr
        end function hipPointerSetAttribute

        integer(c_int) function hipProfilerStart() &
                bind(C, name="hipProfilerStart")
            import
        end function hipProfilerStart

        integer(c_int) function hipProfilerStop() &
                bind(C, name="hipProfilerStop")
            import
        end function hipProfilerStop

        integer(c_int) function hipRuntimeGetVersion(runtimeVersion) &
                bind(C, name="hipRuntimeGetVersion")
            import
            integer(c_int), intent(inout) :: runtimeVersion
        end function hipRuntimeGetVersion

        integer(c_int) function hipSetDevice(deviceId) &
                bind(C, name="hipSetDevice")
            import
            integer(c_int), value :: deviceId
        end function hipSetDevice

        integer(c_int) function hipSetDeviceFlags(flags) &
                bind(C, name="hipSetDeviceFlags")
            import
            integer(c_int), value :: flags
        end function hipSetDeviceFlags

        integer(c_int) function hipSetValidDevices(device_arr, len) &
                bind(C, name="hipSetValidDevices")
            import
            integer(c_int), intent(inout) :: device_arr
            integer(c_int), value :: len
        end function hipSetValidDevices

        integer(c_int) function hipSetupArgument(arg, size, offset) &
                bind(C, name="hipSetupArgument")
            import
            type(c_ptr), value :: arg
            integer(c_size_t), value :: size
            integer(c_size_t), value :: offset
        end function hipSetupArgument

        integer(c_int) function hipSignalExternalSemaphoresAsync(extSemArray, paramsArray, numExtSems, stream) &
                bind(C, name="hipSignalExternalSemaphoresAsync")
            import
            type(c_ptr), intent(out) :: extSemArray
            type(hipExternalSemaphoreSignalParams_st), intent(in) :: paramsArray
            integer(c_int), value :: numExtSems
            type(c_ptr), value :: stream
        end function hipSignalExternalSemaphoresAsync

        integer(c_int) function hipStreamAddCallback(stream, callback, userData, flags) &
                bind(C, name="hipStreamAddCallback")
            import
            type(c_ptr), value :: stream
            type(c_funptr), value :: callback
            type(c_ptr), value :: userData
            integer(c_int), value :: flags
        end function hipStreamAddCallback

        integer(c_int) function hipStreamAttachMemAsync(stream, dev_ptr, length, flags) &
                bind(C, name="hipStreamAttachMemAsync")
            import
            type(c_ptr), value :: stream
            type(c_ptr), value :: dev_ptr
            integer(c_size_t), value :: length
            integer(c_int), value :: flags
        end function hipStreamAttachMemAsync

        integer(c_int) function hipStreamBatchMemOp(stream, count, paramArray, flags) &
                bind(C, name="hipStreamBatchMemOp")
            import
            type(c_ptr), value :: stream
            integer(c_int), value :: count
            type(hipStreamBatchMemOpParams_union), intent(inout) :: paramArray
            integer(c_int), value :: flags
        end function hipStreamBatchMemOp

        integer(c_int) function hipStreamBeginCapture(stream, mode) &
                bind(C, name="hipStreamBeginCapture")
            import
            type(c_ptr), value :: stream
            integer(c_int), value :: mode
        end function hipStreamBeginCapture

        integer(c_int) function hipStreamBeginCaptureToGraph( &
                stream, graph, dependencies, dependencyData, numDependencies, mode) &
                bind(C, name="hipStreamBeginCaptureToGraph")
            import
            type(c_ptr), value :: stream
            type(c_ptr), value :: graph
            type(c_ptr), intent(out) :: dependencies
            type(hipGraphEdgeData), intent(in) :: dependencyData
            integer(c_size_t), value :: numDependencies
            integer(c_int), value :: mode
        end function hipStreamBeginCaptureToGraph

        integer(c_int) function hipStreamCopyAttributes(dst, src) &
                bind(C, name="hipStreamCopyAttributes")
            import
            type(c_ptr), value :: dst
            type(c_ptr), value :: src
        end function hipStreamCopyAttributes

        integer(c_int) function hipStreamCreate(stream) &
                bind(C, name="hipStreamCreate")
            import
            type(c_ptr), intent(out) :: stream
        end function hipStreamCreate

        integer(c_int) function hipStreamCreateWithFlags(stream, flags) &
                bind(C, name="hipStreamCreateWithFlags")
            import
            type(c_ptr), intent(out) :: stream
            integer(c_int), value :: flags
        end function hipStreamCreateWithFlags

        integer(c_int) function hipStreamCreateWithPriority(stream, flags, priority) &
                bind(C, name="hipStreamCreateWithPriority")
            import
            type(c_ptr), intent(out) :: stream
            integer(c_int), value :: flags
            integer(c_int), value :: priority
        end function hipStreamCreateWithPriority

        integer(c_int) function hipStreamDestroy(stream) &
                bind(C, name="hipStreamDestroy")
            import
            type(c_ptr), value :: stream
        end function hipStreamDestroy

        integer(c_int) function hipStreamEndCapture(stream, pGraph) &
                bind(C, name="hipStreamEndCapture")
            import
            type(c_ptr), value :: stream
            type(c_ptr), intent(out) :: pGraph
        end function hipStreamEndCapture

        integer(c_int) function hipStreamGetAttribute(stream, attr, value_out) &
                bind(C, name="hipStreamGetAttribute")
            import
            type(c_ptr), value :: stream
            integer(c_int), value :: attr
            type(hipLaunchAttributeValue), intent(inout) :: value_out
        end function hipStreamGetAttribute

        integer(c_int) function hipStreamGetCaptureInfo(stream, pCaptureStatus, pId) &
                bind(C, name="hipStreamGetCaptureInfo")
            import
            type(c_ptr), value :: stream
            integer(c_int), intent(out) :: pCaptureStatus
            integer(c_long_long), intent(inout) :: pId
        end function hipStreamGetCaptureInfo

        integer(c_int) function hipStreamGetCaptureInfo_v2( &
                stream, captureStatus_out, id_out, graph_out, dependencies_out, numDependencies_out) &
                bind(C, name="hipStreamGetCaptureInfo_v2")
            import
            type(c_ptr), value :: stream
            integer(c_int), intent(out) :: captureStatus_out
            integer(c_long_long), intent(inout) :: id_out
            type(c_ptr), intent(out) :: graph_out
            type(c_ptr), intent(out) :: dependencies_out
            integer(c_size_t), intent(inout) :: numDependencies_out
        end function hipStreamGetCaptureInfo_v2

        integer(c_int) function hipStreamGetDevice(stream, device) &
                bind(C, name="hipStreamGetDevice")
            import
            type(c_ptr), value :: stream
            integer(c_int), intent(inout) :: device
        end function hipStreamGetDevice

        integer(c_int) function hipStreamGetFlags(stream, flags) &
                bind(C, name="hipStreamGetFlags")
            import
            type(c_ptr), value :: stream
            integer(c_int), intent(inout) :: flags
        end function hipStreamGetFlags

        integer(c_int) function hipStreamGetId(stream, streamId) &
                bind(C, name="hipStreamGetId")
            import
            type(c_ptr), value :: stream
            integer(c_long_long), intent(inout) :: streamId
        end function hipStreamGetId

        integer(c_int) function hipStreamGetPriority(stream, priority) &
                bind(C, name="hipStreamGetPriority")
            import
            type(c_ptr), value :: stream
            integer(c_int), intent(inout) :: priority
        end function hipStreamGetPriority

        integer(c_int) function hipStreamIsCapturing(stream, pCaptureStatus) &
                bind(C, name="hipStreamIsCapturing")
            import
            type(c_ptr), value :: stream
            integer(c_int), intent(out) :: pCaptureStatus
        end function hipStreamIsCapturing

        integer(c_int) function hipStreamQuery(stream) &
                bind(C, name="hipStreamQuery")
            import
            type(c_ptr), value :: stream
        end function hipStreamQuery

        integer(c_int) function hipStreamSetAttribute(stream, attr, value) &
                bind(C, name="hipStreamSetAttribute")
            import
            type(c_ptr), value :: stream
            integer(c_int), value :: attr
            type(hipLaunchAttributeValue), intent(in) :: value
        end function hipStreamSetAttribute

        integer(c_int) function hipStreamSynchronize(stream) &
                bind(C, name="hipStreamSynchronize")
            import
            type(c_ptr), value :: stream
        end function hipStreamSynchronize

        integer(c_int) function hipStreamUpdateCaptureDependencies(stream, dependencies, numDependencies, flags) &
                bind(C, name="hipStreamUpdateCaptureDependencies")
            import
            type(c_ptr), value :: stream
            type(c_ptr), intent(out) :: dependencies
            integer(c_size_t), value :: numDependencies
            integer(c_int), value :: flags
        end function hipStreamUpdateCaptureDependencies

        integer(c_int) function hipStreamWaitEvent(stream, event, flags) &
                bind(C, name="hipStreamWaitEvent")
            import
            type(c_ptr), value :: stream
            type(c_ptr), value :: event
            integer(c_int), value :: flags
        end function hipStreamWaitEvent

        integer(c_int) function hipStreamWaitValue32(stream, ptr, value, flags, mask) &
                bind(C, name="hipStreamWaitValue32")
            import
            type(c_ptr), value :: stream
            type(c_ptr), value :: ptr
            integer(c_int32_t), value :: value
            integer(c_int), value :: flags
            integer(c_int32_t), value :: mask
        end function hipStreamWaitValue32

        integer(c_int) function hipStreamWaitValue64(stream, ptr, value, flags, mask) &
                bind(C, name="hipStreamWaitValue64")
            import
            type(c_ptr), value :: stream
            type(c_ptr), value :: ptr
            integer(c_int64_t), value :: value
            integer(c_int), value :: flags
            integer(c_int64_t), value :: mask
        end function hipStreamWaitValue64

        integer(c_int) function hipStreamWriteValue32(stream, ptr, value, flags) &
                bind(C, name="hipStreamWriteValue32")
            import
            type(c_ptr), value :: stream
            type(c_ptr), value :: ptr
            integer(c_int32_t), value :: value
            integer(c_int), value :: flags
        end function hipStreamWriteValue32

        integer(c_int) function hipStreamWriteValue64(stream, ptr, value, flags) &
                bind(C, name="hipStreamWriteValue64")
            import
            type(c_ptr), value :: stream
            type(c_ptr), value :: ptr
            integer(c_int64_t), value :: value
            integer(c_int), value :: flags
        end function hipStreamWriteValue64

        integer(c_int) function hipTexObjectDestroy(texObject) &
                bind(C, name="hipTexObjectDestroy")
            import
            type(c_ptr), value :: texObject
        end function hipTexObjectDestroy

        integer(c_int) function hipTexObjectGetResourceViewDesc(pResViewDesc, texObject) &
                bind(C, name="hipTexObjectGetResourceViewDesc")
            import
            type(HIP_RESOURCE_VIEW_DESC_st), intent(inout) :: pResViewDesc
            type(c_ptr), value :: texObject
        end function hipTexObjectGetResourceViewDesc

        integer(c_int) function hipTexObjectGetTextureDesc(pTexDesc, texObject) &
                bind(C, name="hipTexObjectGetTextureDesc")
            import
            type(HIP_TEXTURE_DESC_st), intent(inout) :: pTexDesc
            type(c_ptr), value :: texObject
        end function hipTexObjectGetTextureDesc

        integer(c_int) function hipTexRefGetAddress(dev_ptr, texRef) &
                bind(C, name="hipTexRefGetAddress")
            import
            type(c_ptr), intent(out) :: dev_ptr
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetAddress

        integer(c_int) function hipTexRefGetAddressMode(pam, texRef, dim) &
                bind(C, name="hipTexRefGetAddressMode")
            import
            integer(c_int), intent(out) :: pam
            type(textureReference), intent(in) :: texRef
            integer(c_int), value :: dim
        end function hipTexRefGetAddressMode

        integer(c_int) function hipTexRefGetArray(pArray, texRef) &
                bind(C, name="hipTexRefGetArray")
            import
            type(c_ptr), intent(out) :: pArray
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetArray

        integer(c_int) function hipTexRefGetBorderColor(pBorderColor, texRef) &
                bind(C, name="hipTexRefGetBorderColor")
            import
            real(c_float), intent(inout) :: pBorderColor
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetBorderColor

        integer(c_int) function hipTexRefGetFilterMode(pfm, texRef) &
                bind(C, name="hipTexRefGetFilterMode")
            import
            integer(c_int), intent(out) :: pfm
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetFilterMode

        integer(c_int) function hipTexRefGetFlags(pFlags, texRef) &
                bind(C, name="hipTexRefGetFlags")
            import
            integer(c_int), intent(inout) :: pFlags
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetFlags

        integer(c_int) function hipTexRefGetFormat(pFormat, pNumChannels, texRef) &
                bind(C, name="hipTexRefGetFormat")
            import
            integer(c_int), intent(out) :: pFormat
            integer(c_int), intent(inout) :: pNumChannels
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetFormat

        integer(c_int) function hipTexRefGetMaxAnisotropy(pmaxAnsio, texRef) &
                bind(C, name="hipTexRefGetMaxAnisotropy")
            import
            integer(c_int), intent(inout) :: pmaxAnsio
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetMaxAnisotropy

        integer(c_int) function hipTexRefGetMipMappedArray(pArray, texRef) &
                bind(C, name="hipTexRefGetMipMappedArray")
            import
            type(c_ptr), intent(out) :: pArray
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetMipMappedArray

        integer(c_int) function hipTexRefGetMipmapFilterMode(pfm, texRef) &
                bind(C, name="hipTexRefGetMipmapFilterMode")
            import
            integer(c_int), intent(out) :: pfm
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetMipmapFilterMode

        integer(c_int) function hipTexRefGetMipmapLevelBias(pbias, texRef) &
                bind(C, name="hipTexRefGetMipmapLevelBias")
            import
            real(c_float), intent(inout) :: pbias
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetMipmapLevelBias

        integer(c_int) function hipTexRefGetMipmapLevelClamp(pminMipmapLevelClamp, pmaxMipmapLevelClamp, texRef) &
                bind(C, name="hipTexRefGetMipmapLevelClamp")
            import
            real(c_float), intent(inout) :: pminMipmapLevelClamp
            real(c_float), intent(inout) :: pmaxMipmapLevelClamp
            type(textureReference), intent(in) :: texRef
        end function hipTexRefGetMipmapLevelClamp

        integer(c_int) function hipTexRefSetAddress(ByteOffset, texRef, dptr, bytes) &
                bind(C, name="hipTexRefSetAddress")
            import
            integer(c_size_t), intent(inout) :: ByteOffset
            type(textureReference), intent(inout) :: texRef
            type(c_ptr), value :: dptr
            integer(c_size_t), value :: bytes
        end function hipTexRefSetAddress

        integer(c_int) function hipTexRefSetAddress2D(texRef, desc, dptr, Pitch) &
                bind(C, name="hipTexRefSetAddress2D")
            import
            type(textureReference), intent(inout) :: texRef
            type(HIP_ARRAY_DESCRIPTOR), intent(in) :: desc
            type(c_ptr), value :: dptr
            integer(c_size_t), value :: Pitch
        end function hipTexRefSetAddress2D

        integer(c_int) function hipTexRefSetAddressMode(texRef, dim, am) &
                bind(C, name="hipTexRefSetAddressMode")
            import
            type(textureReference), intent(inout) :: texRef
            integer(c_int), value :: dim
            integer(c_int), value :: am
        end function hipTexRefSetAddressMode

        integer(c_int) function hipTexRefSetArray(tex, array, flags) &
                bind(C, name="hipTexRefSetArray")
            import
            type(textureReference), intent(inout) :: tex
            type(c_ptr), value :: array
            integer(c_int), value :: flags
        end function hipTexRefSetArray

        integer(c_int) function hipTexRefSetBorderColor(texRef, pBorderColor) &
                bind(C, name="hipTexRefSetBorderColor")
            import
            type(textureReference), intent(inout) :: texRef
            real(c_float), intent(inout) :: pBorderColor
        end function hipTexRefSetBorderColor

        integer(c_int) function hipTexRefSetFilterMode(texRef, fm) &
                bind(C, name="hipTexRefSetFilterMode")
            import
            type(textureReference), intent(inout) :: texRef
            integer(c_int), value :: fm
        end function hipTexRefSetFilterMode

        integer(c_int) function hipTexRefSetFlags(texRef, Flags) &
                bind(C, name="hipTexRefSetFlags")
            import
            type(textureReference), intent(inout) :: texRef
            integer(c_int), value :: Flags
        end function hipTexRefSetFlags

        integer(c_int) function hipTexRefSetFormat(texRef, fmt, NumPackedComponents) &
                bind(C, name="hipTexRefSetFormat")
            import
            type(textureReference), intent(inout) :: texRef
            integer(c_int), value :: fmt
            integer(c_int), value :: NumPackedComponents
        end function hipTexRefSetFormat

        integer(c_int) function hipTexRefSetMaxAnisotropy(texRef, maxAniso) &
                bind(C, name="hipTexRefSetMaxAnisotropy")
            import
            type(textureReference), intent(inout) :: texRef
            integer(c_int), value :: maxAniso
        end function hipTexRefSetMaxAnisotropy

        integer(c_int) function hipTexRefSetMipmapFilterMode(texRef, fm) &
                bind(C, name="hipTexRefSetMipmapFilterMode")
            import
            type(textureReference), intent(inout) :: texRef
            integer(c_int), value :: fm
        end function hipTexRefSetMipmapFilterMode

        integer(c_int) function hipTexRefSetMipmapLevelBias(texRef, bias) &
                bind(C, name="hipTexRefSetMipmapLevelBias")
            import
            type(textureReference), intent(inout) :: texRef
            real(c_float), value :: bias
        end function hipTexRefSetMipmapLevelBias

        integer(c_int) function hipTexRefSetMipmapLevelClamp(texRef, minMipMapLevelClamp, maxMipMapLevelClamp) &
                bind(C, name="hipTexRefSetMipmapLevelClamp")
            import
            type(textureReference), intent(inout) :: texRef
            real(c_float), value :: minMipMapLevelClamp
            real(c_float), value :: maxMipMapLevelClamp
        end function hipTexRefSetMipmapLevelClamp

        integer(c_int) function hipTexRefSetMipmappedArray(texRef, mipmappedArray, Flags) &
                bind(C, name="hipTexRefSetMipmappedArray")
            import
            type(textureReference), intent(inout) :: texRef
            type(hipMipmappedArray), intent(inout) :: mipmappedArray
            integer(c_int), value :: Flags
        end function hipTexRefSetMipmappedArray

        integer(c_int) function hipThreadExchangeStreamCaptureMode(mode) &
                bind(C, name="hipThreadExchangeStreamCaptureMode")
            import
            integer(c_int), intent(out) :: mode
        end function hipThreadExchangeStreamCaptureMode

        integer(c_int) function hipUnbindTexture(tex) &
                bind(C, name="hipUnbindTexture")
            import
            type(textureReference), intent(in) :: tex
        end function hipUnbindTexture

        integer(c_int) function hipUserObjectCreate(object_out, ptr, destroy, initialRefcount, flags) &
                bind(C, name="hipUserObjectCreate")
            import
            type(c_ptr), intent(out) :: object_out
            type(c_ptr), value :: ptr
            type(c_funptr), value :: destroy
            integer(c_int), value :: initialRefcount
            integer(c_int), value :: flags
        end function hipUserObjectCreate

        integer(c_int) function hipUserObjectRelease(object, count) &
                bind(C, name="hipUserObjectRelease")
            import
            type(c_ptr), value :: object
            integer(c_int), value :: count
        end function hipUserObjectRelease

        integer(c_int) function hipUserObjectRetain(object, count) &
                bind(C, name="hipUserObjectRetain")
            import
            type(c_ptr), value :: object
            integer(c_int), value :: count
        end function hipUserObjectRetain

        integer(c_int) function hipWaitExternalSemaphoresAsync(extSemArray, paramsArray, numExtSems, stream) &
                bind(C, name="hipWaitExternalSemaphoresAsync")
            import
            type(c_ptr), intent(out) :: extSemArray
            type(hipExternalSemaphoreWaitParams_st), intent(in) :: paramsArray
            integer(c_int), value :: numExtSems
            type(c_ptr), value :: stream
        end function hipWaitExternalSemaphoresAsync

    end interface

end module pic_hip_runtime
#endif /* HIP */
