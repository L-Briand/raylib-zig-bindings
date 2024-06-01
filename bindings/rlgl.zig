// Build options

// Same as rlGlVersion / rlGetVersion
const GraphicsApi = enum(usize) { OPENGL_11 = 1, OPENGL_21, OPENGL_33, OPENGL_43, OPENGL_ES2, OPENGL_ES3 };

const std = @import("std");

// C Options to added at build time. See options.rlgl.zig file
// In raylib the default graphic api is OPENGL_33
const options = @import("rlgl_options");
const selected_graphics_api: GraphicsApi = std.meta.intToEnum(GraphicsApi, options.graphics_api) catch @panic("Failed to read `rlgl_options.graphics_api` value");

test {
    const testing = std.testing;
    std.testing.refAllDeclsRecursive(@This());
    try testing.expect(@intFromEnum(rlGetVersion()) == @intFromEnum(selected_graphics_api));
}

// rlgl.h file

pub const RLGL_VERSION = "4.5";

//----------------------------------------------------------------------------------
// Defines and Macros
//----------------------------------------------------------------------------------

// Texture parameters (equivalent to OpenGL defines)
pub const RL_TEXTURE_WRAP_S = 0x2802; // GL_TEXTURE_WRAP_S
pub const RL_TEXTURE_WRAP_T = 0x2803; // GL_TEXTURE_WRAP_T
pub const RL_TEXTURE_MAG_FILTER = 0x2800; // GL_TEXTURE_MAG_FILTER
pub const RL_TEXTURE_MIN_FILTER = 0x2801; // GL_TEXTURE_MIN_FILTER

pub const RL_TEXTURE_FILTER_NEAREST = 0x2600; // GL_NEAREST
pub const RL_TEXTURE_FILTER_LINEAR = 0x2601; // GL_LINEAR
pub const RL_TEXTURE_FILTER_MIP_NEAREST = 0x2700; // GL_NEAREST_MIPMAP_NEAREST
pub const RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR = 0x2702; // GL_NEAREST_MIPMAP_LINEAR
pub const RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST = 0x2701; // GL_LINEAR_MIPMAP_NEAREST
pub const RL_TEXTURE_FILTER_MIP_LINEAR = 0x2703; // GL_LINEAR_MIPMAP_LINEAR
pub const RL_TEXTURE_FILTER_ANISOTROPIC = 0x3000; // Anisotropic filter (custom identifier)
pub const RL_TEXTURE_MIPMAP_BIAS_RATIO = 0x4000; // Texture mipmap bias, percentage ratio (custom identifier)

pub const RL_TEXTURE_WRAP_REPEAT = 0x2901; // GL_REPEAT
pub const RL_TEXTURE_WRAP_CLAMP = 0x812F; // GL_CLAMP_TO_EDGE
pub const RL_TEXTURE_WRAP_MIRROR_REPEAT = 0x8370; // GL_MIRRORED_REPEAT
pub const RL_TEXTURE_WRAP_MIRROR_CLAMP = 0x8742; // GL_MIRROR_CLAMP_EXT

// Matrix modes (equivalent to OpenGL)
pub const RL_MODELVIEW = 0x1700; // GL_MODELVIEW
pub const RL_PROJECTION = 0x1701; // GL_PROJECTION
pub const RL_TEXTURE = 0x1702; // GL_TEXTURE

// Primitive assembly draw modes
pub const RL_LINES = 0x0001; // GL_LINES
pub const RL_TRIANGLES = 0x0004; // GL_TRIANGLES
pub const RL_QUADS = 0x0007; // GL_QUADS

// GL equivalent data types
pub const RL_UNSIGNED_BYTE = 0x1401; // GL_UNSIGNED_BYTE
pub const RL_FLOAT = 0x1406; // GL_FLOAT

// GL buffer usage hint
pub const RL_STREAM_DRAW = 0x88E0; // GL_STREAM_DRAW
pub const RL_STREAM_READ = 0x88E1; // GL_STREAM_READ
pub const RL_STREAM_COPY = 0x88E2; // GL_STREAM_COPY
pub const RL_STATIC_DRAW = 0x88E4; // GL_STATIC_DRAW
pub const RL_STATIC_READ = 0x88E5; // GL_STATIC_READ
pub const RL_STATIC_COPY = 0x88E6; // GL_STATIC_COPY
pub const RL_DYNAMIC_DRAW = 0x88E8; // GL_DYNAMIC_DRAW
pub const RL_DYNAMIC_READ = 0x88E9; // GL_DYNAMIC_READ
pub const RL_DYNAMIC_COPY = 0x88EA; // GL_DYNAMIC_COPY

// GL Shader type
pub const RL_FRAGMENT_SHADER = 0x8B30; // GL_FRAGMENT_SHADER
pub const RL_VERTEX_SHADER = 0x8B31; // GL_VERTEX_SHADER
pub const RL_COMPUTE_SHADER = 0x91B9; // GL_COMPUTE_SHADER

// GL blending factors
pub const RL_ZERO = 0; // GL_ZERO
pub const RL_ONE = 1; // GL_ONE
pub const RL_SRC_COLOR = 0x0300; // GL_SRC_COLOR
pub const RL_ONE_MINUS_SRC_COLOR = 0x0301; // GL_ONE_MINUS_SRC_COLOR
pub const RL_SRC_ALPHA = 0x0302; // GL_SRC_ALPHA
pub const RL_ONE_MINUS_SRC_ALPHA = 0x0303; // GL_ONE_MINUS_SRC_ALPHA
pub const RL_DST_ALPHA = 0x0304; // GL_DST_ALPHA
pub const RL_ONE_MINUS_DST_ALPHA = 0x0305; // GL_ONE_MINUS_DST_ALPHA
pub const RL_DST_COLOR = 0x0306; // GL_DST_COLOR
pub const RL_ONE_MINUS_DST_COLOR = 0x0307; // GL_ONE_MINUS_DST_COLOR
pub const RL_SRC_ALPHA_SATURATE = 0x0308; // GL_SRC_ALPHA_SATURATE
pub const RL_CONSTANT_COLOR = 0x8001; // GL_CONSTANT_COLOR
pub const RL_ONE_MINUS_CONSTANT_COLOR = 0x8002; // GL_ONE_MINUS_CONSTANT_COLOR
pub const RL_CONSTANT_ALPHA = 0x8003; // GL_CONSTANT_ALPHA
pub const RL_ONE_MINUS_CONSTANT_ALPHA = 0x8004; // GL_ONE_MINUS_CONSTANT_ALPHA

// GL blending functions/equations
pub const RL_FUNC_ADD = 0x8006; // GL_FUNC_ADD
pub const RL_MIN = 0x8007; // GL_MIN
pub const RL_MAX = 0x8008; // GL_MAX
pub const RL_FUNC_SUBTRACT = 0x800A; // GL_FUNC_SUBTRACT
pub const RL_FUNC_REVERSE_SUBTRACT = 0x800B; // GL_FUNC_REVERSE_SUBTRACT
pub const RL_BLEND_EQUATION = 0x8009; // GL_BLEND_EQUATION
pub const RL_BLEND_EQUATION_RGB = 0x8009; // GL_BLEND_EQUATION_RGB   // (Same as BLEND_EQUATION)
pub const RL_BLEND_EQUATION_ALPHA = 0x883D; // GL_BLEND_EQUATION_ALPHA
pub const RL_BLEND_DST_RGB = 0x80C8; // GL_BLEND_DST_RGB
pub const RL_BLEND_SRC_RGB = 0x80C9; // GL_BLEND_SRC_RGB
pub const RL_BLEND_DST_ALPHA = 0x80CA; // GL_BLEND_DST_ALPHA
pub const RL_BLEND_SRC_ALPHA = 0x80CB; // GL_BLEND_SRC_ALPHA
pub const RL_BLEND_COLOR = 0x8005; // GL_BLEND_COLOR

//----------------------------------------------------------------------------------
// Types and Structures Definition
//----------------------------------------------------------------------------------

// Matrix, 4x4 components, column major, OpenGL style, right handed
const Matrix = @import("raylib.zig").Matrix;

pub const rlVertexBuffer_GL33 = rlVertexBuffer_GL11;
pub const rlVertexBuffer_GL11 = extern struct {
    elementCount: c_int, // Number of elements in the buffer (QUADS)
    vertices: [*c]f32, // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    texcoords: [*c]f32, // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    colors: [*c]u8, // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)

    indices: [*c]c_uint, // Vertex indices (in case vertex data comes indexed) (6 indices per quad)

    vaoId: c_uint, // OpenGL Vertex Array Object id
    vboId: [4]c_uint, // OpenGL Vertex Buffer Objects id (4 types of vertex data)

    pub fn init(elementCount: c_int, vertices: [*c]f32, texcoords: [*c]f32, colors: [*c]u8, indices: [*c]c_uint, vaoId: c_uint, vboId: [4]c_uint) @This() {
        return @This(){ .elementCount = elementCount, .vertices = vertices, .texcoords = texcoords, .colors = colors, .indices = indices, .vaoId = vaoId, .vboId = vboId };
    }
};

pub const rlVertexBuffer_GLES2 = extern struct {
    elementCount: c_int, // Number of elements in the buffer (QUADS)
    vertices: [*c]f32, // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    texcoords: [*c]f32, // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    colors: [*c]u8, // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)

    indices: [*c]c_ushort, // Vertex indices (in case vertex data comes indexed) (6 indices per quad)

    vaoId: c_uint, // OpenGL Vertex Array Object id
    vboId: [4]c_uint, // OpenGL Vertex Buffer Objects id (4 types of vertex data)

    pub fn init(elementCount: c_int, vertices: [*c]f32, texcoords: [*c]f32, colors: [*c]u8, indices: [*c]c_ushort, vaoId: c_uint, vboId: [4]c_uint) @This() {
        return @This(){ .elementCount = elementCount, .vertices = vertices, .texcoords = texcoords, .colors = colors, .indices = indices, .vaoId = vaoId, .vboId = vboId };
    }
};

pub const rlVertexBuffer_DEFAULT = extern struct {
    elementCount: c_int, // Number of elements in the buffer (QUADS)
    vertices: [*c]f32, // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    texcoords: [*c]f32, // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    colors: [*c]u8, // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)

    vaoId: c_uint, // OpenGL Vertex Array Object id
    vboId: [4]c_uint, // OpenGL Vertex Buffer Objects id (4 types of vertex data)

    pub fn init(elementCount: c_int, vertices: [*c]f32, texcoords: [*c]f32, colors: [*c]u8, vaoId: c_uint, vboId: [4]c_uint) @This() {
        return @This(){ .elementCount = elementCount, .vertices = vertices, .texcoords = texcoords, .colors = colors, .vaoId = vaoId, .vboId = vboId };
    }
};

pub const rlVertexBuffer = switch (selected_graphics_api) {
    GraphicsApi.OPENGL_11 => rlVertexBuffer_GL11,
    GraphicsApi.OPENGL_33 => rlVertexBuffer_GL33,
    GraphicsApi.OPENGL_ES2 => rlVertexBuffer_GLES2,
    else => rlVertexBuffer_DEFAULT,
};

// Draw call type
// NOTE: Only texture changes register a new draw, other state-change-related elements are not
// used at this moment (vaoId, shaderId, matrices), raylib just forces a batch draw call if any
// of those state-change happens (this is done in core module)
pub const rlDrawCall = extern struct {
    mode: c_uint, // Drawing mode: LINES, TRIANGLES, QUADS
    vertexCount: c_uint, // Number of vertex of the draw
    vertexAlignment: c_uint, // Number of vertex required for index alignment (LINES, TRIANGLES)
    //unsigned int vaoId;       // Vertex array id to be used on the draw -> Using RLGL.currentBatch->vertexBuffer.vaoId
    //unsigned int shaderId;    // Shader id to be used on the draw -> Using RLGL.currentShaderId
    textureId: c_uint, // Texture id to be used on the draw -> Use to create new draw call if changes

    //Matrix projection;        // Projection matrix for this draw -> Using RLGL.projection by default
    //Matrix modelview;         // Modelview matrix for this draw -> Using RLGL.modelview by default

    pub fn init(mode: c_uint, vertexCount: c_uint, vertexAlignment: c_uint, textureId: c_uint) rlDrawCall {
        return rlDrawCall{ .mode = mode, .vertexCount = vertexCount, .vertexAlignment = vertexAlignment, .textureId = textureId };
    }
};

// rlRenderBatch type
pub const rlRenderBatch = extern struct {
    bufferCount: c_int, // Number of vertex buffers (multi-buffering support)
    currentBuffer: c_int, // Current buffer tracking in case of multi-buffering
    vertexBuffer: [*c]rlVertexBuffer, // Dynamic buffer(s) for vertex data

    draws: [*c]rlDrawCall, // Draw calls array, depends on textureId
    drawCounter: c_int, // Draw calls counter
    currentDepth: f32, // Current depth value for next draw
    pub fn init(bufferCount: c_int, currentBuffer: c_int, vertexBuffer: [*c]rlVertexBuffer, draws: [*c]rlDrawCall, drawCounter: c_int, currentDepth: f32) rlRenderBatch {
        return rlRenderBatch{ .bufferCount = bufferCount, .currentBuffer = currentBuffer, .vertexBuffer = vertexBuffer, .draws = draws, .drawCounter = drawCounter, .currentDepth = currentDepth };
    }
};

// OpenGL version
pub const rlGlVersion = enum(c_int) {
    RL_OPENGL_11 = 1, // OpenGL 1.1
    RL_OPENGL_21, // OpenGL 2.1 (GLSL 120)
    RL_OPENGL_33, // OpenGL 3.3 (GLSL 330)
    RL_OPENGL_43, // OpenGL 4.3 (using GLSL 330)
    RL_OPENGL_ES_20, // OpenGL ES 2.0 (GLSL 100)
    RL_OPENGL_ES_30, // OpenGL ES 3.0 (GLSL 300 es)

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Trace log level
// NOTE: Organized by priority level
pub const rlTraceLogLevel = enum(c_int) {
    RL_LOG_ALL = 0, // Display all logs
    RL_LOG_TRACE, // Trace logging, intended for internal use only
    RL_LOG_DEBUG, // Debug logging, used for internal debugging, it should be disabled on release builds
    RL_LOG_INFO, // Info logging, used for program execution info
    RL_LOG_WARNING, // Warning logging, used on recoverable failures
    RL_LOG_ERROR, // Error logging, used on unrecoverable failures
    RL_LOG_FATAL, // Fatal logging, used to abort program: exit(EXIT_FAILURE)
    RL_LOG_NONE, // Disable logging

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Texture pixel formats
// NOTE: Support depends on OpenGL version
pub const rlPixelFormat = enum(c_int) {
    RL_PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1, // 8 bit per pixel (no alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA, // 8*2 bpp (2 channels)
    RL_PIXELFORMAT_UNCOMPRESSED_R5G6B5, // 16 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8, // 24 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R5G5B5A1, // 16 bpp (1 bit alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_R4G4B4A4, // 16 bpp (4 bit alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8, // 32 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R32, // 32 bpp (1 channel - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32, // 32*3 bpp (3 channels - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32A32, // 32*4 bpp (4 channels - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R16, // 16 bpp (1 channel - half float)
    RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16, // 16*3 bpp (3 channels - half float)
    RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16A16, // 16*4 bpp (4 channels - half float)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGB, // 4 bpp (no alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA, // 4 bpp (1 bit alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA, // 8 bpp
    RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA, // 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC1_RGB, // 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_RGB, // 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA, // 8 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGB, // 4 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA, // 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA, // 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA, // 2 bpp

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Texture parameters: filter mode
// NOTE 1: Filtering considers mipmaps if available in the texture
// NOTE 2: Filter is accordingly set for minification and magnification
pub const rlTextureFilter = enum(c_int) {
    RL_TEXTURE_FILTER_POINT = 0, // No filter, just pixel approximation
    RL_TEXTURE_FILTER_BILINEAR, // Linear filtering
    RL_TEXTURE_FILTER_TRILINEAR, // Trilinear filtering (linear with mipmaps)
    RL_TEXTURE_FILTER_ANISOTROPIC_4X, // Anisotropic filtering 4x
    RL_TEXTURE_FILTER_ANISOTROPIC_8X, // Anisotropic filtering 8x
    RL_TEXTURE_FILTER_ANISOTROPIC_16X, // Anisotropic filtering 16x

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Color blending modes (pre-defined)
pub const rlBlendMode = enum(c_int) {
    RL_BLEND_ALPHA = 0, // Blend textures considering alpha (default)
    RL_BLEND_ADDITIVE, // Blend textures adding colors
    RL_BLEND_MULTIPLIED, // Blend textures multiplying colors
    RL_BLEND_ADD_COLORS, // Blend textures adding colors (alternative)
    RL_BLEND_SUBTRACT_COLORS, // Blend textures subtracting colors (alternative)
    RL_BLEND_ALPHA_PREMULTIPLY, // Blend premultiplied textures considering alpha
    RL_BLEND_CUSTOM, // Blend textures using custom src/dst factors (use rlSetBlendFactors())
    RL_BLEND_CUSTOM_SEPARATE, // Blend textures using custom src/dst factors (use rlSetBlendFactorsSeparate())

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Shader location point type
pub const rlShaderLocationIndex = enum(c_int) {
    RL_SHADER_LOC_VERTEX_POSITION = 0, // Shader location: vertex attribute: position
    RL_SHADER_LOC_VERTEX_TEXCOORD01, // Shader location: vertex attribute: texcoord01
    RL_SHADER_LOC_VERTEX_TEXCOORD02, // Shader location: vertex attribute: texcoord02
    RL_SHADER_LOC_VERTEX_NORMAL, // Shader location: vertex attribute: normal
    RL_SHADER_LOC_VERTEX_TANGENT, // Shader location: vertex attribute: tangent
    RL_SHADER_LOC_VERTEX_COLOR, // Shader location: vertex attribute: color
    RL_SHADER_LOC_MATRIX_MVP, // Shader location: matrix uniform: model-view-projection
    RL_SHADER_LOC_MATRIX_VIEW, // Shader location: matrix uniform: view (camera transform)
    RL_SHADER_LOC_MATRIX_PROJECTION, // Shader location: matrix uniform: projection
    RL_SHADER_LOC_MATRIX_MODEL, // Shader location: matrix uniform: model (transform)
    RL_SHADER_LOC_MATRIX_NORMAL, // Shader location: matrix uniform: normal
    RL_SHADER_LOC_VECTOR_VIEW, // Shader location: vector uniform: view
    RL_SHADER_LOC_COLOR_DIFFUSE, // Shader location: vector uniform: diffuse color
    RL_SHADER_LOC_COLOR_SPECULAR, // Shader location: vector uniform: specular color
    RL_SHADER_LOC_COLOR_AMBIENT, // Shader location: vector uniform: ambient color
    RL_SHADER_LOC_MAP_ALBEDO, // Shader location: sampler2d texture: albedo (same as: RL_SHADER_LOC_MAP_DIFFUSE)
    RL_SHADER_LOC_MAP_METALNESS, // Shader location: sampler2d texture: metalness (same as: RL_SHADER_LOC_MAP_SPECULAR)
    RL_SHADER_LOC_MAP_NORMAL, // Shader location: sampler2d texture: normal
    RL_SHADER_LOC_MAP_ROUGHNESS, // Shader location: sampler2d texture: roughness
    RL_SHADER_LOC_MAP_OCCLUSION, // Shader location: sampler2d texture: occlusion
    RL_SHADER_LOC_MAP_EMISSION, // Shader location: sampler2d texture: emission
    RL_SHADER_LOC_MAP_HEIGHT, // Shader location: sampler2d texture: height
    RL_SHADER_LOC_MAP_CUBEMAP, // Shader location: samplerCube texture: cubemap
    RL_SHADER_LOC_MAP_IRRADIANCE, // Shader location: samplerCube texture: irradiance
    RL_SHADER_LOC_MAP_PREFILTER, // Shader location: samplerCube texture: prefilter
    RL_SHADER_LOC_MAP_BRDF, // Shader location: sampler2d texture: brdf

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

pub const RL_SHADER_LOC_MAP_DIFFUSE = rlShaderLocationIndex.RL_SHADER_LOC_MAP_ALBEDO;
pub const RL_SHADER_LOC_MAP_SPECULAR = rlShaderLocationIndex.RL_SHADER_LOC_MAP_METALNESS;

// Shader uniform data type
pub const rlShaderUniformDataType = enum(c_int) {
    RL_SHADER_UNIFORM_FLOAT = 0, // Shader uniform type: float
    RL_SHADER_UNIFORM_VEC2, // Shader uniform type: vec2 (2 float)
    RL_SHADER_UNIFORM_VEC3, // Shader uniform type: vec3 (3 float)
    RL_SHADER_UNIFORM_VEC4, // Shader uniform type: vec4 (4 float)
    RL_SHADER_UNIFORM_INT, // Shader uniform type: int
    RL_SHADER_UNIFORM_IVEC2, // Shader uniform type: ivec2 (2 int)
    RL_SHADER_UNIFORM_IVEC3, // Shader uniform type: ivec3 (3 int)
    RL_SHADER_UNIFORM_IVEC4, // Shader uniform type: ivec4 (4 int)
    RL_SHADER_UNIFORM_SAMPLER2D, // Shader uniform type: sampler2d

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Shader attribute data types
pub const rlShaderAttributeDataType = enum(c_int) {
    RL_SHADER_ATTRIB_FLOAT = 0, // Shader attribute type: float
    RL_SHADER_ATTRIB_VEC2, // Shader attribute type: vec2 (2 float)
    RL_SHADER_ATTRIB_VEC3, // Shader attribute type: vec3 (3 float)
    RL_SHADER_ATTRIB_VEC4, // Shader attribute type: vec4 (4 float)

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Framebuffer attachment type
// NOTE: By default up to 8 color channels defined, but it can be more
pub const rlFramebufferAttachType = enum(c_int) {
    RL_ATTACHMENT_COLOR_CHANNEL0 = 0, // Framebuffer attachment type: color 0
    RL_ATTACHMENT_COLOR_CHANNEL1 = 1, // Framebuffer attachment type: color 1
    RL_ATTACHMENT_COLOR_CHANNEL2 = 2, // Framebuffer attachment type: color 2
    RL_ATTACHMENT_COLOR_CHANNEL3 = 3, // Framebuffer attachment type: color 3
    RL_ATTACHMENT_COLOR_CHANNEL4 = 4, // Framebuffer attachment type: color 4
    RL_ATTACHMENT_COLOR_CHANNEL5 = 5, // Framebuffer attachment type: color 5
    RL_ATTACHMENT_COLOR_CHANNEL6 = 6, // Framebuffer attachment type: color 6
    RL_ATTACHMENT_COLOR_CHANNEL7 = 7, // Framebuffer attachment type: color 7
    RL_ATTACHMENT_DEPTH = 100, // Framebuffer attachment type: depth
    RL_ATTACHMENT_STENCIL = 200, // Framebuffer attachment type: stencil

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Framebuffer texture attachment type
pub const rlFramebufferAttachTextureType = enum(c_int) {
    RL_ATTACHMENT_CUBEMAP_POSITIVE_X = 0, // Framebuffer texture attachment type: cubemap, +X side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_X = 1, // Framebuffer texture attachment type: cubemap, -X side
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Y = 2, // Framebuffer texture attachment type: cubemap, +Y side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y = 3, // Framebuffer texture attachment type: cubemap, -Y side
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Z = 4, // Framebuffer texture attachment type: cubemap, +Z side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z = 5, // Framebuffer texture attachment type: cubemap, -Z side
    RL_ATTACHMENT_TEXTURE2D = 100, // Framebuffer texture attachment type: texture2d
    RL_ATTACHMENT_RENDERBUFFER = 200, // Framebuffer texture attachment type: renderbuffer

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Face culling mode
pub const rlCullMode = enum(c_int) { RL_CULL_FACE_FRONT = 0, RL_CULL_FACE_BACK };

//------------------------------------------------------------------------------------
// Functions Declaration - Matrix operations
//------------------------------------------------------------------------------------

pub extern fn rlMatrixMode(mode: c_int) void; // Choose the current matrix to be transformed
pub extern fn rlPushMatrix() void; // Push the current matrix to stack
pub extern fn rlPopMatrix() void; // Pop latest inserted matrix from stack
pub extern fn rlLoadIdentity() void; // Reset current matrix to identity matrix
pub extern fn rlTranslatef(x: f32, y: f32, z: f32) void; // Multiply the current matrix by a translation matrix
pub extern fn rlRotatef(angle: f32, x: f32, y: f32, z: f32) void; // Multiply the current matrix by a rotation matrix
pub extern fn rlScalef(x: f32, y: f32, z: f32) void; // Multiply the current matrix by a scaling matrix
pub extern fn rlMultMatrixf(matf: [*c]const f32) void; // Multiply the current matrix by another matrix
pub extern fn rlFrustum(left: f64, right: f64, bottom: f64, top: f64, znear: f64, zfar: f64) void;
pub extern fn rlOrtho(left: f64, right: f64, bottom: f64, top: f64, znear: f64, zfar: f64) void;
pub extern fn rlViewport(x: c_int, y: c_int, width: c_int, height: c_int) void; // Set the viewport area

//------------------------------------------------------------------------------------
// Functions Declaration - Vertex level operations
//------------------------------------------------------------------------------------
pub extern fn rlBegin(mode: c_int) void; // Initialize drawing mode (how to organize vertex)
pub extern fn rlEnd() void; // Finish vertex providing
pub extern fn rlVertex2i(x: c_int, y: c_int) void; // Define one vertex (position) - 2 int
pub extern fn rlVertex2f(x: f32, y: f32) void; // Define one vertex (position) - 2 float
pub extern fn rlVertex3f(x: f32, y: f32, z: f32) void; // Define one vertex (position) - 3 float
pub extern fn rlTexCoord2f(x: f32, y: f32) void; // Define one vertex (texture coordinate) - 2 float
pub extern fn rlNormal3f(x: f32, y: f32, z: f32) void; // Define one vertex (normal) - 3 float
pub extern fn rlColor4ub(r: u8, g: u8, b: u8, a: u8) void; // Define one vertex (color) - 4 byte
pub extern fn rlColor3f(x: f32, y: f32, z: f32) void; // Define one vertex (color) - 3 float
pub extern fn rlColor4f(x: f32, y: f32, z: f32, w: f32) void; // Define one vertex (color) - 4 float

//------------------------------------------------------------------------------------
// Functions Declaration - OpenGL style functions (common to 1.1, 3.3+, ES2)
// NOTE: This functions are used to completely abstract raylib code from OpenGL layer,
// some of them are direct wrappers over OpenGL calls, some others are custom
//------------------------------------------------------------------------------------

// Vertex buffers state
pub extern fn rlEnableVertexArray(vaoId: c_uint) bool; // Enable vertex array (VAO, if supported)
pub extern fn rlDisableVertexArray() void; // Disable vertex array (VAO, if supported)
pub extern fn rlEnableVertexBuffer(id: c_uint) void; // Enable vertex buffer (VBO)
pub extern fn rlDisableVertexBuffer() void; // Disable vertex buffer (VBO)
pub extern fn rlEnableVertexBufferElement(id: c_uint) void; // Enable vertex buffer element (VBO element)
pub extern fn rlDisableVertexBufferElement() void; // Disable vertex buffer element (VBO element)
pub extern fn rlEnableVertexAttribute(index: c_uint) void; // Enable vertex attribute index
pub extern fn rlDisableVertexAttribute(index: c_uint) void; // Disable vertex attribute index

pub extern "c" fn rlEnableStatePointer(vertexAttribType: c_int, buffer: *anyopaque) void; // Enable attribute state pointer
pub extern "c" fn rlDisableStatePointer(vertexAttribType: c_int) void; // Disable attribute state pointer

// Textures state
pub extern fn rlActiveTextureSlot(slot: c_int) void; // Select and active a texture slot
pub extern fn rlEnableTexture(id: c_uint) void; // Enable texture
pub extern fn rlDisableTexture() void; // Disable texture
pub extern fn rlEnableTextureCubemap(id: c_uint) void; // Enable texture cubemap
pub extern fn rlDisableTextureCubemap() void; // Disable texture cubemap
pub extern fn rlTextureParameters(id: c_uint, param: c_int, value: c_int) void; // Set texture parameters (filter, wrap)
pub extern fn rlCubemapParameters(id: c_uint, param: c_int, value: c_int) void; // Set cubemap parameters (filter, wrap)

// Shader state
pub extern fn rlEnableShader(id: c_uint) void; // Enable shader program
pub extern fn rlDisableShader() void; // Disable shader program

// Framebuffer state
pub extern fn rlEnableFramebuffer(id: c_uint) void; // Enable render texture (fbo)
pub extern fn rlDisableFramebuffer() void; // Disable render texture (fbo), return to default framebuffer
pub extern fn rlActiveDrawBuffers(count: c_int) void; // Activate multiple draw color buffers
pub extern fn rlBlitFramebuffer(srcX: c_int, srcY: c_int, srcWidth: c_int, srcHeight: c_int, dstX: c_int, dstY: c_int, dstWidth: c_int, dstHeight: c_int, bufferMask: c_int) void; // Blit active framebuffer to main framebuffer

// General render state
pub extern fn rlEnableColorBlend() void; // Disable color blending
pub extern fn rlDisableColorBlend() void; // Enable depth test
pub extern fn rlEnableDepthTest() void; // Disable depth test
pub extern fn rlDisableDepthTest() void; // Enable depth write
pub extern fn rlEnableDepthMask() void; // Disable depth write
pub extern fn rlDisableDepthMask() void; // Enable backface culling
pub extern fn rlEnableBackfaceCulling() void; // Disable backface culling
pub extern fn rlDisableBackfaceCulling() void; // Set face culling mode
pub extern fn rlSetCullFace(mode: c_int) void; // Enable scissor test
pub extern fn rlEnableScissorTest() void; // Disable scissor test
pub extern fn rlDisableScissorTest() void; // Scissor test
pub extern fn rlScissor(x: c_int, y: c_int, width: c_int, height: c_int) void; // Enable wire mode
pub extern fn rlEnableWireMode() void; //  Enable point mode
pub extern fn rlEnablePointMode() void; // Disable wire mode ( and point ) maybe rename
pub extern fn rlDisableWireMode() void; // Set the line drawing width
pub extern fn rlSetLineWidth(width: f32) void; // Get the line drawing width
pub extern fn rlGetLineWidth() f32; // Enable line aliasing
pub extern fn rlEnableSmoothLines() void; // Disable line aliasing
pub extern fn rlDisableSmoothLines() void; // Enable stereo rendering
pub extern fn rlEnableStereoRender() void; // Disable stereo rendering
pub extern fn rlDisableStereoRender() void; // Check if stereo render is enabled

pub extern fn rlClearColor(r: u8, g: u8, b: u8, a: u8) void; // Clear color buffer with color
pub extern fn rlClearScreenBuffers() void; // Clear used screen buffers (color and depth)
pub extern fn rlCheckErrors() void; // Check and log OpenGL error codes
pub extern fn rlSetBlendMode(mode: c_int) void; // Set blending mode
pub extern fn rlSetBlendFactors(glSrcFactor: c_int, glDstFactor: c_int, glEquation: c_int) void; // Set blending mode factor and equation (using OpenGL factors)
pub extern fn rlSetBlendFactorsSeparate(glSrcRGB: c_int, glDstRGB: c_int, glSrcAlpha: c_int, glDstAlpha: c_int, glEqRGB: c_int, glEqAlpha: c_int) void; // Set blending mode factors and equations separately (using OpenGL factors)

//------------------------------------------------------------------------------------
// Functions Declaration - rlgl functionality
//------------------------------------------------------------------------------------
// rlgl initialization functions
pub extern fn rlglInit(width: c_int, height: c_int) void; // Initialize rlgl (buffers, shaders, textures, states)
pub extern fn rlglClose() void; // De-initialize rlgl (buffers, shaders, textures)
pub extern fn rlLoadExtensions(loader: ?*anyopaque) void; // Load OpenGL extensions (loader function required)
pub extern fn rlGetVersion() rlGlVersion; // Get current OpenGL version
pub extern fn rlSetFramebufferWidth(width: c_int) void; // Set current framebuffer width
pub extern fn rlGetFramebufferWidth() c_int; // Get default framebuffer width
pub extern fn rlSetFramebufferHeight(height: c_int) void; // Set current framebuffer height
pub extern fn rlGetFramebufferHeight() c_int; // Get default framebuffer height

pub extern fn rlGetTextureIdDefault() c_uint; // Get default texture id
pub extern fn rlGetShaderIdDefault() c_uint; // Get default shader id
pub extern fn rlGetShaderLocsDefault() [*c]c_int; // Get default shader locations

// Render batch management
// NOTE: rlgl provides a default render batch to behave like OpenGL 1.1 immediate mode
// but this render batch API is exposed in case of custom batches are required
pub extern fn rlLoadRenderBatch(numBuffers: c_int, bufferElements: c_int) rlRenderBatch; // Load a render batch system
pub extern fn rlUnloadRenderBatch(batch: rlRenderBatch) void; // Unload render batch system
pub extern fn rlDrawRenderBatch(batch: [*c]rlRenderBatch) void; // Draw render batch data (Update->Draw->Reset)
pub extern fn rlSetRenderBatchActive(batch: [*c]rlRenderBatch) void; // Set the active render batch for rlgl (NULL for default internal)
pub extern fn rlDrawRenderBatchActive() void; // Update and draw internal render batch
pub extern fn rlCheckRenderBatchLimit(vCount: c_int) bool; // Check internal buffer overflow for a given number of vertex

pub extern fn rlSetTexture(id: c_uint) void; // Set current texture for render batch and check buffers limits

//------------------------------------------------------------------------------------------------------------------------

// Vertex buffers management
pub extern fn rlLoadVertexArray() c_uint; // Load vertex array (vao) if supported
pub extern fn rlLoadVertexBuffer(buffer: ?*const anyopaque, size: c_int, dynamic: bool) c_uint; // Load a vertex buffer attribute
pub extern fn rlLoadVertexBufferElement(buffer: ?*const anyopaque, size: c_int, dynamic: bool) c_uint; // Load a new attributes element buffer
pub extern fn rlUpdateVertexBuffer(bufferId: c_uint, data: ?*const anyopaque, dataSize: c_int, offset: c_int) void; // Update GPU buffer with new data
pub extern fn rlUpdateVertexBufferElements(id: c_uint, data: ?*const anyopaque, dataSize: c_int, offset: c_int) void; // Update vertex buffer elements with new data
pub extern fn rlUnloadVertexArray(vaoId: c_uint) void;
pub extern fn rlUnloadVertexBuffer(vboId: c_uint) void;
pub extern fn rlSetVertexAttribute(index: c_uint, compSize: c_int, @"type": c_int, normalized: bool, stride: c_int, pointer: ?*const anyopaque) void;
pub extern fn rlSetVertexAttributeDivisor(index: c_uint, divisor: c_int) void;
pub extern fn rlSetVertexAttributeDefault(locIndex: c_int, value: ?*const anyopaque, attribType: c_int, count: c_int) void; // Set vertex attribute default value
pub extern fn rlDrawVertexArray(offset: c_int, count: c_int) void;
pub extern fn rlDrawVertexArrayElements(offset: c_int, count: c_int, buffer: ?*const anyopaque) void;
pub extern fn rlDrawVertexArrayInstanced(offset: c_int, count: c_int, instances: c_int) void;
pub extern fn rlDrawVertexArrayElementsInstanced(offset: c_int, count: c_int, buffer: ?*const anyopaque, instances: c_int) void;

// Textures management
pub extern fn rlLoadTexture(data: ?*const anyopaque, width: c_int, height: c_int, format: c_int, mipmapCount: c_int) c_uint; // Load texture in GPU
pub extern fn rlLoadTextureDepth(width: c_int, height: c_int, useRenderBuffer: bool) c_uint; // Load depth texture/renderbuffer (to be attached to fbo)
pub extern fn rlLoadTextureCubemap(data: ?*const anyopaque, size: c_int, format: c_int) c_uint; // Load texture cubemap
pub extern fn rlUpdateTexture(id: c_uint, offsetX: c_int, offsetY: c_int, width: c_int, height: c_int, format: c_int, data: ?*const anyopaque) void; // Update GPU texture with new data
pub extern fn rlGetGlTextureFormats(format: c_int, glInternalFormat: [*c]c_uint, glFormat: [*c]c_uint, glType: [*c]c_uint) void; // Get OpenGL internal formats
pub extern fn rlGetPixelFormatName(format: c_int) [*c]const u8; // Get name string for pixel format
pub extern fn rlUnloadTexture(id: c_uint) void; // Unload texture from GPU memory
pub extern fn rlGenTextureMipmaps(id: c_uint, width: c_int, height: c_int, format: c_int, mipmaps: [*c]c_int) void; // Generate mipmap data for selected texture
pub extern fn rlReadTexturePixels(id: c_uint, width: c_int, height: c_int, format: c_int) ?*anyopaque; // Read texture pixel data
pub extern fn rlReadScreenPixels(width: c_int, height: c_int) [*c]u8; // Read screen pixel data (color buffer)

// Framebuffer management (fbo)
pub extern fn rlLoadFramebuffer(width: c_int, height: c_int) c_uint; // Load an empty framebuffer
pub extern fn rlFramebufferAttach(fboId: c_uint, texId: c_uint, attachType: c_int, texType: c_int, mipLevel: c_int) void; // Attach texture/renderbuffer to a framebuffer
pub extern fn rlFramebufferComplete(id: c_uint) bool; // Verify framebuffer is complete
pub extern fn rlUnloadFramebuffer(id: c_uint) void; // Delete framebuffer from GPU

// Shaders management
pub extern fn rlLoadShaderCode(vsCode: [*c]const u8, fsCode: [*c]const u8) c_uint; // Load shader from code strings
pub extern fn rlCompileShader(shaderCode: [*c]const u8, @"type": c_int) c_uint; // Compile custom shader and return shader id (type: RL_VERTEX_SHADER, RL_FRAGMENT_SHADER, RL_COMPUTE_SHADER)
pub extern fn rlLoadShaderProgram(vShaderId: c_uint, fShaderId: c_uint) c_uint; // Load custom shader program
pub extern fn rlUnloadShaderProgram(id: c_uint) void; // Unload shader program
pub extern fn rlGetLocationUniform(shaderId: c_uint, uniformName: [*c]const u8) c_int; // Get shader location uniform
pub extern fn rlGetLocationAttrib(shaderId: c_uint, attribName: [*c]const u8) c_int; // Get shader location attribute
pub extern fn rlSetUniform(locIndex: c_int, value: ?*const anyopaque, uniformType: c_int, count: c_int) void; // Set shader value uniform
pub extern fn rlSetUniformMatrix(locIndex: c_int, mat: Matrix) void; // Set shader value matrix
pub extern fn rlSetUniformSampler(locIndex: c_int, textureId: c_uint) void; // Set shader value sampler
pub extern fn rlSetShader(id: c_uint, locs: [*c]c_int) void; // Set shader currently active (id and locations)

// Compute shader management
pub extern fn rlLoadComputeShaderProgram(shaderId: c_uint) c_uint; // Load compute shader program
pub extern fn rlComputeShaderDispatch(groupX: c_uint, groupY: c_uint, groupZ: c_uint) void; // Dispatch compute shader (equivalent to *draw* for graphics pipeline)

// Shader buffer storage object management (ssbo)
pub extern fn rlLoadShaderBuffer(size: c_uint, data: ?*const anyopaque, usageHint: c_int) c_uint; // Load shader storage buffer object (SSBO)
pub extern fn rlUnloadShaderBuffer(ssboId: c_uint) void; // Unload shader storage buffer object (SSBO)
pub extern fn rlUpdateShaderBuffer(id: c_uint, data: ?*const anyopaque, dataSize: c_uint, offset: c_uint) void; // Update SSBO buffer data
pub extern fn rlBindShaderBuffer(id: c_uint, index: c_uint) void; // Bind SSBO buffer
pub extern fn rlReadShaderBuffer(id: c_uint, dest: ?*anyopaque, count: c_uint, offset: c_uint) void; // Read SSBO buffer data (GPU->CPU)
pub extern fn rlCopyShaderBuffer(destId: c_uint, srcId: c_uint, destOffset: c_uint, srcOffset: c_uint, count: c_uint) void; // Copy SSBO data between buffers
pub extern fn rlGetShaderBufferSize(id: c_uint) c_uint; // Get SSBO buffer size

// Buffer management
pub extern fn rlBindImageTexture(id: c_uint, index: c_uint, format: c_int, readonly: bool) void; // Bind image texture

// Matrix state management
pub extern fn rlGetMatrixModelview() Matrix; // Get internal modelview matrix
pub extern fn rlGetMatrixProjection() Matrix; // Get internal projection matrix
pub extern fn rlGetMatrixTransform() Matrix; // Get internal accumulated transform matrix
pub extern fn rlGetMatrixProjectionStereo(eye: c_int) Matrix; // Get internal projection matrix for stereo render (selected eye)
pub extern fn rlGetMatrixViewOffsetStereo(eye: c_int) Matrix; // Get internal view offset matrix for stereo render (selected eye)
pub extern fn rlSetMatrixProjection(proj: Matrix) void; // Set a custom projection matrix (replaces internal projection matrix)
pub extern fn rlSetMatrixModelview(view: Matrix) void; // Set a custom modelview matrix (replaces internal modelview matrix)
pub extern fn rlSetMatrixProjectionStereo(right: Matrix, left: Matrix) void; // Set eyes projection matrices for stereo rendering
pub extern fn rlSetMatrixViewOffsetStereo(right: Matrix, left: Matrix) void; // Set eyes view offsets matrices for stereo rendering

// Quick and dirty cube/quad buffers load->draw->unload
pub extern fn rlLoadDrawCube() void; // Load and draw a cube
pub extern fn rlLoadDrawQuad() void; // Load and draw a quad
