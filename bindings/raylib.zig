const std = @import("std");

test {
    std.testing.refAllDeclsRecursive(@This());
}

// raylib.h file

pub const RAYLIB_VERSION_MAJOR = 5;
pub const RAYLIB_VERSION_MINOR = 0;
pub const RAYLIB_VERSION_PATCH = 0;
pub const RAYLIB_VERSION = "5.0";

// Some Basic Colors
// NOTE: Custom raylib color palette for amazing visuals on WHITE background
pub const LIGHTGRAY: Color = Color.init(200, 200, 200, 255); // Light Gray
pub const GRAY: Color = Color.init(130, 130, 130, 255); // Gray
pub const DARKGRAY: Color = Color.init(80, 80, 80, 255); // Dark Gray
pub const YELLOW: Color = Color.init(253, 249, 0, 255); // Yellow
pub const GOLD: Color = Color.init(255, 203, 0, 255); // Gold
pub const ORANGE: Color = Color.init(255, 161, 0, 255); // Orange
pub const PINK: Color = Color.init(255, 109, 194, 255); // Pink
pub const RED: Color = Color.init(230, 41, 55, 255); // Red
pub const MAROON: Color = Color.init(190, 33, 55, 255); // Maroon
pub const GREEN: Color = Color.init(0, 228, 48, 255); // Green
pub const LIME: Color = Color.init(0, 158, 47, 255); // Lime
pub const DARKGREEN: Color = Color.init(0, 117, 44, 255); // Dark Green
pub const SKYBLUE: Color = Color.init(102, 191, 255, 255); // Sky Blue
pub const BLUE: Color = Color.init(0, 121, 241, 255); // Blue
pub const DARKBLUE: Color = Color.init(0, 82, 172, 255); // Dark Blue
pub const PURPLE: Color = Color.init(200, 122, 255, 255); // Purple
pub const VIOLET: Color = Color.init(135, 60, 190, 255); // Violet
pub const DARKPURPLE: Color = Color.init(112, 31, 126, 255); // Dark Purple
pub const BEIGE: Color = Color.init(211, 176, 131, 255); // Beige
pub const BROWN: Color = Color.init(127, 106, 79, 255); // Brown
pub const DARKBROWN: Color = Color.init(76, 63, 47, 255); // Dark Brown

pub const WHITE: Color = Color.init(255, 255, 255, 255); // White
pub const BLACK: Color = Color.init(0, 0, 0, 255); // Black
pub const BLANK: Color = Color.init(0, 0, 0, 0); // Blank (Transparent)
pub const MAGENTA: Color = Color.init(255, 0, 255, 255); // Magenta
pub const RAYWHITE: Color = Color.init(245, 245, 245, 255); // Ray's White (raylib logo)

//----------------------------------------------------------------------------------
// Structures Definition
//----------------------------------------------------------------------------------

/// Vector2, 2 components
pub const Vector2 = extern struct {
    x: f32, // Vector x component
    y: f32, // Vector y component

    pub fn init(x: f32, y: f32) Vector2 {
        return Vector2{ .x = x, .y = y };
    }
};

/// Vector3, 3 components
pub const Vector3 = extern struct {
    x: f32, // Vector x component
    y: f32, // Vector y component
    z: f32, // Vector z component

    pub fn init(x: f32, y: f32, z: f32) Vector3 {
        return Vector3{ .x = x, .y = y, .z = z };
    }
};

/// Vector4, 4 components
pub const Vector4 = extern struct {
    x: f32, // Vector x component
    y: f32, // Vector y component
    z: f32, // Vector z component
    w: f32, // Vector w component

    pub fn init(x: f32, y: f32, z: f32, w: f32) Vector4 {
        return Vector4{ .x = x, .y = y, .z = z, .w = w };
    }
};

// Quaternion, 4 components (Vector4 alias)
pub const Quaternion = Vector4;

/// Matrix, 4x4 components, column major, OpenGL style, right handed
pub const Matrix = extern struct {
    m0: f32, // Matrix first row (4 components)
    m4: f32,
    m8: f32,
    m12: f32,
    m1: f32, // Matrix second row (4 components)
    m5: f32,
    m9: f32,
    m13: f32,
    m2: f32, // Matrix third row (4 components)
    m6: f32,
    m10: f32,
    m14: f32,
    m3: f32, // Matrix fourth row (4 components)
    m7: f32,
    m11: f32,
    m15: f32,

    pub fn init(m0: f32, m4: f32, m8: f32, m12: f32, m1: f32, m5: f32, m9: f32, m13: f32, m2: f32, m6: f32, m10: f32, m14: f32, m3: f32, m7: f32, m11: f32, m15: f32) Matrix {
        return Matrix{ .m0 = m0, .m4 = m4, .m8 = m8, .m12 = m12, .m1 = m1, .m5 = m5, .m9 = m9, .m13 = m13, .m2 = m2, .m6 = m6, .m10 = m10, .m14 = m14, .m3 = m3, .m7 = m7, .m11 = m11, .m15 = m15 };
    }
};

/// Color, 4 components, R8G8B8A8 (32bit)
pub const Color = extern struct {
    r: u8, // Color red value
    g: u8, // Color green value
    b: u8, // Color blue value
    a: u8, // Color alpha value

    pub fn init(r: u8, g: u8, b: u8, a: u8) Color {
        return Color{ .r = r, .g = g, .b = b, .a = a };
    }
};

/// Rectangle, 4 components
pub const Rectangle = extern struct {
    x: f32, // Rectangle top-left corner position x
    y: f32, // Rectangle top-left corner position y
    width: f32, // Rectangle width
    height: f32, // Rectangle height

    pub fn init(x: f32, y: f32, width: f32, height: f32) Rectangle {
        return Rectangle{ .x = x, .y = y, .width = width, .height = height };
    }
};

/// Image, pixel data stored in CPU memory (RAM)
pub const Image = extern struct {
    data: *anyopaque, // Image raw data
    width: c_int, // Image base width
    height: c_int, // Image base height
    mipmaps: c_int, // Mipmap levels, 1 by default
    format: c_int, // Data format (PixelFormat type) TODO: ENUM

    pub fn init(data: *anyopaque, width: c_int, height: c_int, mipmaps: c_int, format: c_int) Image {
        return Image{ .data = data, .width = width, .height = height, .mipmaps = mipmaps, .format = format };
    }
};

/// Texture, tex data stored in GPU memory (VRAM)
pub const Texture = extern struct {
    id: c_uint, // OpenGL texture id
    width: c_int, // Texture base width
    height: c_int, // Texture base height
    mipmaps: c_int, // Mipmap levels, 1 by default
    format: c_int, // Data format (PixelFormat type)  TODO: ENUM

    pub fn init(id: c_uint, width: c_int, height: c_int, mipmaps: c_int, format: c_int) Texture {
        return Texture{ .id = id, .width = width, .height = height, .mipmaps = mipmaps, .format = format };
    }
};
// Texture2D, same as Texture
pub const Texture2D = Texture;
// TextureCubemap, same as Texture
pub const TextureCubemap = Texture;

/// RenderTexture, fbo for texture rendering
pub const RenderTexture = extern struct {
    id: c_uint, // OpenGL framebuffer object id
    texture: Texture, // Color buffer attachment texture
    depth: Texture, // Depth buffer attachment texture

    pub fn init(id: c_uint, texture: Texture, depth: Texture) RenderTexture {
        return RenderTexture{ .id = id, .texture = texture, .depth = depth };
    }
};
// RenderTexture2D, same as RenderTexture
pub const RenderTexture2D = RenderTexture;

/// NPatchInfo, n-patch layout info
pub const NPatchInfo = extern struct {
    source: Rectangle, // Texture source rectangle
    left: c_int, // Left border offset
    top: c_int, // Top border offset
    right: c_int, // Right border offset
    bottom: c_int, // Bottom border offset
    layout: c_int, // Layout of the n-patch: 3x3, 1x3 or 3x1

    pub fn init(source: Rectangle, left: c_int, top: c_int, right: c_int, bottom: c_int, layout: c_int) NPatchInfo {
        return NPatchInfo{ .source = source, .left = left, .top = top, .right = right, .bottom = bottom, .layout = layout };
    }
};

/// GlyphInfo, font characters glyphs info
pub const GlyphInfo = extern struct {
    value: c_int, // Character value (Unicode)
    offsetX: c_int, // Character offset X when drawing
    offsetY: c_int, // Character offset Y when drawing
    advanceX: c_int, // Character advance position X
    image: Image, // Character image data

    pub fn init(value: c_int, offsetX: c_int, offsetY: c_int, advanceX: c_int, image: Image) GlyphInfo {
        return GlyphInfo{ .value = value, .offsetX = offsetX, .offsetY = offsetY, .advanceX = advanceX, .image = image };
    }
};

/// Font, font texture and GlyphInfo array data
pub const Font = extern struct {
    baseSize: c_int, // Base size (default chars height)
    glyphCount: c_int, // Number of glyph characters
    glyphPadding: c_int, // Padding around the glyph characters
    texture: Texture2D, // Texture atlas containing the glyphs
    recs: [*c]Rectangle, // Rectangles in texture for the glyphs
    glyphs: [*c]GlyphInfo, // Glyphs info data

    pub fn init(baseSize: c_int, glyphCount: c_int, glyphPadding: c_int, texture: Texture2D, recs: [*c]Rectangle, glyphs: [*c]GlyphInfo) Font {
        return Font{ .baseSize = baseSize, .glyphCount = glyphCount, .glyphPadding = glyphPadding, .texture = texture, .recs = recs, .glyphs = glyphs };
    }
};

/// Camera, defines position/orientation in 3d space
pub const Camera3D = extern struct {
    position: Vector3, // Camera position
    target: Vector3, // Camera target it looks-at
    up: Vector3, // Camera up vector (rotation over its axis)
    fovy: f32, // Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
    projection: c_int, // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC

    pub fn init(position: Vector3, target: Vector3, up: Vector3, fovy: f32, projection: c_int) Camera3D {
        return Camera3D{ .position = position, .target = target, .up = up, .fovy = fovy, .projection = projection };
    }
};

/// Camera type fallback, defaults to Camera3D
pub const Camera = Camera3D;

/// Camera2D, defines position/orientation in 2d space
pub const Camera2D = extern struct {
    offset: Vector2, // Camera offset (displacement from target)
    target: Vector2, // Camera target (rotation and zoom origin)
    rotation: f32, // Camera rotation in degrees
    zoom: f32, // Camera zoom (scaling), should be 1.0f by default

    pub fn init(offset: Vector2, target: Vector2, rotation: f32, zoom: f32) Camera2D {
        return Camera2D{ .offset = offset, .target = target, .rotation = rotation, .zoom = zoom };
    }
};

/// Mesh, vertex data and vao/vbo
pub const Mesh = extern struct {
    vertexCount: c_int, // Number of vertices stored in arrays
    triangleCount: c_int, // Number of triangles stored (indexed or not)

    // Vertex attributes data
    vertices: [*c]f32, // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    texcoords: [*c]f32, // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    texcoords2: [*c]f32, // Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
    normals: [*c]f32, // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    tangents: [*c]f32, // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    colors: [*c]u8, // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    indices: [*c]c_ushort, // Vertex indices (in case vertex data comes indexed)

    // Animation vertex data
    animVertices: [*c]f32, // Animated vertex positions (after bones transformations)
    animNormals: [*c]f32, // Animated normals (after bones transformations)
    boneIds: [*c]u8, // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
    boneWeights: [*c]f32, // Vertex bone weight, up to 4 bones influence by vertex (skinning)

    // OpenGL identifiers
    vaoId: c_uint, // OpenGL Vertex Array Object id
    vboId: [*c]c_uint, // OpenGL Vertex Buffer Objects id (default vertex data)

    pub fn init(vertexCount: c_int, triangleCount: c_int, vertices: [*c]f32, texcoords: [*c]f32, texcoords2: [*c]f32, normals: [*c]f32, tangents: [*c]f32, colors: [*c]u8, indices: [*c]c_ushort, animVertices: [*c]f32, animNormals: [*c]f32, boneIds: [*c]u8, boneWeights: [*c]f32, vaoId: c_uint, vboId: [*c]c_uint) Mesh {
        return Mesh{ .vertexCount = vertexCount, .triangleCount = triangleCount, .vertices = vertices, .texcoords = texcoords, .texcoords2 = texcoords2, .normals = normals, .tangents = tangents, .colors = colors, .indices = indices, .animVertices = animVertices, .animNormals = animNormals, .boneIds = boneIds, .boneWeights = boneWeights, .vaoId = vaoId, .vboId = vboId };
    }
};

/// Shader
pub const Shader = extern struct {
    id: c_uint, // Shader program id
    locs: [*c]c_int, // Shader locations array (RL_MAX_SHADER_LOCATIONS)

    pub fn init(id: c_uint, locs: [*c]c_int) Shader {
        return Shader{ .id = id, .locs = locs };
    }
};

/// MaterialMap
pub const MaterialMap = extern struct {
    texture: Texture2D, // Material map texture
    color: Color, // Material map color
    value: f32, // Material map value

    pub fn init(texture: Texture2D, color: Color, value: f32) MaterialMap {
        return MaterialMap{ .texture = texture, .color = color, .value = value };
    }
};

/// Material, includes shader and maps
pub const Material = extern struct {
    shader: Shader, // Material shader
    maps: [*c]MaterialMap, // Material maps array (MAX_MATERIAL_MAPS)
    params: [4]f32, // Material generic parameters (if required)

    pub fn init(shader: Shader, maps: [*c]MaterialMap, params: [4]f32) Material {
        return Material{ .shader = shader, .maps = maps, .params = params };
    }
};

/// Transform, vertex transformation data
pub const Transform = extern struct {
    translation: Vector3, // Translation
    rotation: Quaternion, // Rotation
    scale: Vector3, // Scale

    pub fn init(translation: Vector3, rotation: Quaternion, scale: Vector3) Transform {
        return Transform{ .translation = translation, .rotation = rotation, .scale = scale };
    }
};

/// Bone, skeletal animation bone
pub const BoneInfo = extern struct {
    name: [32]u8, // Bone name
    parent: c_int, // Bone parent

    pub fn init(name: [32]u8, parent: c_int) BoneInfo {
        return BoneInfo{ .name = name, .parent = parent };
    }
};

/// Model, meshes, materials and animation data
pub const Model = extern struct {
    transform: Matrix, // Local transform matrix

    meshCount: c_int, // Number of meshes
    materialCount: c_int, // Number of materials
    meshes: [*c]Mesh, // Meshes array
    materials: [*c]Material, // Materials array
    meshMaterial: [*c]c_int, // Mesh material number

    // Animation data
    boneCount: c_int, // Number of bones
    bones: [*c]BoneInfo, // Bones information (skeleton)
    bindPose: [*c]Transform, // Bones base transformation (pose)

    pub fn init(transform: Matrix, meshCount: c_int, materialCount: c_int, meshes: [*c]Mesh, materials: [*c]Material, meshMaterial: [*c]c_int, boneCount: c_int, bones: [*c]BoneInfo, bindPose: [*c]Transform) Model {
        return Model{ .transform = transform, .meshCount = meshCount, .materialCount = materialCount, .meshes = meshes, .materials = materials, .meshMaterial = meshMaterial, .boneCount = boneCount, .bones = bones, .bindPose = bindPose };
    }
};

/// ModelAnimation
pub const ModelAnimation = extern struct {
    boneCount: c_int, // Number of bones
    frameCount: c_int, // Number of animation frames
    bones: [*c]BoneInfo, // Bones information (skeleton)
    framePoses: [*c][*c]Transform, // Poses array by frame
    name: [32]u8, // Animation name

    pub fn init(boneCount: c_int, frameCount: c_int, bones: [*c]BoneInfo, framePoses: [*c][*c]Transform, name: [32]u8) ModelAnimation {
        return ModelAnimation{ .boneCount = boneCount, .frameCount = frameCount, .bones = bones, .framePoses = framePoses, .name = name };
    }
};

/// Ray, ray for raycasting
pub const Ray = extern struct {
    position: Vector3, // Ray position (origin)
    direction: Vector3, // Ray direction

    pub fn init(position: Vector3, direction: Vector3) Ray {
        return Ray{ .position = position, .direction = direction };
    }
};

/// RayCollision, ray hit information
pub const RayCollision = extern struct {
    hit: bool, // Did the ray hit something?
    distance: f32, // Distance to the nearest hit
    point: Vector3, // Point of the nearest hit
    normal: Vector3, // Surface normal of hit

    pub fn init(hit: bool, distance: f32, point: Vector3, normal: Vector3) RayCollision {
        return RayCollision{ .hit = hit, .distance = distance, .point = point, .normal = normal };
    }
};

/// BoundingBox
pub const BoundingBox = extern struct {
    min: Vector3, // Minimum vertex box-corner
    max: Vector3, // Maximum vertex box-corner

    pub fn init(min: Vector3, max: Vector3) BoundingBox {
        return BoundingBox{ .min = min, .max = max };
    }
};

/// Wave, audio wave data
pub const Wave = extern struct {
    frameCount: c_uint, // Total number of frames (considering channels)
    sampleRate: c_uint, // Frequency (samples per second)
    sampleSize: c_uint, // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    channels: c_uint, // Number of channels (1-mono, 2-stereo, ...)
    data: *anyopaque, // Buffer data pointer

    pub fn init(frameCount: c_uint, sampleRate: c_uint, sampleSize: c_uint, channels: c_uint, data: *anyopaque) Wave {
        return Wave{ .frameCount = frameCount, .sampleRate = sampleRate, .sampleSize = sampleSize, .channels = channels, .data = data };
    }
};

// Opaque structs declaration
// NOTE: Actual structs are defined internally in raudio module
pub const rAudioBuffer = opaque {};
pub const rAudioProcessor = opaque {};

/// AudioStream, custom audio stream
pub const AudioStream = extern struct {
    buffer: *rAudioBuffer, // Pointer to internal data used by the audio system
    processor: *rAudioProcessor, // Pointer to internal data processor, useful for audio effects

    sampleRate: c_uint, // Frequency (samples per second)
    sampleSize: c_uint, // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    channels: c_uint, // Number of channels (1-mono, 2-stereo, ...)

    pub fn init(buffer: *rAudioBuffer, processor: *rAudioProcessor, sampleRate: c_uint, sampleSize: c_uint, channels: c_uint) AudioStream {
        return AudioStream{ .buffer = buffer, .processor = processor, .sampleRate = sampleRate, .sampleSize = sampleSize, .channels = channels };
    }
};

/// Sound
pub const Sound = extern struct {
    stream: AudioStream, // Audio stream
    frameCount: c_uint, // Total number of frames (considering channels)

    pub fn init(stream: AudioStream, frameCount: c_uint) Sound {
        return Sound{ .stream = stream, .frameCount = frameCount };
    }
};

/// Music, audio stream, anything longer than ~10 seconds should be streamed
pub const Music = extern struct {
    stream: AudioStream, // Audio stream
    frameCount: c_uint, // Total number of frames (considering channels)
    looping: bool, // Music looping enable

    ctxType: c_int, // Type of music context (audio filetype)
    ctxData: *anyopaque, // Audio context data, depends on type

    pub fn init(stream: AudioStream, frameCount: c_uint, looping: bool, ctxType: c_int, ctxData: *anyopaque) Music {
        return Music{ .stream = stream, .frameCount = frameCount, .looping = looping, .ctxType = ctxType, .ctxData = ctxData };
    }
};

/// VrDeviceInfo, Head-Mounted-Display device parameters
pub const VrDeviceInfo = extern struct {
    hResolution: c_int, // Horizontal resolution in pixels
    vResolution: c_int, // Vertical resolution in pixels
    hScreenSize: f32, // Horizontal size in meters
    vScreenSize: f32, // Vertical size in meters
    eyeToScreenDistance: f32, // Distance between eye and display in meters
    lensSeparationDistance: f32, // Lens separation distance in meters
    interpupillaryDistance: f32, // IPD (distance between pupils) in meters
    lensDistortionValues: [4]f32, // Lens distortion constant parameters
    chromaAbCorrection: [4]f32, // Chromatic aberration correction parameters

    pub fn init(hResolution: c_int, vResolution: c_int, hScreenSize: f32, vScreenSize: f32, eyeToScreenDistance: f32, lensSeparationDistance: f32, interpupillaryDistance: f32, lensDistortionValues: [4]f32, chromaAbCorrection: [4]f32) VrDeviceInfo {
        return VrDeviceInfo{ .hResolution = hResolution, .vResolution = vResolution, .hScreenSize = hScreenSize, .vScreenSize = vScreenSize, .eyeToScreenDistance = eyeToScreenDistance, .lensSeparationDistance = lensSeparationDistance, .interpupillaryDistance = interpupillaryDistance, .lensDistortionValues = lensDistortionValues, .chromaAbCorrection = chromaAbCorrection };
    }
};

/// VrStereoConfig, VR stereo rendering configuration for simulator
pub const VrStereoConfig = extern struct {
    projection: [2]Matrix, // VR projection matrices (per eye)
    viewOffset: [2]Matrix, // VR view offset matrices (per eye)
    leftLensCenter: [2]f32, // VR left lens center
    rightLensCenter: [2]f32, // VR right lens center
    leftScreenCenter: [2]f32, // VR left screen center
    rightScreenCenter: [2]f32, // VR right screen center
    scale: [2]f32, // VR distortion scale
    scaleIn: [2]f32, // VR distortion scale in

    pub fn init(projection: [2]Matrix, viewOffset: [2]Matrix, leftLensCenter: [2]f32, rightLensCenter: [2]f32, leftScreenCenter: [2]f32, rightScreenCenter: [2]f32, scale: [2]f32, scaleIn: [2]f32) VrStereoConfig {
        return VrStereoConfig{ .projection = projection, .viewOffset = viewOffset, .leftLensCenter = leftLensCenter, .rightLensCenter = rightLensCenter, .leftScreenCenter = leftScreenCenter, .rightScreenCenter = rightScreenCenter, .scale = scale, .scaleIn = scaleIn };
    }
};

/// File path list
pub const FilePathList = extern struct {
    capacity: c_uint, // Filepaths max entries
    count: c_uint, // Filepaths entries count
    paths: [*c][*c]u8, // Filepaths entries

    pub fn init(capacity: c_uint, count: c_uint, paths: [*c][*c]u8) FilePathList {
        return FilePathList{ .capacity = capacity, .count = count, .paths = paths };
    }
};

/// Automation event
pub const AutomationEvent = extern struct {
    frame: c_uint, // Event frame
    type: c_uint, // Event type (AutomationEventType)
    params: [4]c_int, // Event parameters (if required)

    pub fn init(frame: c_uint, type_: c_uint, params: [4]c_int) AutomationEvent {
        return AutomationEvent{ .frame = frame, .type = type_, .params = params };
    }
};

/// Automation event list
pub const AutomationEventList = extern struct {
    capacity: c_uint, // Events max entries (MAX_AUTOMATION_EVENTS)
    count: c_uint, // Events entries count
    events: [*c]AutomationEvent, // Events entries

    pub fn init(capacity: c_uint, count: c_uint, events: [*c]AutomationEvent) AutomationEventList {
        return AutomationEventList{ .capacity = capacity, .count = count, .events = events };
    }
};

//----------------------------------------------------------------------------------
// Enumerators Definition
//----------------------------------------------------------------------------------

// System/Window config flags
// NOTE: Every bit registers one state (use it with bit masks)
// By default all flags are set to 0
pub const ConfigFlags = enum(c_int) {
    FLAG_VSYNC_HINT = 0x00000040, // Set to try enabling V-Sync on GPU
    FLAG_FULLSCREEN_MODE = 0x00000002, // Set to run program in fullscreen
    FLAG_WINDOW_RESIZABLE = 0x00000004, // Set to allow resizable window
    FLAG_WINDOW_UNDECORATED = 0x00000008, // Set to disable window decoration (frame and buttons)
    FLAG_WINDOW_HIDDEN = 0x00000080, // Set to hide window
    FLAG_WINDOW_MINIMIZED = 0x00000200, // Set to minimize window (iconify)
    FLAG_WINDOW_MAXIMIZED = 0x00000400, // Set to maximize window (expanded to monitor)
    FLAG_WINDOW_UNFOCUSED = 0x00000800, // Set to window non focused
    FLAG_WINDOW_TOPMOST = 0x00001000, // Set to window always on top
    FLAG_WINDOW_ALWAYS_RUN = 0x00000100, // Set to allow windows running while minimized
    FLAG_WINDOW_TRANSPARENT = 0x00000010, // Set to allow transparent framebuffer
    FLAG_WINDOW_HIGHDPI = 0x00002000, // Set to support HighDPI
    FLAG_WINDOW_MOUSE_PASSTHROUGH = 0x00004000, // Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
    FLAG_BORDERLESS_WINDOWED_MODE = 0x00008000, // Set to run program in borderless windowed mode
    FLAG_MSAA_4X_HINT = 0x00000020, // Set to try enabling MSAA 4X
    FLAG_INTERLACED_HINT = 0x00010000, // Set to try enabling interlaced video format (for V3D)

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};
// Trace log level
// NOTE: Organized by priority level
pub const TraceLogLevel = enum(c_int) {
    LOG_ALL = 0, // Display all logs
    LOG_TRACE, // Trace logging, intended for internal use only
    LOG_DEBUG, // Debug logging, used for internal debugging, it should be disabled on release builds
    LOG_INFO, // Info logging, used for program execution info
    LOG_WARNING, // Warning logging, used on recoverable failures
    LOG_ERROR, // Error logging, used on unrecoverable failures
    LOG_FATAL, // Fatal logging, used to abort program: exit(EXIT_FAILURE)
    LOG_NONE, // Disable logging

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Keyboard keys (US keyboard layout)
// NOTE: Use GetKeyPressed() to allow redefining
// required keys for alternative layouts
pub const KeyboardKey = enum(c_int) {
    KEY_NULL = 0, // Key: NULL, used for no key pressed
    // Alphanumeric keys
    KEY_APOSTROPHE = 39, // Key: '
    KEY_COMMA = 44, // Key: ,
    KEY_MINUS = 45, // Key: -
    KEY_PERIOD = 46, // Key: .
    KEY_SLASH = 47, // Key: /
    KEY_ZERO = 48, // Key: 0
    KEY_ONE = 49, // Key: 1
    KEY_TWO = 50, // Key: 2
    KEY_THREE = 51, // Key: 3
    KEY_FOUR = 52, // Key: 4
    KEY_FIVE = 53, // Key: 5
    KEY_SIX = 54, // Key: 6
    KEY_SEVEN = 55, // Key: 7
    KEY_EIGHT = 56, // Key: 8
    KEY_NINE = 57, // Key: 9
    KEY_SEMICOLON = 59, // Key: ;
    KEY_EQUAL = 61, // Key: =
    KEY_A = 65, // Key: A | a
    KEY_B = 66, // Key: B | b
    KEY_C = 67, // Key: C | c
    KEY_D = 68, // Key: D | d
    KEY_E = 69, // Key: E | e
    KEY_F = 70, // Key: F | f
    KEY_G = 71, // Key: G | g
    KEY_H = 72, // Key: H | h
    KEY_I = 73, // Key: I | i
    KEY_J = 74, // Key: J | j
    KEY_K = 75, // Key: K | k
    KEY_L = 76, // Key: L | l
    KEY_M = 77, // Key: M | m
    KEY_N = 78, // Key: N | n
    KEY_O = 79, // Key: O | o
    KEY_P = 80, // Key: P | p
    KEY_Q = 81, // Key: Q | q
    KEY_R = 82, // Key: R | r
    KEY_S = 83, // Key: S | s
    KEY_T = 84, // Key: T | t
    KEY_U = 85, // Key: U | u
    KEY_V = 86, // Key: V | v
    KEY_W = 87, // Key: W | w
    KEY_X = 88, // Key: X | x
    KEY_Y = 89, // Key: Y | y
    KEY_Z = 90, // Key: Z | z
    KEY_LEFT_BRACKET = 91, // Key: [
    KEY_BACKSLASH = 92, // Key: '\'
    KEY_RIGHT_BRACKET = 93, // Key: ]
    KEY_GRAVE = 96, // Key: `
    // Function keys
    KEY_SPACE = 32, // Key: Space
    KEY_ESCAPE = 256, // Key: Esc
    KEY_ENTER = 257, // Key: Enter
    KEY_TAB = 258, // Key: Tab
    KEY_BACKSPACE = 259, // Key: Backspace
    KEY_INSERT = 260, // Key: Ins
    KEY_DELETE = 261, // Key: Del
    KEY_RIGHT = 262, // Key: Cursor right
    KEY_LEFT = 263, // Key: Cursor left
    KEY_DOWN = 264, // Key: Cursor down
    KEY_UP = 265, // Key: Cursor up
    KEY_PAGE_UP = 266, // Key: Page up
    KEY_PAGE_DOWN = 267, // Key: Page down
    KEY_HOME = 268, // Key: Home
    KEY_END = 269, // Key: End
    KEY_CAPS_LOCK = 280, // Key: Caps lock
    KEY_SCROLL_LOCK = 281, // Key: Scroll down
    KEY_NUM_LOCK = 282, // Key: Num lock
    KEY_PRINT_SCREEN = 283, // Key: Print screen
    KEY_PAUSE = 284, // Key: Pause
    KEY_F1 = 290, // Key: F1
    KEY_F2 = 291, // Key: F2
    KEY_F3 = 292, // Key: F3
    KEY_F4 = 293, // Key: F4
    KEY_F5 = 294, // Key: F5
    KEY_F6 = 295, // Key: F6
    KEY_F7 = 296, // Key: F7
    KEY_F8 = 297, // Key: F8
    KEY_F9 = 298, // Key: F9
    KEY_F10 = 299, // Key: F10
    KEY_F11 = 300, // Key: F11
    KEY_F12 = 301, // Key: F12
    KEY_LEFT_SHIFT = 340, // Key: Shift left
    KEY_LEFT_CONTROL = 341, // Key: Control left
    KEY_LEFT_ALT = 342, // Key: Alt left
    KEY_LEFT_SUPER = 343, // Key: Super left
    KEY_RIGHT_SHIFT = 344, // Key: Shift right
    KEY_RIGHT_CONTROL = 345, // Key: Control right
    KEY_RIGHT_ALT = 346, // Key: Alt right
    KEY_RIGHT_SUPER = 347, // Key: Super right
    KEY_KB_MENU = 348, // Key: KB menu
    // Keypad keys
    KEY_KP_0 = 320, // Key: Keypad 0
    KEY_KP_1 = 321, // Key: Keypad 1
    KEY_KP_2 = 322, // Key: Keypad 2
    KEY_KP_3 = 323, // Key: Keypad 3
    KEY_KP_4 = 324, // Key: Keypad 4
    KEY_KP_5 = 325, // Key: Keypad 5
    KEY_KP_6 = 326, // Key: Keypad 6
    KEY_KP_7 = 327, // Key: Keypad 7
    KEY_KP_8 = 328, // Key: Keypad 8
    KEY_KP_9 = 329, // Key: Keypad 9
    KEY_KP_DECIMAL = 330, // Key: Keypad .
    KEY_KP_DIVIDE = 331, // Key: Keypad /
    KEY_KP_MULTIPLY = 332, // Key: Keypad *
    KEY_KP_SUBTRACT = 333, // Key: Keypad -
    KEY_KP_ADD = 334, // Key: Keypad +
    KEY_KP_ENTER = 335, // Key: Keypad Enter
    KEY_KP_EQUAL = 336, // Key: Keypad =
    // Android key buttons
    KEY_BACK = 4, // Key: Android back button
    KEY_MENU = 5, // Key: Android menu button
    KEY_VOLUME_UP = 24, // Key: Android volume up button
    KEY_VOLUME_DOWN = 25, // Key: Android volume down button

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Mouse buttons
pub const MouseButton = enum(c_int) {
    MOUSE_BUTTON_LEFT = 0, // Mouse button left
    MOUSE_BUTTON_RIGHT = 1, // Mouse button right
    MOUSE_BUTTON_MIDDLE = 2, // Mouse button middle (pressed wheel)
    MOUSE_BUTTON_SIDE = 3, // Mouse button side (advanced mouse device)
    MOUSE_BUTTON_EXTRA = 4, // Mouse button extra (advanced mouse device)
    MOUSE_BUTTON_FORWARD = 5, // Mouse button forward (advanced mouse device)
    MOUSE_BUTTON_BACK = 6, // Mouse button back (advanced mouse device)

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Add backwards compatibility support for deprecated names
pub const MOUSE_LEFT_BUTTON = MouseButton.MOUSE_BUTTON_LEFT;
pub const MOUSE_RIGHT_BUTTON = MouseButton.MOUSE_BUTTON_RIGHT;
pub const MOUSE_MIDDLE_BUTTON = MouseButton.MOUSE_BUTTON_MIDDLE;

// Mouse cursor
pub const MouseCursor = enum(c_int) {
    MOUSE_CURSOR_DEFAULT = 0, // Default pointer shape
    MOUSE_CURSOR_ARROW = 1, // Arrow shape
    MOUSE_CURSOR_IBEAM = 2, // Text writing cursor shape
    MOUSE_CURSOR_CROSSHAIR = 3, // Cross shape
    MOUSE_CURSOR_POINTING_HAND = 4, // Pointing hand cursor
    MOUSE_CURSOR_RESIZE_EW = 5, // Horizontal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NS = 6, // Vertical resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NWSE = 7, // Top-left to bottom-right diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NESW = 8, // The top-right to bottom-left diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_ALL = 9, // The omnidirectional resize/move cursor shape
    MOUSE_CURSOR_NOT_ALLOWED = 10, // The operation-not-allowed shape

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Gamepad buttons
pub const GamepadButton = enum(c_int) {
    GAMEPAD_BUTTON_UNKNOWN = 0, // Unknown button, just for error checking
    GAMEPAD_BUTTON_LEFT_FACE_UP, // Gamepad left DPAD up button
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT, // Gamepad left DPAD right button
    GAMEPAD_BUTTON_LEFT_FACE_DOWN, // Gamepad left DPAD down button
    GAMEPAD_BUTTON_LEFT_FACE_LEFT, // Gamepad left DPAD left button
    GAMEPAD_BUTTON_RIGHT_FACE_UP, // Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT, // Gamepad right button right (i.e. PS3: Circle, Xbox: B)
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN, // Gamepad right button down (i.e. PS3: Cross, Xbox: A)
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT, // Gamepad right button left (i.e. PS3: Square, Xbox: X)
    GAMEPAD_BUTTON_LEFT_TRIGGER_1, // Gamepad top/back trigger left (first), it could be a trailing button
    GAMEPAD_BUTTON_LEFT_TRIGGER_2, // Gamepad top/back trigger left (second), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1, // Gamepad top/back trigger right (first), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2, // Gamepad top/back trigger right (second), it could be a trailing button
    GAMEPAD_BUTTON_MIDDLE_LEFT, // Gamepad center buttons, left one (i.e. PS3: Select)
    GAMEPAD_BUTTON_MIDDLE, // Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
    GAMEPAD_BUTTON_MIDDLE_RIGHT, // Gamepad center buttons, right one (i.e. PS3: Start)
    GAMEPAD_BUTTON_LEFT_THUMB, // Gamepad joystick pressed button left
    GAMEPAD_BUTTON_RIGHT_THUMB, // Gamepad joystick pressed button right

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Gamepad axis
pub const GamepadAxis = enum(c_int) {
    GAMEPAD_AXIS_LEFT_X = 0, // Gamepad left stick X axis
    GAMEPAD_AXIS_LEFT_Y = 1, // Gamepad left stick Y axis
    GAMEPAD_AXIS_RIGHT_X = 2, // Gamepad right stick X axis
    GAMEPAD_AXIS_RIGHT_Y = 3, // Gamepad right stick Y axis
    GAMEPAD_AXIS_LEFT_TRIGGER = 4, // Gamepad back trigger left, pressure level: [1..-1]
    GAMEPAD_AXIS_RIGHT_TRIGGER = 5, // Gamepad back trigger right, pressure level: [1..-1]

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Material map index
pub const MaterialMapIndex = enum(c_int) {
    MATERIAL_MAP_ALBEDO = 0, // Albedo material (same as: MATERIAL_MAP_DIFFUSE)
    MATERIAL_MAP_METALNESS, // Metalness material (same as: MATERIAL_MAP_SPECULAR)
    MATERIAL_MAP_NORMAL, // Normal material
    MATERIAL_MAP_ROUGHNESS, // Roughness material
    MATERIAL_MAP_OCCLUSION, // Ambient occlusion material
    MATERIAL_MAP_EMISSION, // Emission material
    MATERIAL_MAP_HEIGHT, // Heightmap material
    MATERIAL_MAP_CUBEMAP, // Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_IRRADIANCE, // Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_PREFILTER, // Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_BRDF, // Brdf material

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

pub const MATERIAL_MAP_DIFFUSE = MaterialMapIndex.MATERIAL_MAP_ALBEDO;
pub const MATERIAL_MAP_SPECULAR = MaterialMapIndex.MATERIAL_MAP_METALNESS;

// Shader location index
pub const ShaderLocationIndex = enum(c_int) {
    SHADER_LOC_VERTEX_POSITION = 0, // Shader location: vertex attribute: position
    SHADER_LOC_VERTEX_TEXCOORD01, // Shader location: vertex attribute: texcoord01
    SHADER_LOC_VERTEX_TEXCOORD02, // Shader location: vertex attribute: texcoord02
    SHADER_LOC_VERTEX_NORMAL, // Shader location: vertex attribute: normal
    SHADER_LOC_VERTEX_TANGENT, // Shader location: vertex attribute: tangent
    SHADER_LOC_VERTEX_COLOR, // Shader location: vertex attribute: color
    SHADER_LOC_MATRIX_MVP, // Shader location: matrix uniform: model-view-projection
    SHADER_LOC_MATRIX_VIEW, // Shader location: matrix uniform: view (camera transform)
    SHADER_LOC_MATRIX_PROJECTION, // Shader location: matrix uniform: projection
    SHADER_LOC_MATRIX_MODEL, // Shader location: matrix uniform: model (transform)
    SHADER_LOC_MATRIX_NORMAL, // Shader location: matrix uniform: normal
    SHADER_LOC_VECTOR_VIEW, // Shader location: vector uniform: view
    SHADER_LOC_COLOR_DIFFUSE, // Shader location: vector uniform: diffuse color
    SHADER_LOC_COLOR_SPECULAR, // Shader location: vector uniform: specular color
    SHADER_LOC_COLOR_AMBIENT, // Shader location: vector uniform: ambient color
    SHADER_LOC_MAP_ALBEDO, // Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
    SHADER_LOC_MAP_METALNESS, // Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
    SHADER_LOC_MAP_NORMAL, // Shader location: sampler2d texture: normal
    SHADER_LOC_MAP_ROUGHNESS, // Shader location: sampler2d texture: roughness
    SHADER_LOC_MAP_OCCLUSION, // Shader location: sampler2d texture: occlusion
    SHADER_LOC_MAP_EMISSION, // Shader location: sampler2d texture: emission
    SHADER_LOC_MAP_HEIGHT, // Shader location: sampler2d texture: height
    SHADER_LOC_MAP_CUBEMAP, // Shader location: samplerCube texture: cubemap
    SHADER_LOC_MAP_IRRADIANCE, // Shader location: samplerCube texture: irradiance
    SHADER_LOC_MAP_PREFILTER, // Shader location: samplerCube texture: prefilter
    SHADER_LOC_MAP_BRDF, // Shader location: sampler2d texture: brdf

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

pub const SHADER_LOC_MAP_DIFFUSE = ShaderLocationIndex.SHADER_LOC_MAP_ALBEDO;
pub const SHADER_LOC_MAP_SPECULAR = ShaderLocationIndex.SHADER_LOC_MAP_METALNESS;

// Shader uniform data type
pub const ShaderUniformDataType = enum(c_int) {
    SHADER_UNIFORM_FLOAT = 0, // Shader uniform type: float
    SHADER_UNIFORM_VEC2, // Shader uniform type: vec2 (2 float)
    SHADER_UNIFORM_VEC3, // Shader uniform type: vec3 (3 float)
    SHADER_UNIFORM_VEC4, // Shader uniform type: vec4 (4 float)
    SHADER_UNIFORM_INT, // Shader uniform type: int
    SHADER_UNIFORM_IVEC2, // Shader uniform type: ivec2 (2 int)
    SHADER_UNIFORM_IVEC3, // Shader uniform type: ivec3 (3 int)
    SHADER_UNIFORM_IVEC4, // Shader uniform type: ivec4 (4 int)
    SHADER_UNIFORM_SAMPLER2D, // Shader uniform type: sampler2d

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Shader attribute data types
pub const ShaderAttributeDataType = enum(c_int) {
    SHADER_ATTRIB_FLOAT = 0, // Shader attribute type: float
    SHADER_ATTRIB_VEC2, // Shader attribute type: vec2 (2 float)
    SHADER_ATTRIB_VEC3, // Shader attribute type: vec3 (3 float)
    SHADER_ATTRIB_VEC4, // Shader attribute type: vec4 (4 float)

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Pixel formats
// NOTE: Support depends on OpenGL version and platform
pub const PixelFormat = enum(c_int) {
    PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1, // 8 bit per pixel (no alpha)
    PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA, // 8*2 bpp (2 channels)
    PIXELFORMAT_UNCOMPRESSED_R5G6B5, // 16 bpp
    PIXELFORMAT_UNCOMPRESSED_R8G8B8, // 24 bpp
    PIXELFORMAT_UNCOMPRESSED_R5G5B5A1, // 16 bpp (1 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R4G4B4A4, // 16 bpp (4 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R8G8B8A8, // 32 bpp
    PIXELFORMAT_UNCOMPRESSED_R32, // 32 bpp (1 channel - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32, // 32*3 bpp (3 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32A32, // 32*4 bpp (4 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R16, // 16 bpp (1 channel - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16, // 16*3 bpp (3 channels - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16A16, // 16*4 bpp (4 channels - half float)
    PIXELFORMAT_COMPRESSED_DXT1_RGB, // 4 bpp (no alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGBA, // 4 bpp (1 bit alpha)
    PIXELFORMAT_COMPRESSED_DXT3_RGBA, // 8 bpp
    PIXELFORMAT_COMPRESSED_DXT5_RGBA, // 8 bpp
    PIXELFORMAT_COMPRESSED_ETC1_RGB, // 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_RGB, // 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA, // 8 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGB, // 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGBA, // 4 bpp
    PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA, // 8 bpp
    PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA, // 2 bpp

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
pub const TextureFilter = enum(c_int) {
    TEXTURE_FILTER_POINT = 0, // No filter, just pixel approximation
    TEXTURE_FILTER_BILINEAR, // Linear filtering
    TEXTURE_FILTER_TRILINEAR, // Trilinear filtering (linear with mipmaps)
    TEXTURE_FILTER_ANISOTROPIC_4X, // Anisotropic filtering 4x
    TEXTURE_FILTER_ANISOTROPIC_8X, // Anisotropic filtering 8x
    TEXTURE_FILTER_ANISOTROPIC_16X, // Anisotropic filtering 16x

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Texture parameters: wrap mode
pub const TextureWrap = enum(c_int) {
    TEXTURE_WRAP_REPEAT = 0, // Repeats texture in tiled mode
    TEXTURE_WRAP_CLAMP, // Clamps texture to edge pixel in tiled mode
    TEXTURE_WRAP_MIRROR_REPEAT, // Mirrors and repeats the texture in tiled mode
    TEXTURE_WRAP_MIRROR_CLAMP, // Mirrors and clamps to border the texture in tiled mode

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Cubemap layouts
pub const CubemapLayout = enum(c_int) {
    CUBEMAP_LAYOUT_AUTO_DETECT = 0, // Automatically detect layout type
    CUBEMAP_LAYOUT_LINE_VERTICAL, // Layout is defined by a vertical line with faces
    CUBEMAP_LAYOUT_LINE_HORIZONTAL, // Layout is defined by a horizontal line with faces
    CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR, // Layout is defined by a 3x4 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE, // Layout is defined by a 4x3 cross with cubemap faces
    CUBEMAP_LAYOUT_PANORAMA, // Layout is defined by a panorama image (equirrectangular map)

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Font type, defines generation method
pub const FontType = enum(c_int) {
    FONT_DEFAULT = 0, // Default font generation, anti-aliased
    FONT_BITMAP, // Bitmap font generation, no anti-aliasing
    FONT_SDF, // SDF font generation, requires external shader

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Color blending modes (pre-defined)
pub const BlendMode = enum(c_int) {
    BLEND_ALPHA = 0, // Blend textures considering alpha (default)
    BLEND_ADDITIVE, // Blend textures adding colors
    BLEND_MULTIPLIED, // Blend textures multiplying colors
    BLEND_ADD_COLORS, // Blend textures adding colors (alternative)
    BLEND_SUBTRACT_COLORS, // Blend textures subtracting colors (alternative)
    BLEND_ALPHA_PREMULTIPLY, // Blend premultiplied textures considering alpha
    BLEND_CUSTOM, // Blend textures using custom src/dst factors (use rlSetBlendFactors())
    BLEND_CUSTOM_SEPARATE, // Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate())

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Gesture
// NOTE: Provided as bit-wise flags to enable only desired gestures
pub const Gesture = enum(c_int) {
    GESTURE_NONE = 0, // No gesture
    GESTURE_TAP = 1, // Tap gesture
    GESTURE_DOUBLETAP = 2, // Double tap gesture
    GESTURE_HOLD = 4, // Hold gesture
    GESTURE_DRAG = 8, // Drag gesture
    GESTURE_SWIPE_RIGHT = 16, // Swipe right gesture
    GESTURE_SWIPE_LEFT = 32, // Swipe left gesture
    GESTURE_SWIPE_UP = 64, // Swipe up gesture
    GESTURE_SWIPE_DOWN = 128, // Swipe down gesture
    GESTURE_PINCH_IN = 256, // Pinch in gesture
    GESTURE_PINCH_OUT = 512, // Pinch out gesture

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Camera system modes
pub const CameraMode = enum(c_int) {
    CAMERA_CUSTOM = 0, // Camera custom, controlled by user (UpdateCamera() does nothing)
    CAMERA_FREE, // Camera free mode
    CAMERA_ORBITAL, // Camera orbital, around target, zoom supported
    CAMERA_FIRST_PERSON, // Camera first person
    CAMERA_THIRD_PERSON, // Camera third person

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Camera projection
pub const CameraProjection = enum(c_int) {
    CAMERA_PERSPECTIVE = 0, // Perspective projection
    CAMERA_ORTHOGRAPHIC, // Orthographic projection

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// N-patch layout
pub const NPatchLayout = enum(c_int) {
    NPATCH_NINE_PATCH = 0, // Npatch layout: 3x3 tiles
    NPATCH_THREE_PATCH_VERTICAL, // Npatch layout: 1x3 tiles
    NPATCH_THREE_PATCH_HORIZONTAL, // Npatch layout: 3x1 tiles

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Callbacks to hook some internal functions
// WARNING: These callbacks are intended for advance users
pub const TraceLogCallback = *const fn (loglevel: c_int, text: [*c]const u8, args: *anyopaque) callconv(.C) void; // Logging: Redirect trace log messages
pub const LoadFileDataCallback = *const fn (fileName: [*c]const u8, dataSize: [*c]c_int) callconv(.C) [*c]u8; // FileIO: Save binary data
pub const SaveFileDataCallback = *const fn (fileName: [*c]const u8, data: *anyopaque, dataSize: c_int) callconv(.C) bool; // FileIO: Load text data
pub const LoadFileTextCallback = *const fn (fileName: [*c]const u8) callconv(.C) [*c]u8; // FileIO: Load text data
pub const SaveFileTextCallback = *const fn (fileName: [*c]const u8, text: [*c]u8) callconv(.C) bool; // FileIO: Save text data

//------------------------------------------------------------------------------------
// Window and Graphics Device Functions (Module: core)
//------------------------------------------------------------------------------------

// Window-related functions
pub extern "c" fn InitWindow(width: c_int, height: c_int, title: [*c]const u8) void; // Initialize window and OpenGL context
pub extern "c" fn CloseWindow() void; // Close window and unload OpenGL context
pub extern "c" fn WindowShouldClose() bool; // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
pub extern "c" fn IsWindowReady() bool; // Check if window has been initialized successfully
pub extern "c" fn IsWindowFullscreen() bool; // Check if window is currently fullscreen
pub extern "c" fn IsWindowHidden() bool; // Check if window is currently hidden (only PLATFORM_DESKTOP)
pub extern "c" fn IsWindowMinimized() bool; // Check if window is currently minimized (only PLATFORM_DESKTOP)
pub extern "c" fn IsWindowMaximized() bool; // Check if window is currently maximized (only PLATFORM_DESKTOP)
pub extern "c" fn IsWindowFocused() bool; // Check if window is currently focused (only PLATFORM_DESKTOP)
pub extern "c" fn IsWindowResized() bool; // Check if window has been resized last frame
pub extern "c" fn IsWindowState(flag: c_uint) bool; // Check if one specific window flag is enabled
pub extern "c" fn SetWindowState(flags: c_uint) void; // Set window configuration state using flags (only PLATFORM_DESKTOP)
pub extern "c" fn ClearWindowState(flags: c_uint) void; // Clear window configuration state flags
pub extern "c" fn ToggleFullscreen() void; // Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
pub extern "c" fn ToggleBorderlessWindowed() void; // Toggle window state: borderless windowed (only PLATFORM_DESKTOP)
pub extern "c" fn MaximizeWindow() void; // Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
pub extern "c" fn MinimizeWindow() void; // Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
pub extern "c" fn RestoreWindow() void; // Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
pub extern "c" fn SetWindowIcon(image: Image) void; // Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
pub extern "c" fn SetWindowIcons(images: [*c]Image, count: c_int) void; // Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
pub extern "c" fn SetWindowTitle(title: [*c]const u8) void; // Set title for window (only PLATFORM_DESKTOP and PLATFORM_WEB)
pub extern "c" fn SetWindowPosition(x: c_int, y: c_int) void; // Set window position on screen (only PLATFORM_DESKTOP)
pub extern "c" fn SetWindowMonitor(monitor: c_int) void; // Set monitor for the current window
pub extern "c" fn SetWindowMinSize(width: c_int, height: c_int) void; // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
pub extern "c" fn SetWindowMaxSize(width: c_int, height: c_int) void; // Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
pub extern "c" fn SetWindowSize(width: c_int, height: c_int) void; // Set window dimensions
pub extern "c" fn SetWindowOpacity(opacity: f32) void; // Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
pub extern "c" fn SetWindowFocused() void; // Set window focused (only PLATFORM_DESKTOP)
pub extern "c" fn GetWindowHandle() *anyopaque; // Get native window handle
pub extern "c" fn GetScreenWidth() c_int; // Get current screen width
pub extern "c" fn GetScreenHeight() c_int; // Get current screen height
pub extern "c" fn GetRenderWidth() c_int; // Get current render width (it considers HiDPI)
pub extern "c" fn GetRenderHeight() c_int; // Get current render height (it considers HiDPI)
pub extern "c" fn GetMonitorCount() c_int; // Get number of connected monitors
pub extern "c" fn GetCurrentMonitor() c_int; // Get current connected monitor
pub extern "c" fn GetMonitorPosition(monitor: c_int) Vector2; // Get specified monitor position
pub extern "c" fn GetMonitorWidth(monitor: c_int) c_int; // Get specified monitor width (current video mode used by monitor)
pub extern "c" fn GetMonitorHeight(monitor: c_int) c_int; // Get specified monitor height (current video mode used by monitor)
pub extern "c" fn GetMonitorPhysicalWidth(monitor: c_int) c_int; // Get specified monitor physical width in millimetres
pub extern "c" fn GetMonitorPhysicalHeight(monitor: c_int) c_int; // Get specified monitor physical height in millimetres
pub extern "c" fn GetMonitorRefreshRate(monitor: c_int) c_int; // Get specified monitor refresh rate
pub extern "c" fn GetWindowPosition() Vector2; // Get window position XY on monitor
pub extern "c" fn GetWindowScaleDPI() Vector2; // Get window scale DPI factor
pub extern "c" fn GetMonitorName(monitor: c_int) [*c]const u8; // Get the human-readable, UTF-8 encoded name of the specified monitor
pub extern "c" fn SetClipboardText(text: [*c]const u8) void; // Set clipboard text content
pub extern "c" fn GetClipboardText() [*c]const u8; // Get clipboard text content
pub extern "c" fn EnableEventWaiting() void; // Enable waiting for events on EndDrawing(), no automatic event polling
pub extern "c" fn DisableEventWaiting() void; // Disable waiting for events on EndDrawing(), automatic events polling

// Cursor-related functions
pub extern "c" fn ShowCursor() void; // Shows cursor
pub extern "c" fn HideCursor() void; // Hides cursor
pub extern "c" fn IsCursorHidden() bool; // Check if cursor is not visible
pub extern "c" fn EnableCursor() void; // Enables cursor (unlock cursor)
pub extern "c" fn DisableCursor() void; // Disables cursor (lock cursor)
pub extern "c" fn IsCursorOnScreen() bool; // Check if cursor is on the screen

// Drawing-related functions
pub extern "c" fn ClearBackground(color: Color) void; // Set background color (framebuffer clear color)
pub extern "c" fn BeginDrawing() void; // Setup canvas (framebuffer) to start drawing
pub extern "c" fn EndDrawing() void; // End canvas drawing and swap buffers (double buffering)
pub extern "c" fn BeginMode2D(camera: Camera2D) void; // Begin 2D mode with custom camera (2D)
pub extern "c" fn EndMode2D() void; // Ends 2D mode with custom camera
pub extern "c" fn BeginMode3D(camera: Camera3D) void; // Begin 3D mode with custom camera (3D)
pub extern "c" fn EndMode3D() void; // Ends 3D mode and returns to default 2D orthographic mode
pub extern "c" fn BeginTextureMode(target: RenderTexture2D) void; // Begin drawing to render texture
pub extern "c" fn EndTextureMode() void; // Ends drawing to render texture
pub extern "c" fn BeginShaderMode(shader: Shader) void; // Begin custom shader drawing
pub extern "c" fn EndShaderMode() void; // End custom shader drawing (use default shader)
pub extern "c" fn BeginBlendMode(mode: c_int) void; // Begin blending mode (alpha, additive, multiplied, subtract, custom)
pub extern "c" fn EndBlendMode() void; // End blending mode (reset to default: alpha blending)
pub extern "c" fn BeginScissorMode(x: c_int, y: c_int, width: c_int, height: c_int) void; // Begin scissor mode (define screen area for following drawing)
pub extern "c" fn EndScissorMode() void; // End scissor mode
pub extern "c" fn BeginVrStereoMode(config: VrStereoConfig) void; // Begin stereo rendering (requires VR simulator)
pub extern "c" fn EndVrStereoMode() void; // End stereo rendering (requires VR simulator)

// VR stereo config functions for VR simulator
pub extern "c" fn LoadVrStereoConfig(device: VrDeviceInfo) VrStereoConfig; // Load VR stereo config for VR simulator device parameters
pub extern "c" fn UnloadVrStereoConfig(config: VrStereoConfig) void; // Unload VR stereo config

// Shader management functions
// NOTE: Shader functionality is not available on OpenGL 1.1
pub extern "c" fn LoadShader(vsFileName: [*c]const u8, fsFileName: [*c]const u8) Shader; // Load shader from files and bind default locations
pub extern "c" fn LoadShaderFromMemory(vsCode: [*c]const u8, fsCode: [*c]const u8) Shader; // Load shader from code strings and bind default locations
pub extern "c" fn IsShaderReady(shader: Shader) bool; // Check if a shader is ready
pub extern "c" fn GetShaderLocation(shader: Shader, uniformName: [*c]const u8) c_int; // Get shader uniform location
pub extern "c" fn GetShaderLocationAttrib(shader: Shader, attribName: [*c]const u8) c_int; // Get shader attribute location
pub extern "c" fn SetShaderValue(shader: Shader, locIndex: c_int, value: *const anyopaque, uniformType: c_int) void; // Set shader uniform value
pub extern "c" fn SetShaderValueV(shader: Shader, locIndex: c_int, value: *const anyopaque, uniformType: c_int, count: c_int) void; // Set shader uniform value vector
pub extern "c" fn SetShaderValueMatrix(shader: Shader, locIndex: c_int, mat: Matrix) void; // Set shader uniform value (matrix 4x4)
pub extern "c" fn SetShaderValueTexture(shader: Shader, locIndex: c_int, texture: Texture2D) void; // Set shader uniform value for texture (sampler2d)
pub extern "c" fn UnloadShader(shader: Shader) void; // Unload shader from GPU memory (VRAM)

// Screen-space-related functions
pub extern "c" fn GetMouseRay(mousePosition: Vector2, camera: Camera) Ray; // Get a ray trace from mouse position
pub extern "c" fn GetCameraMatrix(camera: Camera) Matrix; // Get camera transform matrix (view matrix)
pub extern "c" fn GetCameraMatrix2D(camera: Camera2D) Matrix; // Get camera 2d transform matrix
pub extern "c" fn GetWorldToScreen(position: Vector3, camera: Camera) Vector2; // Get the screen space position for a 3d world space position
pub extern "c" fn GetScreenToWorld2D(position: Vector2, camera: Camera2D) Vector2; // Get the world space position for a 2d camera screen space position
pub extern "c" fn GetWorldToScreenEx(position: Vector3, camera: Camera, width: c_int, height: c_int) Vector2; // Get size position for a 3d world space position
pub extern "c" fn GetWorldToScreen2D(position: Vector2, camera: Camera2D) Vector2; // Get the screen space position for a 2d camera world space position

// Timing-related functions
pub extern "c" fn SetTargetFPS(fps: c_int) void; // Set target FPS (maximum)
pub extern "c" fn GetFrameTime() f32; // Get time in seconds for last frame drawn (delta time)
pub extern "c" fn GetTime() f64; // Get elapsed time in seconds since InitWindow()
pub extern "c" fn GetFPS() c_int; // Get current FPS

// Custom frame control functions
// NOTE: Those functions are intended for advance users that want full control over the frame processing
// By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
// To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
pub extern "c" fn SwapScreenBuffer() void; // Swap back buffer with front buffer (screen drawing)
pub extern "c" fn PollInputEvents() void; // Register all input events
pub extern "c" fn WaitTime(seconds: f64) void; // Wait for some time (halt program execution)

// Random values generation functions
pub extern "c" fn SetRandomSeed(seed: c_uint) void; // Set the seed for the random number generator
pub extern "c" fn GetRandomValue(min: c_int, max: c_int) c_int; // Get a random value between min and max (both included)
pub extern "c" fn LoadRandomSequence(count: c_uint, min: c_int, max: c_int) [*c]c_int; // Load random values sequence, no values repeated
pub extern "c" fn UnloadRandomSequence(sequence: [*c]c_int) void; // Unload random values sequence

// Misc. functions
pub extern "c" fn TakeScreenshot(fileName: [*c]const u8) void; // Takes a screenshot of current screen (filename extension defines format)
pub extern "c" fn SetConfigFlags(flags: c_uint) void; // Setup init configuration flags (view FLAGS)
pub extern "c" fn OpenURL(url: [*c]const u8) void; // Open URL with default system browser (if available)

// NOTE: Following functions implemented in module [utils]
//------------------------------------------------------------------
pub extern "c" fn TraceLog(logLevel: c_int, text: [*c]const u8, ...) void; // Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
pub extern "c" fn SetTraceLogLevel(logLevel: c_int) void; // Set the current threshold (minimum) log level
pub extern "c" fn MemAlloc(size: c_uint) *anyopaque; // Internal memory allocator
pub extern "c" fn MemRealloc(ptr: *anyopaque, size: c_uint) *anyopaque; // Internal memory reallocator
pub extern "c" fn MemFree(ptr: *anyopaque) void; // Internal memory free

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
pub extern "c" fn SetTraceLogCallback(callback: TraceLogCallback) void; // Set custom trace log
pub extern "c" fn SetLoadFileDataCallback(callback: LoadFileDataCallback) void; // Set custom file binary data loader
pub extern "c" fn SetSaveFileDataCallback(callback: SaveFileDataCallback) void; // Set custom file binary data saver
pub extern "c" fn SetLoadFileTextCallback(callback: LoadFileTextCallback) void; // Set custom file text data loader
pub extern "c" fn SetSaveFileTextCallback(callback: SaveFileTextCallback) void; // Set custom file text data saver

// Files management functions
pub extern "c" fn LoadFileData(fileName: [*c]const u8, dataSize: [*c]c_int) [*c]u8; // Load file data as byte array (read)
pub extern "c" fn UnloadFileData(data: [*c]u8) void; // Unload file data allocated by LoadFileData()
pub extern "c" fn SaveFileData(fileName: [*c]const u8, data: *anyopaque, dataSize: c_int) bool; // Save data to file from byte array (write), returns true on success
pub extern "c" fn ExportDataAsCode(data: [*c]const u8, dataSize: c_int, fileName: [*c]const u8) bool; // Export data to code (.h), returns true on success
pub extern "c" fn LoadFileText(fileName: [*c]const u8) [*c]u8; // Load text data from file (read), returns a '\0' terminated string
pub extern "c" fn UnloadFileText(text: [*c]u8) void; // Unload file text data allocated by LoadFileText()
pub extern "c" fn SaveFileText(fileName: [*c]const u8, text: [*c]u8) bool; // Save text data to file (write), string must be '\0' terminated, returns true on success
//------------------------------------------------------------------

// File system functions
pub extern "c" fn FileExists(fileName: [*c]const u8) bool; // Check if file exists
pub extern "c" fn DirectoryExists(dirPath: [*c]const u8) bool; // Check if a directory path exists
pub extern "c" fn IsFileExtension(fileName: [*c]const u8, ext: [*c]const u8) bool; // Check file extension (including point: .png, .wav)
pub extern "c" fn GetFileLength(fileName: [*c]const u8) c_int; // Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
pub extern "c" fn GetFileExtension(fileName: [*c]const u8) [*c]const u8; // Get pointer to extension for a filename string (includes dot: '.png')
pub extern "c" fn GetFileName(filePath: [*c]const u8) [*c]const u8; // Get pointer to filename for a path string
pub extern "c" fn GetFileNameWithoutExt(filePath: [*c]const u8) [*c]const u8; // Get filename string without extension (uses static string)
pub extern "c" fn GetDirectoryPath(filePath: [*c]const u8) [*c]const u8; // Get full path for a given fileName with path (uses static string)
pub extern "c" fn GetPrevDirectoryPath(dirPath: [*c]const u8) [*c]const u8; // Get previous directory path for a given path (uses static string)
pub extern "c" fn GetWorkingDirectory() [*c]const u8; // Get current working directory (uses static string)
pub extern "c" fn GetApplicationDirectory() [*c]const u8; // Get the directory of the running application (uses static string)
pub extern "c" fn ChangeDirectory(dir: [*c]const u8) bool; // Change working directory, return true on success
pub extern "c" fn IsPathFile(path: [*c]const u8) bool; // Check if a given path is a file or a directory
pub extern "c" fn LoadDirectoryFiles(dirPath: [*c]const u8) FilePathList; // Load directory filepaths
pub extern "c" fn LoadDirectoryFilesEx(basePath: [*c]const u8, filter: [*c]const u8, scanSubdirs: bool) FilePathList; // Load directory filepaths with extension filtering and recursive directory scan
pub extern "c" fn UnloadDirectoryFiles(files: FilePathList) void; // Unload filepaths
pub extern "c" fn IsFileDropped() bool; // Check if a file has been dropped into window
pub extern "c" fn LoadDroppedFiles() FilePathList; // Load dropped filepaths
pub extern "c" fn UnloadDroppedFiles(files: FilePathList) void; // Unload dropped filepaths
pub extern "c" fn GetFileModTime(fileName: [*c]const u8) c_long; // Get file modification time (last write time)

// Compression/Encoding functionality
pub extern "c" fn CompressData(data: [*c]const u8, dataSize: c_int, compDataSize: [*c]c_int) [*c]u8; // Compress data (DEFLATE algorithm), memory must be MemFree()
pub extern "c" fn DecompressData(compData: [*c]const u8, compDataSize: c_int, dataSize: [*c]c_int) [*c]u8; // Decompress data (DEFLATE algorithm), memory must be MemFree()
pub extern "c" fn EncodeDataBase64(data: [*c]const u8, dataSize: c_int, outputSize: [*c]c_int) [*c]u8; // Encode data to Base64 string, memory must be MemFree()
pub extern "c" fn DecodeDataBase64(data: [*c]const u8, outputSize: [*c]c_int) [*c]u8; // Decode Base64 string data, memory must be MemFree()

// Automation events functionality
pub extern "c" fn LoadAutomationEventList(fileName: [*c]const u8) AutomationEventList; // Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
pub extern "c" fn UnloadAutomationEventList(list: AutomationEventList) void; // Unload automation events list from file
pub extern "c" fn ExportAutomationEventList(list: AutomationEventList, fileName: [*c]const u8) bool; // Export automation events list as text file
pub extern "c" fn SetAutomationEventList(list: [*c]AutomationEventList) void; // Set automation event list to record to
pub extern "c" fn SetAutomationEventBaseFrame(frame: c_int) void; // Set automation event internal base frame to start recording
pub extern "c" fn StartAutomationEventRecording() void; // Start recording automation events (AutomationEventList must be set)
pub extern "c" fn StopAutomationEventRecording() void; // Stop recording automation events
pub extern "c" fn PlayAutomationEvent(event: AutomationEvent) void; // Play a recorded automation event

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
pub extern "c" fn IsKeyPressed(key: c_int) bool; // Check if a key has been pressed once
pub extern "c" fn IsKeyPressedRepeat(key: c_int) bool; // Check if a key has been pressed again (Only PLATFORM_DESKTOP)
pub extern "c" fn IsKeyDown(key: c_int) bool; // Check if a key is being pressed
pub extern "c" fn IsKeyReleased(key: c_int) bool; // Check if a key has been released once
pub extern "c" fn IsKeyUp(key: c_int) bool; // Check if a key is NOT being pressed
pub extern "c" fn GetKeyPressed() c_int; // Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
pub extern "c" fn GetCharPressed() c_int; // Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
pub extern "c" fn SetExitKey(key: c_int) void; // Set a custom key to exit program (default is ESC)

// Input-related functions: gamepads
pub extern "c" fn IsGamepadAvailable(gamepad: c_int) bool; // Check if a gamepad is available
pub extern "c" fn GetGamepadName(gamepad: c_int) [*c]const u8; // Get gamepad internal name id
pub extern "c" fn IsGamepadButtonPressed(gamepad: c_int, button: c_int) bool; // Check if a gamepad button has been pressed once
pub extern "c" fn IsGamepadButtonDown(gamepad: c_int, button: c_int) bool; // Check if a gamepad button is being pressed
pub extern "c" fn IsGamepadButtonReleased(gamepad: c_int, button: c_int) bool; // Check if a gamepad button has been released once
pub extern "c" fn IsGamepadButtonUp(gamepad: c_int, button: c_int) bool; // Check if a gamepad button is NOT being pressed
pub extern "c" fn GetGamepadButtonPressed() c_int; // Get the last gamepad button pressed
pub extern "c" fn GetGamepadAxisCount(gamepad: c_int) c_int; // Get gamepad axis count for a gamepad
pub extern "c" fn GetGamepadAxisMovement(gamepad: c_int, axis: c_int) f32; // Get axis movement value for a gamepad axis
pub extern "c" fn SetGamepadMappings(mappings: [*c]const u8) c_int; // Set internal gamepad mappings (SDL_GameControllerDB)

// Input-related functions: mouse
pub extern "c" fn IsMouseButtonPressed(button: c_int) bool; // Check if a mouse button has been pressed once
pub extern "c" fn IsMouseButtonDown(button: c_int) bool; // Check if a mouse button is being pressed
pub extern "c" fn IsMouseButtonReleased(button: c_int) bool; // Check if a mouse button has been released once
pub extern "c" fn IsMouseButtonUp(button: c_int) bool; // Check if a mouse button is NOT being pressed
pub extern "c" fn GetMouseX() c_int; // Get mouse position X
pub extern "c" fn GetMouseY() c_int; // Get mouse position Y
pub extern "c" fn GetMousePosition() Vector2; // Get mouse position XY
pub extern "c" fn GetMouseDelta() Vector2; // Get mouse delta between frames
pub extern "c" fn SetMousePosition(x: c_int, y: c_int) void; // Set mouse position XY
pub extern "c" fn SetMouseOffset(offsetX: c_int, offsetY: c_int) void; // Set mouse offset
pub extern "c" fn SetMouseScale(scaleX: f32, scaleY: f32) void; // Set mouse scaling
pub extern "c" fn GetMouseWheelMove() f32; // Get mouse wheel movement for X or Y, whichever is larger
pub extern "c" fn GetMouseWheelMoveV() Vector2; // Get mouse wheel movement for both X and Y
pub extern "c" fn SetMouseCursor(cursor: c_int) void; // Set mouse cursor

// Input-related functions: touch
pub extern "c" fn GetTouchX() c_int; // Get touch position X for touch point 0 (relative to screen size)
pub extern "c" fn GetTouchY() c_int; // Get touch position Y for touch point 0 (relative to screen size)
pub extern "c" fn GetTouchPosition(index: c_int) Vector2; // Get touch position XY for a touch point index (relative to screen size)
pub extern "c" fn GetTouchPointId(index: c_int) c_int; // Get touch point identifier for given index
pub extern "c" fn GetTouchPointCount() c_int; // Get number of touch points

//------------------------------------------------------------------------------------
// Gestures and Touch Handling Functions (Module: rgestures)
//------------------------------------------------------------------------------------
pub extern "c" fn SetGesturesEnabled(flags: c_uint) void; // Enable a set of gestures using flags
pub extern "c" fn IsGestureDetected(gesture: c_uint) bool; // Check if a gesture have been detected
pub extern "c" fn GetGestureDetected() c_int; // Get latest detected gesture
pub extern "c" fn GetGestureHoldDuration() f32; // Get gesture hold time in milliseconds
pub extern "c" fn GetGestureDragVector() Vector2; // Get gesture drag vector
pub extern "c" fn GetGestureDragAngle() f32; // Get gesture drag angle
pub extern "c" fn GetGesturePinchVector() Vector2; // Get gesture pinch delta
pub extern "c" fn GetGesturePinchAngle() f32; // Get gesture pinch angle

//------------------------------------------------------------------------------------
// Camera System Functions (Module: rcamera)
//------------------------------------------------------------------------------------
pub extern "c" fn UpdateCamera(camera: [*c]Camera, mode: c_int) void; // Update camera position for selected mode
pub extern "c" fn UpdateCameraPro(camera: [*c]Camera, movement: Vector3, rotation: Vector3, zoom: f32) void; // Update camera movement/rotation

//------------------------------------------------------------------------------------
// Basic Shapes Drawing Functions (Module: shapes)
//------------------------------------------------------------------------------------
// Set texture and rectangle to be used on shapes drawing
// NOTE: It can be useful when using basic shapes and one single font,
// defining a font char white rectangle would allow drawing everything in a single draw call
pub extern "c" fn SetShapesTexture(texture: Texture2D, source: Rectangle) void; // Set texture and rectangle to be used on shapes drawing

// Basic shapes drawing functions
pub extern "c" fn DrawPixel(posX: c_int, posY: c_int, color: Color) void; // Draw a pixel
pub extern "c" fn DrawPixelV(position: Vector2, color: Color) void; // Draw a pixel (Vector version)
pub extern "c" fn DrawLine(startPosX: c_int, startPosY: c_int, endPosX: c_int, endPosY: c_int, color: Color) void; // Draw a line
pub extern "c" fn DrawLineV(startPos: Vector2, endPos: Vector2, color: Color) void; // Draw a line (using gl lines)
pub extern "c" fn DrawLineEx(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void; // Draw a line (using triangles/quads)
pub extern "c" fn DrawLineStrip(points: [*c]Vector2, pointCount: c_int, color: Color) void; // Draw lines sequence (using gl lines)
pub extern "c" fn DrawLineBezier(startPos: Vector2, endPos: Vector2, thick: f32, color: Color) void; // Draw line segment cubic-bezier in-out interpolation
pub extern "c" fn DrawCircle(centerX: c_int, centerY: c_int, radius: f32, color: Color) void; // Draw a color-filled circle
pub extern "c" fn DrawCircleSector(center: Vector2, radius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void; // Draw a piece of a circle
pub extern "c" fn DrawCircleSectorLines(center: Vector2, radius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void; // Draw circle sector outline
pub extern "c" fn DrawCircleGradient(centerX: c_int, centerY: c_int, radius: f32, color1: Color, color2: Color) void; // Draw a gradient-filled circle
pub extern "c" fn DrawCircleV(center: Vector2, radius: f32, color: Color) void; // Draw a color-filled circle (Vector version)
pub extern "c" fn DrawCircleLines(centerX: c_int, centerY: c_int, radius: f32, color: Color) void; // Draw circle outline
pub extern "c" fn DrawCircleLinesV(center: Vector2, radius: f32, color: Color) void; // Draw circle outline (Vector version)
pub extern "c" fn DrawEllipse(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void; // Draw ellipse
pub extern "c" fn DrawEllipseLines(centerX: c_int, centerY: c_int, radiusH: f32, radiusV: f32, color: Color) void; // Draw ellipse outline
pub extern "c" fn DrawRing(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void; // Draw ring
pub extern "c" fn DrawRingLines(center: Vector2, innerRadius: f32, outerRadius: f32, startAngle: f32, endAngle: f32, segments: c_int, color: Color) void; // Draw ring outline
pub extern "c" fn DrawRectangle(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void; // Draw a color-filled rectangle
pub extern "c" fn DrawRectangleV(position: Vector2, size: Vector2, color: Color) void; // Draw a color-filled rectangle (Vector version)
pub extern "c" fn DrawRectangleRec(rec: Rectangle, color: Color) void; // Draw a color-filled rectangle
pub extern "c" fn DrawRectanglePro(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) void; // Draw a color-filled rectangle with pro parameters
pub extern "c" fn DrawRectangleGradientV(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: Color, color2: Color) void; // Draw a vertical-gradient-filled rectangle
pub extern "c" fn DrawRectangleGradientH(posX: c_int, posY: c_int, width: c_int, height: c_int, color1: Color, color2: Color) void; // Draw a horizontal-gradient-filled rectangle
pub extern "c" fn DrawRectangleGradientEx(rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color) void; // Draw a gradient-filled rectangle with custom vertex colors
pub extern "c" fn DrawRectangleLines(posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void; // Draw rectangle outline
pub extern "c" fn DrawRectangleLinesEx(rec: Rectangle, lineThick: f32, color: Color) void; // Draw rectangle outline with extended parameters
pub extern "c" fn DrawRectangleRounded(rec: Rectangle, roundness: f32, segments: c_int, color: Color) void; // Draw rectangle with rounded edges
pub extern "c" fn DrawRectangleRoundedLines(rec: Rectangle, roundness: f32, segments: c_int, lineThick: f32, color: Color) void; // Draw rectangle with rounded edges outline
pub extern "c" fn DrawTriangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void; // Draw a color-filled triangle (vertex in counter-clockwise order!)
pub extern "c" fn DrawTriangleLines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void; // Draw triangle outline (vertex in counter-clockwise order!)
pub extern "c" fn DrawTriangleFan(points: [*c]Vector2, pointCount: c_int, color: Color) void; // Draw a triangle fan defined by points (first vertex is the center)
pub extern "c" fn DrawTriangleStrip(points: [*c]Vector2, pointCount: c_int, color: Color) void; // Draw a triangle strip defined by points
pub extern "c" fn DrawPoly(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void; // Draw a regular polygon (Vector version)
pub extern "c" fn DrawPolyLines(center: Vector2, sides: c_int, radius: f32, rotation: f32, color: Color) void; // Draw a polygon outline of n sides
pub extern "c" fn DrawPolyLinesEx(center: Vector2, sides: c_int, radius: f32, rotation: f32, lineThick: f32, color: Color) void; // Draw a polygon outline of n sides with extended parameters

// Splines drawing functions
pub extern "c" fn DrawSplineLinear(points: [*c]Vector2, pointCount: c_int, thick: f32, color: Color) void; // Draw spline: Linear, minimum 2 points
pub extern "c" fn DrawSplineBasis(points: [*c]Vector2, pointCount: c_int, thick: f32, color: Color) void; // Draw spline: B-Spline, minimum 4 points
pub extern "c" fn DrawSplineCatmullRom(points: [*c]Vector2, pointCount: c_int, thick: f32, color: Color) void; // Draw spline: Catmull-Rom, minimum 4 points
pub extern "c" fn DrawSplineBezierQuadratic(points: [*c]Vector2, pointCount: c_int, thick: f32, color: Color) void; // Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
pub extern "c" fn DrawSplineBezierCubic(points: [*c]Vector2, pointCount: c_int, thick: f32, color: Color) void; // Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
pub extern "c" fn DrawSplineSegmentLinear(p1: Vector2, p2: Vector2, thick: f32, color: Color) void; // Draw spline segment: Linear, 2 points
pub extern "c" fn DrawSplineSegmentBasis(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, thick: f32, color: Color) void; // Draw spline segment: B-Spline, 4 points
pub extern "c" fn DrawSplineSegmentCatmullRom(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, thick: f32, color: Color) void; // Draw spline segment: Catmull-Rom, 4 points
pub extern "c" fn DrawSplineSegmentBezierQuadratic(p1: Vector2, c2: Vector2, p3: Vector2, thick: f32, color: Color) void; // Draw spline segment: Quadratic Bezier, 2 points, 1 control point
pub extern "c" fn DrawSplineSegmentBezierCubic(p1: Vector2, c2: Vector2, c3: Vector2, p4: Vector2, thick: f32, color: Color) void; // Draw spline segment: Cubic Bezier, 2 points, 2 control points

// Spline segment point evaluation functions, for a given t [0.0f .. 1.0f]
pub extern "c" fn GetSplinePointLinear(startPos: Vector2, endPos: Vector2, t: f32) Vector2; // Get (evaluate) spline point: Linear
pub extern "c" fn GetSplinePointBasis(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, t: f32) Vector2; // Get (evaluate) spline point: B-Spline
pub extern "c" fn GetSplinePointCatmullRom(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, t: f32) Vector2; // Get (evaluate) spline point: Catmull-Rom
pub extern "c" fn GetSplinePointBezierQuad(p1: Vector2, c2: Vector2, p3: Vector2, t: f32) Vector2; // Get (evaluate) spline point: Quadratic Bezier
pub extern "c" fn GetSplinePointBezierCubic(p1: Vector2, c2: Vector2, c3: Vector2, p4: Vector2, t: f32) Vector2; // Get (evaluate) spline point: Cubic Bezier

// Basic shapes collision detection functions
pub extern "c" fn CheckCollisionRecs(rec1: Rectangle, rec2: Rectangle) bool; // Check collision between two rectangles
pub extern "c" fn CheckCollisionCircles(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) bool; // Check collision between two circles
pub extern "c" fn CheckCollisionCircleRec(center: Vector2, radius: f32, rec: Rectangle) bool; // Check collision between circle and rectangle
pub extern "c" fn CheckCollisionPointRec(point: Vector2, rec: Rectangle) bool; // Check if point is inside rectangle
pub extern "c" fn CheckCollisionPointCircle(point: Vector2, center: Vector2, radius: f32) bool; // Check if point is inside circle
pub extern "c" fn CheckCollisionPointTriangle(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) bool; // Check if point is inside a triangle
pub extern "c" fn CheckCollisionPointPoly(point: Vector2, points: [*c]Vector2, pointCount: c_int) bool; // Check if point is within a polygon described by array of vertices
pub extern "c" fn CheckCollisionLines(startPos1: Vector2, endPos1: Vector2, startPos2: Vector2, endPos2: Vector2, collisionPoint: [*c]Vector2) bool; // Check the collision between two lines defined by two points each, returns collision point by reference
pub extern "c" fn CheckCollisionPointLine(point: Vector2, p1: Vector2, p2: Vector2, threshold: c_int) bool; // Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
pub extern "c" fn GetCollisionRec(rec1: Rectangle, rec2: Rectangle) Rectangle; // Get collision rectangle for two rectangles collision

//------------------------------------------------------------------------------------
// Texture Loading and Drawing Functions (Module: textures)
//------------------------------------------------------------------------------------

// Image loading functions
// NOTE: These functions do not require GPU access
pub extern "c" fn LoadImage(fileName: [*c]const u8) Image; // Load image from file into CPU memory (RAM)
pub extern "c" fn LoadImageRaw(fileName: [*c]const u8, width: c_int, height: c_int, format: c_int, headerSize: c_int) Image; // Load image from RAW file data
pub extern "c" fn LoadImageSvg(fileNameOrString: [*c]const u8, width: c_int, height: c_int) Image; // Load image from SVG file data or string with specified size
pub extern "c" fn LoadImageAnim(fileName: [*c]const u8, frames: [*c]c_int) Image; // Load image sequence from file (frames appended to image.data)
pub extern "c" fn LoadImageFromMemory(fileType: [*c]const u8, fileData: [*c]const u8, dataSize: c_int) Image; // Load image from memory buffer, fileType refers to extension: i.e. '.png'
pub extern "c" fn LoadImageFromTexture(texture: Texture2D) Image; // Load image from GPU texture data
pub extern "c" fn LoadImageFromScreen() Image; // Load image from screen buffer and (screenshot)
pub extern "c" fn IsImageReady(image: Image) bool; // Check if an image is ready
pub extern "c" fn UnloadImage(image: Image) void; // Unload image from CPU memory (RAM)
pub extern "c" fn ExportImage(image: Image, fileName: [*c]const u8) bool; // Export image data to file, returns true on success
pub extern "c" fn ExportImageToMemory(image: Image, fileType: [*c]const u8, fileSize: [*c]c_int) [*c]u8; // Export image to memory buffer
pub extern "c" fn ExportImageAsCode(image: Image, fileName: [*c]const u8) bool; // Export image as code file defining an array of bytes, returns true on success

// Image generation functions
pub extern "c" fn GenImageColor(width: c_int, height: c_int, color: Color) Image; // Generate image: plain color
pub extern "c" fn GenImageGradientLinear(width: c_int, height: c_int, direction: c_int, start: Color, end: Color) Image; // Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
pub extern "c" fn GenImageGradientRadial(width: c_int, height: c_int, density: f32, inner: Color, outer: Color) Image; // Generate image: radial gradient
pub extern "c" fn GenImageGradientSquare(width: c_int, height: c_int, density: f32, inner: Color, outer: Color) Image; // Generate image: square gradient
pub extern "c" fn GenImageChecked(width: c_int, height: c_int, checksX: c_int, checksY: c_int, col1: Color, col2: Color) Image; // Generate image: checked
pub extern "c" fn GenImageWhiteNoise(width: c_int, height: c_int, factor: f32) Image; // Generate image: white noise
pub extern "c" fn GenImagePerlinNoise(width: c_int, height: c_int, offsetX: c_int, offsetY: c_int, scale: f32) Image; // Generate image: perlin noise
pub extern "c" fn GenImageCellular(width: c_int, height: c_int, tileSize: c_int) Image; // Generate image: cellular algorithm, bigger tileSize means bigger cells
pub extern "c" fn GenImageText(width: c_int, height: c_int, text: [*c]const u8) Image; // Generate image: grayscale image from text data

// Image manipulation functions
pub extern "c" fn ImageCopy(image: Image) Image; // Create an image duplicate (useful for transformations)
pub extern "c" fn ImageFromImage(image: Image, rec: Rectangle) Image; // Create an image from another image piece
pub extern "c" fn ImageText(text: [*c]const u8, fontSize: c_int, color: Color) Image; // Create an image from text (default font)
pub extern "c" fn ImageTextEx(font: Font, text: [*c]const u8, fontSize: f32, spacing: f32, tint: Color) Image; // Create an image from text (custom sprite font)
pub extern "c" fn ImageFormat(image: [*c]Image, newFormat: c_int) void; // Convert image data to desired format
pub extern "c" fn ImageToPOT(image: [*c]Image, fill: Color) void; // Convert image to POT (power-of-two)
pub extern "c" fn ImageCrop(image: [*c]Image, crop: Rectangle) void; // Crop an image to a defined rectangle
pub extern "c" fn ImageAlphaCrop(image: [*c]Image, threshold: f32) void; // Crop image depending on alpha value
pub extern "c" fn ImageAlphaClear(image: [*c]Image, color: Color, threshold: f32) void; // Clear alpha channel to desired color
pub extern "c" fn ImageAlphaMask(image: [*c]Image, alphaMask: Image) void; // Apply alpha mask to image
pub extern "c" fn ImageAlphaPremultiply(image: [*c]Image) void; // Premultiply alpha channel
pub extern "c" fn ImageBlurGaussian(image: [*c]Image, blurSize: c_int) void; // Apply Gaussian blur using a box blur approximation
pub extern "c" fn ImageResize(image: [*c]Image, newWidth: c_int, newHeight: c_int) void; // Resize image (Bicubic scaling algorithm)
pub extern "c" fn ImageResizeNN(image: [*c]Image, newWidth: c_int, newHeight: c_int) void; // Resize image (Nearest-Neighbor scaling algorithm)
pub extern "c" fn ImageResizeCanvas(image: [*c]Image, newWidth: c_int, newHeight: c_int, offsetX: c_int, offsetY: c_int, fill: Color) void; // Resize canvas and fill with color
pub extern "c" fn ImageMipmaps(image: [*c]Image) void; // Compute all mipmap levels for a provided image
pub extern "c" fn ImageDither(image: [*c]Image, rBpp: c_int, gBpp: c_int, bBpp: c_int, aBpp: c_int) void; // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
pub extern "c" fn ImageFlipVertical(image: [*c]Image) void; // Flip image vertically
pub extern "c" fn ImageFlipHorizontal(image: [*c]Image) void; // Flip image horizontally
pub extern "c" fn ImageRotate(image: [*c]Image, degrees: c_int) void; // Rotate image by input angle in degrees (-359 to 359)
pub extern "c" fn ImageRotateCW(image: [*c]Image) void; // Rotate image clockwise 90deg
pub extern "c" fn ImageRotateCCW(image: [*c]Image) void; // Rotate image counter-clockwise 90deg
pub extern "c" fn ImageColorTint(image: [*c]Image, color: Color) void; // Modify image color: tint
pub extern "c" fn ImageColorInvert(image: [*c]Image) void; // Modify image color: invert
pub extern "c" fn ImageColorGrayscale(image: [*c]Image) void; // Modify image color: grayscale
pub extern "c" fn ImageColorContrast(image: [*c]Image, contrast: f32) void; // Modify image color: contrast (-100 to 100)
pub extern "c" fn ImageColorBrightness(image: [*c]Image, brightness: c_int) void; // Modify image color: brightness (-255 to 255)
pub extern "c" fn ImageColorReplace(image: [*c]Image, color: Color, replace: Color) void; // Modify image color: replace color
pub extern "c" fn LoadImageColors(image: Image) [*c]Color; // Load color data from image as a Color array (RGBA - 32bit)
pub extern "c" fn LoadImagePalette(image: Image, maxPaletteSize: c_int, colorCount: [*c]c_int) [*c]Color; // Load colors palette from image as a Color array (RGBA - 32bit)
pub extern "c" fn UnloadImageColors(colors: [*c]Color) void; // Unload color data loaded with LoadImageColors()
pub extern "c" fn UnloadImagePalette(colors: [*c]Color) void; // Unload colors palette loaded with LoadImagePalette()
pub extern "c" fn GetImageAlphaBorder(image: Image, threshold: f32) Rectangle; // Get image alpha border rectangle
pub extern "c" fn GetImageColor(image: Image, x: c_int, y: c_int) Color; // Get image pixel color at (x, y) position

// Image drawing functions
// NOTE: Image software-rendering functions (CPU)
pub extern "c" fn ImageClearBackground(dst: [*c]Image, color: Color) void; // Clear image background with given color
pub extern "c" fn ImageDrawPixel(dst: [*c]Image, posX: c_int, posY: c_int, color: Color) void; // Draw pixel within an image
pub extern "c" fn ImageDrawPixelV(dst: [*c]Image, position: Vector2, color: Color) void; // Draw pixel within an image (Vector version)
pub extern "c" fn ImageDrawLine(dst: [*c]Image, startPosX: c_int, startPosY: c_int, endPosX: c_int, endPosY: c_int, color: Color) void; // Draw line within an image
pub extern "c" fn ImageDrawLineV(dst: [*c]Image, start: Vector2, end: Vector2, color: Color) void; // Draw line within an image (Vector version)
pub extern "c" fn ImageDrawCircle(dst: [*c]Image, centerX: c_int, centerY: c_int, radius: c_int, color: Color) void; // Draw a filled circle within an image
pub extern "c" fn ImageDrawCircleV(dst: [*c]Image, center: Vector2, radius: c_int, color: Color) void; // Draw a filled circle within an image (Vector version)
pub extern "c" fn ImageDrawCircleLines(dst: [*c]Image, centerX: c_int, centerY: c_int, radius: c_int, color: Color) void; // Draw circle outline within an image
pub extern "c" fn ImageDrawCircleLinesV(dst: [*c]Image, center: Vector2, radius: c_int, color: Color) void; // Draw circle outline within an image (Vector version)
pub extern "c" fn ImageDrawRectangle(dst: [*c]Image, posX: c_int, posY: c_int, width: c_int, height: c_int, color: Color) void; // Draw rectangle within an image
pub extern "c" fn ImageDrawRectangleV(dst: [*c]Image, position: Vector2, size: Vector2, color: Color) void; // Draw rectangle within an image (Vector version)
pub extern "c" fn ImageDrawRectangleRec(dst: [*c]Image, rec: Rectangle, color: Color) void; // Draw rectangle within an image
pub extern "c" fn ImageDrawRectangleLines(dst: [*c]Image, rec: Rectangle, thick: c_int, color: Color) void; // Draw rectangle lines within an image
pub extern "c" fn ImageDraw(dst: [*c]Image, src: Image, srcRec: Rectangle, dstRec: Rectangle, tint: Color) void; // Draw a source image within a destination image (tint applied to source)
pub extern "c" fn ImageDrawText(dst: [*c]Image, text: [*c]const u8, posX: c_int, posY: c_int, fontSize: c_int, color: Color) void; // Draw text (using default font) within an image (destination)
pub extern "c" fn ImageDrawTextEx(dst: [*c]Image, font: Font, text: [*c]const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void; // Draw text (custom sprite font) within an image (destination)

// Texture loading functions
// NOTE: These functions require GPU access
pub extern "c" fn LoadTexture(fileName: [*c]const u8) Texture2D; // Load texture from file into GPU memory (VRAM)
pub extern "c" fn LoadTextureFromImage(image: Image) Texture2D; // Load texture from image data
pub extern "c" fn LoadTextureCubemap(image: Image, layout: c_int) TextureCubemap; // Load cubemap from image, multiple image cubemap layouts supported
pub extern "c" fn LoadRenderTexture(width: c_int, height: c_int) RenderTexture2D; // Load texture for rendering (framebuffer)
pub extern "c" fn IsTextureReady(texture: Texture2D) bool; // Check if a texture is ready
pub extern "c" fn UnloadTexture(texture: Texture2D) void; // Unload texture from GPU memory (VRAM)
pub extern "c" fn IsRenderTextureReady(target: RenderTexture2D) bool; // Check if a render texture is ready
pub extern "c" fn UnloadRenderTexture(target: RenderTexture2D) void; // Unload render texture from GPU memory (VRAM)
pub extern "c" fn UpdateTexture(texture: Texture2D, pixels: *const anyopaque) void; // Update GPU texture with new data
pub extern "c" fn UpdateTextureRec(texture: Texture2D, rec: Rectangle, pixels: *const anyopaque) void; // Update GPU texture rectangle with new data

// Texture configuration functions
pub extern "c" fn GenTextureMipmaps(texture: [*c]Texture2D) void; // Generate GPU mipmaps for a texture
pub extern "c" fn SetTextureFilter(texture: Texture2D, filter: c_int) void; // Set texture scaling filter mode
pub extern "c" fn SetTextureWrap(texture: Texture2D, wrap: c_int) void; // Set texture wrapping mode

// Texture drawing functions
pub extern "c" fn DrawTexture(texture: Texture2D, posX: c_int, posY: c_int, tint: Color) void; // Draw a Texture2D
pub extern "c" fn DrawTextureV(texture: Texture2D, position: Vector2, tint: Color) void; // Draw a Texture2D with position defined as Vector2
pub extern "c" fn DrawTextureEx(texture: Texture2D, position: Vector2, rotation: f32, scale: f32, tint: Color) void; // Draw a Texture2D with extended parameters
pub extern "c" fn DrawTextureRec(texture: Texture2D, source: Rectangle, position: Vector2, tint: Color) void; // Draw a part of a texture defined by a rectangle
pub extern "c" fn DrawTexturePro(texture: Texture2D, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void; // Draw a part of a texture defined by a rectangle with 'pro' parameters
pub extern "c" fn DrawTextureNPatch(texture: Texture2D, nPatchInfo: NPatchInfo, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void; // Draws a texture (or part of it) that stretches or shrinks nicely

// Color/pixel related functions
pub extern "c" fn Fade(color: Color, alpha: f32) Color; // Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub extern "c" fn ColorToInt(color: Color) c_int; // Get hexadecimal value for a Color
pub extern "c" fn ColorNormalize(color: Color) Vector4; // Get Color normalized as float [0..1]
pub extern "c" fn ColorFromNormalized(normalized: Vector4) Color; // Get Color from normalized values [0..1]
pub extern "c" fn ColorToHSV(color: Color) Vector3; // Get HSV values for a Color, hue [0..360], saturation/value [0..1]
pub extern "c" fn ColorFromHSV(hue: f32, saturation: f32, value: f32) Color; // Get a Color from HSV values, hue [0..360], saturation/value [0..1]
pub extern "c" fn ColorTint(color: Color, tint: Color) Color; // Get color multiplied with another color
pub extern "c" fn ColorBrightness(color: Color, factor: f32) Color; // Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
pub extern "c" fn ColorContrast(color: Color, contrast: f32) Color; // Get color with contrast correction, contrast values between -1.0f and 1.0f
pub extern "c" fn ColorAlpha(color: Color, alpha: f32) Color; // Get color with alpha applied, alpha goes from 0.0f to 1.0f
pub extern "c" fn ColorAlphaBlend(dst: Color, src: Color, tint: Color) Color; // Get src alpha-blended into dst color with tint
pub extern "c" fn GetColor(hexValue: c_uint) Color; // Get Color structure from hexadecimal value
pub extern "c" fn GetPixelColor(srcPtr: *anyopaque, format: c_int) Color; // Get Color from a source pixel pointer of certain format
pub extern "c" fn SetPixelColor(dstPtr: *anyopaque, color: Color, format: c_int) void; // Set color formatted into destination pixel pointer
pub extern "c" fn GetPixelDataSize(width: c_int, height: c_int, format: c_int) c_int; // Get pixel data size in bytes for certain format

//------------------------------------------------------------------------------------
// Font Loading and Text Drawing Functions (Module: text)
//------------------------------------------------------------------------------------

// Font loading/unloading functions
pub extern "c" fn GetFontDefault() Font; // Get the default Font
pub extern "c" fn LoadFont(fileName: [*c]const u8) Font; // Load font from file into GPU memory (VRAM)
pub extern "c" fn LoadFontEx(fileName: [*c]const u8, fontSize: c_int, codepoints: [*c]c_int, codepointCount: c_int) Font; // Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set
pub extern "c" fn LoadFontFromImage(image: Image, key: Color, firstChar: c_int) Font; // Load font from Image (XNA style)
pub extern "c" fn LoadFontFromMemory(fileType: [*c]const u8, fileData: [*c]const u8, dataSize: c_int, fontSize: c_int, codepoints: [*c]c_int, codepointCount: c_int) Font; // Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
pub extern "c" fn IsFontReady(font: Font) bool; // Check if a font is ready
pub extern "c" fn LoadFontData(fileData: [*c]const u8, dataSize: c_int, fontSize: c_int, codepoints: [*c]c_int, codepointCount: c_int, @"type": c_int) [*c]GlyphInfo; // Load font data for further use
pub extern "c" fn GenImageFontAtlas(glyphs: [*c]const GlyphInfo, glyphRecs: [*c][*c]Rectangle, glyphCount: c_int, fontSize: c_int, padding: c_int, packMethod: c_int) Image; // Generate image font atlas using chars info
pub extern "c" fn UnloadFontData(glyphs: [*c]GlyphInfo, glyphCount: c_int) void; // Unload font chars info data (RAM)
pub extern "c" fn UnloadFont(font: Font) void; // Unload font from GPU memory (VRAM)
pub extern "c" fn ExportFontAsCode(font: Font, fileName: [*c]const u8) bool; // Export font as code file, returns true on success

// Text drawing functions
pub extern "c" fn DrawFPS(posX: c_int, posY: c_int) void; // Draw current FPS
pub extern "c" fn DrawText(text: [*c]const u8, posX: c_int, posY: c_int, fontSize: c_int, color: Color) void; // Draw text (using default font)
pub extern "c" fn DrawTextEx(font: Font, text: [*c]const u8, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void; // Draw text using font and additional parameters
pub extern "c" fn DrawTextPro(font: Font, text: [*c]const u8, position: Vector2, origin: Vector2, rotation: f32, fontSize: f32, spacing: f32, tint: Color) void; // Draw text using Font and pro parameters (rotation)
pub extern "c" fn DrawTextCodepoint(font: Font, codepoint: c_int, position: Vector2, fontSize: f32, tint: Color) void; // Draw one character (codepoint)
pub extern "c" fn DrawTextCodepoints(font: Font, codepoints: [*c]const c_int, codepointCount: c_int, position: Vector2, fontSize: f32, spacing: f32, tint: Color) void; // Draw multiple character (codepoint)

// Text font info functions
pub extern "c" fn SetTextLineSpacing(spacing: c_int) void; // Set vertical line spacing when drawing with line-breaks
pub extern "c" fn MeasureText(text: [*c]const u8, fontSize: c_int) c_int; // Measure string width for default font
pub extern "c" fn MeasureTextEx(font: Font, text: [*c]const u8, fontSize: f32, spacing: f32) Vector2; // Measure string size for Font
pub extern "c" fn GetGlyphIndex(font: Font, codepoint: c_int) c_int; // Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
pub extern "c" fn GetGlyphInfo(font: Font, codepoint: c_int) GlyphInfo; // Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
pub extern "c" fn GetGlyphAtlasRec(font: Font, codepoint: c_int) Rectangle; // Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found

// Text codepoints management functions (unicode characters)
pub extern "c" fn LoadUTF8(codepoints: [*c]const c_int, length: c_int) [*c]u8; // Load UTF-8 text encoded from codepoints array
pub extern "c" fn UnloadUTF8(text: [*c]u8) void; // Unload UTF-8 text encoded from codepoints array
pub extern "c" fn LoadCodepoints(text: [*c]const u8, count: [*c]c_int) [*c]c_int; // Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
pub extern "c" fn UnloadCodepoints(codepoints: [*c]c_int) void; // Unload codepoints data from memory
pub extern "c" fn GetCodepointCount(text: [*c]const u8) c_int; // Get total number of codepoints in a UTF-8 encoded string
pub extern "c" fn GetCodepoint(text: [*c]const u8, codepointSize: [*c]c_int) c_int; // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub extern "c" fn GetCodepointNext(text: [*c]const u8, codepointSize: [*c]c_int) c_int; // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub extern "c" fn GetCodepointPrevious(text: [*c]const u8, codepointSize: [*c]c_int) c_int; // Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
pub extern "c" fn CodepointToUTF8(codepoint: c_int, utf8Size: [*c]c_int) [*c]const u8; // Encode one codepoint into UTF-8 byte array (array length returned as parameter)

// Text strings management functions (no UTF-8 strings, only byte chars)
// NOTE: Some strings allocate memory internally for returned strings, just be careful!
pub extern "c" fn TextCopy(dst: [*c]u8, src: [*c]const u8) c_int; // Copy one string to another, returns bytes copied
pub extern "c" fn TextIsEqual(text1: [*c]const u8, text2: [*c]const u8) bool; // Check if two text string are equal
pub extern "c" fn TextLength(text: [*c]const u8) c_uint; // Get text length, checks for '\0' ending
pub extern "c" fn TextFormat(text: [*c]const u8, ...) [*c]const u8; // Text formatting with variables (sprintf() style)
pub extern "c" fn TextSubtext(text: [*c]const u8, position: c_int, length: c_int) [*c]const u8; // Get a piece of a text string
pub extern "c" fn TextReplace(text: [*c]u8, replace: [*c]const u8, by: [*c]const u8) [*c]u8; // Replace text string (WARNING: memory must be freed!)
pub extern "c" fn TextInsert(text: [*c]const u8, insert: [*c]const u8, position: c_int) [*c]u8; // Insert text in a position (WARNING: memory must be freed!)
pub extern "c" fn TextJoin(textList: [*c][*c]const u8, count: c_int, delimiter: [*c]const u8) [*c]const u8; // Join text strings with delimiter
pub extern "c" fn TextSplit(text: [*c]const u8, delimiter: u8, count: [*c]c_int) [*c][*c]const u8; // Split text into multiple strings
pub extern "c" fn TextAppend(text: [*c]u8, append: [*c]const u8, position: [*c]c_int) void; // Append text at specific position and move cursor!
pub extern "c" fn TextFindIndex(text: [*c]const u8, find: [*c]const u8) c_int; // Find first text occurrence within a string
pub extern "c" fn TextToUpper(text: [*c]const u8) [*c]const u8; // Get upper case version of provided string
pub extern "c" fn TextToLower(text: [*c]const u8) [*c]const u8; // Get lower case version of provided string
pub extern "c" fn TextToPascal(text: [*c]const u8) [*c]const u8; // Get Pascal case notation version of provided string
pub extern "c" fn TextToInteger(text: [*c]const u8) c_int; // Get integer value from text (negative values not supported)

//------------------------------------------------------------------------------------
// Basic 3d Shapes Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Basic geometric 3D shapes drawing functions
pub extern "c" fn DrawLine3D(startPos: Vector3, endPos: Vector3, color: Color) void; // Draw a line in 3D world space
pub extern "c" fn DrawPoint3D(position: Vector3, color: Color) void; // Draw a point in 3D space, actually a small line
pub extern "c" fn DrawCircle3D(center: Vector3, radius: f32, rotationAxis: Vector3, rotationAngle: f32, color: Color) void; // Draw a circle in 3D world space
pub extern "c" fn DrawTriangle3D(v1: Vector3, v2: Vector3, v3: Vector3, color: Color) void; // Draw a color-filled triangle (vertex in counter-clockwise order!)
pub extern "c" fn DrawTriangleStrip3D(points: [*c]Vector3, pointCount: c_int, color: Color) void; // Draw a triangle strip defined by points
pub extern "c" fn DrawCube(position: Vector3, width: f32, height: f32, length: f32, color: Color) void; // Draw cube
pub extern "c" fn DrawCubeV(position: Vector3, size: Vector3, color: Color) void; // Draw cube (Vector version)
pub extern "c" fn DrawCubeWires(position: Vector3, width: f32, height: f32, length: f32, color: Color) void; // Draw cube wires
pub extern "c" fn DrawCubeWiresV(position: Vector3, size: Vector3, color: Color) void; // Draw cube wires (Vector version)
pub extern "c" fn DrawSphere(centerPos: Vector3, radius: f32, color: Color) void; // Draw sphere
pub extern "c" fn DrawSphereEx(centerPos: Vector3, radius: f32, rings: c_int, slices: c_int, color: Color) void; // Draw sphere with extended parameters
pub extern "c" fn DrawSphereWires(centerPos: Vector3, radius: f32, rings: c_int, slices: c_int, color: Color) void; // Draw sphere wires
pub extern "c" fn DrawCylinder(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: c_int, color: Color) void; // Draw a cylinder/cone
pub extern "c" fn DrawCylinderEx(startPos: Vector3, endPos: Vector3, startRadius: f32, endRadius: f32, sides: c_int, color: Color) void; // Draw a cylinder with base at startPos and top at endPos
pub extern "c" fn DrawCylinderWires(position: Vector3, radiusTop: f32, radiusBottom: f32, height: f32, slices: c_int, color: Color) void; // Draw a cylinder/cone wires
pub extern "c" fn DrawCylinderWiresEx(startPos: Vector3, endPos: Vector3, startRadius: f32, endRadius: f32, sides: c_int, color: Color) void; // Draw a cylinder wires with base at startPos and top at endPos
pub extern "c" fn DrawCapsule(startPos: Vector3, endPos: Vector3, radius: f32, slices: c_int, rings: c_int, color: Color) void; // Draw a capsule with the center of its sphere caps at startPos and endPos
pub extern "c" fn DrawCapsuleWires(startPos: Vector3, endPos: Vector3, radius: f32, slices: c_int, rings: c_int, color: Color) void; // Draw capsule wireframe with the center of its sphere caps at startPos and endPos
pub extern "c" fn DrawPlane(centerPos: Vector3, size: Vector2, color: Color) void; // Draw a plane XZ
pub extern "c" fn DrawRay(ray: Ray, color: Color) void; // Draw a ray line
pub extern "c" fn DrawGrid(slices: c_int, spacing: f32) void; // Draw a grid (centered at (0, 0, 0))

//------------------------------------------------------------------------------------
// Model 3d Loading and Drawing Functions (Module: models)
//------------------------------------------------------------------------------------

// Model management functions
pub extern "c" fn LoadModel(fileName: [*c]const u8) Model; // Load model from files (meshes and materials)
pub extern "c" fn LoadModelFromMesh(mesh: Mesh) Model; // Load model from generated mesh (default material)
pub extern "c" fn IsModelReady(model: Model) bool; // Check if a model is ready
pub extern "c" fn UnloadModel(model: Model) void; // Unload model (including meshes) from memory (RAM and/or VRAM)
pub extern "c" fn GetModelBoundingBox(model: Model) BoundingBox; // Compute model bounding box limits (considers all meshes)

// Model drawing functions
pub extern "c" fn DrawModel(model: Model, position: Vector3, scale: f32, tint: Color) void; // Draw a model (with texture if set)
pub extern "c" fn DrawModelEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void; // Draw a model with extended parameters
pub extern "c" fn DrawModelWires(model: Model, position: Vector3, scale: f32, tint: Color) void; // Draw a model wires (with texture if set)
pub extern "c" fn DrawModelWiresEx(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: f32, scale: Vector3, tint: Color) void; // Draw a model wires (with texture if set) with extended parameters
pub extern "c" fn DrawBoundingBox(box: BoundingBox, color: Color) void; // Draw bounding box (wires)
pub extern "c" fn DrawBillboard(camera: Camera, texture: Texture2D, position: Vector3, size: f32, tint: Color) void; // Draw a billboard texture
pub extern "c" fn DrawBillboardRec(camera: Camera, texture: Texture2D, source: Rectangle, position: Vector3, size: Vector2, tint: Color) void; // Draw a billboard texture defined by source
pub extern "c" fn DrawBillboardPro(camera: Camera, texture: Texture2D, source: Rectangle, position: Vector3, up: Vector3, size: Vector2, origin: Vector2, rotation: f32, tint: Color) void; // Draw a billboard texture defined by source and rotation

// Mesh management functions
pub extern "c" fn UploadMesh(mesh: [*c]Mesh, dynamic: bool) void; // Upload mesh vertex data in GPU and provide VAO/VBO ids
pub extern "c" fn UpdateMeshBuffer(mesh: Mesh, index: c_int, data: *const anyopaque, dataSize: c_int, offset: c_int) void; // Update mesh vertex data in GPU for a specific buffer index
pub extern "c" fn UnloadMesh(mesh: Mesh) void; // Unload mesh data from CPU and GPU
pub extern "c" fn DrawMesh(mesh: Mesh, material: Material, transform: Matrix) void; // Draw a 3d mesh with material and transform
pub extern "c" fn DrawMeshInstanced(mesh: Mesh, material: Material, transforms: [*c]const Matrix, instances: c_int) void; // Draw multiple mesh instances with material and different transforms
pub extern "c" fn ExportMesh(mesh: Mesh, fileName: [*c]const u8) bool; // Export mesh data to file, returns true on success
pub extern "c" fn GetMeshBoundingBox(mesh: Mesh) BoundingBox; // Compute mesh bounding box limits
pub extern "c" fn GenMeshTangents(mesh: [*c]Mesh) void; // Compute mesh tangents

// Mesh generation functions
pub extern "c" fn GenMeshPoly(sides: c_int, radius: f32) Mesh; // Generate polygonal mesh
pub extern "c" fn GenMeshPlane(width: f32, length: f32, resX: c_int, resZ: c_int) Mesh; // Generate plane mesh (with subdivisions)
pub extern "c" fn GenMeshCube(width: f32, height: f32, length: f32) Mesh; // Generate cuboid mesh
pub extern "c" fn GenMeshSphere(radius: f32, rings: c_int, slices: c_int) Mesh; // Generate sphere mesh (standard sphere)
pub extern "c" fn GenMeshHemiSphere(radius: f32, rings: c_int, slices: c_int) Mesh; // Generate half-sphere mesh (no bottom cap)
pub extern "c" fn GenMeshCylinder(radius: f32, height: f32, slices: c_int) Mesh; // Generate cylinder mesh
pub extern "c" fn GenMeshCone(radius: f32, height: f32, slices: c_int) Mesh; // Generate cone/pyramid mesh
pub extern "c" fn GenMeshTorus(radius: f32, size: f32, radSeg: c_int, sides: c_int) Mesh; // Generate torus mesh
pub extern "c" fn GenMeshKnot(radius: f32, size: f32, radSeg: c_int, sides: c_int) Mesh; // Generate trefoil knot mesh
pub extern "c" fn GenMeshHeightmap(heightmap: Image, size: Vector3) Mesh; // Generate heightmap mesh from image data
pub extern "c" fn GenMeshCubicmap(cubicmap: Image, cubeSize: Vector3) Mesh; // Generate cubes-based map mesh from image data

// Material loading/unloading functions
pub extern "c" fn LoadMaterials(fileName: [*c]const u8, materialCount: [*c]c_int) [*c]Material; // Load materials from model file
pub extern "c" fn LoadMaterialDefault() Material; // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
pub extern "c" fn IsMaterialReady(material: Material) bool; // Check if a material is ready
pub extern "c" fn UnloadMaterial(material: Material) void; // Unload material from GPU memory (VRAM)
pub extern "c" fn SetMaterialTexture(material: [*c]Material, mapType: c_int, texture: Texture2D) void; // Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
pub extern "c" fn SetModelMeshMaterial(model: [*c]Model, meshId: c_int, materialId: c_int) void; // Set material for a mesh

// Model animations loading/unloading functions
pub extern "c" fn LoadModelAnimations(fileName: [*c]const u8, animCount: [*c]c_int) [*c]ModelAnimation; // Load model animations from file
pub extern "c" fn UpdateModelAnimation(model: Model, anim: ModelAnimation, frame: c_int) void; // Update model animation pose
pub extern "c" fn UnloadModelAnimation(anim: ModelAnimation) void; // Unload animation data
pub extern "c" fn UnloadModelAnimations(animations: [*c]ModelAnimation, animCount: c_int) void; // Unload animation array data
pub extern "c" fn IsModelAnimationValid(model: Model, anim: ModelAnimation) bool; // Check model animation skeleton match

// Collision detection functions
pub extern "c" fn CheckCollisionSpheres(center1: Vector3, radius1: f32, center2: Vector3, radius2: f32) bool; // Check collision between two spheres
pub extern "c" fn CheckCollisionBoxes(box1: BoundingBox, box2: BoundingBox) bool; // Check collision between two bounding boxes
pub extern "c" fn CheckCollisionBoxSphere(box: BoundingBox, center: Vector3, radius: f32) bool; // Check collision between box and sphere
pub extern "c" fn GetRayCollisionSphere(ray: Ray, center: Vector3, radius: f32) RayCollision; // Get collision info between ray and sphere
pub extern "c" fn GetRayCollisionBox(ray: Ray, box: BoundingBox) RayCollision; // Get collision info between ray and box
pub extern "c" fn GetRayCollisionMesh(ray: Ray, mesh: Mesh, transform: Matrix) RayCollision; // Get collision info between ray and mesh
pub extern "c" fn GetRayCollisionTriangle(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3) RayCollision; // Get collision info between ray and triangle
pub extern "c" fn GetRayCollisionQuad(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3, p4: Vector3) RayCollision; // Get collision info between ray and quad

//------------------------------------------------------------------------------------
// Audio Loading and Playing Functions (Module: audio)
//------------------------------------------------------------------------------------
pub const AudioCallback = *const fn (bufferData: *anyopaque, frames: c_uint) callconv(.C) void;

// Audio device management functions
pub extern "c" fn InitAudioDevice() void; // Initialize audio device and context
pub extern "c" fn CloseAudioDevice() void; // Close the audio device and context
pub extern "c" fn IsAudioDeviceReady() bool; // Check if audio device has been initialized successfully
pub extern "c" fn SetMasterVolume(volume: f32) void; // Set master volume (listener)
pub extern "c" fn GetMasterVolume() f32; // Get master volume (listener)

// Wave/Sound loading/unloading functions
pub extern "c" fn LoadWave(fileName: [*c]const u8) Wave; // Load wave data from file
pub extern "c" fn LoadWaveFromMemory(fileType: [*c]const u8, fileData: [*c]const u8, dataSize: c_int) Wave; // Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
pub extern "c" fn IsWaveReady(wave: Wave) bool; // Checks if wave data is ready
pub extern "c" fn LoadSound(fileName: [*c]const u8) Sound; // Load sound from file
pub extern "c" fn LoadSoundFromWave(wave: Wave) Sound; // Load sound from wave data
pub extern "c" fn LoadSoundAlias(source: Sound) Sound; // Create a new sound that shares the same sample data as the source sound, does not own the sound data
pub extern "c" fn IsSoundReady(sound: Sound) bool; // Checks if a sound is ready
pub extern "c" fn UpdateSound(sound: Sound, data: *const anyopaque, sampleCount: c_int) void; // Update sound buffer with new data
pub extern "c" fn UnloadWave(wave: Wave) void; // Unload wave data
pub extern "c" fn UnloadSound(sound: Sound) void; // Unload sound
pub extern "c" fn UnloadSoundAlias(alias: Sound) void; // Unload a sound alias (does not deallocate sample data)
pub extern "c" fn ExportWave(wave: Wave, fileName: [*c]const u8) bool; // Export wave data to file, returns true on success
pub extern "c" fn ExportWaveAsCode(wave: Wave, fileName: [*c]const u8) bool; // Export wave sample data to code (.h), returns true on success

// Wave/Sound management functions
pub extern "c" fn PlaySound(sound: Sound) void; // Play a sound
pub extern "c" fn StopSound(sound: Sound) void; // Stop playing a sound
pub extern "c" fn PauseSound(sound: Sound) void; // Pause a sound
pub extern "c" fn ResumeSound(sound: Sound) void; // Resume a paused sound
pub extern "c" fn IsSoundPlaying(sound: Sound) bool; // Check if a sound is currently playing
pub extern "c" fn SetSoundVolume(sound: Sound, volume: f32) void; // Set volume for a sound (1.0 is max level)
pub extern "c" fn SetSoundPitch(sound: Sound, pitch: f32) void; // Set pitch for a sound (1.0 is base level)
pub extern "c" fn SetSoundPan(sound: Sound, pan: f32) void; // Set pan for a sound (0.5 is center)
pub extern "c" fn WaveCopy(wave: Wave) Wave; // Copy a wave to a new wave
pub extern "c" fn WaveCrop(wave: [*c]Wave, initSample: c_int, finalSample: c_int) void; // Crop a wave to defined samples range
pub extern "c" fn WaveFormat(wave: [*c]Wave, sampleRate: c_int, sampleSize: c_int, channels: c_int) void; // Convert wave data to desired format
pub extern "c" fn LoadWaveSamples(wave: Wave) [*c]f32; // Load samples data from wave as a 32bit float data array
pub extern "c" fn UnloadWaveSamples(samples: [*c]f32) void; // Unload samples data loaded with LoadWaveSamples()

// Music management functions
pub extern "c" fn LoadMusicStream(fileName: [*c]const u8) Music; // Load music stream from file
pub extern "c" fn LoadMusicStreamFromMemory(fileType: [*c]const u8, data: [*c]const u8, dataSize: c_int) Music; // Load music stream from data
pub extern "c" fn IsMusicReady(music: Music) bool; // Checks if a music stream is ready
pub extern "c" fn UnloadMusicStream(music: Music) void; // Unload music stream
pub extern "c" fn PlayMusicStream(music: Music) void; // Start music playing
pub extern "c" fn IsMusicStreamPlaying(music: Music) bool; // Check if music is playing
pub extern "c" fn UpdateMusicStream(music: Music) void; // Updates buffers for music streaming
pub extern "c" fn StopMusicStream(music: Music) void; // Stop music playing
pub extern "c" fn PauseMusicStream(music: Music) void; // Pause music playing
pub extern "c" fn ResumeMusicStream(music: Music) void; // Resume playing paused music
pub extern "c" fn SeekMusicStream(music: Music, position: f32) void; // Seek music to a position (in seconds)
pub extern "c" fn SetMusicVolume(music: Music, volume: f32) void; // Set volume for music (1.0 is max level)
pub extern "c" fn SetMusicPitch(music: Music, pitch: f32) void; // Set pitch for a music (1.0 is base level)
pub extern "c" fn SetMusicPan(music: Music, pan: f32) void; // Set pan for a music (0.5 is center)
pub extern "c" fn GetMusicTimeLength(music: Music) f32; // Get music time length (in seconds)
pub extern "c" fn GetMusicTimePlayed(music: Music) f32; // Get current music time played (in seconds)

// AudioStream management functions
pub extern "c" fn LoadAudioStream(sampleRate: c_uint, sampleSize: c_uint, channels: c_uint) AudioStream; // Load audio stream (to stream raw audio pcm data)
pub extern "c" fn IsAudioStreamReady(stream: AudioStream) bool; // Checks if an audio stream is ready
pub extern "c" fn UnloadAudioStream(stream: AudioStream) void; // Unload audio stream and free memory
pub extern "c" fn UpdateAudioStream(stream: AudioStream, data: *const anyopaque, frameCount: c_int) void; // Update audio stream buffers with data
pub extern "c" fn IsAudioStreamProcessed(stream: AudioStream) bool; // Check if any audio stream buffers requires refill
pub extern "c" fn PlayAudioStream(stream: AudioStream) void; // Play audio stream
pub extern "c" fn PauseAudioStream(stream: AudioStream) void; // Pause audio stream
pub extern "c" fn ResumeAudioStream(stream: AudioStream) void; // Resume audio stream
pub extern "c" fn IsAudioStreamPlaying(stream: AudioStream) bool; // Check if audio stream is playing
pub extern "c" fn StopAudioStream(stream: AudioStream) void; // Stop audio stream
pub extern "c" fn SetAudioStreamVolume(stream: AudioStream, volume: f32) void; // Set volume for audio stream (1.0 is max level)
pub extern "c" fn SetAudioStreamPitch(stream: AudioStream, pitch: f32) void; // Set pitch for audio stream (1.0 is base level)
pub extern "c" fn SetAudioStreamPan(stream: AudioStream, pan: f32) void; // Set pan for audio stream (0.5 is centered)
pub extern "c" fn SetAudioStreamBufferSizeDefault(size: c_int) void; // Default size for new audio streams
pub extern "c" fn SetAudioStreamCallback(stream: AudioStream, callback: AudioCallback) void; // Audio thread callback to request new data

pub extern "c" fn AttachAudioStreamProcessor(stream: AudioStream, processor: AudioCallback) void; // Attach audio stream processor to stream, receives the samples as <float>s
pub extern "c" fn DetachAudioStreamProcessor(stream: AudioStream, processor: AudioCallback) void; // Detach audio stream processor from stream

pub extern "c" fn AttachAudioMixedProcessor(processor: AudioCallback) void; // Attach audio stream processor to the entire audio pipeline, receives the samples as <float>s
pub extern "c" fn DetachAudioMixedProcessor(processor: AudioCallback) void; // Detach audio stream processor from the entire audio pipeline
