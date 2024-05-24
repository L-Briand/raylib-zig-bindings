const std = @import("std");

pub const raylib = @import("raylib.build.zig");
pub const Setup = raylib.RaylibSetup;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    _ = b.addModule("raylib-zig-bindings", .{
        .root_source_file = .{ .src_path = .{
            .owner = b,
            .sub_path = "bindings/bindings.zig",
        } },
        .target = target,
        .optimize = optimize,
    });
}

