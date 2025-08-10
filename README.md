# Obsidian UI Library

![Example Image](assets/Example.png?raw=true)

## Table of Contents

- [Getting Started](#getting-started)
- [Icon Information](#icon-information)
- [Core Components](#core-components)
  - [Window](#window)
  - [Tabs](#tabs)
  - [Groupboxes](#groupboxes)
  - [Tabboxes](#tabboxes)
  - [Dependency Boxes](#dependency-boxes)
  - [Dependency Groupboxes](#dependency-groupboxes)
- [UI Elements](#ui-elements)
  - [Labels](#labels)
  - [Buttons](#buttons)
  - [Toggles & Checkboxes](#toggles--checkboxes)
  - [Inputs](#inputs)
  - [Sliders](#sliders)
  - [Dropdowns](#dropdowns)
  - [Keybinds](#keybinds)
  - [Color Pickers](#color-pickers)
  - [Dividers](#dividers)
  - [Viewports](#viewports)
  - [Images](#images)
- [Additional Features](#additional-features)
  - [Notifications](#notifications)
  - [Tooltips](#tooltips)
  - [Watermark](#watermark)
  - [Keybind Menu](#keybind-menu)
  - [Custom Cursor](#custom-cursor)
  - [Mobile Support](#mobile-support)
- [Theming](#theming)
- [API Reference](#api-reference)
- [Examples](#examples)

## Getting Started

To use the Obsidian UI Library, you need to assign it to a variable:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()
```

Then, create a window:

```lua
local Window = Library:CreateWindow({
    Title = "My Script",
    Footer = "v1.0.0",
    ToggleKeybind = Enum.KeyCode.RightControl,
    Center = true,
    AutoShow = true
})
```

## Icon Information

The Obsidian UI Library uses [Lucide](https://lucide.dev/) for Tab Icons and more.

## Core Components

### Window

The Window is the main container for your UI. You can create one using `Library:CreateWindow()`.

#### Options

| Property          | Type         | Default                    | Description                                        |
| ----------------- | ------------ | -------------------------- | -------------------------------------------------- |
| Title             | string       | "No Title"                 | The title displayed at the top of the window       |
| Footer            | string       | "No Footer"                | The text displayed at the bottom of the window     |
| Position          | UDim2        | UDim2.fromOffset(6, 6)     | The initial position of the window                 |
| Size              | UDim2        | UDim2.fromOffset(720, 600) | The size of the window                             |
| Center            | boolean      | true                       | Whether to center the window on the screen         |
| AutoShow          | boolean      | true                       | Whether to show the window immediately             |
| ToggleKeybind     | Enum.KeyCode | Enum.KeyCode.RightControl  | The keybind to toggle the UI                       |
| NotifySide        | string       | "Right"                    | The side to show notifications ("Left" or "Right") |
| ShowCustomCursor  | boolean      | true                       | Whether to show a custom cursor                    |
| Font              | Enum.Font    | Enum.Font.Code             | The font to use for text                           |
| CornerRadius      | number       | 4                          | The corner radius for UI elements                  |
| Icon              | string/ID    | nil                        | Optional icon for the window                       |
| IconSize          | UDim2        | UDim2.fromOffset(30, 30)   | Size of the icon if provided                       |
| BackgroundImage.  | string/ID.   | nil                        | Background image for the window                    |
| Resizable         | boolean      | true                       | Whether the window can be resized                  |
| MobileButtonsSide | string       | "Left"                     | Side to place mobile buttons ("Left" or "Right")   |
| DisableSearch     | boolean      | false                      | Whether to disable the search box                  |

### Tabs

Tabs are the primary way to organize content in your UI. You can add them with `Window:AddTab()`.

```lua
local MainTab = Window:AddTab("Main", "home", "Main features")
-- Second parameter is the optional icon name from lucide.dev, third is an optional description

local UISettingsTab = Window:AddTab({
    Name = "UI Settings",
    Description = "Customize the UI",
    Icon = "settings"
})
```

#### Methods

| Method                                                                                            | Description                                                                     |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `Window:AddTab(name, iconName, description)`                                                      | Adds a new tab with the given name and optional icon and a optional description |
| `Window:AddTab({ Name = "Tab Name", Icon = "icon_name", Description = "Tab description" })`       | Adds a new tab with a table containing name, icon, and description              |
| `Window:AddKeyTab(name)`                                                                          | Adds a special tab for key input                                                |
| `Tab:UpdateWarningBox({ Title = "Warning", Text = "Example", Visible = true, LockSize = true })`  | Updates the warning box in a tab                                                |

### Groupboxes

Groupboxes are containers for UI elements within tabs. They help organize elements into sections.

```lua
local LeftGroupbox = MainTab:AddLeftGroupbox("Settings", "wrench")
local RightGroupbox = MainTab:AddRightGroupbox("Information", "info")
```

#### Methods

| Method                                 | Description                                   |
| -------------------------------------- | --------------------------------------------- |
| `Tab:AddLeftGroupbox(name, iconName)`  | Adds a groupbox on the left side              |
| `Tab:AddRightGroupbox(name, iconName)` | Adds a groupbox on the right side             |
| `Groupbox:Resize()`                    | Manually resizes the groupbox (rarely needed) |

### Tabboxes

Tabboxes are containers that can have their own tabs, useful for organizing related options.

```lua
local Tabbox = MainTab:AddLeftTabbox("Settings")
local Tab1 = Tabbox:AddTab("General")
local Tab2 = Tabbox:AddTab("Advanced")
```

#### Methods

| Method                     | Description                     |
| -------------------------- | ------------------------------- |
| `Tab:AddLeftTabbox(name)`  | Adds a tabbox on the left side  |
| `Tab:AddRightTabbox(name)` | Adds a tabbox on the right side |
| `Tabbox:AddTab(name)`      | Adds a new tab to the tabbox    |

### Dependency Boxes

Dependency boxes allow you to conditionally show or hide elements contained in a groupbox based on the state of other elements.

```lua
local LeftGroupbox = MainTab:AddLeftGroupbox("Settings", "wrench")

LeftGroupbox:AddToggle("EnableAudio", {
    Text = "Enable Audio",
    Default = false
})

local AudioSettings = LeftGroupbox:AddDependencyBox()

AudioSettings:AddSlider("Volume", {
    Text = "Volume",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0
})

AudioSettings:SetupDependencies({
    { Toggles.EnableAudio, true } -- Only show if EnableAudio is true
})
```

### Dependency Groupboxes

Dependency groupboxes allow you to conditionally show or hide entire groupboxes based on the state of other elements.

```lua
local LeftGroupbox = MainTab:AddLeftGroupbox("Settings", "wrench")

LeftGroupbox:AddToggle("EnableAudio", {
    Text = "Enable Audio",
    Default = false
})

-- Creates a dependency groupbox on the left side since LeftGroupbox is on the left
local DependencyGroupbox = LeftGroupbox:AddDependencyGroupbox("Audio Settings")

DependencyGroupbox:AddSlider("Volume", {
    Text = "Volume",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0
})

DependencyGroupbox:SetupDependencies({
    { Toggles.EnableAudio, true } -- Only show if EnableAudio is true
})

```

## UI Elements

### Labels

Labels display text information.

```lua
local Label = Groupbox:AddLabel("This is a label")
local WrappedLabel = Groupbox:AddLabel({
    Text = "This is a wrapped label that will break into multiple lines",
    DoesWrap = true
})
```

#### Methods

| Method                      | Description              |
| --------------------------- | ------------------------ |
| `Label:SetText(text)`       | Updates the label's text |
| `Label:SetVisible(boolean)` | Shows or hides the label |

### Buttons

Buttons allow user interaction through clicking.

```lua
local Button = Groupbox:AddButton({
    Text = "Click Me",
    Func = function()
        print("Button clicked!")
    end,
    DoubleClick = true -- Requires double-click for risky actions
})

-- You can also add sub-buttons
Button:AddButton({
    Text = "Sub Button",
    Func = function()
        print("Sub-button clicked!")
    end
})
```

#### Options

| Property        | Type     | Default        | Description                                   |
| --------------- | -------- | -------------- | --------------------------------------------- |
| Text            | string   | "Button"       | The button's text                             |
| Func            | function | function() end | The function to call when clicked             |
| DoubleClick     | boolean  | false          | Whether the button needs double-click         |
| Tooltip         | string   | nil            | Tooltip text shown on hover                   |
| DisabledTooltip | string   | nil            | Tooltip shown when disabled                   |
| Risky           | boolean  | false          | Displays text in red to indicate risky action |
| Disabled        | boolean  | false          | Whether the button is disabled                |
| Visible         | boolean  | true           | Whether the button is visible                 |

#### Methods

| Method                        | Description                    |
| ----------------------------- | ------------------------------ |
| `Button:SetText(text)`        | Updates the button's text      |
| `Button:SetDisabled(boolean)` | Enables or disables the button |
| `Button:SetVisible(boolean)`  | Shows or hides the button      |

### Toggles & Checkboxes

Toggles and checkboxes allow users to toggle boolean values.

```lua
-- Always capture the reference returned by AddToggle
local MyToggle = Groupbox:AddToggle("MyToggle", {
    Text = "Example Toggle",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(Value)
        print("Toggle changed to:", Value)
    end
})

-- You can use :OnChanged to add another callback
MyToggle:OnChanged(function(Value)
    print("Toggle changed via OnChanged:", Value)
})

-- You can also create checkboxes instead of switch-style toggles
local MyCheckbox = Groupbox:AddCheckbox("MyCheckbox", {
    Text = "Example Checkbox",
    Default = false,
    Callback = function(Value)
        print("Checkbox changed to:", Value)
    end
})
```

#### Options

| Property        | Type     | Default        | Description                                   |
| --------------- | -------- | -------------- | --------------------------------------------- |
| Text            | string   | "Toggle"       | The toggle's text                             |
| Default         | boolean  | false          | The initial state                             |
| Tooltip         | string   | nil            | Tooltip text shown on hover                   |
| DisabledTooltip | string   | nil            | Tooltip shown when disabled                   |
| Callback        | function | function() end | Called when the toggle changes                |
| Risky           | boolean  | false          | Displays text in red to indicate risky action |
| Disabled        | boolean  | false          | Whether the toggle is disabled                |
| Visible         | boolean  | true           | Whether the toggle is visible                 |

#### Methods

| Method                        | Description                    |
| ----------------------------- | ------------------------------ |
| `Toggle:SetValue(boolean)`    | Sets the toggle value          |
| `Toggle:SetText(text)`        | Updates the toggle's text      |
| `Toggle:SetDisabled(boolean)` | Enables or disables the toggle |
| `Toggle:SetVisible(boolean)`  | Shows or hides the toggle      |
| `Toggle:OnChanged(function)`  | Adds another callback function |

### Inputs

Input fields allow users to enter text values.

```lua
local Input = Groupbox:AddInput("MyInput", {
    Text = "Input Example",
    Default = "Default value",
    Numeric = false,
    Finished = true, -- Only calls callback when you press enter
    Placeholder = "Enter text here...",
    Callback = function(Value)
        print("Input updated:", Value)
    end
})
```

#### Options

| Property         | Type     | Default        | Description                                             |
| ---------------- | -------- | -------------- | ------------------------------------------------------- |
| Text             | string   | "Input"        | The input's label text                                  |
| Default          | string   | ""             | The initial value                                       |
| Numeric          | boolean  | false          | Whether to allow only numeric input                     |
| Finished         | boolean  | false          | Whether to call the callback only when Enter is pressed |
| ClearTextOnFocus | boolean  | true           | Whether to clear the text when focused                  |
| Placeholder      | string   | ""             | Placeholder text when empty                             |
| AllowEmpty       | boolean  | true           | Whether to allow empty input                            |
| EmptyReset       | string   | "---"          | Value to use when empty if AllowEmpty is false          |
| MaxLength        | number   | nil            | Maximum character length                                |
| Tooltip          | string   | nil            | Tooltip text shown on hover                             |
| DisabledTooltip  | string   | nil            | Tooltip shown when disabled                             |
| Callback         | function | function() end | Called when the input changes                           |
| Disabled         | boolean  | false          | Whether the input is disabled                           |
| Visible          | boolean  | true           | Whether the input is visible                            |

#### Methods

| Method                       | Description                    |
| ---------------------------- | ------------------------------ |
| `Input:SetValue(text)`       | Sets the input value           |
| `Input:SetText(text)`        | Updates the input's label text |
| `Input:SetDisabled(boolean)` | Enables or disables the input  |
| `Input:SetVisible(boolean)`  | Shows or hides the input       |
| `Input:OnChanged(function)`  | Adds another callback function |

### Sliders

Sliders allow users to select a numeric value from a range.

```lua
local Slider = Groupbox:AddSlider("MySlider", {
    Text = "Example Slider",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        print("Slider changed to:", Value)
    end
})
```

#### Options

| Property        | Type     | Default        | Description                              |
| --------------- | -------- | -------------- | ---------------------------------------- |
| Text            | string   | "Slider"       | The slider's text                        |
| Default         | number   | 0              | The initial value                        |
| Min             | number   | 0              | The minimum value                        |
| Max             | number   | 100            | The maximum value                        |
| Rounding        | number   | 0              | Decimal places to round to               |
| Compact         | boolean  | false          | Whether to use compact mode              |
| HideMax         | boolean  | false          | Whether to hide the max value in display |
| Prefix          | string   | ""             | Text before the value                    |
| Suffix          | string   | ""             | Text after the value                     |
| Tooltip         | string   | nil            | Tooltip text shown on hover              |
| DisabledTooltip | string   | nil            | Tooltip shown when disabled              |
| Callback        | function | function() end | Called when the slider changes           |
| Disabled        | boolean  | false          | Whether the slider is disabled           |
| Visible         | boolean  | true           | Whether the slider is visible            |

#### Methods

| Method                        | Description                    |
| ----------------------------- | ------------------------------ |
| `Slider:SetValue(number)`     | Sets the slider value          |
| `Slider:SetText(text)`        | Updates the slider's text      |
| `Slider:SetMin(number)`       | Sets the minimum value         |
| `Slider:SetMax(number)`       | Sets the maximum value         |
| `Slider:SetDisabled(boolean)` | Enables or disables the slider |
| `Slider:SetVisible(boolean)`  | Shows or hides the slider      |
| `Slider:SetPrefix(text)`      | Sets the prefix text           |
| `Slider:SetSuffix(text)`      | Sets the suffix text           |
| `Slider:OnChanged(function)`  | Adds another callback function |

### Dropdowns

Dropdowns allow users to select from a list of options.

```lua
local Dropdown = Groupbox:AddDropdown("MyDropdown", {
    Values = {"Option 1", "Option 2", "Option 3"},
    Default = 1, -- Index of the default option
    Multi = false, -- Whether to allow multiple selections
    Text = "Example Dropdown",
    Tooltip = "This is a dropdown",
    Callback = function(Value)
        print("Dropdown new value:", Value)
    end
})

-- Multi-select dropdown
local MultiDropdown = Groupbox:AddDropdown("MyMultiDropdown", {
    Values = {"Option A", "Option B", "Option C"},
    Default = {"Option A"}, -- Default selected values for multi-select
    Multi = true,
    Text = "Multi-Select Example",
    Callback = function(Values)
        for Value, Selected in pairs(Values) do
            if Selected then
                print("Selected:", Value)
            end
        end
    end
})
```

#### Special Dropdowns

```lua
-- Player dropdown (automatically updates with players)
local PlayerDropdown = Groupbox:AddDropdown("PlayerDropdown", {
    SpecialType = "Player",
    Text = "Select Players",
    Multi = true,
    ExcludeLocalPlayer = true
})

-- Team dropdown (automatically updates with teams)
local TeamDropdown = Groupbox:AddDropdown("TeamDropdown", {
    SpecialType = "Team",
    Text = "Select Team"
})
```

#### Options

| Property                | Type      | Default        | Description                                       |
| ----------------------- | --------- | -------------- | ------------------------------------------------- |
| Text                    | string    | nil            | The dropdown's label text                         |
| Values                  | table     | {}             | List of selectable values                         |
| Default                 | any/table | nil            | Default selected value or values for multi-select |
| Multi                   | boolean   | false          | Whether multiple values can be selected           |
| AllowNull               | boolean   | false          | Whether no selection is allowed                   |
| Searchable              | boolean   | false          | Whether to allow searching in dropdown            |
| MaxVisibleDropdownItems | number    | 8              | Maximum number of visible items                   |
| SpecialType             | string    | nil            | Special types: "Player" or "Team"                 |
| ExcludeLocalPlayer      | boolean   | false          | For Player type, excludes local player            |
| FormatDisplayValue      | function  | nil            | Function to format displayed values               |
| DisabledValues          | table     | {}             | Values that cannot be selected                    |
| Tooltip                 | string    | nil            | Tooltip text shown on hover                       |
| DisabledTooltip         | string    | nil            | Tooltip shown when disabled                       |
| Callback                | function  | function() end | Called when selection changes                     |
| Disabled                | boolean   | false          | Whether the dropdown is disabled                  |
| Visible                 | boolean   | true           | Whether the dropdown is visible                   |

#### Methods

| Method                                    | Description                       |
| ----------------------------------------- | --------------------------------- |
| `Dropdown:SetValue(value)`                | Sets the selected value(s)        |
| `Dropdown:SetValues(table)`               | Replaces all dropdown values      |
| `Dropdown:AddValues(value/table)`         | Adds new values to the dropdown   |
| `Dropdown:SetDisabledValues(table)`       | Sets which values are disabled    |
| `Dropdown:AddDisabledValues(value/table)` | Adds values to disabled list      |
| `Dropdown:SetText(text)`                  | Updates the dropdown's label text |
| `Dropdown:SetDisabled(boolean)`           | Enables or disables the dropdown  |
| `Dropdown:SetVisible(boolean)`            | Shows or hides the dropdown       |
| `Dropdown:OnChanged(function)`            | Adds another callback function    |

### Keybinds

Keybinds allow users to set and use keyboard shortcuts. You must add them to a toggle by using the reference returned when creating the toggle.

```lua
-- First create a toggle and capture the reference
local MyToggle = Groupbox:AddToggle("MyToggle", {
    Text = "Example Toggle",
    Default = false
})

-- Then add a keybind to it using the reference
local Keybind = MyToggle:AddKeyPicker("MyKeybind", {
    Default = "F",
    Text = "Example Keybind",
    Mode = "Toggle", -- Options: "Toggle", "Hold", "Always"

    -- Sets the toggle's value according to the keybind state if Mode is Toggle
    SyncToggleState = false,

    Callback = function(Value)
        print("Keybind pressed, value:", Value)
    end
})
```

#### Options

| Property        | Type     | Default                      | Description                                 |
| --------------- | -------- | ---------------------------- | ------------------------------------------- |
| Text            | string   | "KeyPicker"                  | The keybind's text                          |
| Default         | string   | "None"                       | The initial key                             |
| Mode            | string   | "Toggle"                     | Operation mode ("Toggle", "Hold", "Always") |
| SyncToggleState | boolean  | false                        | Whether to sync with parent toggle          |
| Modes           | table    | {"Always", "Toggle", "Hold"} | Available modes                             |
| NoUI            | boolean  | false                        | Whether to hide from keybind menu           |
| Callback        | function | function() end               | Called when keybind state changes           |
| ChangedCallback | function | function() end               | Called when key is changed                  |
| Clicked         | function | function() end               | Called when clicked                         |

#### Methods

| Method                          | Description                        |
| ------------------------------- | ---------------------------------- |
| `Keybind:SetValue({key, mode})` | Sets the key and mode              |
| `Keybind:GetState()`            | Returns current state (true/false) |
| `Keybind:SetText(text)`         | Updates the keybind's text         |
| `Keybind:Update()`              | Updates the keybind display        |
| `Keybind:OnClick(function)`     | Sets the click callback            |
| `Keybind:OnChanged(function)`   | Sets the change callback           |

### Color Pickers

Color pickers allow users to select colors. They must be added to a toggle by using the reference returned when creating the toggle.

```lua
-- First create a toggle and capture the reference
local MyToggle = Groupbox:AddToggle("MyToggle", {
    Text = "Example Toggle",
    Default = false
})

-- Then add a color picker to it using the reference
local ColorPicker = MyToggle:AddColorPicker("MyColorPicker", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "Select Color",
    Transparency = 0, -- 0 to 1

    Callback = function(Value)
        print("Color changed to:", Value)
    end
})
```

#### Options

| Property     | Type     | Default             | Description                |
| ------------ | -------- | ------------------- | -------------------------- |
| Default      | Color3   | Color3.new(1, 1, 1) | The initial color          |
| Title        | string   | nil                 | Title shown in picker      |
| Transparency | number   | 0                   | Default transparency (0-1) |
| Callback     | function | function() end      | Called when color changes  |
| Changed      | function | function() end      | Alternative callback       |

#### Methods

| Method                                         | Description                     |
| ---------------------------------------------- | ------------------------------- |
| `ColorPicker:SetValue(hsv, transparency)`      | Sets HSV color and transparency |
| `ColorPicker:SetValueRGB(color, transparency)` | Sets RGB color and transparency |
| `ColorPicker:OnChanged(function)`              | Sets the change callback        |

### Dividers

Dividers are simple horizontal lines that separate content.

```lua
Groupbox:AddDivider()
```

### Viewports

Viewports allow you to display 3D Objects in your UI.

```lua
local Viewport = Groupbox:AddViewport("MyViewport", {
    Object = Instance.new("Part"),
    Camera = Instance.new("Camera"),
    Interactive = true,
    AutoFocus = true
})
```

#### Options

| Property    | Type              | Default           | Description                                                                                                |
| ----------- | ----------------- | ----------------- | ---------------------------------------------------------------------------------------------------------- |
| Object      | Instance          | nil               | The 3D object to display in the viewport                                                                   |
| Camera      | Instance (Camera) | Instance (Camera) | The camera used to view the object                                                                         |
| Interactive | boolean           | false             | Whether the viewport is interactive (scrolling/pinching to zoom, right click and move mouse/swipe to move) |
| AutoFocus   | boolean           | true              | Whether to automatically focus the camera on the object on viewport creation                               |
| Height      | number            | 200               | Height of the viewport frame in pixels.                                                                    |

#### Methods

| Method                                 | Description                                      |
| -------------------------------------- | ------------------------------------------------ |
| `Viewport:SetObject(object)`           | Sets the 3D object to display in the viewport    |
| `Viewport:SetCamera(camera)`           | Sets the camera used to view the object          |
| `Viewport:SetInteractive(Interactive)` | Sets whether the viewport is interactive         |
| `Viewport:SetHeight(height)`           | Sets the height of the viewport frame in pixels  |
| `Viewport:Focus()`                     | Focuses the camera on the object in the viewport |

### Images

Images allow you to display static images in your UI.

```lua
LeftGroupBox:AddImage("MyAgaImage", {
    Image = "http://www.roblox.com/asset/?id=135666356081915",
    Transparency = 0,
    Color = Color3.new(1, 1, 1),
    RectOffset = Vector2.zero,
    RectSize = Vector2.zero,
    ScaleType = Enum.ScaleType.Fit,
    Height = 200,
})
```

#### Options

| Property     | Type           | Default             | Description                                                   |
| ------------ | -------------- | ------------------- | ------------------------------------------------------------- |
| Image        | string         | ""                  | The image URL or asset ID to display                          |
| Transparency | number         | 0                   | The transparency of the image (0 to 1)                        |
| Color        | Color3         | Color3.new(1, 1, 1) | The color tint applied to the image                           |
| RectOffset   | Vector2        | Vector2.zero        | The offset for the image rectangle                            |
| RectSize     | Vector2        | Vector2.zero        | The size of the image rectangle                               |
| ScaleType    | Enum.ScaleType | Enum.ScaleType.Fit  | How the image should scale within its frame (Fit, Fill, etc.) |
| Height       | number         | 200                 | The height of the image frame in pixels                       |

#### Methods

| Method                          | Description                                      |
| ------------------------------- | ------------------------------------------------ |
| `Image:SetImage(image)`         | Sets the image URL or asset ID to display        |
| `Image:SetTransparency(value)`  | Sets the transparency of the image (0 to 1)      |
| `Image:SetColor(color)`         | Sets the color tint applied to the image         |
| `Image:SetRectOffset(offset)`   | Sets the offset for the image rectangle          |
| `Image:SetRectSize(size)`       | Sets the size of the image rectangle             |
| `Image:SetScaleType(scaleType)` | Sets how the image should scale within its frame |
| `Image:SetHeight(height)`       | Sets the height of the image frame in pixels     |

## Additional Features

### Notifications

Notifications display temporary messages to the user.

```lua
-- Simple notification
Library:Notify("This is a notification", 5) -- Second param is duration in seconds

-- Advanced notification
Library:Notify({
    Title = "Success",
    Description = "Operation completed successfully",
    Time = 5, -- Duration in seconds
    SoundId = 123456789 -- Optional sound ID
})

-- Getting notification object for manipulation
local Notification = Library:Notify({
    Title = "Progress",
    Description = "Processing...",
    Time = 10
})

-- Update notification text
Notification:ChangeTitle("Almost done")
Notification:ChangeDescription("Finalizing...")

-- For step notifications
local StepNotification = Library:Notify({
    Title = "Progress",
    Description = "Downloading files...",
    Steps = 5, -- Total number of steps
    Time = someInstanceThatFires -- or use a number for time-based
})

-- Update steps
StepNotification:ChangeStep(2) -- Set to step 2 of 5
```

### Tooltips

Tooltips provide additional information on hover.

```lua
-- Tooltips are added automatically to UI elements via the Tooltip and DisabledTooltip properties
local Button = Groupbox:AddButton({
    Text = "Help",
    Tooltip = "Click for assistance",
    DisabledTooltip = "Currently unavailable"
})

-- Manual tooltip creation
local TooltipObject = Library:AddTooltip("Normal info", "Disabled info", someGuiElement)
```

### Watermark

The library can create a customizable draggable watermark that can be shown in the top left corner.

```lua
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Example of dynamically-updating watermark with common traits (fps and ping)
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('Obsidian demo | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);
```

### Keybind Menu

The library provides a built-in keybind menu that shows all keybinds.

```lua
-- The keybind menu is shown automatically when any keybinds are added
-- You can customize its appearance:
Library.ShowToggleFrameInKeybinds = true -- Show toggle state in keybind menu
```

### Custom Cursor

The library includes a custom cursor option.

```lua
-- Enable/disable the custom cursor
Library.ShowCustomCursor = true
```

### Mobile Support

The library includes built-in mobile support.

```lua
-- Check if the user is on mobile
if Library.IsMobile then
    -- Adjust your UI accordingly
end

-- Mobile button positioning
Window = Library:CreateWindow({
    MobileButtonsSide = "Right" -- "Left" or "Right"
})
```

## Theming

You can customize the appearance of the UI programmatically.

Setting default colors:

```lua
ThemeManager:SetLibrary(Library)

ThemeManager:SetDefaultTheme({
    BackgroundColor = Color3.fromRGB(15, 15, 15),
    MainColor = Color3.fromRGB(25, 25, 25),
    AccentColor = Color3.fromRGB(125, 85, 255),
    OutlineColor = Color3.fromRGB(40, 40, 40),
    FontColor = Color3.new(1, 1, 1),
    FontFace = Enum.Font.Gotham,
})

-- ApplyToTab must be called after setting the default theme
ThemeManager:ApplyToTab(Tabs["UI Settings"])

-- Change font
Library:SetFont(Enum.Font.Gotham)

-- Change DPI scale
Library:SetDPIScale(150) -- 150% scaling
```

## API Reference

### Library Functions

| Function                                                | Description                             |
| ------------------------------------------------------- | --------------------------------------- |
| `Library:CreateWindow(options)`                         | Creates a new window                    |
| `Library:Notify(message, duration, soundId)`            | Shows a notification                    |
| `Library:SetFont(font)`                                 | Sets the global font                    |
| `Library:SetNotifySide(side)`                           | Sets which side notifications appear on |
| `Library:SetDPIScale(scale)`                            | Sets the UI scaling (100 = 100%)        |
| `Library:Toggle(visible)`                               | Shows or hides the entire UI            |
| `Library:AddTooltip(tooltip, disabledTooltip, element)` | Adds a tooltip to an element            |
| `Library:AddDraggableButton(text, callback)`            | Creates a draggable button              |
| `Library:AddDraggableMenu(name)`                        | Creates a draggable menu                |
| `Library:OnUnload(callback)`                            | Sets a function to call when unloaded   |
| `Library:Unload()`                                      | Destroys the UI completely              |

### Global References

| Variable                            | Description                                          |
| ----------------------------------- | ---------------------------------------------------- |
| `Library.Toggled`                   | Whether the UI is currently visible                  |
| `Library.IsMobile`                  | Whether the user is on a mobile device               |
| `Library.IsRobloxFocused`           | Whether the roblox window is focused                 |
| `Library.CornerRadius`              | The corner radius used throughout the UI             |
| `Library.NotifySide`                | Which side notifications appear on                   |
| `Library.ShowCustomCursor`          | Whether to show the custom cursor                    |
| `Library.ForceCheckbox`             | Whether to always use checkboxes instead of switches |
| `Library.ShowToggleFrameInKeybinds` | Whether to show toggle state in keybind menu         |
| `Library.NotifyOnError`             | Whether to show notifications for errors             |
| `Library.ToggleKeybind`             | The keybind to toggle the UI                         |

## Examples

### Basic Window with Elements

```lua
-- Create a basic window with common elements
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "My Script",
    Footer = "v1.0.0",
    Center = true,
    AutoShow = true
})

local MainTab = Window:AddTab("Main", "home")
local SettingsTab = Window:AddTab("Settings", "settings", "Customize the UI")

-- Add a groupbox to the left side
local LeftGroupbox = MainTab:AddLeftGroupbox("Features")

-- Add toggles, buttons, sliders
local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Enable Feature",
    Default = false,
    Tooltip = "Enables the main feature",
    Callback = function(Value)
        print("Feature enabled:", Value)
    end
})

local MyButton = LeftGroupbox:AddButton({
    Text = "Run Action",
    Func = function()
        print("Action running!")
    end
})

local MySlider = LeftGroupbox:AddSlider("MySlider", {
    Text = "Speed",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Callback = function(Value)
        print("Speed set to:", Value)
    end
})

-- Add a dropdown
local MyDropdown = LeftGroupbox:AddDropdown("MyDropdown", {
    Values = {"Option 1", "Option 2", "Option 3"},
    Default = 1,
    Text = "Select Option",
    Callback = function(Value)
        print("Selected:", Value)
    end
})

-- Add a groupbox to the right side
local RightGroupbox = MainTab:AddRightGroupbox("Information")

-- Add a label
RightGroupbox:AddLabel("Welcome to my script!")

-- Add a tabbox
local MyTabbox = SettingsTab:AddLeftTabbox("Settings")
local ConfigTab = MyTabbox:AddTab("Config")
local ThemeTab = MyTabbox:AddTab("Theme")

-- Add config elements
ConfigTab:AddButton({
    Text = "Save Config",
    Func = function()
        Library:Notify("Config saved!")
    end
})

-- Add toggle with keybind - IMPORTANT: Capture the toggle reference
local ToggleWithKeybind = LeftGroupbox:AddToggle("ToggleWithKey", {
    Text = "Toggle with Keybind",
    Default = false,
    Callback = function(Value)
        print("Toggled with keybind:", Value)
    end
})

-- Add keybind to the toggle using the reference
local MyKeybind = ToggleWithKeybind:AddKeyPicker("MyKeybind", {
    Default = "G",
    Mode = "Toggle",
    Text = "Toggle Feature",
    SyncToggleState = true,
})

-- Add a color picker to the toggle using the reference
local MyColorPicker = ToggleWithKeybind:AddColorPicker("MyColorPicker", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "UI Color",
    Callback = function(Value)
        Library.Scheme.AccentColor = Value
        Library:UpdateColorsUsingRegistry()
    end
})
```

### Advanced Example with Tabboxes

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Advanced Example",
    Size = UDim2.fromOffset(550, 480),
    Center = true
})

local MainTab = Window:AddTab("Main")
local ConfigTab = Window:AddTab("Config")

-- Main features
local FeaturesBox = MainTab:AddLeftTabbox("Features")
local GeneralTab = FeaturesBox:AddTab("General")
local CombatTab = FeaturesBox:AddTab("Combat")
local VisualsTab = FeaturesBox:AddTab("Visuals")

-- General features
local WalkSpeedToggle = GeneralTab:AddToggle("WalkSpeed", {
    Text = "Custom Walk Speed",
    Default = false,
    Callback = function(Value)
        print("Walk Speed enabled:", Value)
    end
})

local SpeedSlider = GeneralTab:AddSlider("SpeedValue", {
    Text = "Speed Value",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        print("Speed set to:", Value)
    end
})

-- Combat features - IMPORTANT: Capture references directly
local AimbotToggle = CombatTab:AddToggle("Aimbot", {
    Text = "Aimbot",
    Default = false,
    Tooltip = "Automatically aims at enemies",
    Callback = function(Value)
        print("Aimbot enabled:", Value)
    end
})

-- Use the direct reference to add the keybind
AimbotToggle:AddKeyPicker("AimbotKey", {
    Default = "E",
    Mode = "Hold",
    Text = "Aimbot",
    Callback = function(Value)
        print("Aimbot key held:", Value)
    end
})

local TargetDropdown = CombatTab:AddDropdown("AimbotTarget", {
    Text = "Target",
    Values = {"Head", "Torso", "Random"},
    Default = 1,
    Callback = function(Value)
        print("Aimbot targeting:", Value)
    end
})

-- Visuals features - IMPORTANT: Capture references directly
local ESPToggle = VisualsTab:AddToggle("ESP", {
    Text = "ESP",
    Default = false,
    Callback = function(Value)
        print("ESP enabled:", Value)
    end
})

-- Use the direct reference to add the color picker
ESPToggle:AddColorPicker("ESPColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "ESP Color",
    Callback = function(Value)
        print("ESP color set to:", Value)
    end
})

local ESPOptions = VisualsTab:AddDropdown("ESPOptions", {
    Text = "ESP Options",
    Values = {"Boxes", "Names", "Health", "Distance"},
    Multi = true,
    Default = {"Boxes", "Names"},
    Callback = function(Values)
        for Option, Enabled in pairs(Values) do
            if Enabled then
                print("ESP option enabled:", Option)
            end
        end
    end
})

-- Config section
local SaveBox = ConfigTab:AddLeftGroupbox("Save Configuration")

local ConfigNameInput = SaveBox:AddInput("ConfigName", {
    Text = "Config Name",
    Default = "MyConfig",
    Placeholder = "Enter name...",
    Finished = true
})

SaveBox:AddButton({
    Text = "Save Config",
    Func = function()
        local name = Options.ConfigName.Value
        Library:Notify({
            Title = "Config Saved",
            Description = "Saved configuration as " .. name,
            Time = 3
        })
    end
})

SaveBox:AddButton({
    Text = "Load Config",
    Func = function()
        local name = Options.ConfigName.Value
        Library:Notify({
            Title = "Config Loaded",
            Description = "Loaded configuration " .. name,
            Time = 3
        })
    end
})

-- Player list
local PlayerBox = MainTab:AddRightGroupbox("Players")

local PlayerSelector = PlayerBox:AddDropdown("PlayerList", {
    SpecialType = "Player",
    Text = "Select Player",
    Tooltip = "Select a player to target",
    Callback = function(Value)
        print("Selected player:", Value)
    end
})

-- Theme settings
local ThemeBox = ConfigTab:AddRightGroupbox("UI Settings")

local ThemeToggle = ThemeBox:AddToggle("CustomTheme", {
    Text = "Custom Theme",
    Default = false,
    Callback = function(Value)
        print("Custom theme enabled:", Value)
    end
})

local UIScaleSlider = ThemeBox:AddSlider("UIScale", {
    Text = "UI Scale",
    Default = 100,
    Min = 75,
    Max = 150,
    Rounding = 0,
    Suffix = "%",
    Callback = function(Value)
        Library:SetDPIScale(Value)
    end
})

-- Set a keybind toggler
ThemeBox:AddLabel("Press Right-Ctrl to toggle the UI")

-- Show the UI
Library:Toggle(true)
```
