const std = @import("std");
const Builder = std.build.Builder;
const CrossTarget = std.zig.CrossTarget;

pub fn build (b: *Builder) !void {
    const target = CrossTarget{
        .cpu_arch = .riscv64,
        .os_tag = .freestanding,
    };

    const build_mode = b.standardReleaseOptions();

    const exec = b.addExecutable("goOZe.elf", "src/main.zig");
    exec.setBuildMode(build_mode);
    exec.setLinkerScriptPath("./virt.ld");
    exec.setTarget(target);
    exec.code_model = std.builtin.CodeModel.medium;
    exec.install();

    b.default_step.dependOn(&exec.step);
}
