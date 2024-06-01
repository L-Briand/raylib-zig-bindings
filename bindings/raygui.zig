const std = @import("std");

// C Options added at build time. See options.raygui.zig file.
const options = @import("raygui_options");

// raygui.h File

//----------------------------------------------------------------------------------
// Types and Structures Definition
// NOTE: Some types are required for RAYGUI_STANDALONE usage
//----------------------------------------------------------------------------------

const Vector2 = @import("raylib.zig").Vector2;
const Vector3 = @import("raylib.zig").Vector3;
const Color = @import("raylib.zig").Color;
const Rectangle = @import("raylib.zig").Rectangle;
const Texture2D = @import("raylib.zig").Texture2D;
const Image = @import("raylib.zig").Image;
const GlyphInfo = @import("raylib.zig").GlyphInfo;
const Font = @import("raylib.zig").Font;

// Style property
// NOTE: Used when exporting style as code for convenience
pub const GuiStyleProp = extern struct {
    controlId: c_ushort, // Control identifier
    propertyId: c_ushort, // Property identifier
    propertyValue: c_int, // Property value

    pub fn init(controlId: c_ushort, propertyId: c_ushort, propertyValue: c_int) GuiStyleProp {
        return GuiStyleProp{ .controlId = controlId, .propertyId = propertyId, .propertyValue = propertyValue };
    }
};

// Gui control state
pub const GuiState = enum(c_int) {
    STATE_NORMAL = 0,
    STATE_FOCUSED,
    STATE_PRESSED,
    STATE_DISABLED,

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Gui control text alignment
pub const GuiTextAlignment = enum(c_int) {
    TEXT_ALIGN_LEFT = 0,
    TEXT_ALIGN_CENTER,
    TEXT_ALIGN_RIGHT,

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Gui control text alignment vertical
// NOTE: Text vertical position inside the text bounds
pub const GuiTextAlignmentVertical = enum(c_int) {
    TEXT_ALIGN_TOP = 0,
    TEXT_ALIGN_MIDDLE,
    TEXT_ALIGN_BOTTOM,

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Gui control text wrap mode
// NOTE: Useful for multiline text
pub const GuiTextWrapMode = enum(c_int) {
    TEXT_WRAP_NONE = 0,
    TEXT_WRAP_CHAR,
    TEXT_WRAP_WORD,

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Gui controls
pub const GuiControl = enum(c_int) {
    // Default -> populates to all controls when set
    DEFAULT = 0,

    // Basic controls
    LABEL, // Used also for: LABELBUTTON
    BUTTON,
    TOGGLE, // Used also for: TOGGLEGROUP
    SLIDER, // Used also for: SLIDERBAR, TOGGLESLIDER
    PROGRESSBAR,
    CHECKBOX,
    COMBOBOX,
    DROPDOWNBOX,
    TEXTBOX, // Used also for: TEXTBOXMULTI
    VALUEBOX,
    SPINNER, // Uses: BUTTON, VALUEBOX
    LISTVIEW,
    COLORPICKER,
    SCROLLBAR,
    STATUSBAR,

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Gui base properties for every control
// NOTE: RAYGUI_MAX_PROPS_BASE properties (by default 16 properties)
pub const GuiControlProperty = enum(c_int) {
    BORDER_COLOR_NORMAL = 0, // Control border color in STATE_NORMAL
    BASE_COLOR_NORMAL, // Control base color in STATE_NORMAL
    TEXT_COLOR_NORMAL, // Control text color in STATE_NORMAL
    BORDER_COLOR_FOCUSED, // Control border color in STATE_FOCUSED
    BASE_COLOR_FOCUSED, // Control base color in STATE_FOCUSED
    TEXT_COLOR_FOCUSED, // Control text color in STATE_FOCUSED
    BORDER_COLOR_PRESSED, // Control border color in STATE_PRESSED
    BASE_COLOR_PRESSED, // Control base color in STATE_PRESSED
    TEXT_COLOR_PRESSED, // Control text color in STATE_PRESSED
    BORDER_COLOR_DISABLED, // Control border color in STATE_DISABLED
    BASE_COLOR_DISABLED, // Control base color in STATE_DISABLED
    TEXT_COLOR_DISABLED, // Control text color in STATE_DISABLED
    BORDER_WIDTH, // Control border size, 0 for no border
    //TEXT_SIZE,                  // Control text size (glyphs max height) -> GLOBAL for all controls
    //TEXT_SPACING,               // Control text spacing between glyphs -> GLOBAL for all controls
    //TEXT_LINE_SPACING           // Control text spacing between lines -> GLOBAL for all controls
    TEXT_PADDING, // Control text padding, not considering border
    TEXT_ALIGNMENT, // Control text horizontal alignment inside control text bound (after border and padding)
    //TEXT_WRAP_MODE              // Control text wrap-mode inside text bounds -> GLOBAL for all controls

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// TODO: Which text styling properties should be global or per-control?
// At this moment TEXT_PADDING and TEXT_ALIGNMENT is configured and saved per control while
// TEXT_SIZE, TEXT_SPACING, TEXT_LINE_SPACING, TEXT_ALIGNMENT_VERTICAL, TEXT_WRAP_MODE are global and
// should be configured by user as needed while defining the UI layout

// Gui extended properties depend on control
// NOTE: RAYGUI_MAX_PROPS_EXTENDED properties (by default, max 8 properties)
//----------------------------------------------------------------------------------
// DEFAULT extended properties
// NOTE: Those properties are common to all controls or global
// WARNING: We only have 8 slots for those properties by default!!! -> New global control: TEXT?
pub const GuiDefaultProperty = enum(c_int) {
    TEXT_SIZE = 16, // Text size (glyphs max height)
    TEXT_SPACING, // Text spacing between glyphs
    LINE_COLOR, // Line control color
    BACKGROUND_COLOR, // Background color
    TEXT_LINE_SPACING, // Text spacing between lines
    TEXT_ALIGNMENT_VERTICAL, // Text vertical alignment inside text bounds (after border and padding)
    TEXT_WRAP_MODE, // Text wrap-mode inside text bounds
    //TEXT_DECORATION             // Text decoration: 0-None, 1-Underline, 2-Line-through, 3-Overline
    //TEXT_DECORATION_THICK       // Text decoration line thikness

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Other possible text properties:
// TEXT_WEIGHT                  // Normal, Italic, Bold -> Requires specific font change
// TEXT_INDENT	                // Text indentation -> Now using TEXT_PADDING...

// Toggle/ToggleGroup
pub const GuiToggleProperty = enum(c_int) {
    GROUP_PADDING = 16, // ToggleGroup separation between toggles

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Slider/SliderBar
pub const GuiSliderProperty = enum(c_int) {
    SLIDER_WIDTH = 16, // Slider size of internal bar
    SLIDER_PADDING, // Slider/SliderBar internal bar padding

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// ProgressBar
pub const GuiProgressBarProperty = enum(c_int) {
    PROGRESS_PADDING = 16, // ProgressBar internal padding

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// ScrollBar
pub const GuiScrollBarProperty = enum(c_int) {
    ARROWS_SIZE = 16, // ScrollBar arrows size
    ARROWS_VISIBLE, // ScrollBar arrows visible
    SCROLL_SLIDER_PADDING, // ScrollBar slider internal padding
    SCROLL_SLIDER_SIZE, // ScrollBar slider size
    SCROLL_PADDING, // ScrollBar scroll padding from arrows
    SCROLL_SPEED, // ScrollBar scrolling speed

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// CheckBox
pub const GuiCheckBoxProperty = enum(c_int) {
    CHECK_PADDING = 16, // CheckBox internal check padding

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// ComboBox
pub const GuiComboBoxProperty = enum(c_int) {
    COMBO_BUTTON_WIDTH = 16, // ComboBox right button width
    COMBO_BUTTON_SPACING, // ComboBox button separation

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// DropdownBox
pub const GuiDropdownBoxProperty = enum(c_int) {
    ARROW_PADDING = 16, // DropdownBox arrow separation from border and items
    DROPDOWN_ITEMS_SPACING, // DropdownBox items separation

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// TextBox/TextBoxMulti/ValueBox/Spinner
pub const GuiTextBoxProperty = enum(c_int) {
    TEXT_READONLY = 16, // TextBox in read-only mode: 0-text editable, 1-text no-editable

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// Spinner
pub const GuiSpinnerProperty = enum(c_int) {
    SPIN_BUTTON_WIDTH = 16, // Spinner left/right buttons width
    SPIN_BUTTON_SPACING, // Spinner buttons separation

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// ListView
pub const GuiListViewProperty = enum(c_int) {
    LIST_ITEMS_HEIGHT = 16, // ListView items height
    LIST_ITEMS_SPACING, // ListView items separation
    SCROLLBAR_WIDTH, // ListView scrollbar size (usually width)
    SCROLLBAR_SIDE, // ListView scrollbar side (0-SCROLLBAR_LEFT_SIDE, 1-SCROLLBAR_RIGHT_SIDE)

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

// ColorPicker
pub const GuiColorPickerProperty = enum(c_int) {
    COLOR_SELECTOR_SIZE = 16,
    HUEBAR_WIDTH, // ColorPicker right hue bar width
    HUEBAR_PADDING, // ColorPicker right hue bar separation from panel
    HUEBAR_SELECTOR_HEIGHT, // ColorPicker right hue bar selector height
    HUEBAR_SELECTOR_OVERFLOW, // ColorPicker right hue bar selector overflow

    pub fn fromCInt(value: c_int) !@This() {
        return try std.meta.intToEnum(@This(), value);
    }

    pub fn toCInt(self: @This()) c_int {
        return @intFromEnum(self);
    }
};

pub const SCROLLBAR_LEFT_SIDE = 0;
pub const SCROLLBAR_RIGHT_SIDE = 1;

// Global gui state control functions
pub extern fn GuiEnable() void; // Enable gui controls (global state)
pub extern fn GuiDisable() void; // Disable gui controls (global state)
pub extern fn GuiLock() void; // Lock gui controls (global state)
pub extern fn GuiUnlock() void; // Unlock gui controls (global state)
pub extern fn GuiIsLocked() bool; // Check if gui is locked (global state)
pub extern fn GuiSetAlpha(alpha: f32) void; // Set gui controls alpha (global state), alpha goes from 0.0f to 1.0f
pub extern fn GuiSetState(state: GuiState) void; // Set gui state (global state)
pub extern fn GuiGetState() GuiState; // Get gui state (global state)

// Font set/get functions
pub extern fn GuiSetFont(font: Font) void; // Set gui custom font (global state)
pub extern fn GuiGetFont() Font; // Get gui custom font (global state)

// Style set/get functions
pub extern fn GuiSetStyle(control: c_int, property: c_int, value: c_int) void; // Set one style property
pub extern fn GuiGetStyle(control: c_int, property: c_int) c_int; // Get one style property

// Styles loading functions
pub extern fn GuiLoadStyle(fileName: [*c]const u8) void; // Load style file over global style variable (.rgs)
pub extern fn GuiLoadStyleDefault() void; // Load style default over global style

// Tooltips management functions
pub extern fn GuiEnableTooltip() void; // Enable gui tooltips (global state)
pub extern fn GuiDisableTooltip() void; // Disable gui tooltips (global state)
pub extern fn GuiSetTooltip(tooltip: [*c]const u8) void; // Set tooltip string

// Icons functionality
pub extern fn GuiIconText(iconId: GuiIconName, text: [*c]const u8) [*c]const u8; // Get text with icon id prepended (if supported)

// NOTE: The 4 functions below are only available when RAYGUI_NO_ICONS is set.
pub extern fn GuiSetIconScale(scale: c_int) void; // Set default icon drawing size
pub extern fn GuiGetIcons() [*c]c_uint; // Get raygui icons data pointer
pub extern fn GuiLoadIcons(fileName: [*c]const u8, loadIconsName: bool) [*c][*c]u8; // Load raygui icons file (.rgi) into internal icons data
pub extern fn GuiDrawIcon(iconId: GuiIconName, posX: c_int, posY: c_int, pixelSize: c_int, color: Color) void; // Draw icon using pixel size at specified position

// Controls
//----------------------------------------------------------------------------------------------------------
// Container/separator controls, useful for controls organization
pub extern fn GuiWindowBox(bounds: Rectangle, title: [*c]const u8) c_int; // Window Box control, shows a window that can be closed
pub extern fn GuiGroupBox(bounds: Rectangle, text: [*c]const u8) c_int; // Group Box control with text name
pub extern fn GuiLine(bounds: Rectangle, text: [*c]const u8) c_int; // Line separator control, could contain text
pub extern fn GuiPanel(bounds: Rectangle, text: [*c]const u8) c_int; // Panel control, useful to group controls
pub extern fn GuiTabBar(bounds: Rectangle, text: [*c][*c]const u8, count: c_int, active: [*c]c_int) c_int; // Tab Bar control, returns TAB to be closed or -1
pub extern fn GuiScrollPanel(bounds: Rectangle, text: [*c]const u8, content: Rectangle, scroll: [*c]Vector2, view: [*c]Rectangle) c_int; // Scroll Panel control

// Basic controls set
pub extern fn GuiLabel(bounds: Rectangle, text: [*c]const u8) c_int; // Label control, shows text
pub extern fn GuiButton(bounds: Rectangle, text: [*c]const u8) c_int; // Button control, returns true when clicked
pub extern fn GuiLabelButton(bounds: Rectangle, text: [*c]const u8) c_int; // Label button control, show true when clicked
pub extern fn GuiToggle(bounds: Rectangle, text: [*c]const u8, active: [*c]bool) c_int; // Toggle Button control, returns true when active
pub extern fn GuiToggleGroup(bounds: Rectangle, text: [*c]const u8, active: [*c]c_int) c_int; // Toggle Group control, returns active toggle index
pub extern fn GuiToggleSlider(bounds: Rectangle, text: [*c]const u8, active: [*c]c_int) c_int; // Toggle Slider control, returns true when clicked
pub extern fn GuiCheckBox(bounds: Rectangle, text: [*c]const u8, checked: [*c]bool) c_int; // Check Box control, returns true when active
pub extern fn GuiComboBox(bounds: Rectangle, text: [*c]const u8, active: [*c]c_int) c_int; // Combo Box control, returns selected item index

pub extern fn GuiDropdownBox(bounds: Rectangle, text: [*c]const u8, active: [*c]c_int, editMode: bool) c_int; // Dropdown Box control, returns selected item
pub extern fn GuiSpinner(bounds: Rectangle, text: [*c]const u8, value: [*c]c_int, minValue: c_int, maxValue: c_int, editMode: bool) c_int; // Spinner control, returns selected value
pub extern fn GuiValueBox(bounds: Rectangle, text: [*c]const u8, value: [*c]c_int, minValue: c_int, maxValue: c_int, editMode: bool) c_int; // Value Box control, updates input text with numbers
pub extern fn GuiTextBox(bounds: Rectangle, text: [*c]u8, textSize: c_int, editMode: bool) c_int; // Text Box control, updates input text

pub extern fn GuiSlider(bounds: Rectangle, textLeft: [*c]const u8, textRight: [*c]const u8, value: [*c]f32, minValue: f32, maxValue: f32) c_int; // Slider control, returns selected value
pub extern fn GuiSliderBar(bounds: Rectangle, textLeft: [*c]const u8, textRight: [*c]const u8, value: [*c]f32, minValue: f32, maxValue: f32) c_int; // Slider Bar control, returns selected value
pub extern fn GuiProgressBar(bounds: Rectangle, textLeft: [*c]const u8, textRight: [*c]const u8, value: [*c]f32, minValue: f32, maxValue: f32) c_int; // Progress Bar control, shows current progress value
pub extern fn GuiStatusBar(bounds: Rectangle, text: [*c]const u8) c_int; // Status Bar control, shows info text
pub extern fn GuiDummyRec(bounds: Rectangle, text: [*c]const u8) c_int; // Dummy control for placeholders
pub extern fn GuiGrid(bounds: Rectangle, text: [*c]const u8, spacing: f32, subdivs: c_int, mouseCell: [*c]Vector2) c_int; // Grid control, returns mouse cell position

// Advance controls set
pub extern fn GuiListView(bounds: Rectangle, text: [*c]const u8, scrollIndex: [*c]c_int, active: [*c]c_int) c_int; // List View control, returns selected list item index
pub extern fn GuiListViewEx(bounds: Rectangle, text: [*c][*c]const u8, count: c_int, scrollIndex: [*c]c_int, active: [*c]c_int, focus: [*c]c_int) c_int; // List View with extended parameters
pub extern fn GuiMessageBox(bounds: Rectangle, title: [*c]const u8, message: [*c]const u8, buttons: [*c]const u8) c_int; // Message Box control, displays a message
pub extern fn GuiTextInputBox(bounds: Rectangle, title: [*c]const u8, message: [*c]const u8, buttons: [*c]const u8, text: [*c]u8, textMaxSize: c_int, secretViewActive: [*c]bool) c_int; // Text Input Box control, ask for text, supports secret
pub extern fn GuiColorPicker(bounds: Rectangle, text: [*c]const u8, color: [*c]Color) c_int; // Color Picker control (multiple color controls)
pub extern fn GuiColorPanel(bounds: Rectangle, text: [*c]const u8, color: [*c]Color) c_int; // Color Panel control
pub extern fn GuiColorBarAlpha(bounds: Rectangle, text: [*c]const u8, alpha: [*c]f32) c_int; // Color Bar Alpha control
pub extern fn GuiColorBarHue(bounds: Rectangle, text: [*c]const u8, value: [*c]f32) c_int; // Color Bar Hue control
pub extern fn GuiColorPickerHSV(bounds: Rectangle, text: [*c]const u8, colorHsv: [*c]Vector3) c_int; // Color Picker control that avoids conversion to RGB on each call (multiple color controls)
pub extern fn GuiColorPanelHSV(bounds: Rectangle, text: [*c]const u8, colorHsv: [*c]Vector3) c_int; // Color Panel control that returns HSV color value, used by GuiColorPickerHSV()
//----------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------
// Icons enumeration
//----------------------------------------------------------------------------------
pub const GuiIconName = enum(c_int) {
    ICON_NONE = 0,
    ICON_FOLDER_FILE_OPEN = 1,
    ICON_FILE_SAVE_CLASSIC = 2,
    ICON_FOLDER_OPEN = 3,
    ICON_FOLDER_SAVE = 4,
    ICON_FILE_OPEN = 5,
    ICON_FILE_SAVE = 6,
    ICON_FILE_EXPORT = 7,
    ICON_FILE_ADD = 8,
    ICON_FILE_DELETE = 9,
    ICON_FILETYPE_TEXT = 10,
    ICON_FILETYPE_AUDIO = 11,
    ICON_FILETYPE_IMAGE = 12,
    ICON_FILETYPE_PLAY = 13,
    ICON_FILETYPE_VIDEO = 14,
    ICON_FILETYPE_INFO = 15,
    ICON_FILE_COPY = 16,
    ICON_FILE_CUT = 17,
    ICON_FILE_PASTE = 18,
    ICON_CURSOR_HAND = 19,
    ICON_CURSOR_POINTER = 20,
    ICON_CURSOR_CLASSIC = 21,
    ICON_PENCIL = 22,
    ICON_PENCIL_BIG = 23,
    ICON_BRUSH_CLASSIC = 24,
    ICON_BRUSH_PAINTER = 25,
    ICON_WATER_DROP = 26,
    ICON_COLOR_PICKER = 27,
    ICON_RUBBER = 28,
    ICON_COLOR_BUCKET = 29,
    ICON_TEXT_T = 30,
    ICON_TEXT_A = 31,
    ICON_SCALE = 32,
    ICON_RESIZE = 33,
    ICON_FILTER_POINT = 34,
    ICON_FILTER_BILINEAR = 35,
    ICON_CROP = 36,
    ICON_CROP_ALPHA = 37,
    ICON_SQUARE_TOGGLE = 38,
    ICON_SYMMETRY = 39,
    ICON_SYMMETRY_HORIZONTAL = 40,
    ICON_SYMMETRY_VERTICAL = 41,
    ICON_LENS = 42,
    ICON_LENS_BIG = 43,
    ICON_EYE_ON = 44,
    ICON_EYE_OFF = 45,
    ICON_FILTER_TOP = 46,
    ICON_FILTER = 47,
    ICON_TARGET_POINT = 48,
    ICON_TARGET_SMALL = 49,
    ICON_TARGET_BIG = 50,
    ICON_TARGET_MOVE = 51,
    ICON_CURSOR_MOVE = 52,
    ICON_CURSOR_SCALE = 53,
    ICON_CURSOR_SCALE_RIGHT = 54,
    ICON_CURSOR_SCALE_LEFT = 55,
    ICON_UNDO = 56,
    ICON_REDO = 57,
    ICON_REREDO = 58,
    ICON_MUTATE = 59,
    ICON_ROTATE = 60,
    ICON_REPEAT = 61,
    ICON_SHUFFLE = 62,
    ICON_EMPTYBOX = 63,
    ICON_TARGET = 64,
    ICON_TARGET_SMALL_FILL = 65,
    ICON_TARGET_BIG_FILL = 66,
    ICON_TARGET_MOVE_FILL = 67,
    ICON_CURSOR_MOVE_FILL = 68,
    ICON_CURSOR_SCALE_FILL = 69,
    ICON_CURSOR_SCALE_RIGHT_FILL = 70,
    ICON_CURSOR_SCALE_LEFT_FILL = 71,
    ICON_UNDO_FILL = 72,
    ICON_REDO_FILL = 73,
    ICON_REREDO_FILL = 74,
    ICON_MUTATE_FILL = 75,
    ICON_ROTATE_FILL = 76,
    ICON_REPEAT_FILL = 77,
    ICON_SHUFFLE_FILL = 78,
    ICON_EMPTYBOX_SMALL = 79,
    ICON_BOX = 80,
    ICON_BOX_TOP = 81,
    ICON_BOX_TOP_RIGHT = 82,
    ICON_BOX_RIGHT = 83,
    ICON_BOX_BOTTOM_RIGHT = 84,
    ICON_BOX_BOTTOM = 85,
    ICON_BOX_BOTTOM_LEFT = 86,
    ICON_BOX_LEFT = 87,
    ICON_BOX_TOP_LEFT = 88,
    ICON_BOX_CENTER = 89,
    ICON_BOX_CIRCLE_MASK = 90,
    ICON_POT = 91,
    ICON_ALPHA_MULTIPLY = 92,
    ICON_ALPHA_CLEAR = 93,
    ICON_DITHERING = 94,
    ICON_MIPMAPS = 95,
    ICON_BOX_GRID = 96,
    ICON_GRID = 97,
    ICON_BOX_CORNERS_SMALL = 98,
    ICON_BOX_CORNERS_BIG = 99,
    ICON_FOUR_BOXES = 100,
    ICON_GRID_FILL = 101,
    ICON_BOX_MULTISIZE = 102,
    ICON_ZOOM_SMALL = 103,
    ICON_ZOOM_MEDIUM = 104,
    ICON_ZOOM_BIG = 105,
    ICON_ZOOM_ALL = 106,
    ICON_ZOOM_CENTER = 107,
    ICON_BOX_DOTS_SMALL = 108,
    ICON_BOX_DOTS_BIG = 109,
    ICON_BOX_CONCENTRIC = 110,
    ICON_BOX_GRID_BIG = 111,
    ICON_OK_TICK = 112,
    ICON_CROSS = 113,
    ICON_ARROW_LEFT = 114,
    ICON_ARROW_RIGHT = 115,
    ICON_ARROW_DOWN = 116,
    ICON_ARROW_UP = 117,
    ICON_ARROW_LEFT_FILL = 118,
    ICON_ARROW_RIGHT_FILL = 119,
    ICON_ARROW_DOWN_FILL = 120,
    ICON_ARROW_UP_FILL = 121,
    ICON_AUDIO = 122,
    ICON_FX = 123,
    ICON_WAVE = 124,
    ICON_WAVE_SINUS = 125,
    ICON_WAVE_SQUARE = 126,
    ICON_WAVE_TRIANGULAR = 127,
    ICON_CROSS_SMALL = 128,
    ICON_PLAYER_PREVIOUS = 129,
    ICON_PLAYER_PLAY_BACK = 130,
    ICON_PLAYER_PLAY = 131,
    ICON_PLAYER_PAUSE = 132,
    ICON_PLAYER_STOP = 133,
    ICON_PLAYER_NEXT = 134,
    ICON_PLAYER_RECORD = 135,
    ICON_MAGNET = 136,
    ICON_LOCK_CLOSE = 137,
    ICON_LOCK_OPEN = 138,
    ICON_CLOCK = 139,
    ICON_TOOLS = 140,
    ICON_GEAR = 141,
    ICON_GEAR_BIG = 142,
    ICON_BIN = 143,
    ICON_HAND_POINTER = 144,
    ICON_LASER = 145,
    ICON_COIN = 146,
    ICON_EXPLOSION = 147,
    ICON_1UP = 148,
    ICON_PLAYER = 149,
    ICON_PLAYER_JUMP = 150,
    ICON_KEY = 151,
    ICON_DEMON = 152,
    ICON_TEXT_POPUP = 153,
    ICON_GEAR_EX = 154,
    ICON_CRACK = 155,
    ICON_CRACK_POINTS = 156,
    ICON_STAR = 157,
    ICON_DOOR = 158,
    ICON_EXIT = 159,
    ICON_MODE_2D = 160,
    ICON_MODE_3D = 161,
    ICON_CUBE = 162,
    ICON_CUBE_FACE_TOP = 163,
    ICON_CUBE_FACE_LEFT = 164,
    ICON_CUBE_FACE_FRONT = 165,
    ICON_CUBE_FACE_BOTTOM = 166,
    ICON_CUBE_FACE_RIGHT = 167,
    ICON_CUBE_FACE_BACK = 168,
    ICON_CAMERA = 169,
    ICON_SPECIAL = 170,
    ICON_LINK_NET = 171,
    ICON_LINK_BOXES = 172,
    ICON_LINK_MULTI = 173,
    ICON_LINK = 174,
    ICON_LINK_BROKE = 175,
    ICON_TEXT_NOTES = 176,
    ICON_NOTEBOOK = 177,
    ICON_SUITCASE = 178,
    ICON_SUITCASE_ZIP = 179,
    ICON_MAILBOX = 180,
    ICON_MONITOR = 181,
    ICON_PRINTER = 182,
    ICON_PHOTO_CAMERA = 183,
    ICON_PHOTO_CAMERA_FLASH = 184,
    ICON_HOUSE = 185,
    ICON_HEART = 186,
    ICON_CORNER = 187,
    ICON_VERTICAL_BARS = 188,
    ICON_VERTICAL_BARS_FILL = 189,
    ICON_LIFE_BARS = 190,
    ICON_INFO = 191,
    ICON_CROSSLINE = 192,
    ICON_HELP = 193,
    ICON_FILETYPE_ALPHA = 194,
    ICON_FILETYPE_HOME = 195,
    ICON_LAYERS_VISIBLE = 196,
    ICON_LAYERS = 197,
    ICON_WINDOW = 198,
    ICON_HIDPI = 199,
    ICON_FILETYPE_BINARY = 200,
    ICON_HEX = 201,
    ICON_SHIELD = 202,
    ICON_FILE_NEW = 203,
    ICON_FOLDER_ADD = 204,
    ICON_ALARM = 205,
    ICON_CPU = 206,
    ICON_ROM = 207,
    ICON_STEP_OVER = 208,
    ICON_STEP_INTO = 209,
    ICON_STEP_OUT = 210,
    ICON_RESTART = 211,
    ICON_BREAKPOINT_ON = 212,
    ICON_BREAKPOINT_OFF = 213,
    ICON_BURGER_MENU = 214,
    ICON_CASE_SENSITIVE = 215,
    ICON_REG_EXP = 216,
    ICON_FOLDER = 217,
    ICON_FILE = 218,
    ICON_SAND_TIMER = 219,
    ICON_220 = 220,
    ICON_221 = 221,
    ICON_222 = 222,
    ICON_223 = 223,
    ICON_224 = 224,
    ICON_225 = 225,
    ICON_226 = 226,
    ICON_227 = 227,
    ICON_228 = 228,
    ICON_229 = 229,
    ICON_230 = 230,
    ICON_231 = 231,
    ICON_232 = 232,
    ICON_233 = 233,
    ICON_234 = 234,
    ICON_235 = 235,
    ICON_236 = 236,
    ICON_237 = 237,
    ICON_238 = 238,
    ICON_239 = 239,
    ICON_240 = 240,
    ICON_241 = 241,
    ICON_242 = 242,
    ICON_243 = 243,
    ICON_244 = 244,
    ICON_245 = 245,
    ICON_246 = 246,
    ICON_247 = 247,
    ICON_248 = 248,
    ICON_249 = 249,
    ICON_250 = 250,
    ICON_251 = 251,
    ICON_252 = 252,
    ICON_253 = 253,
    ICON_254 = 254,
    ICON_255 = 255,
};
