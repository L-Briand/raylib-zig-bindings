const std = @import("std");
const builtin = @import("builtin");
const LazyPath = std.Build.LazyPath;

pub const RCameraConfiguration = struct {
    // Generates the implementation of the library into the included file.
    // If not defined, the library is in header only mode and can be included in other headers
    // or source files without problems. But only ONE file should hold the implementation.
    rcamera_implementation: ?bool = null,

    // If defined, the library can be used as standalone as a camera system but some
    // functions must be redefined to manage inputs accordingly.
    rcamera_standalone: ?bool = null,
};

pub const GraphicsApi = enum(usize) {
    OPENGL_11 = 1,
    OPENGL_21,
    OPENGL_33,
    OPENGL_43,
    OPENGL_ES2,
    OPENGL_ES3,
};

pub const RlglConfiguration = struct {
    // Use selected OpenGL graphics backend, should be supported by platform
    // Those preprocessor defines are only used on rlgl module, if OpenGL version is
    // required by any other module, use rlGetVersion() to check it
    graphics_api: GraphicsApi = .OPENGL_33,

    // Generates the implementation of the library into the included file.
    // If not defined, the library is in header only mode and can be included in other headers
    // or source files without problems. But only ONE file should hold the implementation.
    rlgl_implementation: ?bool = null,

    // Enable framebuffer objects (fbo) support (enabled by default)
    // Some GPUs could not support them despite the OpenGL version
    rlgl_render_textures_hint: ?bool = null,

    // Show OpenGL extensions and capabilities detailed logs on init
    rlgl_show_gl_details_info: ?bool = null,

    // Enable debug context (only available on OpenGL 4.3)
    rlgl_enable_opengl_debug_context: ?bool = null,

    // Default internal render batch elements limits
    rl_default_batch_buffer_elements: ?[]const u8 = null,

    // Default number of batch buffers (multi-buffering)
    rl_default_batch_buffers: ?[]const u8 = null,

    // Default number of batch draw calls (by state changes: mode
    rl_default_batch_drawcalls: ?[]const u8 = null,

    // Maximum number of textures units that can be activated on
    rl_default_batch_max_texture_units: ?[]const u8 = null,

    // Maximum size of internal Matrix stack
    rl_max_matrix_stack_size: ?[]const u8 = null,

    // Maximum number of shader locations supported
    rl_max_shader_locations: ?[]const u8 = null,

    // Default projection matrix near cull distance
    rl_cull_distance_near: ?[]const u8 = null,

    // Default projection matrix far cull distance
    rl_cull_distance_far: ?[]const u8 = null,
};

pub const RayguiConfiguration = struct {
    // Generates the implementation of the library into the included file.
    // If not defined, the library is in header only mode and can be included in other headers
    // or source files without problems. But only ONE file should hold the implementation.
    raygui_implementation: ?bool = true,

    // Avoid raylib.h header inclusion in this file. Data types defined on raylib are defined
    // internally in the library and input management and drawing functions must be provided by
    // the user (check library implementation for further details).
    raygui_standalone: ?bool = null,

    // Avoid including embedded ricons data (256 icons, 16x16 pixels, 1-bit per pixel, 2KB)
    raygui_no_icons: ?bool = null,

    // Includes custom ricons.h header defining a set of custom icons,
    // this file can be generated using rGuiIcons tool
    raygui_custom_icons: ?bool = null,

    // Draw control bounds rectangles for debug
    raygui_debug_recs_bounds: ?bool = null,

    // Draw text bounds rectangles for debug
    raygui_debug_text_bounds: ?bool = null,
};

// Default c files to add during init
pub const RaylibIncludes = struct {
    rcore: bool = true,
    utils: bool = true,
    raudio: bool = true,
    rmodels: bool = true,
    rshapes: bool = true,
    rtext: bool = true,
    rtextures: bool = true,
};

// Linux specific options when linking libraries
pub const LinuxPlatform = enum { DESKTOP, DRM };
pub const LinuxBackend = enum { X11, WAYLAND };
pub const LinuxOptions = struct {
    platform: LinuxPlatform = LinuxPlatform.DESKTOP,
    // On platform DRM, backend field is not used.
    backend: LinuxBackend = LinuxBackend.X11,
};

pub const RaylibSetup = struct {
    raylibSrcPath: LazyPath,
    flags: std.ArrayList([]const u8),
    files: std.ArrayList([]const u8),
    rcamera: ?RCameraConfiguration = null,
    rlgl: ?RlglConfiguration = null,
    raygui: ?RayguiConfiguration = null,

    // Initialize RaylibSetup with specified options.
    pub fn init(b: *std.Build, raylibSrcPath: LazyPath, includes: RaylibIncludes) !RaylibSetup {
        var flags = std.ArrayList([]const u8).init(b.allocator);
        var files = std.ArrayList([]const u8).init(b.allocator);

        try flags.append("-std=gnu99");
        try flags.append("-D_GNU_SOURCE");
        try flags.append("-DGL_SILENCE_DEPRECATION=199309L");

        if (includes.rcore) try files.append("rcore.c");
        if (includes.utils) try files.append("utils.c");
        if (includes.raudio) try files.append("raudio.c");
        if (includes.rmodels) try files.append("rmodels.c");
        if (includes.rshapes) try files.append("rshapes.c");
        if (includes.rtext) try files.append("rtext.c");
        if (includes.rtextures) try files.append("rtextures.c");

        return RaylibSetup{
            .raylibSrcPath = raylibSrcPath,
            .flags = flags,
            .files = files,
        };
    }

    // Move raygui file to raylib's directory and include the file to the c files list.
    pub fn addRayguiToRaylibSrc(
        self: *RaylibSetup,
        b: *std.Build,
        rayguiFile: LazyPath,
    ) !void {
        const cRaygui = b.pathJoin(&[_][]const u8{ self.raylibSrcPath.getPath(b), "raygui.c" });
        try std.fs.copyFileAbsolute(rayguiFile.getPath(b), cRaygui, .{});
        try self.files.append("raygui.c");
    }

    // Update `step` to build for windows.
    pub fn linkWindows(
        self: *RaylibSetup,
        b: *std.Build,
        step: *std.Build.Step.Compile,
    ) !void {
        const glfwInclude = b.pathJoin(&[_][]const u8{ self.raylibSrcPath.getPath(b), "external", "glfw", "include" });
        step.addIncludePath(.{ .cwd_relative = glfwInclude });

        try self.files.append("rglfw.c");
        step.linkSystemLibrary("winmm");
        step.linkSystemLibrary("gdi32");
        step.linkSystemLibrary("opengl32");

        step.defineCMacro("PLATFORM_DESKTOP", null);
    }

    // Update `step` to build for macos.
    pub fn linkMacos(
        self: *RaylibSetup,
        b: *std.Build,
        step: *std.Build.Step.Compile,
    ) !void {
        const glfwInclude = b.pathJoin(&[_][]const u8{ self.raylibSrcPath.getPath(b), "external", "glfw", "include" });
        step.addIncludePath(.{ .cwd_relative = glfwInclude });

        // On macos rglfw.c include Objective-C files.
        try self.flags.append("-ObjC");
        const cRglfw = b.pathJoin(&[_][]const u8{ self.raylibSrcPath.getPath(b), "rglfw.c" });
        step.root_module.addCSourceFile(.{
            .file = .{ .cwd_relative = cRglfw },
            .flags = self.flags.items,
        });
        _ = self.flags.pop();
        step.linkFramework("Foundation");
        step.linkFramework("CoreServices");
        step.linkFramework("CoreGraphics");
        step.linkFramework("AppKit");
        step.linkFramework("IOKit");

        step.defineCMacro("PLATFORM_DESKTOP", null);
    }

    // Update `step` to build for linux.
    // If you set the option to build with platform DRM,
    // it will use setRlglOptions with opengl_es2 and link to glwfv2.
    pub fn linkLinux(
        self: *RaylibSetup,
        b: *std.Build,
        step: *std.Build.Step.Compile,
        options: LinuxOptions,
    ) !void {
        switch (options.platform) {
            .DESKTOP => {
                step.defineCMacro("PLATFORM_DESKTOP", null);
                try self.files.append("rglfw.c");

                step.linkSystemLibrary("GL");
                step.linkSystemLibrary("rt");
                step.linkSystemLibrary("dl");
                step.linkSystemLibrary("m");

                const glfwInclude = b.pathJoin(&[_][]const u8{ self.raylibSrcPath.getPath(b), "external", "glfw", "include" });
                step.addIncludePath(.{ .cwd_relative = glfwInclude });
                step.addIncludePath(.{ .cwd_relative = "/usr/include" });
                step.addLibraryPath(.{ .cwd_relative = "/usr/lib" });

                switch (options.backend) {
                    .X11 => {
                        step.defineCMacro("_GLFW_X11", null);
                        step.linkSystemLibrary("X11");
                    },
                    .WAYLAND => {
                        step.defineCMacro("_GLFW_WAYLAND", null);
                        step.linkSystemLibrary("wayland-client");
                        step.linkSystemLibrary("wayland-cursor");
                        step.linkSystemLibrary("wayland-egl");
                        step.linkSystemLibrary("xkbcommon");

                        waylandGenerate(self, b, step, "wayland.xml", "wayland-client-protocol");
                        waylandGenerate(self, b, step, "xdg-shell.xml", "xdg-shell-client-protocol");
                        waylandGenerate(self, b, step, "xdg-decoration-unstable-v1.xml", "xdg-decoration-unstable-v1-client-protocol");
                        waylandGenerate(self, b, step, "viewporter.xml", "viewporter-client-protocol");
                        waylandGenerate(self, b, step, "relative-pointer-unstable-v1.xml", "relative-pointer-unstable-v1-client-protocol");
                        waylandGenerate(self, b, step, "pointer-constraints-unstable-v1.xml", "pointer-constraints-unstable-v1-client-protocol");
                        waylandGenerate(self, b, step, "fractional-scale-v1.xml", "fractional-scale-v1-client-protocol");
                        waylandGenerate(self, b, step, "xdg-activation-v1.xml", "xdg-activation-v1-client-protocol");
                        waylandGenerate(self, b, step, "idle-inhibit-unstable-v1.xml", "idle-inhibit-unstable-v1-client-protocol");
                    },
                }
            },
            .DRM => {
                step.linkSystemLibrary("EGL");
                step.linkSystemLibrary("drm");
                step.linkSystemLibrary("gbm");
                step.linkSystemLibrary("pthread");
                step.linkSystemLibrary("rt");
                step.linkSystemLibrary("m");
                step.linkSystemLibrary("dl");
                step.addIncludePath(.{ .cwd_relative = "/usr/include/libdrm" });

                step.defineCMacro("PLATFORM_DRM", null);
                step.defineCMacro("EGL_NO_X11", null);

                // If opengl_es2 is selected, we link against it.
                if (self.rlgl) |opts| {
                    if (opts.graphics_api == .OPENGL_ES2) {
                        step.linkSystemLibrary("GLESv2");
                    }
                } else {
                    setRlglOptions(self, b, step, .{
                        .graphics_api = .OPENGL_ES2,
                        .rl_default_batch_buffer_elements = "2048",
                    });
                    step.linkSystemLibrary("GLESv2");
                }
            },
        }
    }

    // Commands to generate wayland bindings.
    fn waylandGenerate(
        self: *RaylibSetup,
        b: *std.Build,
        step: *std.Build.Step.Compile,
        comptime protocol: []const u8,
        comptime basename: []const u8,
    ) void {
        const waylandDir = b.pathJoin(&[_][]const u8{ self.raylibSrcPath.getPath(b), "external", "glfw", "deps", "wayland" });
        const protocolDir = b.pathJoin(&[_][]const u8{ waylandDir, protocol });

        const clientHeader = basename ++ ".h";
        const privateCode = basename ++ "-code.h";

        const client_step = b.addSystemCommand(&.{ "wayland-scanner", "client-header" });
        client_step.addFileArg(.{ .cwd_relative = protocolDir });
        step.addIncludePath(client_step.addOutputFileArg(clientHeader).dirname());

        const private_step = b.addSystemCommand(&.{ "wayland-scanner", "private-code" });
        private_step.addFileArg(.{ .cwd_relative = protocolDir });
        step.addIncludePath(private_step.addOutputFileArg(privateCode).dirname());

        step.step.dependOn(&client_step.step);
        step.step.dependOn(&private_step.step);
    }

    // Options

    // C macros and build options for rcamera
    pub fn setRCameraOptions(
        self: *RaylibSetup,
        build: *std.Build,
        step: *std.Build.Step.Compile,
        conf: RCameraConfiguration,
    ) void {
        self.rcamera = conf;
        const buildOpts = build.addOptions();
        if (conf.rcamera_implementation) |implementation| {
            buildOpts.addOption(@TypeOf(implementation), "implementation", implementation);
            if (implementation) step.defineCMacro("RCAMERA_IMPLEMENTATION", null) else step.forceUndefinedSymbol("RCAMERA_IMPLEMENTATION");
        }
        if (conf.rcamera_standalone) |standalone| {
            buildOpts.addOption(@TypeOf(standalone), "standalone", standalone);
            if (standalone) step.defineCMacro("RCAMERA_STANDALONE", null) else step.forceUndefinedSymbol("RCAMERA_STANDALONE");
        }
        step.root_module.addOptions("raygui_options", buildOpts);
    }

    // C macros and build options for rlgl
    pub fn setRlglOptions(
        self: *RaylibSetup,
        build: *std.Build,
        step: *std.Build.Step.Compile,
        conf: RlglConfiguration,
    ) void {
        self.rlgl = conf;
        const buildOpts = build.addOptions();

        buildOpts.addOption(usize, "graphics_api", @intFromEnum(conf.graphics_api));
        switch (conf.graphics_api) {
            GraphicsApi.OPENGL_11 => step.defineCMacro("GRAPHICS_API_OPENGL_11", null),
            GraphicsApi.OPENGL_21 => step.defineCMacro("GRAPHICS_API_OPENGL_21", null),
            GraphicsApi.OPENGL_33 => step.defineCMacro("GRAPHICS_API_OPENGL_33", null),
            GraphicsApi.OPENGL_43 => step.defineCMacro("GRAPHICS_API_OPENGL_43", null),
            GraphicsApi.OPENGL_ES2 => step.defineCMacro("GRAPHICS_API_OPENGL_ES2", null),
            GraphicsApi.OPENGL_ES3 => step.defineCMacro("GRAPHICS_API_OPENGL_ES3", null),
        }

        if (conf.rlgl_implementation) |implementation| {
            buildOpts.addOption(@TypeOf(implementation), "implementation", implementation);
            if (implementation) step.defineCMacro("RLGL_IMPLEMENTATION", null) else step.forceUndefinedSymbol("RLGL_IMPLEMENTATION");
        }
        if (conf.rlgl_render_textures_hint) |render_textures_hint| {
            buildOpts.addOption(@TypeOf(render_textures_hint), "render_textures_hint", render_textures_hint);
            if (render_textures_hint) step.defineCMacro("RLGL_RENDER_TEXTURES_HINT", null) else step.forceUndefinedSymbol("RLGL_RENDER_TEXTURES_HINT");
        }
        if (conf.rlgl_show_gl_details_info) |show_gl_details_info| {
            buildOpts.addOption(@TypeOf(show_gl_details_info), "show_gl_details_info", show_gl_details_info);
            if (show_gl_details_info) step.defineCMacro("RLGL_SHOW_GL_DETAILS_INFO", null) else step.forceUndefinedSymbol("RLGL_SHOW_GL_DETAILS_INFO");
        }
        if (conf.rlgl_enable_opengl_debug_context) |enable_opengl_debug_context| {
            buildOpts.addOption(@TypeOf(enable_opengl_debug_context), "enable_opengl_debug_context", enable_opengl_debug_context);
            if (enable_opengl_debug_context) step.defineCMacro("RLGL_ENABLE_OPENGL_DEBUG_CONTEXT", null) else step.forceUndefinedSymbol("RLGL_ENABLE_OPENGL_DEBUG_CONTEXT");
        }
        if (conf.rl_default_batch_buffer_elements) |default_batch_buffer_elements| {
            buildOpts.addOption(@TypeOf(default_batch_buffer_elements), "default_batch_buffer_elements", default_batch_buffer_elements);
            step.defineCMacro("RL_DEFAULT_BATCH_BUFFER_ELEMENTS", default_batch_buffer_elements);
        }
        if (conf.rl_default_batch_buffers) |default_batch_buffers| {
            buildOpts.addOption(@TypeOf(default_batch_buffers), "default_batch_buffers", default_batch_buffers);
            step.defineCMacro("RL_DEFAULT_BATCH_BUFFERS", default_batch_buffers);
        }
        if (conf.rl_default_batch_drawcalls) |default_batch_drawcalls| {
            buildOpts.addOption(@TypeOf(default_batch_drawcalls), "default_batch_drawcalls", default_batch_drawcalls);
            step.defineCMacro("RL_DEFAULT_BATCH_DRAWCALLS", default_batch_drawcalls);
        }
        if (conf.rl_default_batch_max_texture_units) |default_batch_max_texture_units| {
            buildOpts.addOption(@TypeOf(default_batch_max_texture_units), "default_batch_max_texture_units", default_batch_max_texture_units);
            step.defineCMacro("RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS", default_batch_max_texture_units);
        }
        if (conf.rl_max_matrix_stack_size) |max_matrix_stack_size| {
            buildOpts.addOption(@TypeOf(max_matrix_stack_size), "max_matrix_stack_size", max_matrix_stack_size);
            step.defineCMacro("RL_MAX_MATRIX_STACK_SIZE", max_matrix_stack_size);
        }
        if (conf.rl_max_shader_locations) |max_shader_locations| {
            buildOpts.addOption(@TypeOf(max_shader_locations), "max_shader_locations", max_shader_locations);
            step.defineCMacro("RL_MAX_SHADER_LOCATIONS", max_shader_locations);
        }
        if (conf.rl_cull_distance_near) |cull_distance_near| {
            buildOpts.addOption(@TypeOf(cull_distance_near), "cull_distance_near", cull_distance_near);
            step.defineCMacro("RL_CULL_DISTANCE_NEAR", cull_distance_near);
        }
        if (conf.rl_cull_distance_far) |cull_distance_far| {
            buildOpts.addOption(@TypeOf(cull_distance_far), "cull_distance_far", cull_distance_far);
            step.defineCMacro("RL_CULL_DISTANCE_FAR", cull_distance_far);
        }

        step.root_module.addOptions("rlgl_options", buildOpts);
    }

    // C macros and build options for raygui
    pub fn setRayguiOptions(
        self: *RaylibSetup,
        build: *std.Build,
        step: *std.Build.Step.Compile,
        conf: RayguiConfiguration,
    ) void {
        self.raygui = conf;
        const buildOpts = build.addOptions();
        if (conf.raygui_implementation) |implementation| {
            buildOpts.addOption(@TypeOf(implementation), "implementation", implementation);
            if (implementation) step.defineCMacro("RAYGUI_IMPLEMENTATION", null) else step.forceUndefinedSymbol("RAYGUI_IMPLEMENTATION");
        }
        if (conf.raygui_standalone) |standalone| {
            buildOpts.addOption(@TypeOf(standalone), "standalone", standalone);
            if (standalone) step.defineCMacro("RAYGUI_STANDALONE", null) else step.forceUndefinedSymbol("RAYGUI_STANDALONE");
        }
        if (conf.raygui_no_icons) |no_icons| {
            buildOpts.addOption(@TypeOf(no_icons), "no_icons", no_icons);
            if (no_icons) step.defineCMacro("RAYGUI_NO_ICONS", null) else step.forceUndefinedSymbol("RAYGUI_NO_ICONS");
        }
        if (conf.raygui_custom_icons) |custom_icons| {
            buildOpts.addOption(@TypeOf(custom_icons), "custom_icons", custom_icons);
            if (custom_icons) step.defineCMacro("RAYGUI_CUSTOM_ICONS", null) else step.forceUndefinedSymbol("RAYGUI_CUSTOM_ICONS");
        }
        if (conf.raygui_debug_recs_bounds) |debug_recs_bounds| {
            buildOpts.addOption(@TypeOf(debug_recs_bounds), "debug_recs_bounds", debug_recs_bounds);
            if (debug_recs_bounds) step.defineCMacro("RAYGUI_DEBUG_RECS_BOUNDS", null) else step.forceUndefinedSymbol("RAYGUI_DEBUG_RECS_BOUNDS");
        }
        if (conf.raygui_debug_text_bounds) |debug_text_bounds| {
            buildOpts.addOption(@TypeOf(debug_text_bounds), "debug_text_bounds", debug_text_bounds);
            if (debug_text_bounds) step.defineCMacro("RAYGUI_DEBUG_TEXT_BOUNDS", null) else step.forceUndefinedSymbol("RAYGUI_DEBUG_TEXT_BOUNDS");
        }

        step.root_module.addOptions("raygui_options", buildOpts);
    }

    pub fn finalize(
        self: *RaylibSetup,
        build: *std.Build,
        step: *std.Build.Step.Compile,
    ) void {
        // Set unsetted options
        if (self.rlgl == null) setRlglOptions(self, build, step, .{});
        if (self.rcamera == null) setRCameraOptions(self, build, step, .{});
        if (self.raygui == null) setRayguiOptions(self, build, step, .{});

        // libc is required to work with raylib c files.
        if (!step.is_linking_libc) step.linkLibC();

        // Add raylib sources to the step's module.
        step.root_module.addCSourceFiles(.{
            .root = self.raylibSrcPath,
            .files = self.files.items,
            .flags = self.flags.items,
        });
    }

    pub fn deinit(self: *RaylibSetup) void {
        self.flags.deinit();
        self.files.deinit();
    }
};
