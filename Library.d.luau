--!strict
-- Luau type definitions for the Obsidian UI Library

--// Helper & Configuration Types
export type Scheme = {
    BackgroundColor: Color3,
    MainColor: Color3,
    AccentColor: Color3,
    OutlineColor: Color3,
    FontColor: Color3,
    Font: Font,
    Red: Color3,
    Dark: Color3,
    White: Color3,
}

export type Icon = {
    Url: string,
    ImageRectOffset: Vector2,
    ImageRectSize: Vector2,
}

export type ContextMenu = {
    Active: boolean,
    Holder: GuiObject,
    Menu: GuiObject,
    List: UIListLayout?,
    Signal: RBXScriptConnection?,
    Size: UDim2 | () -> UDim2,

    Open: (self: ContextMenu) -> (),
    Close: (self: ContextMenu) -> (),
    Toggle: (self: ContextMenu) -> (),
    SetSize: (self: ContextMenu, Size: UDim2 | () -> UDim2) -> (),
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
    SoundId: string | number?,
    Steps: number?,
    Persist: boolean?,
    Destroyed: boolean,

    Resize: (self: Notification) -> (),
    ChangeTitle: (self: Notification, NewText: string) -> (),
    ChangeDescription: (self: Notification, NewText: string) -> (),
    ChangeStep: (self: Notification, NewStep: number) -> (),
    Destroy: (self: Notification) -> (),
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

export type DraggableButton = {
    Button: TextButton,
    SetText: (self: DraggableButton, NewText: string) -> (),
}

--// Element Creation Info Types
export type ButtonInfo = {
    Text: string,
    Func: () -> (),
    DoubleClick: boolean?,
    Tooltip: string?,
    DisabledTooltip: string?,
    Risky: boolean?,
    Disabled: boolean?,
    Visible: boolean?,
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
    Placeholder: string?,
    AllowEmpty: boolean?,
    EmptyReset: string?,
    MaxLength: number?,
    Tooltip: string?,
    DisabledTooltip: string?,
    Callback: ((string) -> ())?,
    Changed: ((string) -> ())?,
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
}

export type DropdownInfo = {
    Text: string?,
    Values: { any },
    Default: any,
    DisabledValues: { any }?,
    Multi: boolean?,
    MaxVisibleDropdownItems: number?,
    SpecialType: "Player" | "Team"?,
    ExcludeLocalPlayer: boolean?,
    AllowNull: boolean?,
    Searchable: boolean?,
    FormatDisplayValue: ((any) -> string)?,
    Tooltip: string?,
    DisabledTooltip: string?,
    Callback: ((any) -> ())?,
    Changed: ((any) -> ())?,
    Disabled: boolean?,
    Visible: boolean?,
}

export type ViewportInfo = {
    Object: BasePart | Model,
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
    Color: Color3?,
    RectOffset: Vector2?,
    RectSize: Vector2?,
    ScaleType: Enum.ScaleType?,
    Height: number?,
    Visible: boolean?,
}

export type KeyPickerInfo = {
    Text: string,
    Default: string?,
    Mode: "Always" | "Toggle" | "Hold" | "Press"?,
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
    Callback: ((Color3) -> ())?,
    Changed: ((Color3) -> ())?,
}

--// Addon Types
export type KeyPicker = {
    Text: string,
    Value: string,
    Toggled: boolean,
    Mode: "Always" | "Toggle" | "Hold" | "Press",
    SyncToggleState: boolean,
    Callback: (Toggled: boolean) -> (),
    ChangedCallback: (Key: Enum.KeyCode | Enum.UserInputType) -> (),
    Changed: (Key: Enum.KeyCode | Enum.UserInputType) -> (),
    Clicked: () -> (),
    Type: "KeyPicker",
    Menu: ContextMenu,

    Display: (self: KeyPicker) -> (),
    Update: (self: KeyPicker) -> (),
    GetState: (self: KeyPicker) -> boolean,
    OnChanged: (self: KeyPicker, Func: (Key: Enum.KeyCode | Enum.UserInputType) -> ()) -> (),
    OnClick: (self: KeyPicker, Func: () -> ()) -> (),
    DoClick: (self: KeyPicker) -> (),
    SetValue: (self: KeyPicker, Data: { string }) -> (),
    SetText: (self: KeyPicker, Text: string) -> (),
}

export type ColorPicker = {
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
    Update: (self: ColorPicker) -> (),
    OnChanged: (self: ColorPicker, Func: (Value: Color3) -> ()) -> (),
    SetValue: (self: ColorPicker, HSV: { number }, Transparency: number?) -> (),
    SetValueRGB: (self: ColorPicker, Color: Color3, Transparency: number?) -> (),
}

export type Addon = KeyPicker | ColorPicker

--// Base Element Types
export type Label = {
    Text: string,
    DoesWrap: boolean,
    Addons: { [number]: Addon },
    Visible: boolean,
    Type: "Label",
    TextLabel: TextLabel,
    Container: GuiObject,
    Holder: TextLabel,

    SetVisible: (self: Label, Visible: boolean) -> (),
    SetText: (self: Label, Text: string) -> (),

    -- From BaseAddons
    AddKeyPicker: (self: Label, Idx: string, Info: KeyPickerInfo) -> Label,
    AddColorPicker: (self: Label, Idx: string, Info: ColorPickerInfo) -> Label,
}

export type Button = {
    Text: string,
    Func: () -> (),
    DoubleClick: boolean?,
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
    Holder: Frame,
    SubButton: SubButton?,

    AddButton: (self: Button, Info: ButtonInfo | string, Func: (() -> ())?, Idx: string?) -> SubButton,
    UpdateColors: (self: Button) -> (),
    SetDisabled: (self: Button, Disabled: boolean) -> (),
    SetVisible: (self: Button, Visible: boolean) -> (),
    SetText: (self: Button, Text: string) -> (),
}

export type SubButton = {
    Text: string,
    Func: () -> (),
    DoubleClick: boolean?,
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

    UpdateColors: (self: SubButton) -> (),
    SetDisabled: (self: SubButton, Disabled: boolean) -> (),
    SetVisible: (self: SubButton, Visible: boolean) -> (),
    SetText: (self: SubButton, Text: string) -> (),
}

export type Toggle = {
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

    UpdateColors: (self: Toggle) -> (),
    Display: (self: Toggle) -> (),
    OnChanged: (self: Toggle, Func: (Value: boolean) -> ()) -> (),
    SetValue: (self: Toggle, Value: boolean) -> (),
    SetDisabled: (self: Toggle, Disabled: boolean) -> (),
    SetVisible: (self: Toggle, Visible: boolean) -> (),
    SetText: (self: Toggle, Text: string) -> (),

    -- From BaseAddons
    AddKeyPicker: (self: Toggle, Idx: string, Info: KeyPickerInfo) -> Toggle,
    AddColorPicker: (self: Toggle, Idx: string, Info: ColorPickerInfo) -> Toggle,
}

export type Input = {
    Text: string,
    Value: string,
    Finished: boolean,
    Numeric: boolean,
    ClearTextOnFocus: boolean,
    Placeholder: string,
    AllowEmpty: boolean,
    EmptyReset: string,
    Tooltip: string?,
    DisabledTooltip: string?,
    TooltipTable: Tooltip?,
    Callback: (Value: string) -> (),
    Changed: (Value: string) -> (),
    Disabled: boolean,
    Visible: boolean,
    Type: "Input",
    Holder: Frame,

    UpdateColors: (self: Input) -> (),
    OnChanged: (self: Input, Func: (Value: string) -> ()) -> (),
    SetValue: (self: Input, Text: string) -> (),
    SetDisabled: (self: Input, Disabled: boolean) -> (),
    SetVisible: (self: Input, Visible: boolean) -> (),
    SetText: (self: Input, Text: string) -> (),
}

export type Slider = {
    Text: string,
    Value: number,
    Min: number,
    Max: number,
    Prefix: string,
    Suffix: string,
    Compact: boolean?,
    Rounding: number,
    Tooltip: string?,
    DisabledTooltip: string?,
    TooltipTable: Tooltip?,
    Callback: (Value: number) -> (),
    Changed: (Value: number) -> (),
    Disabled: boolean,
    Visible: boolean,
    Type: "Slider",
    Holder: Frame,

    UpdateColors: (self: Slider) -> (),
    Display: (self: Slider) -> (),
    OnChanged: (self: Slider, Func: (Value: number) -> ()) -> (),
    SetMax: (self: Slider, Value: number) -> (),
    SetMin: (self: Slider, Value: number) -> (),
    SetValue: (self: Slider, Value: number | string) -> (),
    SetDisabled: (self: Slider, Disabled: boolean) -> (),
    SetVisible: (self: Slider, Visible: boolean) -> (),
    SetText: (self: Slider, Text: string) -> (),
    SetPrefix: (self: Slider, Prefix: string) -> (),
    SetSuffix: (self: Slider, Suffix: string) -> (),
}

export type Dropdown = {
    Text: string?,
    Value: { [any]: boolean } | any,
    Values: { any },
    DisabledValues: { any },
    Multi: boolean,
    SpecialType: "Player" | "Team"?,
    ExcludeLocalPlayer: boolean?,
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

    RecalculateListSize: (self: Dropdown, Count: number?) -> (),
    UpdateColors: (self: Dropdown) -> (),
    Display: (self: Dropdown) -> (),
    OnChanged: (self: Dropdown, Func: (Value: any) -> ()) -> (),
    GetActiveValues: (self: Dropdown) -> { any } | number,
    BuildDropdownList: (self: Dropdown) -> (),
    SetValue: (self: Dropdown, Value: any) -> (),
    SetValues: (self: Dropdown, Values: { any }) -> (),
    AddValues: (self: Dropdown, Values: { any } | string) -> (),
    SetDisabledValues: (self: Dropdown, DisabledValues: { any }) -> (),
    AddDisabledValues: (self: Dropdown, DisabledValues: { any } | string) -> (),
    SetDisabled: (self: Dropdown, Disabled: boolean) -> (),
    SetVisible: (self: Dropdown, Visible: boolean) -> (),
    SetText: (self: Dropdown, Text: string) -> (),
}

export type Viewport = {
    Object: BasePart | Model,
    Camera: Camera,
    Interactive: boolean,
    AutoFocus: boolean,
    Visible: boolean,
    Type: "Viewport",
    Holder: Frame,

    SetObject: (self: Viewport, Object: Instance, Clone: boolean?) -> (),
    SetHeight: (self: Viewport, Height: number) -> (),
    Focus: (self: Viewport) -> (),
    SetCamera: (self: Viewport, Camera: Camera) -> (),
    SetInteractive: (self: Viewport, Interactive: boolean) -> (),
    SetVisible: (self: Viewport, Visible: boolean) -> (),
}

export type Image = {
    Image: string,
    Color: Color3,
    RectOffset: Vector2,
    RectSize: Vector2,
    Height: number,
    ScaleType: Enum.ScaleType,
    Transparency: number,
    Visible: boolean,
    Type: "Image",
    Holder: Frame,

    SetHeight: (self: Image, Height: number) -> (),
    SetImage: (self: Image, NewImage: string) -> (),
    SetColor: (self: Image, Color: Color3) -> (),
    SetRectOffset: (self: Image, RectOffset: Vector2) -> (),
    SetRectSize: (self: Image, RectSize: Vector2) -> (),
    SetScaleType: (self: Image, ScaleType: Enum.ScaleType) -> (),
    SetTransparency: (self: Image, Transparency: number) -> (),
    SetVisible: (self: Image, Visible: boolean) -> (),
}

export type Divider = {
    Type: "Divider",
    Holder: Frame,
}

export type Element = Label | Button | Toggle | Input | Slider | Dropdown | Viewport | Image | Divider
export type Option = Toggle | Input | Slider | Dropdown | Viewport | Image | KeyPicker | ColorPicker

--// Container Types
export type BaseGroupbox = {
    AddDivider: (self: Groupbox) -> (),
    AddLabel: (
        self: Groupbox,
        Info: { Text: string, DoesWrap: boolean?, Size: number?, Visible: boolean?, Idx: string? } | string,
        DoesWrap: boolean?,
        Idx: string?
    ) -> Label,
    AddButton: (self: Groupbox, Info: ButtonInfo | string, Func: (() -> ())?, Idx: string?) -> Button,
    AddCheckbox: (self: Groupbox, Idx: string, Info: ToggleInfo) -> Toggle,
    AddToggle: (self: Groupbox, Idx: string, Info: ToggleInfo) -> Toggle,
    AddInput: (self: Groupbox, Idx: string, Info: InputInfo) -> Input,
    AddSlider: (self: Groupbox, Idx: string, Info: SliderInfo) -> Slider,
    AddDropdown: (self: Groupbox, Idx: string, Info: DropdownInfo) -> Dropdown,
    AddViewport: (self: Groupbox, Idx: string, Info: ViewportInfo) -> Viewport,
    AddImage: (self: Groupbox, Idx: string, Info: ImageInfo) -> Image,
    AddDependencyBox: (self: Groupbox) -> DependencyBox,
    AddDependencyGroupbox: (self: Groupbox) -> DependencyGroupbox,
}

export type DependencyBox = BaseGroupbox & {
    Visible: boolean,
    Dependencies: { [number]: { Element } },
    Holder: Frame,
    Container: Frame,
    Elements: { [number]: Element },
    DependencyBoxes: { [number]: DependencyBox },

    Resize: (self: DependencyBox) -> (),
    Update: (self: DependencyBox, CancelSearch: boolean?) -> (),
    SetupDependencies: (self: DependencyBox, Dependencies: { { Element } }) -> (),
}

export type DependencyGroupbox = BaseGroupbox & {
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
}

export type Groupbox = BaseGroupbox & {
    BoxHolder: Frame,
    Holder: Frame,
    Container: Frame,
    Tab: Tab,
    DependencyBoxes: { [number]: DependencyBox },
    Elements: { [number]: Element },

    Resize: (self: Groupbox) -> (),
}

export type SubTab = BaseGroupbox & {
    ButtonHolder: TextButton,
    Container: Frame,
    Tab: Tab,
    Elements: { [number]: Element },
    DependencyBoxes: { [number]: DependencyBox },

    Show: (self: SubTab) -> (),
    Hide: (self: SubTab) -> (),
    Resize: (self: SubTab) -> (),
}

export type Tabbox = {
    ActiveTab: SubTab?,
    BoxHolder: Frame,
    Holder: Frame,
    Tabs: { [string]: SubTab },

    AddTab: (self: Tabbox, Name: string) -> SubTab,
}

export type Tab = {
    Groupboxes: { [string]: Groupbox },
    Tabboxes: { [string]: Tabbox },
    DependencyGroupboxes: { [number]: DependencyGroupbox },
    Sides: { ScrollingFrame },
    WarningBox: { IsNormal: boolean, LockSize: boolean, Visible: boolean, Title: string, Text: string },

    UpdateWarningBox: (
        self: Tab,
        Info: { IsNormal: boolean?, LockSize: boolean?, Visible: boolean?, Title: string?, Text: string? }
    ) -> (),
    Resize: (self: Tab, ResizeWarningBox: boolean?) -> (),
    AddGroupbox: (self: Tab, Info: { Side: number, Name: string, IconName: string? }) -> Groupbox,
    AddLeftGroupbox: (self: Tab, Name: string, IconName: string?) -> Groupbox,
    AddRightGroupbox: (self: Tab, Name: string, IconName: string?) -> Groupbox,
    AddTabbox: (self: Tab, Info: { Side: number, Name: string? }) -> Tabbox,
    AddLeftTabbox: (self: Tab, Name: string?) -> Tabbox,
    AddRightTabbox: (self: Tab, Name: string?) -> Tabbox,
    Hover: (self: Tab, Hovering: boolean) -> (),
    Show: (self: Tab) -> (),
    Hide: (self: Tab) -> (),
}

export type KeyTab = BaseGroupbox & {
    Elements: { [any]: any },
    IsKeyTab: true,
    Container: ScrollingFrame,

    AddKeyBox: (self: KeyTab, ExpectedKey: string?, Callback: (Success: boolean, Key: string) -> ()) -> (),
    Resize: (self: KeyTab) -> (),
    Hover: (self: KeyTab, Hovering: boolean) -> (),
    Show: (self: KeyTab) -> (),
    Hide: (self: KeyTab) -> (),
}

export type Window = {
    GetSidebarWidth: (self: Window) -> number,
    IsSidebarCompacted: (self: Window) -> boolean,
    SetSidebarWidth: (self: Window, Width: number) -> (),
    SetCompact: (self: Window, State: boolean) -> (),
    ApplyLayout: (self: Window) -> (),
    AddTab: (
        self: Window,
        Info: { Name: string, Icon: string?, Description: string? } | string,
        Icon: string?,
        Description: string?
    ) -> Tab,
    AddKeyTab: (self: Window, Name: string) -> KeyTab,
}

--// Main Library Type
export type Library = {
    -- Properties
    LocalPlayer: Player,
    DevicePlatform: Enum.Platform?,
    IsMobile: boolean,
    IsRobloxFocused: boolean,
    ScreenGui: ScreenGui?,
    SearchText: string,
    Searching: boolean,
    LastSearchTab: Tab?,
    ActiveTab: Tab?,
    Tabs: { [string]: Tab | KeyTab },
    DependencyBoxes: { [number]: DependencyBox | DependencyGroupbox },
    KeybindFrame: Frame?,
    KeybindContainer: Frame?,
    KeybindToggles: { [number]: KeybindToggle },
    Notifications: { [GuiObject]: Notification },
    ToggleKeybind: Enum.KeyCode,
    TweenInfo: TweenInfo,
    NotifyTweenInfo: TweenInfo,
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
    Signals: { [number]: RBXScriptConnection },
    UnloadSignals: { [number]: () -> () },
    MinSize: Vector2,
    DPIScale: number,
    CornerRadius: number,
    IsLightTheme: boolean,
    Scheme: Scheme,
    Registry: { [GuiObject]: { [string]: string | () -> Color3 } },
    DPIRegistry: { [GuiObject]: { [string]: any } },
    CopiedColor: { Color3 | number }?,

    -- Methods
    UpdateKeybindFrame: (self: Library) -> (),
    UpdateDependencyBoxes: (self: Library) -> (),
    UpdateSearch: (self: Library, SearchText: string) -> (),
    AddToRegistry: (self: Library, Instance: GuiObject, Properties: { [string]: string | () -> Color3 }) -> (),
    RemoveFromRegistry: (self: Library, Instance: GuiObject) -> (),
    UpdateColorsUsingRegistry: (self: Library) -> (),
    UpdateDPI: (self: Library, Instance: GuiObject, Properties: { [string]: any }) -> (),
    SetDPIScale: (self: Library, DPIScale: number) -> (),
    GiveSignal: (self: Library, Connection: RBXScriptConnection) -> RBXScriptConnection,
    GetIcon: (self: Library, IconName: string) -> Icon?,
    Validate: (self: Library, Table: { [string]: any }, Template: { [string]: any }) -> { [string]: any },
    GetBetterColor: (self: Library, Color: Color3, Add: number) -> Color3,
    GetDarkerColor: (self: Library, Color: Color3) -> Color3,
    GetKeyString: (self: Library, KeyCode: Enum.KeyCode) -> string,
    GetTextBounds: (self: Library, Text: string, Font: Font, Size: number, Width: number?) -> (number, number),
    MouseIsOverFrame: (self: Library, Frame: GuiObject, Mouse: Vector2) -> boolean,
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
    MakeLine: (self: Library, Frame: GuiObject, Info: { AnchorPoint: Vector2?, Position: UDim2, Size: UDim2 }) -> Frame,
    MakeOutline: (self: Library, Frame: GuiObject, Corner: number?, ZIndex: number?) -> Frame,
    AddDraggableButton: (self: Library, Text: string, Func: (DraggableButton) -> ()) -> DraggableButton,
    AddDraggableMenu: (self: Library, Name: string) -> (Frame, Frame),
    SetWatermarkVisibility: (self: Library, Visible: boolean) -> (),
    SetWatermark: (self: Library, Text: string) -> (),
    AddContextMenu: (
        self: Library,
        Holder: GuiObject,
        Size: UDim2 | () -> UDim2,
        Offset: { [number]: number } | () -> { [number]: number },
        List: number?,
        ActiveCallback: ((boolean) -> ())?
    ) -> ContextMenu,
    AddTooltip: (self: Library, InfoStr: string, DisabledInfoStr: string, HoverInstance: GuiObject) -> Tooltip,
    OnUnload: (self: Library, Callback: () -> ()) -> (),
    Unload: (self: Library) -> (),
    SetFont: (self: Library, FontFace: Font | Enum.Font) -> (),
    SetNotifySide: (self: Library, Side: "Left" | "Right") -> (),
    Notify: (
        self: Library,
        Info: {
            Title: string,
            Description: string,
            Time: number?,
            SoundId: string | number?,
            Steps: number?,
            Persist: boolean?,
        } | string,
        Time: number?,
        SoundId: string | number?
    ) -> Notification,
    CreateWindow: (
        self: Library,
        WindowInfo: {
            Title: string?,
            Footer: string?,
            Position: UDim2?,
            Size: UDim2?,
            Icon: string?,
            IconSize: UDim2?,
            BackgroundImage: string?,
            AutoShow: boolean?,
            Center: boolean?,
            Resizable: boolean?,
            DisableSearch: boolean?,
            SearchbarSize: UDim2?,
            CornerRadius: number?,
            NotifySide: "Left" | "Right"?,
            ShowCustomCursor: boolean?,
            Font: Font | Enum.Font?,
            ToggleKeybind: Enum.KeyCode?,
            MobileButtonsSide: "Left" | "Right"?,
            UnlockMouseWhileOpen: boolean?,
            Compact: boolean?,
            EnableSidebarResize: boolean?,
            SidebarMinWidth: number?,
            SidebarCompactWidth: number?,
            SidebarCollapseThreshold: number?,
            SidebarHighlightCallback: ((Frame, boolean) -> ())?,
            InitialSidebarWidth: number?,
            InitialSidebarScale: number?,
            MinContentWidth: number?,
        }
    ) -> Window,
    Toggle: (self: Library, Value: boolean?) -> (),
}

return nil
