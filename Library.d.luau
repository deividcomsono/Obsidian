--!strict
-- Last updated: 31.10.2026
-- Luau type definitions for the Obsidian UI Library

--// Helper & Configuration Types
export type Scheme = {
    BackgroundColor: Color3,
    MainColor: Color3,
    AccentColor: Color3,
    OutlineColor: Color3,
    FontColor: Color3,
    Font: Font,
    RedColor: Color3,
    DestructiveColor: Color3,
    DarkColor: Color3,
    WhiteColor: Color3,
    BackgroundImage: string | number,

    -- Aliases
    Red: Color3?,
    Dark: Color3?,
    White: Color3?,
}

export type Icon = {
    Url: string,
    Id: number?,
    IconName: string?,
    ImageRectOffset: Vector2,
    ImageRectSize: Vector2,
    FontFace: Font?,
    Text: string?,
    Custom: boolean?,
}

export type IconModule = {
    Icons: { string },
    GetAsset: (Name: string) -> Icon?,
}

export type ImageManager = {
    AddAsset: (AssetName: string, RobloxAssetId: number, URL: string, ForceRedownload: boolean?) -> (),
    GetAsset: (AssetName: string) -> string?,
    DownloadAsset: (AssetName: string, ForceRedownload: boolean?) -> (),
}

export type Cursor = {
    ResetCross: (self: Cursor) -> (),
    ResetIcon: (self: Cursor) -> (),
    ResetCursor: (self: Cursor) -> (),
    ChangeCrossColor: (self: Cursor, Color: Color3) -> (),
    ChangeIcon: (self: Cursor, ImageId: string) -> (),
    ChangeIconColor: (self: Cursor, Color: Color3) -> (),
    ChangeIconSize: (self: Cursor, Size: UDim2) -> (),
}

export type ContextMenu = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Active: boolean,
    ActiveCallback: ((Active: boolean) -> ())?,
    Holder: GuiObject,
    Menu: GuiObject,
    Corner: UICorner?,
    List: UIListLayout?,
    Signal: RBXScriptConnection?,
    Size: UDim2 | () -> UDim2,
    AutoSizeY: boolean,
    ParentMenu: ContextMenu?,

    Open: (self: ContextMenu) -> (),
    Close: (self: ContextMenu) -> (),
    Toggle: (self: ContextMenu) -> (),
    SetSize: (self: ContextMenu, Size: UDim2 | () -> UDim2) -> (),
    Destroy: (self: ContextMenu) -> (),
}

export type Tooltip = {
    Disabled: boolean,
    Hovering: boolean,
    Signals: { [number]: RBXScriptConnection },
    Destroy: (self: Tooltip) -> (),
}

export type Notification = {
    Title: string?,
    Description: string,
    Time: number | Instance,
    SoundId: (string | number)?,
    Volume: number?,
    Steps: number?,
    Persist: boolean?,
    Icon: (string | number)?,
    BigIcon: string?,
    IconColor: (Color3 | string)?,
    TitleColor: Color3?,
    DescriptionColor: Color3?,
    Callback: ((self: Notification) -> ())?,
    Destroyed: boolean,
    PositionInitialized: boolean?,

    Resize: (self: Notification) -> (),
    ChangeTitle: (self: Notification, Text: string) -> (),
    ChangeDescription: (self: Notification, Text: string) -> (),
    ChangeStep: (self: Notification, NewStep: number) -> (),
    Destroy: (self: Notification, Reason: any?) -> (),
}

export type NotificationInfo = {
    Title: string?,
    Description: string,
    Time: (number | Instance)?,
    SoundId: (string | number)?,
    Volume: number?,
    Steps: number?,
    Persist: boolean?,
    TitleColor: Color3?,
    DescriptionColor: Color3?,
    Icon: (string | number)?,
    IconColor: (Color3 | string)?,
    BigIcon: string?,
    Callback: ((Notification: Notification) -> ())?,
}

export type KeybindToggle = {
    Normal: boolean,
    Holder: TextButton,
    Label: TextLabel,
    Checkbox: Frame,
    Loaded: boolean,

    Display: (self: KeybindToggle, State: boolean) -> (),
    SetText: (self: KeybindToggle, Text: string) -> (),
    SetVisibility: (self: KeybindToggle, Visibility: boolean) -> (),
    SetNormal: (self: KeybindToggle, Normal: boolean) -> (),
}

export type DraggableLabel = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Label: TextLabel,

    SetText: (self: DraggableLabel, Text: string) -> (),
    SetVisible: (self: DraggableLabel, Visible: boolean) -> (),
    SetIcon: (self: DraggableLabel, Icon: string) -> (),
    SetIconPosition: (self: DraggableLabel, Position: string) -> (),
    Destroy: (self: DraggableLabel) -> (),
}

export type DraggableButton = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Button: TextButton,

    SetText: (self: DraggableButton, Text: string) -> (),
    Destroy: (self: DraggableButton) -> (),
}

export type DraggableButtonInfo = {
    Text: string,
    Callback: ((DraggableButton) -> ())?,
    Func: ((DraggableButton) -> ())?,
    ExcludeScaling: boolean?,
    ExcludeDragging: boolean?,
}

export type DraggableImageButton = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Button: TextButton,
    IconImage: (ImageLabel | TextLabel)?,

    SetIcon: (self: DraggableImageButton, Icon: string) -> (),
    SetIconSize: (self: DraggableImageButton, Size: number) -> (),
}

export type DraggableImageButtonInfo = {
    Icon: string | number,
    IconSize: number?,
    Callback: ((DraggableImageButton) -> ())?,
    Func: ((DraggableImageButton) -> ())?,
    ExcludeScaling: boolean?,
    ExcludeDragging: boolean?,
}

--// Element Creation Info Types
export type ButtonInfo = {
    Text: string,
    Func: ((FromKeyPicker: boolean?) -> ())?,
    Callback: ((FromKeyPicker: boolean?) -> ())?,
    DoubleClick: boolean?,
    Icon: string?,
    IconName: string?,
    Tooltip: string?,
    DisabledTooltip: string?,
    Risky: boolean?,
    Disabled: boolean?,
    Visible: boolean?,
    Idx: string?,
}

export type ToggleInfo = {
    Text: string,
    Default: boolean?,
    Callback: ((boolean) -> ())?,
    Changed: ((boolean) -> ())?,
    Tooltip: string?,
    DisabledTooltip: string?,
    Risky: boolean?,
    Disabled: boolean?,
    Visible: boolean?,
}

export type InputInfo = {
    Text: string,
    Default: string?,
    Finished: boolean?,
    Numeric: boolean?,
    ClearTextOnFocus: boolean?,
    ClearTextOnBlur: boolean?,
    Placeholder: string?,
    AllowEmpty: boolean?,
    EmptyReset: string?,
    MaxLength: number?,
    Tooltip: string?,
    DisabledTooltip: string?,
    Callback: ((string) -> ())?,
    Changed: ((string) -> ())?,
    VerifyValue: ((string) -> boolean)?,
    Disabled: boolean?,
    Visible: boolean?,
}

export type SliderInfo = {
    Text: string,
    Default: number?,
    Min: number?,
    Max: number?,
    Rounding: number?,
    Prefix: string?,
    Suffix: string?,
    Compact: boolean?,
    HideMax: boolean?,
    FormatDisplayValue: ((Slider, number) -> string)?,
    Tooltip: string?,
    DisabledTooltip: string?,
    Callback: ((number) -> ())?,
    Changed: ((number) -> ())?,
    Disabled: boolean?,
    Visible: boolean?,
    AllowRightClickInput: boolean?,
}

export type DropdownInfo = {
    Text: string?,
    Values: { [any]: any },
    Default: any,
    DisabledValues: { any }?,
    ValueImages: { [any]: string }?,
    Multi: boolean?,
    DragSelect: boolean?,
    MaxVisibleDropdownItems: number?,
    KeepDisabledValuePosition: boolean?,
    SpecialType: ("Player" | "Team")?,
    ExcludeLocalPlayer: boolean?,
    EnablePlayerImages: boolean?,
    AllowNull: boolean?,
    Searchable: boolean?,
    FormatDisplayValue: ((any) -> string)?,
    FormatListValue: ((any) -> string)?,
    Tooltip: string?,
    DisabledTooltip: string?,
    Callback: ((any) -> ())?,
    Changed: ((any) -> ())?,
    Disabled: boolean?,
    Visible: boolean?,
}

export type ViewportInfo = {
    Object: (BasePart | Model)?,
    Camera: Camera?,
    Clone: boolean?,
    AutoFocus: boolean?,
    Interactive: boolean?,
    Height: number?,
    Visible: boolean?,
}

export type ImageInfo = {
    Image: string,
    Transparency: number?,
    BackgroundTransparency: number?,
    Color: Color3?,
    RectOffset: Vector2?,
    RectSize: Vector2?,
    ScaleType: Enum.ScaleType?,
    Height: number?,
    Visible: boolean?,
}

export type VideoInfo = {
    Video: string,
    Looped: boolean?,
    Playing: boolean?,
    Volume: number?,
    Height: number?,
    Visible: boolean?,
}

export type UIPassthroughInfo = {
    Instance: GuiBase2d,
    Height: number?,
    Visible: boolean?,
}

export type KeyPickerInfo = {
    Text: string,
    Default: string?,
    DefaultModifiers: { string }?,
    Blacklisted: { string }?,
    BlacklistedModifiers: { string }?,
    Whitelisted: { string }?,
    WhitelistedModifiers: { string }?,
    Mode: ("Always" | "Toggle" | "Hold" | "Press")?,
    Modes: { "Always" | "Toggle" | "Hold" | "Press" }?,
    SyncToggleState: boolean?,
    NoUI: boolean?,
    WaitForCallback: boolean?,
    Callback: ((boolean) -> ())?,
    ChangedCallback: ((Enum.KeyCode | Enum.UserInputType) -> ())?,
    Changed: ((Enum.KeyCode | Enum.UserInputType) -> ())?,
    Clicked: (() -> ())?,
}

export type ColorPickerInfo = {
    Default: Color3?,
    Transparency: number?,
    Title: string?,
    Resizable: boolean?,
    Callback: ((Color3) -> ())?,
    Changed: ((Color3) -> ())?,
}

export type SettingsInfo = {
    Width: number?,
}

export type LoadingInfo = {
    Title: string?,
    Icon: (string | number)?,
    IconSize: UDim2?,
    LoadingIcon: (string | number)?,
    LoadingIconColor: Color3?,
    LoadingIconTweenTime: number?,
    CurrentStep: number?,
    TotalSteps: number?,
    ShowSidebar: boolean?,
    AutoResizeHeight: boolean?,
    AlwaysOnTop: boolean?,
    WindowWidth: number?,
    WindowHeight: number?,
    ContentWidth: number?,
    SidebarWidth: number?,
}

--// Addon Types
export type KeyPicker = {
    Connections: { RBXScriptConnection },
    Text: string,
    Value: string,
    Modifiers: { string },
    DisplayValue: string,
    Blacklisted: { string },
    BlacklistedModifiers: { string },
    Whitelisted: { string },
    WhitelistedModifiers: { string },
    Toggled: boolean,
    Mode: "Always" | "Toggle" | "Hold" | "Press",
    SyncToggleState: boolean,
    NoUI: boolean,
    Idx: string | number,
    Callback: (Toggled: boolean) -> (),
    ChangedCallback: (Key: Enum.KeyCode | Enum.UserInputType) -> (),
    Changed: (Key: Enum.KeyCode | Enum.UserInputType) -> (),
    Clicked: () -> (),
    Type: "KeyPicker",
    Menu: ContextMenu,
    MenuVisible: boolean,

    Display: (self: KeyPicker, PickerText: string?) -> (),
    Update: (self: KeyPicker) -> (),
    GetState: (self: KeyPicker) -> boolean,
    OnChanged: (self: KeyPicker, Func: (Key: Enum.KeyCode | Enum.UserInputType) -> ()) -> (),
    OnClick: (self: KeyPicker, Func: () -> ()) -> (),
    DoClick: (self: KeyPicker) -> (),
    RunChanged: (self: KeyPicker, IsKeyValid: boolean?, KeyCode: (Enum.KeyCode | Enum.UserInputType)?) -> (),
    SetValue: (self: KeyPicker, Data: { string }) -> (),
    SetText: (self: KeyPicker, Text: string) -> (),
    SetMenuVisibility: (self: KeyPicker, Visible: boolean) -> (),
    Destroy: (self: KeyPicker) -> (),
}

export type KeybindMenu = {
    VisibilityControl: boolean,
    Collapsed: boolean,
    SettingsOpen: boolean,
    Frame: Frame?,
    Container: Frame?,
    SettingsFrame: Frame?,
    SettingsContainer: Frame?,

    SetCollapsed: (self: KeybindMenu, Collapsed: boolean) -> (),
    ToggleCollapsed: (self: KeybindMenu) -> (),
    SetSettingsOpen: (self: KeybindMenu, Open: boolean) -> (),
    ToggleSettings: (self: KeybindMenu) -> (),
    SetVisibilityControl: (self: KeybindMenu, Enabled: boolean) -> (),
    RefreshSettings: (self: KeybindMenu) -> (),
    Destroy: (self: KeybindMenu) -> (),
}

export type ColorPicker = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Value: Color3,
    Transparency: number,
    Title: string?,
    Callback: (Value: Color3) -> (),
    Changed: (Value: Color3) -> (),
    Type: "ColorPicker",
    Hue: number,
    Sat: number,
    Vib: number,
    ColorMenu: ContextMenu,
    ContextMenu: ContextMenu,

    SetHSVFromRGB: (self: ColorPicker, Color: Color3) -> (),
    Display: (self: ColorPicker) -> (),
    RunChanged: (self: ColorPicker) -> (),
    Update: (self: ColorPicker) -> (),
    OnChanged: (self: ColorPicker, Func: (Value: Color3) -> ()) -> (),
    SetValue: (self: ColorPicker, HSV: { number }, Transparency: number?) -> (),
    SetValueRGB: (self: ColorPicker, Color: Color3, Transparency: number?) -> (),
    Destroy: (self: ColorPicker) -> (),
}

export type Settings = BaseGroupbox & {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Elements: { [number]: Element },
    DependencyBoxes: { [number]: DependencyBox },
    Width: number?,
    Type: "Settings",
    Parent: any,
    Menu: ContextMenu,
    Holder: Frame,
    Container: Frame,
    Gear: TextButton,

    Resize: (self: Settings) -> (),
    SetWidth: (self: Settings, Width: number?) -> (),
    Open: (self: Settings) -> (),
    Close: (self: Settings) -> (),
    Toggle: (self: Settings) -> (),
    Update: (self: Settings) -> (),
    Destroy: (self: Settings) -> (),
}

export type Addon = KeyPicker | ColorPicker | Settings

--// Base Element Types
export type Label = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Text: string,
    DoesWrap: boolean,
    Addons: { [number]: Addon },
    Visible: boolean,
    Type: "Label",
    TextLabel: TextLabel,
    Container: GuiObject,
    Holder: TextLabel,
    Parent: BaseGroupbox,
    Settings: Settings?,

    Display: (self: Label) -> (),
    SetVisible: (self: Label, Visible: boolean) -> (),
    SetText: (self: Label, Text: string) -> (),

    -- From BaseAddons
    AddKeyPicker: ((self: Label, Idx: string, Info: KeyPickerInfo, ReturnCreated: true) -> KeyPicker)
        & ((self: Label, Idx: string, Info: KeyPickerInfo, ReturnCreated: false?) -> Label)
        & ((self: Label, Idx: string, Info: KeyPickerInfo, ReturnCreated: boolean) -> Label | KeyPicker),
    AddColorPicker: ((self: Label, Idx: string, Info: ColorPickerInfo, ReturnCreated: true) -> ColorPicker)
        & ((self: Label, Idx: string, Info: ColorPickerInfo, ReturnCreated: false?) -> Label)
        & ((self: Label, Idx: string, Info: ColorPickerInfo, ReturnCreated: boolean) -> Label | ColorPicker),
    AddSettings: (self: Label, Info: SettingsInfo?) -> Settings,
    Destroy: (self: Label) -> (),
}

export type Button = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Text: string,
    Func: ((FromKeyPicker: boolean?) -> ())?,
    DoubleClick: boolean?,
    Icon: string?,
    Tooltip: string?,
    DisabledTooltip: string?,
    TooltipTable: Tooltip?,
    Risky: boolean,
    Disabled: boolean,
    Visible: boolean,
    Tween: Tween?,
    Type: "Button",
    Base: TextButton,
    Stroke: UIStroke,
    Label: TextLabel,
    IconImage: (ImageLabel | TextLabel)?,
    Holder: Frame,
    SubButton: SubButton?,
    Parent: BaseGroupbox,
    Addons: { [number]: Addon },
    Settings: Settings?,

    AddButton: (self: Button, Info: ButtonInfo | string, Func: (((FromKeyPicker: boolean?) -> ()) | string)?, Idx: string?) -> SubButton,
    UpdateColors: (self: Button) -> (),
    SetDisabled: (self: Button, Disabled: boolean) -> (),
    SetVisible: (self: Button, Visible: boolean) -> (),
    SetText: (self: Button, Text: string) -> (),
    SetIcon: (self: Button, Icon: string?) -> (),
    AddKeyPicker: ((self: Button, Idx: string, Info: KeyPickerInfo, ReturnCreated: true) -> KeyPicker)
        & ((self: Button, Idx: string, Info: KeyPickerInfo, ReturnCreated: false?) -> Button)
        & ((self: Button, Idx: string, Info: KeyPickerInfo, ReturnCreated: boolean) -> Button | KeyPicker),
    AddColorPicker: ((self: Button, Idx: string, Info: ColorPickerInfo, ReturnCreated: true) -> ColorPicker)
        & ((self: Button, Idx: string, Info: ColorPickerInfo, ReturnCreated: false?) -> Button)
        & ((self: Button, Idx: string, Info: ColorPickerInfo, ReturnCreated: boolean) -> Button | ColorPicker),
    AddSettings: (self: Button, Info: SettingsInfo?) -> Settings,
    Destroy: (self: Button) -> (),
}

export type SubButton = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Text: string,
    Func: ((FromKeyPicker: boolean?) -> ())?,
    DoubleClick: boolean?,
    Icon: string?,
    Tooltip: string?,
    DisabledTooltip: string?,
    TooltipTable: Tooltip?,
    Risky: boolean,
    Disabled: boolean,
    Visible: boolean,
    Tween: Tween?,
    Type: "SubButton",
    Base: TextButton,
    Stroke: UIStroke,
    Label: TextLabel,
    IconImage: (ImageLabel | TextLabel)?,
    Addons: { [number]: Addon },
    Settings: Settings?,

    UpdateColors: (self: SubButton) -> (),
    SetDisabled: (self: SubButton, Disabled: boolean) -> (),
    SetVisible: (self: SubButton, Visible: boolean) -> (),
    SetText: (self: SubButton, Text: string) -> (),
    SetIcon: (self: SubButton, Icon: string?) -> (),
    AddKeyPicker: ((self: SubButton, Idx: string, Info: KeyPickerInfo, ReturnCreated: true) -> KeyPicker)
        & ((self: SubButton, Idx: string, Info: KeyPickerInfo, ReturnCreated: false?) -> SubButton)
        & ((self: SubButton, Idx: string, Info: KeyPickerInfo, ReturnCreated: boolean) -> SubButton | KeyPicker),
    AddSettings: (self: SubButton, Info: SettingsInfo?) -> Settings,
    Destroy: (self: SubButton) -> (),
}

export type Toggle = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Text: string,
    Value: boolean,
    Tooltip: string?,
    DisabledTooltip: string?,
    TooltipTable: Tooltip?,
    Callback: (Value: boolean) -> (),
    Changed: (Value: boolean) -> (),
    Risky: boolean,
    Disabled: boolean,
    Visible: boolean,
    Addons: { [number]: Addon },
    Type: "Toggle",
    TextLabel: TextLabel,
    Container: GuiObject,
    Holder: TextButton,
    Parent: BaseGroupbox,
    Settings: Settings?,

    UpdateColors: (self: Toggle) -> (),
    Display: (self: Toggle) -> (),
    OnChanged: (self: Toggle, Func: (Value: boolean) -> ()) -> (),
    RunChanged: (self: Toggle) -> (),
    SetValue: (self: Toggle, Value: boolean) -> (),
    SetDisabled: (self: Toggle, Disabled: boolean) -> (),
    SetVisible: (self: Toggle, Visible: boolean) -> (),
    SetText: (self: Toggle, Text: string) -> (),

    -- From BaseAddons
    AddKeyPicker: ((self: Toggle, Idx: string, Info: KeyPickerInfo, ReturnCreated: true) -> KeyPicker)
        & ((self: Toggle, Idx: string, Info: KeyPickerInfo, ReturnCreated: false?) -> Toggle)
        & ((self: Toggle, Idx: string, Info: KeyPickerInfo, ReturnCreated: boolean) -> Toggle | KeyPicker),
    AddColorPicker: ((self: Toggle, Idx: string, Info: ColorPickerInfo, ReturnCreated: true) -> ColorPicker)
        & ((self: Toggle, Idx: string, Info: ColorPickerInfo, ReturnCreated: false?) -> Toggle)
        & ((self: Toggle, Idx: string, Info: ColorPickerInfo, ReturnCreated: boolean) -> Toggle | ColorPicker),
    AddSettings: (self: Toggle, Info: SettingsInfo?) -> Settings,
    Destroy: (self: Toggle) -> (),
}

export type Input = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Text: string,
    Value: string,
    Finished: boolean,
    Numeric: boolean,
    ClearTextOnFocus: boolean,
    ClearTextOnBlur: boolean,
    Placeholder: string,
    AllowEmpty: boolean,
    EmptyReset: string,
    Tooltip: string?,
    DisabledTooltip: string?,
    TooltipTable: Tooltip?,
    Callback: (Value: string) -> (),
    Changed: (Value: string) -> (),
    VerifyValue: ((string) -> boolean)?,
    Disabled: boolean,
    Visible: boolean,
    Type: "Input",
    Holder: Frame,
    Label: TextLabel,
    Container: Frame,
    Addons: { [number]: Addon },
    Settings: Settings?,

    UpdateColors: (self: Input) -> (),
    OnChanged: (self: Input, Func: (Value: string) -> ()) -> (),
    RunChanged: (self: Input) -> (),
    SetValue: (self: Input, Text: string) -> (),
    SetDisabled: (self: Input, Disabled: boolean) -> (),
    SetVisible: (self: Input, Visible: boolean) -> (),
    SetText: (self: Input, Text: string) -> (),
    AddSettings: (self: Input, Info: SettingsInfo?) -> Settings,
    Destroy: (self: Input) -> (),
}

export type Slider = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Text: string,
    Value: number,
    Min: number,
    Max: number,
    Prefix: string,
    Suffix: string,
    Compact: boolean?,
    Rounding: number,
    HideMax: boolean?,
    Tooltip: string?,
    DisabledTooltip: string?,
    TooltipTable: Tooltip?,
    Callback: (Value: number) -> (),
    Changed: (Value: number) -> (),
    Disabled: boolean,
    Visible: boolean,
    AllowRightClickInput: boolean,
    Type: "Slider",
    Holder: Frame,

    UpdateColors: (self: Slider) -> (),
    Display: (self: Slider) -> (),
    OnChanged: (self: Slider, Func: (Value: number) -> ()) -> (),
    RunChanged: (self: Slider) -> (),
    SetMax: (self: Slider, Value: number) -> (),
    SetMin: (self: Slider, Value: number) -> (),
    SetValue: (self: Slider, Value: number | string) -> (),
    SetDisabled: (self: Slider, Disabled: boolean) -> (),
    SetVisible: (self: Slider, Visible: boolean) -> (),
    SetText: (self: Slider, Text: string) -> (),
    SetPrefix: (self: Slider, Prefix: string) -> (),
    SetSuffix: (self: Slider, Suffix: string) -> (),
    Destroy: (self: Slider) -> (),
}

export type Dropdown = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,

    Text: string?,
    Value: { [any]: boolean } | any,
    Values: { [any]: any },
    DisabledValues: { any },
    ValueImages: { [any]: string }?,
    Multi: boolean,
    DragSelect: boolean,
    KeepDisabledValuePosition: boolean,
    SpecialType: ("Player" | "Team")?,
    ExcludeLocalPlayer: boolean?,
    EnablePlayerImages: boolean?,
    Tooltip: string?,
    DisabledTooltip: string?,
    TooltipTable: Tooltip?,
    Callback: (Value: any) -> (),
    Changed: (Value: any) -> (),
    Disabled: boolean,
    Visible: boolean,
    Type: "Dropdown",
    Menu: ContextMenu,
    Holder: Frame,
    Default: any,
    DefaultValues: { [any]: any },
    Addons: { [number]: Addon },
    Settings: Settings?,

    RecalculateListSize: (self: Dropdown, Count: number?) -> (),
    UpdateColors: (self: Dropdown) -> (),
    Display: (self: Dropdown) -> (),
    OnChanged: (self: Dropdown, Func: (Value: any) -> ()) -> (),
    GetActiveValues: (self: Dropdown, ReturnCount: boolean?) -> { any } | number,
    RefreshPool: (self: Dropdown) -> (),
    BuildDropdownList: (self: Dropdown) -> (),
    RunChanged: (self: Dropdown) -> (),
    SetValue: (self: Dropdown, Value: any) -> (),
    SetValues: (self: Dropdown, Values: { [any]: any }) -> (),
    AddValues: (self: Dropdown, Values: { [any]: any } | string) -> Dropdown,
    SetDisabledValues: (self: Dropdown, DisabledValues: { any }) -> (),
    AddDisabledValues: (self: Dropdown, DisabledValues: { any } | string) -> Dropdown,
    SetValueImages: (self: Dropdown, ValueImages: { [any]: string }) -> (),
    AddValueImages: (self: Dropdown, ValueImages: { [any]: string }) -> Dropdown,
    SetDisabled: (self: Dropdown, Disabled: boolean) -> (),
    SetVisible: (self: Dropdown, Visible: boolean) -> (),
    SetText: (self: Dropdown, Text: string) -> (),
    SetDragSelect: (self: Dropdown, Value: boolean) -> (),
    AddSettings: (self: Dropdown, Info: SettingsInfo?) -> Settings,
    Destroy: (self: Dropdown) -> (),
}

export type Viewport = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Object: BasePart | Model,
    Camera: Camera,
    Interactive: boolean,
    AutoFocus: boolean,
    Visible: boolean,
    Type: "Viewport",
    Holder: Frame,
    ViewportFrame: ViewportFrame,

    SetObject: (self: Viewport, Object: Instance, Clone: boolean?) -> (),
    SetHeight: (self: Viewport, Height: number) -> (),
    Focus: (self: Viewport) -> (),
    SetCamera: (self: Viewport, Camera: Camera) -> (),
    SetCameraCFrame: (self: Viewport, NewCFrame: CFrame) -> (),
    GetCameraCFrame: (self: Viewport) -> CFrame,
    Rotate: (self: Viewport, Yaw: number, Pitch: number?) -> (),
    Zoom: (self: Viewport, Amount: number) -> (),
    LookAt: (self: Viewport, Target: Vector3?) -> (),
    SetDistance: (self: Viewport, Distance: number) -> (),
    GetDistance: (self: Viewport) -> number,
    SetFieldOfView: (self: Viewport, FieldOfView: number) -> (),
    SetInteractive: (self: Viewport, Interactive: boolean) -> (),
    SetVisible: (self: Viewport, Visible: boolean) -> (),
    Destroy: (self: Viewport) -> (),
}

export type Image = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Image: string,
    Color: Color3,
    RectOffset: Vector2,
    RectSize: Vector2,
    Height: number,
    ScaleType: Enum.ScaleType,
    Transparency: number,
    BackgroundTransparency: number,
    Visible: boolean,
    Type: "Image",
    Holder: Frame,
    ImageLabel: ImageLabel,

    SetHeight: (self: Image, Height: number) -> (),
    SetImage: (self: Image, NewImage: string) -> (),
    SetColor: (self: Image, Color: Color3) -> (),
    SetRectOffset: (self: Image, RectOffset: Vector2) -> (),
    SetRectSize: (self: Image, RectSize: Vector2) -> (),
    SetScaleType: (self: Image, ScaleType: Enum.ScaleType) -> (),
    SetTransparency: (self: Image, Transparency: number) -> (),
    SetVisible: (self: Image, Visible: boolean) -> (),
    Destroy: (self: Image) -> (),
}

export type Video = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Video: string,
    Looped: boolean,
    Playing: boolean,
    Volume: number,
    Height: number,
    Visible: boolean,
    Type: "Video",
    Holder: Frame,
    VideoFrame: VideoFrame,

    SetHeight: (self: Video, Height: number) -> (),
    SetVideo: (self: Video, NewVideo: string) -> (),
    SetLooped: (self: Video, Looped: boolean) -> (),
    SetVolume: (self: Video, Volume: number) -> (),
    SetPlaying: (self: Video, Playing: boolean) -> (),
    Play: (self: Video) -> (),
    Pause: (self: Video) -> (),
    SetVisible: (self: Video, Visible: boolean) -> (),
    Destroy: (self: Video) -> (),
}

export type UIPassthrough = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Instance: GuiBase2d,
    Height: number,
    Visible: boolean,
    Type: "UIPassthrough",
    Holder: Frame,

    SetHeight: (self: UIPassthrough, Height: number) -> (),
    SetInstance: (self: UIPassthrough, Instance: GuiBase2d) -> (),
    SetVisible: (self: UIPassthrough, Visible: boolean) -> (),
    Destroy: (self: UIPassthrough) -> (),
}

export type Divider = {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Holder: Frame,
    Text: string?,
    MarginTop: number?,
    MarginBottom: number?,
    Type: "Divider",
    Parent: BaseGroupbox,

    SetVisible: (self: Divider, Value: boolean) -> (),
    Destroy: (self: Divider) -> (),
}

export type Element =
    Label
    | Button
    | Toggle
    | Input
    | Slider
    | Dropdown
    | Viewport
    | Image
    | Video
    | UIPassthrough
    | Divider
    | Settings

export type Option =
    Toggle
    | Input
    | Slider
    | Dropdown
    | Viewport
    | Image
    | Video
    | UIPassthrough
    | KeyPicker
    | ColorPicker

--// Container Types
export type BaseGroupbox = {
    AddDivider: (
        self: BaseGroupbox,
        Info: (string | { Text: string?, Margin: number?, MarginTop: number?, MarginBottom: number? })?
    ) -> Divider,
    AddLabel: (
        self: BaseGroupbox,
        Info: { Text: string, DoesWrap: boolean?, Size: number?, Visible: boolean?, Idx: string? } | string,
        DoesWrap: boolean?,
        Idx: string?
    ) -> Label,
    AddButton: (
        self: BaseGroupbox,
        Info: ButtonInfo | string,
        Func: (((FromKeyPicker: boolean?) -> ()) | string)?,
        Idx: string?
    ) -> Button,
    AddCheckbox: (self: BaseGroupbox, Idx: string, Info: ToggleInfo) -> Toggle,
    AddToggle: (self: BaseGroupbox, Idx: string, Info: ToggleInfo) -> Toggle,
    AddInput: (self: BaseGroupbox, Idx: string, Info: InputInfo) -> Input,
    AddSlider: (self: BaseGroupbox, Idx: string, Info: SliderInfo) -> Slider,
    AddDropdown: (self: BaseGroupbox, Idx: string, Info: DropdownInfo) -> Dropdown,
    AddViewport: (self: BaseGroupbox, Idx: string, Info: ViewportInfo) -> Viewport,
    AddImage: (self: BaseGroupbox, Idx: string, Info: ImageInfo) -> Image,
    AddVideo: (self: BaseGroupbox, Idx: string, Info: VideoInfo) -> Video,
    AddUIPassthrough: (self: BaseGroupbox, Idx: string, Info: UIPassthroughInfo) -> UIPassthrough,
    AddDependencyBox: (self: BaseGroupbox) -> DependencyBox,
    AddDependencyGroupbox: (self: BaseGroupbox) -> DependencyGroupbox,
    AddTabbox: (
        self: BaseGroupbox,
        Info: (TabboxInfo | string)?
    ) -> Tabbox,
    SetVisible: (self: BaseGroupbox, Visible: boolean) -> (),
    Show: (self: BaseGroupbox) -> (),
    Hide: (self: BaseGroupbox) -> (),
}

export type DependencyBox = BaseGroupbox & {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Visible: boolean,
    Dependencies: { [number]: { Element } },
    Holder: Frame,
    Container: Frame,
    Elements: { [number]: Element },
    DependencyBoxes: { [number]: DependencyBox },

    Resize: (self: DependencyBox) -> (),
    Update: (self: DependencyBox, CancelSearch: boolean?) -> (),
    SetupDependencies: (self: DependencyBox, Dependencies: { { Element } }) -> (),
    Destroy: (self: DependencyBox) -> (),
}

export type DependencyGroupbox = BaseGroupbox & {
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Visible: boolean,
    Dependencies: { [number]: { Element } },
    BoxHolder: Frame,
    Holder: Frame,
    Container: Frame,
    Tab: Tab,
    Elements: { [number]: Element },
    DependencyBoxes: { [number]: DependencyBox },

    Resize: (self: DependencyGroupbox) -> (),
    Update: (self: DependencyGroupbox, CancelSearch: boolean?) -> (),
    SetupDependencies: (self: DependencyGroupbox, Dependencies: { { Element } }) -> (),
    Destroy: (self: DependencyGroupbox) -> (),
}

export type Groupbox = BaseGroupbox & {
    Type: "Groupbox",
    Name: string?,
    Description: string?,
    Visible: boolean,
    Collapsed: boolean,
    MaxHeight: number?,
    PoppedOut: boolean,
    PopOutEnabled: boolean,
    PopOutFloat: Frame?,
    PopOutPlaceholder: Frame?,
    PopOutMaxHeight: number?,
    PopOutWidth: number?,
    BoxHolder: Frame,
    Holder: Frame,
    Container: ScrollingFrame,
    Tab: Tab,
    DependencyBoxes: { [number]: DependencyBox },
    Elements: { [number]: Element },
    Connections: { RBXScriptConnection },
    Destroyed: boolean,

    Resize: (self: Groupbox) -> (),
    SetDescription: (self: Groupbox, Description: string?) -> (),
    SetCollapsed: (self: Groupbox, Collapsed: boolean) -> (),
    ToggleCollapsed: (self: Groupbox) -> (),
    SetMaxHeight: (self: Groupbox, MaxHeight: number?) -> (),
    RefreshBoxHolderLayout: (self: Groupbox) -> (),
    SetPoppedOut: (self: Groupbox, Value: boolean, FloatPosition: UDim2?) -> (),
    TogglePoppedOut: (self: Groupbox) -> (),
    RefreshPopOutPlaceholder: (self: Groupbox) -> (),
    SetMaxPopOutHeight: (self: Groupbox, Height: number?) -> (),
    SetPopOutWidth: (self: Groupbox, Width: number?) -> (),
    Destroy: (self: Groupbox) -> (),
}

export type SubTab = BaseGroupbox & {
    Type: "SubTab",
    Name: string?,
    MaxHeight: number?,
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    ButtonHolder: TextButton,
    Container: ScrollingFrame,
    ButtonCorner: UICorner,
    Tab: Tab,
    Tabbox: Tabbox,
    Elements: { [number]: Element },
    DependencyBoxes: { [number]: DependencyBox },

    Show: (self: SubTab) -> (),
    Hide: (self: SubTab) -> (),
    Resize: (self: SubTab) -> (),
    SetMaxHeight: (self: SubTab, NewMaxHeight: number?) -> (),
    UpdateCorners: (self: SubTab) -> (),
    Destroy: (self: SubTab) -> (),
}

export type TabboxInfo = {
    Side: (number | string)?,
    Name: string?,
    MaxHeight: number?,
    PopOut: boolean?,
    MaxPopOutHeight: number?,
    PopOutWidth: number?,
}

export type Tabbox = {
    Type: "Tabbox",
    Visible: boolean,
    Destroyed: boolean,
    Connections: { RBXScriptConnection },
    MaxHeight: number?,
    PoppedOut: boolean,
    PopOutEnabled: boolean,
    PopOutFloat: Frame?,
    PopOutPlaceholder: Frame?,
    PopOutMaxHeight: number?,
    PopOutWidth: number?,
    ActiveTab: SubTab?,
    BoxHolder: Frame,
    Holder: Frame,
    Tabs: { [string]: SubTab },
    ParentBox: (Groupbox | SubTab)?,

    AddTab: (self: Tabbox, Name: string, IconName: string?, MaxHeight: number?) -> (SubTab, number),
    Resize: (self: Tabbox) -> (),
    UpdateCorners: (self: Tabbox) -> (),
    SetMaxHeight: (self: Tabbox, MaxHeight: number?) -> (),
    SetPoppedOut: (self: Tabbox, Value: boolean, FloatPosition: UDim2?) -> (),
    TogglePoppedOut: (self: Tabbox) -> (),
    RefreshPopOutPlaceholder: (self: Tabbox) -> (),
    SetMaxPopOutHeight: (self: Tabbox, Height: number?) -> (),
    SetPopOutWidth: (self: Tabbox, Width: number?) -> (),
    Destroy: (self: Tabbox) -> (),
}

export type GroupboxInfo = {
    Side: number | string,
    Name: string,
    IconName: string?,
    Description: string?,
    Visible: boolean?,
    Collapsed: boolean?,
    DisableCollapsing: boolean?,
    MaxHeight: number?,
    PopOut: boolean?,
    MaxPopOutHeight: number?,
    PopOutWidth: number?,
}

export type TabInfo = {
    Name: string,
    Icon: string?,
    Description: string?,
    Tooltip: string?,
    Order: number?,
}

export type Tab = {
    Name: string,
    Description: string?,
    Tooltip: string?,
    TooltipTable: Tooltip?,
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Window: Window,
    Button: TextButton,
    Container: Frame,
    Sides: { ScrollingFrame },
    WarningBox: { IsNormal: boolean, LockSize: boolean, Visible: boolean, Title: string, Text: string },
    Groupboxes: { [string]: Groupbox },
    Tabboxes: { [string]: Tabbox },
    DependencyGroupboxes: { [number]: DependencyGroupbox },

    UpdateWarningBox: (
        self: Tab,
        Info: { IsNormal: boolean?, LockSize: boolean?, Visible: boolean?, Title: string?, Text: string? }
    ) -> (),
    RefreshSides: (self: Tab) -> (),
    Resize: (self: Tab, ResizeWarningBox: boolean?) -> (),
    AddGroupbox: (self: Tab, Info: GroupboxInfo) -> Groupbox,
    AddLeftGroupbox: (
        self: Tab,
        Name: string,
        IconName: string?,
        Visible: boolean?,
        Collapsed: boolean?,
        DisableCollapsing: boolean?
    ) -> Groupbox,
    AddRightGroupbox: (
        self: Tab,
        Name: string,
        IconName: string?,
        Visible: boolean?,
        Collapsed: boolean?,
        DisableCollapsing: boolean?
    ) -> Groupbox,
    AddTabbox: (self: Tab, Info: TabboxInfo) -> Tabbox,
    AddLeftTabbox: (self: Tab, Name: string?) -> Tabbox,
    AddRightTabbox: (self: Tab, Name: string?) -> Tabbox,
    Hover: (self: Tab, Hovering: boolean) -> (),
    Show: (self: Tab) -> (),
    Hide: (self: Tab) -> (),
    SetVisible: (self: Tab, Visible: boolean) -> (),
    SetOrder: (self: Tab, Order: number) -> (),
    SetTooltip: (self: Tab, Text: string?) -> (),
    Destroy: (self: Tab) -> (),
}

export type KeyTab = BaseGroupbox & {
    Description: string?,
    IsKeyTab: true,
    Tooltip: string?,
    TooltipTable: Tooltip?,
    Elements: { [any]: any },
    Window: Window,
    Button: TextButton,
    Container: ScrollingFrame,

    AddKeyBox: (self: KeyTab, Callback: (Key: string) -> ()) -> (),
    RefreshSides: (self: KeyTab) -> (),
    Resize: (self: KeyTab) -> (),
    UpdateCorners: (self: KeyTab) -> (),
    Hover: (self: KeyTab, Hovering: boolean) -> (),
    Show: (self: KeyTab) -> (),
    Hide: (self: KeyTab) -> (),
    SetVisible: (self: KeyTab, Visible: boolean) -> (),
    SetOrder: (self: KeyTab, Order: number) -> (),
    SetTooltip: (self: KeyTab, Text: string?) -> (),
    Destroy: (self: KeyTab) -> (),
}

export type CustomTab = {
    Name: string,
    Description: string?,
    IsCustomTab: true,
    Tooltip: string?,
    TooltipTable: Tooltip?,
    Connections: { RBXScriptConnection },
    Destroyed: boolean,
    Window: Window,
    Button: TextButton,
    Container: Frame,
    Sides: { any },
    Groupboxes: { [string]: Groupbox },
    Tabboxes: { [string]: Tabbox },
    DependencyGroupboxes: { [number]: DependencyGroupbox },

    RefreshSides: (self: CustomTab) -> (),
    Resize: (self: CustomTab) -> (),
    UpdateCorners: (self: CustomTab) -> (),
    Hover: (self: CustomTab, Hovering: boolean) -> (),
    Show: (self: CustomTab) -> (),
    Hide: (self: CustomTab) -> (),
    SetVisible: (self: CustomTab, Visible: boolean) -> (),
    SetOrder: (self: CustomTab, NewOrder: number) -> (),
    SetTooltip: (self: CustomTab, Text: string?) -> (),
    Destroy: (self: CustomTab) -> (),
}

export type LoadingErrorButtonInfo = {
    Title: string?,
    Variant: ("Primary" | "Secondary" | "Destructive" | "Ghost")?,
    Callback: ((Loading) -> ())?,
}

export type LoadingSidebar = BaseGroupbox & {
    Elements: { [number]: Element },
    DependencyBoxes: { [number]: DependencyBox },
    Tabboxes: { [string]: Tabbox },
    BoxHolder: ScrollingFrame,
    Container: ScrollingFrame,
    Tab: {
        Elements: { [number]: Element },
        DependencyBoxes: { [number]: DependencyBox },
        DependencyGroupboxes: { [number]: DependencyGroupbox },
        Tabboxes: { [string]: Tabbox },
    },

    Resize: (self: LoadingSidebar) -> (),
}

export type Loading = {
    CurrentStep: number,
    TotalSteps: number,
    ShowSidebar: boolean,
    AutoResizeHeight: boolean,
    AlwaysOnTop: boolean,
    IsError: boolean,
    Destroyed: boolean,
    WindowWidth: number,
    WindowHeight: number,
    BaseWindowHeight: number,
    WindowErrorHeight: number,
    ContentWidth: number,
    SidebarWidth: number,
    ScreenGui: ScreenGui,
    Sidebar: LoadingSidebar,

    UpdateLayout: (self: Loading) -> (),
    RecalculateLoadingHeight: (self: Loading) -> (),
    SetMessage: (self: Loading, Text: string) -> (),
    SetDescription: (self: Loading, Text: string) -> (),
    SetLoadingIcon: (self: Loading, Icon: string | number) -> (),
    SetLoadingIconTweenTime: (self: Loading, TweenTime: number) -> (),
    SetLoadingIconColor: (self: Loading, Color: Color3) -> (),
    SetCurrentStep: (self: Loading, Step: number) -> (),
    SetTotalSteps: (self: Loading, Steps: number) -> (),
    SetWindowHeight: (self: Loading, Height: number) -> (),
    SetWindowWidth: (self: Loading, Width: number) -> (),
    SetContentWidth: (self: Loading, Width: number) -> (),
    SetSidebarWidth: (self: Loading, Width: number) -> (),
    ShowSidebarPage: (self: Loading, Bool: boolean) -> (),
    ShowErrorPage: (self: Loading, Enabled: boolean) -> (),
    RecalculateErrorHeight: (self: Loading) -> (),
    SetErrorMessage: (self: Loading, Text: string) -> (),
    SetErrorButtons: (self: Loading, Buttons: { [string]: LoadingErrorButtonInfo }) -> (),
    Destroy: (self: Loading) -> (),
    Continue: (self: Loading) -> (),
}

export type DialogButtonInfo = {
    Title: string,
    Variant: ("Primary" | "Secondary" | "Destructive" | "Ghost")?,
    WaitTime: number?,
    Order: number?,
    Callback: ((Dialog) -> ())?,
}

export type DialogInfo = {
    Title: string,
    Description: string?,
    Icon: string?,
    TitleColor: Color3?,
    DescriptionColor: Color3?,
    AutoDismiss: boolean?,
    OutsideClickDismiss: boolean?,
    FooterButtons: { [string]: DialogButtonInfo }?,
}

export type Dialog = {
    Destroyed: boolean,
    Elements: { any },
    Container: Frame,
    OutsideClickDismiss: boolean,

    Resize: (self: Dialog) -> (),
    SetTitle: (self: Dialog, Title: string) -> (),
    SetDescription: (self: Dialog, Description: string) -> (),
    AddFooterButton: (self: Dialog, ButtonIdx: string, ButtonInfo: DialogButtonInfo) -> (),
    RemoveFooterButton: (self: Dialog, ButtonIdx: string) -> (),
    SetButtonDisabled: (self: Dialog, ButtonIdx: string, Disabled: boolean) -> (),
    SetButtonOrder: (self: Dialog, ButtonIdx: string, Order: number) -> (),
    Dismiss: (self: Dialog) -> (),
}

export type TabButtonsStyle = {
    Gap: number?,
    Padding: number?,
    CornerRadius: number?,
    Indicator: boolean?,
    IndicatorWidth: number?,
    IndicatorHeight: number?,
}

export type WindowAnimations = {
    ToggleWindow: boolean?,
    TabSwitch: boolean?,
    Groupbox: boolean?,
    Dropdown: boolean?,
    KeyPicker: boolean?,
}

export type WindowInfo = {
    Title: string?,
    Footer: string?,
    Position: UDim2?,
    Size: UDim2?,
    Icon: string?,
    IconSize: UDim2?,
    BackgroundImage: (string | number)?,
    AutoShow: boolean?,
    Center: boolean?,
    Resizable: boolean?,
    DisableSearch: boolean?,
    SearchbarSize: UDim2?,
    GlobalSearch: boolean?,
    CornerRadius: number?,
    NotifySide: ("Left" | "Right")?,
    ShowCustomCursor: boolean?,
    AlwaysOnTop: boolean?,
    Font: (Font | Enum.Font)?,
    ToggleKeybind: Enum.KeyCode?,
    ShowMobileButtons: boolean?,
    MobileButtonsSide: ("Left" | "Right")?,
    UnlockMouseWhileOpen: boolean?,
    EnableSidebarResize: boolean?,
    EnableCompacting: boolean?,
    DisableCompactingSnap: boolean?,
    SidebarCompacted: boolean?,
    MinContainerWidth: number?,
    MinSidebarWidth: number?,
    SidebarCompactWidth: number?,
    SidebarCollapseThreshold: number?,
    CompactWidthActivation: number?,
    Snapping: boolean?,
    SnapDistance: number?,
    SnapMargin: number?,
    SnapAvoidCoreGui: boolean?,
    Animations: WindowAnimations?,
    TabTransitionTime: number?,
    TabSwipeOffset: number?,
    TabSwipeFrom: ("left" | "right" | "top" | "bottom" | "auto" | string)?,
    TabButtonsStyle: TabButtonsStyle?,

    -- Legacy/Alias Properties
    Compact: boolean?,
    SidebarMinWidth: number?,
}

export type Window = {
    AlwaysOnTop: boolean,
    Snapping: boolean?,
    MainFrame: Frame?,

    IsSidebarCompacted: (self: Window) -> boolean,
    GetSidebarWidth: (self: Window) -> number,
    SetSidebarWidth: (self: Window, Width: number) -> (),
    SetCompact: (self: Window, State: boolean) -> (),
    ShowTabInfo: (self: Window, Name: string, Description: string) -> (),
    HideTabInfo: (self: Window) -> (),
    AddTab: (
        self: Window,
        Info: TabInfo | string,
        Icon: string?,
        Description: string?,
        Order: number?
    ) -> Tab,
    AddKeyTab: (
        self: Window,
        Info: TabInfo | string,
        Icon: string?,
        Description: string?,
        Order: number?
    ) -> KeyTab,
    AddCustomTab: (
        self: Window,
        Info: TabInfo | string,
        Icon: string?,
        Description: string?,
        Order: number?
    ) -> (Frame, CustomTab),
    AddDialog: (
        self: Window,
        Idx: string,
        Info: DialogInfo
    ) -> Dialog,
    ChangeTitle: (self: Window, Title: string) -> (),
    RefreshTitleSize: (self: Window) -> (),
    SetBackgroundImage: (self: Window, Image: string | number) -> (),
    SetFooter: (self: Window, Footer: string) -> (),
    SetAlwaysOnTop: (self: Window, Enabled: boolean) -> (),
    SetCornerRadius: (self: Window, Radius: number) -> (),
    SetSnapping: (
        self: Window,
        Enabled: boolean,
        Distance: number?,
        Margin: number?,
        AvoidCoreGui: boolean?
    ) -> (),
    SetAnimations: (
        self: Window,
        Animations: { [string]: boolean }?,
        TabTransitionTime: number?,
        TabSwipeOffset: number?,
        TabSwipeFrom: ("left" | "right" | "top" | "bottom" | "auto" | string)?
    ) -> (),
    Toggle: (self: Window, Value: boolean?) -> (),
}

--// Main Library Type
export type Library = {
    -- Properties
    LocalPlayer: Player,
    DevicePlatform: Enum.Platform?,
    IsMobile: boolean,
    IsRobloxFocused: boolean,
    ScreenGui: ScreenGui?,
    Window: Window?,
    WindowContainer: Frame?,
    Floats: Frame?,
    Overlay: Frame?,
    SearchText: string,
    Searching: boolean,
    GlobalSearch: boolean,
    LastSearchTab: Tab?,
    ActiveTab: (Tab | KeyTab | CustomTab)?,
    PreviousTab: (Tab | KeyTab | CustomTab)?,
    ActiveLoading: Loading?,
    ActiveDialog: Dialog?,
    Tabs: { [string]: Tab | KeyTab | CustomTab },
    TabButtons: { [number]: any },
    DependencyBoxes: { [number]: DependencyBox | DependencyGroupbox },
    KeybindFrame: Frame?,
    KeybindContainer: Frame?,
    KeybindMenu: KeybindMenu?,
    KeybindToggles: { [number]: KeybindToggle },
    Notifications: { [GuiObject]: Notification },
    Dialogues: { [string]: Dialog },
    ContextMenus: { [any]: ContextMenu },
    Corners: { [number]: UICorner },
    SpecificCorners: { [number]: UICorner },
    ToggleKeybind: Enum.KeyCode,
    TweenInfo: TweenInfo,
    NotifyTweenInfo: TweenInfo,
    TabTransitionInfo: TweenInfo,
    TabSwipeOffset: number,
    TabSwipeFrom: string,
    WindowAnimationInfo: TweenInfo,
    DropdownTransitionInfo: TweenInfo,
    KeyPickerTransitionInfo: TweenInfo,
    GroupboxTweenInfo: TweenInfo,
    RotatingChevronTweenInfo: TweenInfo,
    Animations: {
        ToggleWindow: boolean,
        TabSwitch: boolean,
        Groupbox: boolean,
        Dropdown: boolean,
        KeyPicker: boolean,
    },
    Toggled: boolean,
    Unloaded: boolean,
    Labels: { [string | number]: Label },
    Buttons: { [string | number]: Button | SubButton },
    Toggles: { [string | number]: Toggle },
    Options: { [string | number]: Option },
    NotifySide: "Right" | "Left",
    ShowCustomCursor: boolean,
    ForceCheckbox: boolean,
    ShowToggleFrameInKeybinds: boolean,
    NotifyOnError: boolean,
    CantDragForced: boolean,
    DraggableElements: { GuiObject },
    PopOutSnapDistance: number,
    PopOutDragThreshold: number,
    PopOutHoldTime: number,
    Signals: { [number]: RBXScriptConnection },
    UnloadSignals: { [number]: () -> () },
    OriginalMinSize: Vector2,
    MinSize: Vector2,
    DPIScale: number,
    CornerRadius: number,
    IsLightTheme: boolean,
    Scheme: Scheme,
    Registry: { [GuiObject]: { [string]: string | Color3 | () -> Color3 } },
    Scales: { [GuiObject]: { [string]: any } },
    ScalesOffset: { [GuiObject]: { [string]: any } },
    CopiedColor: { Color3 | number }?,
    OriginalMouseIconEnabled: boolean,
    ShowCursorBinding: string,
    MaxSpriteIconSize: number,
    IsPicking: boolean?,
    ImageManager: ImageManager,

    -- Methods
    UpdateDependencyBoxes: (self: Library) -> (),
    UpdateAddons: (self: Library, Parent: any) -> (),
    UpdateSearch: (self: Library, SearchText: string) -> (),
    AddToRegistry: (self: Library, Instance: GuiObject, Properties: { [string]: string | Color3 | () -> Color3 }) -> (),
    RemoveFromRegistry: (self: Library, Instance: GuiObject) -> (),
    UpdateColorsUsingRegistry: (self: Library) -> (),
    UpdateDPI: (self: Library, Instance: GuiObject, Properties: { [string]: any }) -> (),
    SetDPIScale: (self: Library, DPIScale: number) -> (),
    GiveSignal: (self: Library, Connection: RBXScriptConnection | RBXScriptSignal) -> RBXScriptConnection,
    GetIcon: (self: Library, IconName: string) -> Icon?,
    GetCustomIcon: (self: Library, IconName: string) -> Icon?,
    ApplyLucideIcon: (
        self: Library,
        ImageGui: ImageLabel | ImageButton,
        Icon: Icon,
        Rotation: number?
    ) -> (),
    CreateIcon: (self: Library, Icon: Icon?, Properties: { [string]: any }?, IsButton: boolean?) -> GuiObject,
    ApplyIcon: (self: Library, Target: GuiObject, Icon: Icon?) -> GuiObject,
    SetIconModule: (self: Library, module: IconModule) -> (),
    Validate: (self: Library, Table: { [string]: any }, Template: { [string]: any }) -> { [string]: any },
    Cursor: Cursor,
    ChangeCursorCrossColor: (self: Library, Color: Color3) -> (),
    ResetCursorCross: (self: Library) -> (),
    ChangeCursorIcon: (self: Library, ImageId: string) -> (),
    ChangeCursorIconColor: (self: Library, Color: Color3) -> (),
    ChangeCursorIconSize: (self: Library, Size: UDim2) -> (),
    ResetCursorIcon: (self: Library) -> (),
    GetBetterColor: (self: Library, Color: Color3, Add: number) -> Color3,
    GetLighterColor: (self: Library, Color: Color3) -> Color3,
    GetDarkerColor: (self: Library, Color: Color3) -> Color3,
    GetKeyString: (self: Library, KeyCode: Enum.KeyCode) -> string,
    GetTextBounds: (self: Library, Text: string, Font: Font, Size: number, Width: number?) -> (number, number),
    MouseIsOverFrame: (self: Library, Frame: GuiObject, Mouse: Vector2) -> boolean,
    IsInsideFrame: (self: Library, ParentFrame: GuiObject, Frame: GuiObject) -> boolean,
    SafeCallback: (self: Library, Func: (...any) -> ...any, ...any) -> ...any,
    MakeDraggable: (
        self: Library,
        UI: GuiObject,
        DragFrame: GuiObject,
        IgnoreToggled: boolean?,
        IsMainWindow: boolean?
    ) -> (),
    MakeResizable: (self: Library, UI: GuiObject, DragFrame: GuiObject, Callback: (() -> ())?) -> (),
    MakeCover: (self: Library, Holder: GuiObject, Place: string) -> Frame,
    MakeLine: (self: Library, Frame: GuiObject, Info: { AnchorPoint: Vector2?, Position: UDim2, Size: UDim2, LayoutOrder: number? }) -> Frame,
    AddOutline: (self: Library, Frame: GuiObject) -> (UIStroke, UIStroke),
    AddBlank: (self: Library, Frame: GuiObject, Size: UDim2) -> Frame,
    PlayTabAnimation: (self: Library, Tab: any, Showing: boolean, OnComplete: (() -> ())?) -> (),
    MakeOutline: (self: Library, Frame: GuiObject, Corner: number?, ZIndex: number?) -> Frame,
    AddDraggableLabel: (
        self: Library,
        Text: string | { Text: string, Icon: string?, IconPosition: string? },
        Icon: string?,
        IconPosition: string?
    ) -> DraggableLabel,
    AddDraggableButton: (
        self: Library,
        Text: string | DraggableButtonInfo,
        Func: ((DraggableButton) -> ())?,
        ExcludeScaling: boolean?,
        ExcludeDragging: boolean?
    ) -> DraggableButton,
    AddDraggableImageButton: (
        self: Library,
        Icon: (string | number) | DraggableImageButtonInfo,
        IconSize: number?,
        Func: ((DraggableImageButton) -> ())?,
        ExcludeScaling: boolean?,
        ExcludeDragging: boolean?
    ) -> DraggableImageButton,
    AddDraggableMenu: (self: Library, Name: string) -> (Frame, Frame, TextLabel, Frame, UIPadding),
    SetWatermarkVisibility: (self: Library, Visible: boolean) -> (),
    SetWatermark: (self: Library, Text: string) -> (),
    AddContextMenu: (
        self: Library,
        Holder: GuiObject,
        Size: UDim2 | () -> UDim2,
        Offset: { [number]: number } | () -> { [number]: number },
        List: number?,
        ActiveCallback: ((Active: boolean) -> ())?,
        IgnoreCornerRadius: boolean?,
        SpecificCornersOnly: ("top" | "bottom" | "no_left" | "no_top_left")?,
        AnimationType: ("Dropdown" | "KeyPicker" | "none")?
    ) -> ContextMenu,
    AddTooltip: (self: Library, InfoStr: string?, DisabledInfoStr: string?, HoverInstance: GuiObject) -> Tooltip,
    OnUnload: (self: Library, Callback: () -> ()) -> (),
    Unload: (self: Library) -> (),
    SetFont: (self: Library, FontFace: Font | Enum.Font) -> (),
    SetBackgroundImage: (self: Library, Image: string | number) -> (),
    SetNotifySide: (self: Library, Side: "Left" | "Right" | string) -> (),
    UpdateNotificationPositions: (self: Library, Snap: boolean?) -> (),
    Notify: (
        self: Library,
        Info: NotificationInfo | string,
        Time: (number | Instance)?,
        SoundId: (string | number)?
    ) -> Notification,
    CreateLoading: (self: Library, LoadingInfo: LoadingInfo) -> Loading,
    CreateWindow: (self: Library, WindowInfo: WindowInfo) -> Window,
    Toggle: (self: Library, Value: boolean?) -> (),
}

return nil
