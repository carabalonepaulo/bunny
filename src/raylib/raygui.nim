# 
#   raygui v3.2 - A simple and easy-to-use immediate-mode gui library
# 
#   DESCRIPTION:
# 
#   raygui is a tools-dev-focused immediate-mode-gui library based on raylib but also
#   available as a standalone library, as long as input and drawing functions are provided.
# 
#   Controls provided:
# 
#   # Container/separators Controls
#       - WindowBox     --> StatusBar, Panel
#       - GroupBox      --> Line
#       - Line
#       - Panel         --> StatusBar
#       - ScrollPanel   --> StatusBar
# 
#   # Basic Controls
#       - Label
#       - Button
#       - LabelButton   --> Label
#       - Toggle
#       - ToggleGroup   --> Toggle
#       - CheckBox
#       - ComboBox
#       - DropdownBox
#       - TextBox
#       - TextBoxMulti
#       - ValueBox      --> TextBox
#       - Spinner       --> Button, ValueBox
#       - Slider
#       - SliderBar     --> Slider
#       - ProgressBar
#       - StatusBar
#       - DummyRec
#       - Grid
# 
#   # Advance Controls
#       - ListView
#       - ColorPicker   --> ColorPanel, ColorBarHue
#       - MessageBox    --> Window, Label, Button
#       - TextInputBox  --> Window, Label, TextBox, Button
# 
#   It also provides a set of functions for styling the controls based on its properties (size, color).
# 
# 
#   RAYGUI STYLE (guiStyle):
# 
#   raygui uses a global data array for all gui style properties (allocated on data segment by default),
#   when a new style is loaded, it is loaded over the global style... but a default gui style could always be
#   recovered with GuiLoadStyleDefault() function, that overwrites the current style to the default one
# 
#   The global style array size is fixed and depends on the number of controls and properties:
# 
#       static unsigned int guiStyle[RAYGUI_MAX_CONTROLS*(RAYGUI_MAX_PROPS_BASE + RAYGUI_MAX_PROPS_EXTENDED)];
# 
#   guiStyle size is by default: 16*(16 + 8) = 384*4 = 1536 bytes = 1.5 KB
# 
#   Note that the first set of BASE properties (by default guiStyle[0..15]) belong to the generic style
#   used for all controls, when any of those base values is set, it is automatically populated to all
#   controls, so, specific control values overwriting generic style should be set after base values.
# 
#   After the first BASE set we have the EXTENDED properties (by default guiStyle[16..23]), those
#   properties are actually common to all controls and can not be overwritten individually (like BASE ones)
#   Some of those properties are: TEXT_SIZE, TEXT_SPACING, LINE_COLOR, BACKGROUND_COLOR
# 
#   Custom control properties can be defined using the EXTENDED properties for each independent control.
# 
#   TOOL: rGuiStyler is a visual tool to customize raygui style.
# 
# 
#   RAYGUI ICONS (guiIcons):
# 
#   raygui could use a global array containing icons data (allocated on data segment by default),
#   a custom icons set could be loaded over this array using GuiLoadIcons(), but loaded icons set
#   must be same RAYGUI_ICON_SIZE and no more than RAYGUI_ICON_MAX_ICONS will be loaded
# 
#   Every icon is codified in binary form, using 1 bit per pixel, so, every 16x16 icon
#   requires 8 integers (16*16/32) to be stored in memory.
# 
#   When the icon is draw, actually one quad per pixel is drawn if the bit for that pixel is set.
# 
#   The global icons array size is fixed and depends on the number of icons and size:
# 
#       static unsigned int guiIcons[RAYGUI_ICON_MAX_ICONS*RAYGUI_ICON_DATA_ELEMENTS];
# 
#   guiIcons size is by default: 256*(16*16/32) = 2048*4 = 8192 bytes = 8 KB
# 
#   TOOL: rGuiIcons is a visual tool to customize raygui icons.
# 
# 
#   CONFIGURATION:
# 
#   #define RAYGUI_IMPLEMENTATION
#       Generates the implementation of the library into the included file.
#       If not defined, the library is in header only mode and can be included in other headers
#       or source files without problems. But only ONE file should hold the implementation.
# 
#   #define RAYGUI_STANDALONE
#       Avoid raylib.h header inclusion in this file. Data types defined on raylib are defined
#       internally in the library and input management and drawing functions must be provided by
#       the user (check library implementation for further details).
# 
#   #define RAYGUI_NO_ICONS
#       Avoid including embedded ricons data (256 icons, 16x16 pixels, 1-bit per pixel, 2KB)
# 
#   #define RAYGUI_CUSTOM_ICONS
#       Includes custom ricons.h header defining a set of custom icons,
#       this file can be generated using rGuiIcons tool
# 
# 
#   VERSIONS HISTORY:
#       3.2 (22-May-2022) RENAMED: Some enum values, for unification, avoiding prefixes
#                         REMOVED: GuiScrollBar(), only internal
#                         REDESIGNED: GuiPanel() to support text parameter
#                         REDESIGNED: GuiScrollPanel() to support text parameter
#                         REDESIGNED: GuiColorPicker() to support text parameter
#                         REDESIGNED: GuiColorPanel() to support text parameter
#                         REDESIGNED: GuiColorBarAlpha() to support text parameter
#                         REDESIGNED: GuiColorBarHue() to support text parameter
#                         REDESIGNED: GuiTextInputBox() to support password
#       3.1 (12-Jan-2022) REVIEWED: Default style for consistency (aligned with rGuiLayout v2.5 tool)
#                         REVIEWED: GuiLoadStyle() to support compressed font atlas image data and unload previous textures
#                         REVIEWED: External icons usage logic
#                         REVIEWED: GuiLine() for centered alignment when including text
#                         RENAMED: Multiple controls properties definitions to prepend RAYGUI_
#                         RENAMED: RICON_ references to RAYGUI_ICON_ for library consistency
#                         Projects updated and multiple tweaks
#       3.0 (04-Nov-2021) Integrated ricons data to avoid external file
#                         REDESIGNED: GuiTextBoxMulti()
#                         REMOVED: GuiImageButton*()
#                         Multiple minor tweaks and bugs corrected
#       2.9 (17-Mar-2021) REMOVED: Tooltip API
#       2.8 (03-May-2020) Centralized rectangles drawing to GuiDrawRectangle()
#       2.7 (20-Feb-2020) ADDED: Possible tooltips API
#       2.6 (09-Sep-2019) ADDED: GuiTextInputBox()
#                         REDESIGNED: GuiListView*(), GuiDropdownBox(), GuiSlider*(), GuiProgressBar(), GuiMessageBox()
#                         REVIEWED: GuiTextBox(), GuiSpinner(), GuiValueBox(), GuiLoadStyle()
#                         Replaced property INNER_PADDING by TEXT_PADDING, renamed some properties
#                         ADDED: 8 new custom styles ready to use
#                         Multiple minor tweaks and bugs corrected
#       2.5 (28-May-2019) Implemented extended GuiTextBox(), GuiValueBox(), GuiSpinner()
#       2.3 (29-Apr-2019) ADDED: rIcons auxiliar library and support for it, multiple controls reviewed
#                         Refactor all controls drawing mechanism to use control state
#       2.2 (05-Feb-2019) ADDED: GuiScrollBar(), GuiScrollPanel(), reviewed GuiListView(), removed Gui*Ex() controls
#       2.1 (26-Dec-2018) REDESIGNED: GuiCheckBox(), GuiComboBox(), GuiDropdownBox(), GuiToggleGroup() > Use combined text string
#                         REDESIGNED: Style system (breaking change)
#       2.0 (08-Nov-2018) ADDED: Support controls guiLock and custom fonts
#                         REVIEWED: GuiComboBox(), GuiListView()...
#       1.9 (09-Oct-2018) REVIEWED: GuiGrid(), GuiTextBox(), GuiTextBoxMulti(), GuiValueBox()...
#       1.8 (01-May-2018) Lot of rework and redesign to align with rGuiStyler and rGuiLayout
#       1.5 (21-Jun-2017) Working in an improved styles system
#       1.4 (15-Jun-2017) Rewritten all GUI functions (removed useless ones)
#       1.3 (12-Jun-2017) Complete redesign of style system
#       1.1 (01-Jun-2017) Complete review of the library
#       1.0 (07-Jun-2016) Converted to header-only by Ramon Santamaria.
#       0.9 (07-Mar-2016) Reviewed and tested by Albert Martos, Ian Eito, Sergio Martinez and Ramon Santamaria.
#       0.8 (27-Aug-2015) Initial release. Implemented by Kevin Gato, Daniel Nicolás and Ramon Santamaria.
# 
# 
#   CONTRIBUTORS:
# 
#       Ramon Santamaria:   Supervision, review, redesign, update and maintenance
#       Vlad Adrian:        Complete rewrite of GuiTextBox() to support extended features (2019)
#       Sergio Martinez:    Review, testing (2015) and redesign of multiple controls (2018)
#       Adria Arranz:       Testing and Implementation of additional controls (2018)
#       Jordi Jorba:        Testing and Implementation of additional controls (2018)
#       Albert Martos:      Review and testing of the library (2015)
#       Ian Eito:           Review and testing of the library (2015)
#       Kevin Gato:         Initial implementation of basic components (2014)
#       Daniel Nicolas:     Initial implementation of basic components (2014)
# 
# 
#   LICENSE: zlib/libpng
# 
#   Copyright (c) 2014-2022 Ramon Santamaria (@raysan5)
# 
#   This software is provided "as-is", without any express or implied warranty. In no event
#   will the authors be held liable for any damages arising from the use of this software.
# 
#   Permission is granted to anyone to use this software for any purpose, including commercial
#   applications, and to alter it and redistribute it freely, subject to the following restrictions:
# 
#     1. The origin of this software must not be misrepresented; you must not claim that you
#     wrote the original software. If you use this software in a product, an acknowledgment
#     in the product documentation would be appreciated but is not required.
# 
#     2. Altered source versions must be plainly marked as such, and must not be misrepresented
#     as being the original software.
# 
#     3. This notice may not be removed or altered from any source distribution.
# 
template RAYGUI_H*(): auto = RAYGUI_H
template RAYGUI_VERSION*(): auto = "3.2"
import raylib
# Function specifiers in case library is build/used as a shared library (Windows)
# NOTE: Microsoft specifiers to tell compiler that symbols are imported/exported from a .dll
# Function specifiers definition
# ----------------------------------------------------------------------------------
# Defines and Macros
# ----------------------------------------------------------------------------------
# Allow custom memory allocators
# Simple log system to avoid printf() calls if required
# NOTE: Avoiding those calls, also avoids const strings memory usage
template RAYGUI_SUPPORT_LOG_INFO*(): auto = RAYGUI_SUPPORT_LOG_INFO
# ----------------------------------------------------------------------------------
# Types and Structures Definition
# NOTE: Some types are required for RAYGUI_STANDALONE usage
# ----------------------------------------------------------------------------------
# Style property
type GuiStyleProp* {.bycopy.} = object
    controlId*: uint16 
    propertyId*: uint16 
    propertyValue*: uint32 
# Gui control state
type GuiState* = enum 
    STATE_NORMAL = 0 
    STATE_FOCUSED 
    STATE_PRESSED 
    STATE_DISABLED 
converter GuiState2int32* (self: GuiState): int32 = self.int32 
# Gui control text alignment
type GuiTextAlignment* = enum 
    TEXT_ALIGN_LEFT = 0 
    TEXT_ALIGN_CENTER 
    TEXT_ALIGN_RIGHT 
converter GuiTextAlignment2int32* (self: GuiTextAlignment): int32 = self.int32 
# Gui controls
type GuiControl* = enum 
    DEFAULT = 0 
    LABEL # Used also for: LABELBUTTON
    BUTTON 
    TOGGLE # Used also for: TOGGLEGROUP
    SLIDER # Used also for: SLIDERBAR
    PROGRESSBAR 
    CHECKBOX 
    COMBOBOX 
    DROPDOWNBOX 
    TEXTBOX # Used also for: TEXTBOXMULTI
    VALUEBOX 
    SPINNER # Uses: BUTTON, VALUEBOX
    LISTVIEW 
    COLORPICKER 
    SCROLLBAR 
    STATUSBAR 
converter GuiControl2int32* (self: GuiControl): int32 = self.int32 
# Gui base properties for every control
# NOTE: RAYGUI_MAX_PROPS_BASE properties (by default 16 properties)
type GuiControlProperty* = enum 
    BORDER_COLOR_NORMAL = 0 
    BASE_COLOR_NORMAL 
    TEXT_COLOR_NORMAL 
    BORDER_COLOR_FOCUSED 
    BASE_COLOR_FOCUSED 
    TEXT_COLOR_FOCUSED 
    BORDER_COLOR_PRESSED 
    BASE_COLOR_PRESSED 
    TEXT_COLOR_PRESSED 
    BORDER_COLOR_DISABLED 
    BASE_COLOR_DISABLED 
    TEXT_COLOR_DISABLED 
    BORDER_WIDTH 
    TEXT_PADDING 
    TEXT_ALIGNMENT 
    RESERVED 
converter GuiControlProperty2int32* (self: GuiControlProperty): int32 = self.int32 
# Gui extended properties depend on control
# NOTE: RAYGUI_MAX_PROPS_EXTENDED properties (by default 8 properties)
# ----------------------------------------------------------------------------------
# DEFAULT extended properties
# NOTE: Those properties are common to all controls or global
type GuiDefaultProperty* = enum 
    TEXT_SIZE = 16 # Text size (glyphs max height)
    TEXT_SPACING # Text spacing between glyphs
    LINE_COLOR # Line control color
    BACKGROUND_COLOR # Background color
converter GuiDefaultProperty2int32* (self: GuiDefaultProperty): int32 = self.int32 
# Label
# typedef enum { } GuiLabelProperty;
# Button/Spinner
# typedef enum { } GuiButtonProperty;
# Toggle/ToggleGroup
type GuiToggleProperty* = enum 
    GROUP_PADDING = 16 # ToggleGroup separation between toggles
converter GuiToggleProperty2int32* (self: GuiToggleProperty): int32 = self.int32 
# Slider/SliderBar
type GuiSliderProperty* = enum 
    SLIDER_WIDTH = 16 # Slider size of internal bar
    SLIDER_PADDING # Slider/SliderBar internal bar padding
converter GuiSliderProperty2int32* (self: GuiSliderProperty): int32 = self.int32 
# ProgressBar
type GuiProgressBarProperty* = enum 
    PROGRESS_PADDING = 16 # ProgressBar internal padding
converter GuiProgressBarProperty2int32* (self: GuiProgressBarProperty): int32 = self.int32 
# ScrollBar
type GuiScrollBarProperty* = enum 
    ARROWS_SIZE = 16 
    ARROWS_VISIBLE 
    SCROLL_SLIDER_PADDING # (SLIDERBAR, SLIDER_PADDING)
    SCROLL_SLIDER_SIZE 
    SCROLL_PADDING 
    SCROLL_SPEED 
converter GuiScrollBarProperty2int32* (self: GuiScrollBarProperty): int32 = self.int32 
# CheckBox
type GuiCheckBoxProperty* = enum 
    CHECK_PADDING = 16 # CheckBox internal check padding
converter GuiCheckBoxProperty2int32* (self: GuiCheckBoxProperty): int32 = self.int32 
# ComboBox
type GuiComboBoxProperty* = enum 
    COMBO_BUTTON_WIDTH = 16 # ComboBox right button width
    COMBO_BUTTON_SPACING # ComboBox button separation
converter GuiComboBoxProperty2int32* (self: GuiComboBoxProperty): int32 = self.int32 
# DropdownBox
type GuiDropdownBoxProperty* = enum 
    ARROW_PADDING = 16 # DropdownBox arrow separation from border and items
    DROPDOWN_ITEMS_SPACING # DropdownBox items separation
converter GuiDropdownBoxProperty2int32* (self: GuiDropdownBoxProperty): int32 = self.int32 
# TextBox/TextBoxMulti/ValueBox/Spinner
type GuiTextBoxProperty* = enum 
    TEXT_INNER_PADDING = 16 # TextBox/TextBoxMulti/ValueBox/Spinner inner text padding
    TEXT_LINES_SPACING # TextBoxMulti lines separation
converter GuiTextBoxProperty2int32* (self: GuiTextBoxProperty): int32 = self.int32 
# Spinner
type GuiSpinnerProperty* = enum 
    SPIN_BUTTON_WIDTH = 16 # Spinner left/right buttons width
    SPIN_BUTTON_SPACING # Spinner buttons separation
converter GuiSpinnerProperty2int32* (self: GuiSpinnerProperty): int32 = self.int32 
# ListView
type GuiListViewProperty* = enum 
    LIST_ITEMS_HEIGHT = 16 # ListView items height
    LIST_ITEMS_SPACING # ListView items separation
    SCROLLBAR_WIDTH # ListView scrollbar size (usually width)
    SCROLLBAR_SIDE # ListView scrollbar side (0-left, 1-right)
converter GuiListViewProperty2int32* (self: GuiListViewProperty): int32 = self.int32 
# ColorPicker
type GuiColorPickerProperty* = enum 
    COLOR_SELECTOR_SIZE = 16 
    HUEBAR_WIDTH # ColorPicker right hue bar width
    HUEBAR_PADDING # ColorPicker right hue bar separation from panel
    HUEBAR_SELECTOR_HEIGHT # ColorPicker right hue bar selector height
    HUEBAR_SELECTOR_OVERFLOW # ColorPicker right hue bar selector overflow
converter GuiColorPickerProperty2int32* (self: GuiColorPickerProperty): int32 = self.int32 
template SCROLLBAR_LEFT_SIDE*(): auto = 0
template SCROLLBAR_RIGHT_SIDE*(): auto = 1
# ----------------------------------------------------------------------------------
# Global Variables Definition
# ----------------------------------------------------------------------------------
# ...
# ----------------------------------------------------------------------------------
# Module Functions Declaration
# ----------------------------------------------------------------------------------
# Global gui state control functions
# Font set/get functions
# Style set/get functions
# Container/separator controls, useful for controls organization
# Basic controls set
# Advance controls set
# Styles loading functions
# Icons functionality
# ----------------------------------------------------------------------------------
# Icons enumeration
# ----------------------------------------------------------------------------------
type GuiIconName* = enum 
    ICON_NONE                     = 0 
    ICON_FOLDER_FILE_OPEN         = 1 
    ICON_FILE_SAVE_CLASSIC        = 2 
    ICON_FOLDER_OPEN              = 3 
    ICON_FOLDER_SAVE              = 4 
    ICON_FILE_OPEN                = 5 
    ICON_FILE_SAVE                = 6 
    ICON_FILE_EXPORT              = 7 
    ICON_FILE_ADD                 = 8 
    ICON_FILE_DELETE              = 9 
    ICON_FILETYPE_TEXT            = 10 
    ICON_FILETYPE_AUDIO           = 11 
    ICON_FILETYPE_IMAGE           = 12 
    ICON_FILETYPE_PLAY            = 13 
    ICON_FILETYPE_VIDEO           = 14 
    ICON_FILETYPE_INFO            = 15 
    ICON_FILE_COPY                = 16 
    ICON_FILE_CUT                 = 17 
    ICON_FILE_PASTE               = 18 
    ICON_CURSOR_HAND              = 19 
    ICON_CURSOR_POINTER           = 20 
    ICON_CURSOR_CLASSIC           = 21 
    ICON_PENCIL                   = 22 
    ICON_PENCIL_BIG               = 23 
    ICON_BRUSH_CLASSIC            = 24 
    ICON_BRUSH_PAINTER            = 25 
    ICON_WATER_DROP               = 26 
    ICON_COLOR_PICKER             = 27 
    ICON_RUBBER                   = 28 
    ICON_COLOR_BUCKET             = 29 
    ICON_TEXT_T                   = 30 
    ICON_TEXT_A                   = 31 
    ICON_SCALE                    = 32 
    ICON_RESIZE                   = 33 
    ICON_FILTER_POINT             = 34 
    ICON_FILTER_BILINEAR          = 35 
    ICON_CROP                     = 36 
    ICON_CROP_ALPHA               = 37 
    ICON_SQUARE_TOGGLE            = 38 
    ICON_SYMMETRY                 = 39 
    ICON_SYMMETRY_HORIZONTAL      = 40 
    ICON_SYMMETRY_VERTICAL        = 41 
    ICON_LENS                     = 42 
    ICON_LENS_BIG                 = 43 
    ICON_EYE_ON                   = 44 
    ICON_EYE_OFF                  = 45 
    ICON_FILTER_TOP               = 46 
    ICON_FILTER                   = 47 
    ICON_TARGET_POINT             = 48 
    ICON_TARGET_SMALL             = 49 
    ICON_TARGET_BIG               = 50 
    ICON_TARGET_MOVE              = 51 
    ICON_CURSOR_MOVE              = 52 
    ICON_CURSOR_SCALE             = 53 
    ICON_CURSOR_SCALE_RIGHT       = 54 
    ICON_CURSOR_SCALE_LEFT        = 55 
    ICON_UNDO                     = 56 
    ICON_REDO                     = 57 
    ICON_REREDO                   = 58 
    ICON_MUTATE                   = 59 
    ICON_ROTATE                   = 60 
    ICON_REPEAT                   = 61 
    ICON_SHUFFLE                  = 62 
    ICON_EMPTYBOX                 = 63 
    ICON_TARGET                   = 64 
    ICON_TARGET_SMALL_FILL        = 65 
    ICON_TARGET_BIG_FILL          = 66 
    ICON_TARGET_MOVE_FILL         = 67 
    ICON_CURSOR_MOVE_FILL         = 68 
    ICON_CURSOR_SCALE_FILL        = 69 
    ICON_CURSOR_SCALE_RIGHT_FILL  = 70 
    ICON_CURSOR_SCALE_LEFT_FILL   = 71 
    ICON_UNDO_FILL                = 72 
    ICON_REDO_FILL                = 73 
    ICON_REREDO_FILL              = 74 
    ICON_MUTATE_FILL              = 75 
    ICON_ROTATE_FILL              = 76 
    ICON_REPEAT_FILL              = 77 
    ICON_SHUFFLE_FILL             = 78 
    ICON_EMPTYBOX_SMALL           = 79 
    ICON_BOX                      = 80 
    ICON_BOX_TOP                  = 81 
    ICON_BOX_TOP_RIGHT            = 82 
    ICON_BOX_RIGHT                = 83 
    ICON_BOX_BOTTOM_RIGHT         = 84 
    ICON_BOX_BOTTOM               = 85 
    ICON_BOX_BOTTOM_LEFT          = 86 
    ICON_BOX_LEFT                 = 87 
    ICON_BOX_TOP_LEFT             = 88 
    ICON_BOX_CENTER               = 89 
    ICON_BOX_CIRCLE_MASK          = 90 
    ICON_POT                      = 91 
    ICON_ALPHA_MULTIPLY           = 92 
    ICON_ALPHA_CLEAR              = 93 
    ICON_DITHERING                = 94 
    ICON_MIPMAPS                  = 95 
    ICON_BOX_GRID                 = 96 
    ICON_GRID                     = 97 
    ICON_BOX_CORNERS_SMALL        = 98 
    ICON_BOX_CORNERS_BIG          = 99 
    ICON_FOUR_BOXES               = 100 
    ICON_GRID_FILL                = 101 
    ICON_BOX_MULTISIZE            = 102 
    ICON_ZOOM_SMALL               = 103 
    ICON_ZOOM_MEDIUM              = 104 
    ICON_ZOOM_BIG                 = 105 
    ICON_ZOOM_ALL                 = 106 
    ICON_ZOOM_CENTER              = 107 
    ICON_BOX_DOTS_SMALL           = 108 
    ICON_BOX_DOTS_BIG             = 109 
    ICON_BOX_CONCENTRIC           = 110 
    ICON_BOX_GRID_BIG             = 111 
    ICON_OK_TICK                  = 112 
    ICON_CROSS                    = 113 
    ICON_ARROW_LEFT               = 114 
    ICON_ARROW_RIGHT              = 115 
    ICON_ARROW_DOWN               = 116 
    ICON_ARROW_UP                 = 117 
    ICON_ARROW_LEFT_FILL          = 118 
    ICON_ARROW_RIGHT_FILL         = 119 
    ICON_ARROW_DOWN_FILL          = 120 
    ICON_ARROW_UP_FILL            = 121 
    ICON_AUDIO                    = 122 
    ICON_FX                       = 123 
    ICON_WAVE                     = 124 
    ICON_WAVE_SINUS               = 125 
    ICON_WAVE_SQUARE              = 126 
    ICON_WAVE_TRIANGULAR          = 127 
    ICON_CROSS_SMALL              = 128 
    ICON_PLAYER_PREVIOUS          = 129 
    ICON_PLAYER_PLAY_BACK         = 130 
    ICON_PLAYER_PLAY              = 131 
    ICON_PLAYER_PAUSE             = 132 
    ICON_PLAYER_STOP              = 133 
    ICON_PLAYER_NEXT              = 134 
    ICON_PLAYER_RECORD            = 135 
    ICON_MAGNET                   = 136 
    ICON_LOCK_CLOSE               = 137 
    ICON_LOCK_OPEN                = 138 
    ICON_CLOCK                    = 139 
    ICON_TOOLS                    = 140 
    ICON_GEAR                     = 141 
    ICON_GEAR_BIG                 = 142 
    ICON_BIN                      = 143 
    ICON_HAND_POINTER             = 144 
    ICON_LASER                    = 145 
    ICON_COIN                     = 146 
    ICON_EXPLOSION                = 147 
    ICON_1UP                      = 148 
    ICON_PLAYER                   = 149 
    ICON_PLAYER_JUMP              = 150 
    ICON_KEY                      = 151 
    ICON_DEMON                    = 152 
    ICON_TEXT_POPUP               = 153 
    ICON_GEAR_EX                  = 154 
    ICON_CRACK                    = 155 
    ICON_CRACK_POINTS             = 156 
    ICON_STAR                     = 157 
    ICON_DOOR                     = 158 
    ICON_EXIT                     = 159 
    ICON_MODE_2D                  = 160 
    ICON_MODE_3D                  = 161 
    ICON_CUBE                     = 162 
    ICON_CUBE_FACE_TOP            = 163 
    ICON_CUBE_FACE_LEFT           = 164 
    ICON_CUBE_FACE_FRONT          = 165 
    ICON_CUBE_FACE_BOTTOM         = 166 
    ICON_CUBE_FACE_RIGHT          = 167 
    ICON_CUBE_FACE_BACK           = 168 
    ICON_CAMERA                   = 169 
    ICON_SPECIAL                  = 170 
    ICON_LINK_NET                 = 171 
    ICON_LINK_BOXES               = 172 
    ICON_LINK_MULTI               = 173 
    ICON_LINK                     = 174 
    ICON_LINK_BROKE               = 175 
    ICON_TEXT_NOTES               = 176 
    ICON_NOTEBOOK                 = 177 
    ICON_SUITCASE                 = 178 
    ICON_SUITCASE_ZIP             = 179 
    ICON_MAILBOX                  = 180 
    ICON_MONITOR                  = 181 
    ICON_PRINTER                  = 182 
    ICON_PHOTO_CAMERA             = 183 
    ICON_PHOTO_CAMERA_FLASH       = 184 
    ICON_HOUSE                    = 185 
    ICON_HEART                    = 186 
    ICON_CORNER                   = 187 
    ICON_VERTICAL_BARS            = 188 
    ICON_VERTICAL_BARS_FILL       = 189 
    ICON_LIFE_BARS                = 190 
    ICON_INFO                     = 191 
    ICON_CROSSLINE                = 192 
    ICON_HELP                     = 193 
    ICON_FILETYPE_ALPHA           = 194 
    ICON_FILETYPE_HOME            = 195 
    ICON_LAYERS_VISIBLE           = 196 
    ICON_LAYERS                   = 197 
    ICON_WINDOW                   = 198 
    ICON_HIDPI                    = 199 
    ICON_FILETYPE_BINARY          = 200 
    ICON_HEX                      = 201 
    ICON_SHIELD                   = 202 
    ICON_FILE_NEW                 = 203 
    ICON_FOLDER_ADD               = 204 
    ICON_ALARM                    = 205 
    ICON_206                      = 206 
    ICON_207                      = 207 
    ICON_208                      = 208 
    ICON_209                      = 209 
    ICON_210                      = 210 
    ICON_211                      = 211 
    ICON_212                      = 212 
    ICON_213                      = 213 
    ICON_214                      = 214 
    ICON_215                      = 215 
    ICON_216                      = 216 
    ICON_217                      = 217 
    ICON_218                      = 218 
    ICON_219                      = 219 
    ICON_220                      = 220 
    ICON_221                      = 221 
    ICON_222                      = 222 
    ICON_223                      = 223 
    ICON_224                      = 224 
    ICON_225                      = 225 
    ICON_226                      = 226 
    ICON_227                      = 227 
    ICON_228                      = 228 
    ICON_229                      = 229 
    ICON_230                      = 230 
    ICON_231                      = 231 
    ICON_232                      = 232 
    ICON_233                      = 233 
    ICON_234                      = 234 
    ICON_235                      = 235 
    ICON_236                      = 236 
    ICON_237                      = 237 
    ICON_238                      = 238 
    ICON_239                      = 239 
    ICON_240                      = 240 
    ICON_241                      = 241 
    ICON_242                      = 242 
    ICON_243                      = 243 
    ICON_244                      = 244 
    ICON_245                      = 245 
    ICON_246                      = 246 
    ICON_247                      = 247 
    ICON_248                      = 248 
    ICON_249                      = 249 
    ICON_250                      = 250 
    ICON_251                      = 251 
    ICON_252                      = 252 
    ICON_253                      = 253 
    ICON_254                      = 254 
    ICON_255                      = 255 
converter GuiIconName2int32* (self: GuiIconName): int32 = self.int32 
# 
#   RAYGUI IMPLEMENTATION
# 