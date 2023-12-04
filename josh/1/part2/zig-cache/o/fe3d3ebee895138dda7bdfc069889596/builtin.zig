const std = @import("std");
/// Zig version. When writing code that supports multiple versions of Zig, prefer
/// feature detection (i.e. with `@hasDecl` or `@hasField`) over version checks.
pub const zig_version = std.SemanticVersion.parse(zig_version_string) catch unreachable;
pub const zig_version_string = "0.12.0-dev.1768+39a966b0a";
pub const zig_backend = std.builtin.CompilerBackend.stage2_llvm;

pub const output_mode = std.builtin.OutputMode.Exe;
pub const link_mode = std.builtin.LinkMode.Dynamic;
pub const is_test = false;
pub const single_threaded = false;
pub const abi = std.Target.Abi.none;
pub const cpu: std.Target.Cpu = .{
    .arch = .aarch64,
    .model = &std.Target.aarch64.cpu.apple_a15,
    .features = std.Target.aarch64.featureSet(&[_]std.Target.aarch64.Feature{
        .aes,
        .alternate_sextload_cvt_f32_pattern,
        .altnzcv,
        .am,
        .amvs,
        .arith_bcc_fusion,
        .arith_cbz_fusion,
        .bf16,
        .bti,
        .ccdp,
        .ccidx,
        .ccpp,
        .complxnum,
        .contextidr_el2,
        .crc,
        .crypto,
        .disable_latency_sched_heuristic,
        .dit,
        .dotprod,
        .ecv,
        .el2vmsa,
        .el3,
        .fgt,
        .flagm,
        .fp16fml,
        .fp_armv8,
        .fptoint,
        .fullfp16,
        .fuse_address,
        .fuse_aes,
        .fuse_arith_logic,
        .fuse_crypto_eor,
        .fuse_csel,
        .fuse_literals,
        .i8mm,
        .jsconv,
        .lor,
        .lse,
        .lse2,
        .mpam,
        .neon,
        .nv,
        .pan,
        .pan_rwv,
        .pauth,
        .perfmon,
        .predres,
        .ras,
        .rcpc,
        .rcpc_immo,
        .rdm,
        .sb,
        .sel2,
        .sha2,
        .sha3,
        .specrestrict,
        .ssbs,
        .tlb_rmi,
        .tracev8_4,
        .uaops,
        .v8_1a,
        .v8_2a,
        .v8_3a,
        .v8_4a,
        .v8_5a,
        .v8_6a,
        .v8a,
        .vh,
        .zcm,
        .zcz,
        .zcz_gp,
    }),
};
pub const os = std.Target.Os{
    .tag = .macos,
    .version_range = .{ .semver = .{
        .min = .{
            .major = 14,
            .minor = 0,
            .patch = 0,
        },
        .max = .{
            .major = 14,
            .minor = 0,
            .patch = 0,
        },
    }},
};
pub const target = std.Target{
    .cpu = cpu,
    .os = os,
    .abi = abi,
    .ofmt = object_format,
};
pub const object_format = std.Target.ObjectFormat.macho;
pub const mode = std.builtin.OptimizeMode.Debug;
pub const link_libc = true;
pub const link_libcpp = false;
pub const have_error_return_tracing = true;
pub const valgrind_support = false;
pub const sanitize_thread = false;
pub const position_independent_code = true;
pub const position_independent_executable = true;
pub const strip_debug_info = false;
pub const code_model = std.builtin.CodeModel.default;
pub const omit_frame_pointer = false;
