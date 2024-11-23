const std = @import("std");
const protobuf = @import("protobuf");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "blend2d",
        .root_source_file = b.path("main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const asmjit_dep = b.dependency("asmjit", .{
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath(asmjit_dep.path("src"));
    lib.linkLibrary(asmjit_dep.artifact("asmjit"));

    lib.addIncludePath(b.path("src"));

    lib.addCSourceFiles(.{
        .root = b.path("src"),
        .flags = &.{"-DBL_BUILD_OPT_AVX2"},
        .files = &.{
            "blend2d/api-globals.cpp",
            "blend2d/api-nocxx.cpp",
            "blend2d/array.cpp",
            "blend2d/bitarray.cpp",
            "blend2d/bitset.cpp",
            "blend2d/compopinfo.cpp",
            "blend2d/context.cpp",
            "blend2d/filesystem.cpp",
            "blend2d/font.cpp",
            "blend2d/fontdata.cpp",
            "blend2d/fontface.cpp",
            "blend2d/fontfeaturesettings.cpp",
            "blend2d/fontmanager.cpp",
            "blend2d/fonttagdataids.cpp",
            "blend2d/fonttagdatainfo.cpp",
            "blend2d/fonttagset.cpp",
            "blend2d/fontvariationsettings.cpp",
            "blend2d/format.cpp",
            "blend2d/geometry.cpp",
            "blend2d/glyphbuffer.cpp",
            "blend2d/gradient.cpp",
            "blend2d/image.cpp",
            "blend2d/imagecodec.cpp",
            "blend2d/imagedecoder.cpp",
            "blend2d/imageencoder.cpp",
            "blend2d/imagescale.cpp",
            "blend2d/matrix.cpp",
            "blend2d/matrix_avx.cpp",
            "blend2d/matrix_sse2.cpp",
            "blend2d/object.cpp",
            "blend2d/path.cpp",
            "blend2d/pathstroke.cpp",
            "blend2d/pattern.cpp",
            "blend2d/pixelconverter.cpp",
            "blend2d/pixelconverter_avx2.cpp",
            "blend2d/pixelconverter_sse2.cpp",
            "blend2d/pixelconverter_ssse3.cpp",
            "blend2d/random.cpp",
            "blend2d/runtime.cpp",
            "blend2d/runtimescope.cpp",
            "blend2d/string.cpp",
            "blend2d/trace.cpp",
            "blend2d/var.cpp",
            "blend2d/codec/bmpcodec.cpp",
            "blend2d/codec/jpegcodec.cpp",
            "blend2d/codec/jpeghuffman.cpp",
            "blend2d/codec/jpegops.cpp",
            "blend2d/codec/jpegops_sse2.cpp",
            "blend2d/codec/pngcodec.cpp",
            "blend2d/codec/pngops.cpp",
            "blend2d/codec/pngops_sse2.cpp",
            "blend2d/codec/qoicodec.cpp",
            "blend2d/compression/checksum.cpp",
            "blend2d/compression/deflatedecoder.cpp",
            "blend2d/compression/deflateencoder.cpp",
            "blend2d/opentype/otcff.cpp",
            "blend2d/opentype/otcmap.cpp",
            "blend2d/opentype/otcore.cpp",
            "blend2d/opentype/otface.cpp",
            "blend2d/opentype/otglyf.cpp",
            "blend2d/opentype/otglyf_asimd.cpp",
            "blend2d/opentype/otglyf_avx2.cpp",
            "blend2d/opentype/otglyf_sse4_2.cpp",
            "blend2d/opentype/otglyfsimddata.cpp",
            "blend2d/opentype/otkern.cpp",
            "blend2d/opentype/otlayout.cpp",
            "blend2d/opentype/otmetrics.cpp",
            "blend2d/opentype/otname.cpp",
            "blend2d/pipeline/pipedefs.cpp",
            "blend2d/pipeline/piperuntime.cpp",
            "blend2d/pipeline/jit/compoppart.cpp",
            "blend2d/pipeline/jit/fetchgradientpart.cpp",
            "blend2d/pipeline/jit/fetchpart.cpp",
            "blend2d/pipeline/jit/fetchpatternpart.cpp",
            "blend2d/pipeline/jit/fetchpixelptrpart.cpp",
            "blend2d/pipeline/jit/fetchsolidpart.cpp",
            "blend2d/pipeline/jit/fetchutilscoverage.cpp",
            "blend2d/pipeline/jit/fetchutilsinlineloops.cpp",
            "blend2d/pipeline/jit/fetchutilspixelaccess.cpp",
            "blend2d/pipeline/jit/fetchutilspixelgather.cpp",
            "blend2d/pipeline/jit/fillpart.cpp",
            "blend2d/pipeline/jit/pipecompiler_a64.cpp",
            "blend2d/pipeline/jit/pipecompiler_x86.cpp",
            "blend2d/pipeline/jit/pipecomposer.cpp",
            "blend2d/pipeline/jit/pipefunction.cpp",
            "blend2d/pipeline/jit/pipeprimitives.cpp",
            "blend2d/pipeline/jit/pipegenruntime.cpp",
            "blend2d/pipeline/jit/pipepart.cpp",
            "blend2d/pipeline/reference/fixedpiperuntime.cpp",
            "blend2d/pixelops/interpolation.cpp",
            "blend2d/pixelops/interpolation_avx2.cpp",
            "blend2d/pixelops/interpolation_sse2.cpp",
            "blend2d/pixelops/funcs.cpp",
            "blend2d/raster/rastercontext.cpp",
            "blend2d/raster/rastercontextops.cpp",
            "blend2d/raster/renderfetchdata.cpp",
            "blend2d/raster/rendertargetinfo.cpp",
            "blend2d/raster/workdata.cpp",
            "blend2d/raster/workermanager.cpp",
            "blend2d/raster/workerproc.cpp",
            "blend2d/raster/workersynchronization.cpp",
            "blend2d/support/arenaallocator.cpp",
            "blend2d/support/arenahashmap.cpp",
            "blend2d/support/math.cpp",
            "blend2d/support/scopedallocator.cpp",
            "blend2d/support/zeroallocator.cpp",
            "blend2d/tables/tables.cpp",
            "blend2d/threading/futex.cpp",
            "blend2d/threading/thread.cpp",
            "blend2d/threading/threadpool.cpp",
            "blend2d/threading/uniqueidgenerator.cpp",
            "blend2d/unicode/unicode.cpp",
        },
    });

    // libc
    lib.linkLibC();
    lib.linkLibCpp();

    b.installArtifact(lib);

    const module = b.addModule("blend2d", .{
        .root_source_file = b.path("main.zig"),
    });

    module.addIncludePath(b.path("src"));
    module.linkLibrary(asmjit_dep.artifact("asmjit"));
}
