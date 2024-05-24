// C Options added at build time. See options.rcamera.zig file
const options = @import("rcamera_options");

// rcamera.h file

pub const Vector2 = @import("raylib.zig").Vector2;
pub const Vector3 = @import("raylib.zig").Vector3;
pub const Matrix = @import("raylib.zig").Matrix;
pub const Camera3D = @import("raylib.zig").Camera3D;
pub const Camera = Camera3D;

pub const CameraProjection = @import("raylib.zig").CameraProjection;
pub const CameraMode = @import("raylib.zig").CameraMode;

//----------------------------------------------------------------------------------
// Module Functions Declaration
//----------------------------------------------------------------------------------

pub extern "c" fn GetCameraForward(camera: [*c]Camera) Vector3;
pub extern "c" fn GetCameraUp(camera: [*c]Camera) Vector3;
pub extern "c" fn GetCameraRight(camera: [*c]Camera) Vector3;

// Camera movement
pub extern "c" fn CameraMoveForward(camera: [*c]Camera, distance: f32, moveInWorldPlane: bool) void;
pub extern "c" fn CameraMoveUp(camera: [*c]Camera, distance: f32) void;
pub extern "c" fn CameraMoveRight(camera: [*c]Camera, distance: f32, moveInWorldPlane: bool) void;
pub extern "c" fn CameraMoveToTarget(camera: [*c]Camera, delta: f32) void;

// Camera rotation
pub extern "c" fn CameraYaw(camera: [*c]Camera, angle: f32, rotateAroundTarget: bool) void;
pub extern "c" fn CameraPitch(camera: [*c]Camera, angle: f32, lockView: bool, rotateAroundTarget: bool, rotateUp: bool) void;
pub extern "c" fn CameraRoll(camera: [*c]Camera, angle: f32) void;

pub extern "c" fn GetCameraViewMatrix(camera: [*c]Camera) Matrix;
pub extern "c" fn GetCameraProjectionMatrix(camera: [*c]Camera, aspect: f32) Matrix;

test {
    const std = @import("std");
    std.testing.refAllDeclsRecursive(@This());
}
