local cloneref = (cloneref or clonereference or function(instance: any)
    return instance
end)
local httpService = cloneref(game:GetService("HttpService"))
local httprequest = (syn and syn.request) or request or http_request or (http and http.request)
local getassetfunc = getcustomasset or getsynasset
local isfolder, isfile, listfiles = isfolder, isfile, listfiles

if typeof(copyfunction) == "function" then
    -- Fix is_____ functions for shitsploits, those functions should never error, only return a boolean.

    local isfolder_copy, isfile_copy, listfiles_copy =
        copyfunction(isfolder), copyfunction(isfile), copyfunction(listfiles)

    local isfolder_success, isfolder_error = pcall(function()
        return isfolder_copy("test" .. tostring(math.random(1000000, 9999999)))
    end)

    if isfolder_success == false or typeof(isfolder_error) ~= "boolean" then
        isfolder = function(folder)
            local success, data = pcall(isfolder_copy, folder)
            return (if success then data else false)
        end

        isfile = function(file)
            local success, data = pcall(isfile_copy, file)
            return (if success then data else false)
        end

        listfiles = function(folder)
            local success, data = pcall(listfiles_copy, folder)
            return (if success then data else {})
        end
    end
end

local ThemeManager = {}
do
    ThemeManager.Folder = "ObsidianLibSettings"
    -- if not isfolder(ThemeManager.Folder) then makefolder(ThemeManager.Folder) end

    ThemeManager.Library = nil
    ThemeManager.AppliedToTab = false
    ThemeManager.BuiltInThemes = {
        ["Default"] = {
            1,
            httpService:JSONDecode(
                [[{"FontColor":"ffffff","MainColor":"191919","AccentColor":"7d55ff","BackgroundColor":"0f0f0f","OutlineColor":"282828"}]]
            ),
        },
        ["BBot"] = {
            2,
            httpService:JSONDecode(
                [[{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"7e48a3","BackgroundColor":"232323","OutlineColor":"141414"}]]
            ),
        },
        ["Fatality"] = {
            3,
            httpService:JSONDecode(
                [[{"FontColor":"ffffff","MainColor":"1e1842","AccentColor":"c50754","BackgroundColor":"191335","OutlineColor":"3c355d"}]]
            ),
        },
        ["Jester"] = {
            4,
            httpService:JSONDecode(
                [[{"FontColor":"ffffff","MainColor":"242424","AccentColor":"db4467","BackgroundColor":"1c1c1c","OutlineColor":"373737"}]]
            ),
        },
        ["Mint"] = {
            5,
            httpService:JSONDecode(
                [[{"FontColor":"ffffff","MainColor":"242424","AccentColor":"3db488","BackgroundColor":"1c1c1c","OutlineColor":"373737"}]]
            ),
        },
        ["Tokyo Night"] = {
            6,
            httpService:JSONDecode(
                [[{"FontColor":"ffffff","MainColor":"191925","AccentColor":"6759b3","BackgroundColor":"16161f","OutlineColor":"323232"}]]
            ),
        },
        ["Ubuntu"] = {
            7,
            httpService:JSONDecode(
                [[{"FontColor":"ffffff","MainColor":"3e3e3e","AccentColor":"e2581e","BackgroundColor":"323232","OutlineColor":"191919"}]]
            ),
        },
        ["Quartz"] = {
            8,
            httpService:JSONDecode(
                [[{"FontColor":"ffffff","MainColor":"232330","AccentColor":"426e87","BackgroundColor":"1d1b26","OutlineColor":"27232f"}]]
            ),
        },
        ["Nord"] = {
            9,
            httpService:JSONDecode(
                [[{"FontColor":"eceff4","MainColor":"3b4252","AccentColor":"88c0d0","BackgroundColor":"2e3440","OutlineColor":"4c566a"}]]
            ),
        },
        ["Dracula"] = {
            10,
            httpService:JSONDecode(
                [[{"FontColor":"f8f8f2","MainColor":"44475a","AccentColor":"ff79c6","BackgroundColor":"282a36","OutlineColor":"6272a4"}]]
            ),
        },
        ["Monokai"] = {
            11,
            httpService:JSONDecode(
                [[{"FontColor":"f8f8f2","MainColor":"272822","AccentColor":"f92672","BackgroundColor":"1e1f1c","OutlineColor":"49483e"}]]
            ),
        },
        ["Gruvbox"] = {
            12,
            httpService:JSONDecode(
                [[{"FontColor":"ebdbb2","MainColor":"3c3836","AccentColor":"fb4934","BackgroundColor":"282828","OutlineColor":"504945"}]]
            ),
        },
        ["Solarized"] = {
            13,
            httpService:JSONDecode(
                [[{"FontColor":"839496","MainColor":"073642","AccentColor":"cb4b16","BackgroundColor":"002b36","OutlineColor":"586e75"}]]
            ),
        },
        ["Catppuccin"] = {
            14,
            httpService:JSONDecode(
                [[{"FontColor":"d9e0ee","MainColor":"302d41","AccentColor":"f5c2e7","BackgroundColor":"1e1e2e","OutlineColor":"575268"}]]
            ),
        },
        ["One Dark"] = {
            15,
            httpService:JSONDecode(
                [[{"FontColor":"abb2bf","MainColor":"282c34","AccentColor":"c678dd","BackgroundColor":"21252b","OutlineColor":"5c6370"}]]
            ),
        },
        ["Cyberpunk"] = {
            16,
            httpService:JSONDecode(
                [[{"FontColor":"f9f9f9","MainColor":"262335","AccentColor":"00ff9f","BackgroundColor":"1a1a2e","OutlineColor":"413c5e"}]]
            ),
        },
        ["Oceanic Next"] = {
            17,
            httpService:JSONDecode(
                [[{"FontColor":"d8dee9","MainColor":"1b2b34","AccentColor":"6699cc","BackgroundColor":"16232a","OutlineColor":"343d46"}]]
            ),
        },
        ["Material"] = {
            18,
            httpService:JSONDecode(
                [[{"FontColor":"eeffff","MainColor":"212121","AccentColor":"82aaff","BackgroundColor":"151515","OutlineColor":"424242"}]]
            ),
        },
    }

    function ThemeManager:SetLibrary(library)
        self.Library = library
    end

    --// Folders \\--
    function ThemeManager:GetPaths()
        local paths = {}

        local parts = self.Folder:split("/")
        for idx = 1, #parts do
            paths[#paths + 1] = table.concat(parts, "/", 1, idx)
        end

        paths[#paths + 1] = self.Folder .. "/themes"

        return paths
    end

    function ThemeManager:BuildFolderTree()
        local paths = self:GetPaths()

        for i = 1, #paths do
            local str = paths[i]
            if isfolder(str) then
                continue
            end
            makefolder(str)
        end
    end

    function ThemeManager:CheckFolderTree()
        if isfolder(self.Folder) then
            return
        end
        self:BuildFolderTree()

        task.wait(0.1)
    end

    function ThemeManager:SetFolder(folder)
        self.Folder = folder
        self:BuildFolderTree()
    end

    --// Apply, Update theme \\--
    function ThemeManager:ApplyTheme(theme)
        local customThemeData = self:GetCustomTheme(theme)
        local data = customThemeData or self.BuiltInThemes[theme]

        if not data then
            return
        end

        local scheme = data[2]
        for idx, val in pairs(customThemeData or scheme) do
            if idx == "VideoLink" then
                continue
            elseif idx == "FontFace" then
                self.Library:SetFont(Enum.Font[val])

                if self.Library.Options[idx] then
                    self.Library.Options[idx]:SetValue(val)
                end
            else
                self.Library.Scheme[idx] = Color3.fromHex(val)

                if self.Library.Options[idx] then
                    self.Library.Options[idx]:SetValueRGB(Color3.fromHex(val))
                end
            end
        end

        self:ThemeUpdate()
    end

    function ThemeManager:ThemeUpdate()
        local options = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
        for i, field in pairs(options) do
            if self.Library.Options and self.Library.Options[field] then
                self.Library.Scheme[field] = self.Library.Options[field].Value
            end
        end

        self.Library:UpdateColorsUsingRegistry()
    end

    --// Get, Load, Save, Delete, Refresh \\--
    function ThemeManager:GetCustomTheme(file)
        local path = self.Folder .. "/themes/" .. file .. ".json"
        if not isfile(path) then
            return nil
        end

        local data = readfile(path)
        local success, decoded = pcall(httpService.JSONDecode, httpService, data)

        if not success then
            return nil
        end

        return decoded
    end

    function ThemeManager:LoadDefault()
        local theme = "Default"
        local content = isfile(self.Folder .. "/themes/default.txt") and readfile(self.Folder .. "/themes/default.txt")

        local isDefault = true
        if content then
            if self.BuiltInThemes[content] then
                theme = content
            elseif self:GetCustomTheme(content) then
                theme = content
                isDefault = false
            end
        elseif self.BuiltInThemes[self.DefaultTheme] then
            theme = self.DefaultTheme
        end

        if isDefault then
            self.Library.Options.ThemeManager_ThemeList:SetValue(theme)
        else
            self:ApplyTheme(theme)
        end
    end

    function ThemeManager:SaveDefault(theme)
        writefile(self.Folder .. "/themes/default.txt", theme)
    end

    function ThemeManager:SetDefaultTheme(theme)
        assert(self.Library, "Must set ThemeManager.Library first!")
        assert(not self.AppliedToTab, "Cannot set default theme after applying ThemeManager to a tab!")

        local FinalTheme = {}
        local LibraryScheme = {}
        local fields = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
        for _, field in pairs(fields) do
            if typeof(theme[field]) == "Color3" then
                FinalTheme[field] = "#" .. theme[field]:ToHex()
                LibraryScheme[field] = theme[field]
            elseif typeof(theme[field]) == "string" then
                FinalTheme[field] = if theme[field]:sub(1, 1) == "#" then theme[field] else ("#" .. theme[field])
                LibraryScheme[field] = Color3.fromHex(theme[field])
            else
                FinalTheme[field] = ThemeManager.BuiltInThemes["Default"][2][field]
                LibraryScheme[field] = Color3.fromHex(ThemeManager.BuiltInThemes["Default"][2][field])
            end
        end

        if typeof(theme["FontFace"]) == "EnumItem" then
            FinalTheme["FontFace"] = theme["FontFace"].Name
            LibraryScheme["Font"] = Font.fromEnum(theme["FontFace"])
        elseif typeof(theme["FontFace"]) == "string" then
            FinalTheme["FontFace"] = theme["FontFace"]
            LibraryScheme["Font"] = Font.fromEnum(Enum.Font[theme["FontFace"]])
        else
            FinalTheme["FontFace"] = "Code"
            LibraryScheme["Font"] = Font.fromEnum(Enum.Font.Code)
        end

        for _, field in pairs({ "Red", "Dark", "White" }) do
            LibraryScheme[field] = self.Library.Scheme[field]
        end

        self.Library.Scheme = LibraryScheme
        self.BuiltInThemes["Default"] = { 1, FinalTheme }

        self.Library:UpdateColorsUsingRegistry()
    end

    function ThemeManager:SaveCustomTheme(file)
        if file:gsub(" ", "") == "" then
            return self.Library:Notify("Invalid file name for theme (empty)", 3)
        end

        local theme = {}
        local fields = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }

        for _, field in pairs(fields) do
            theme[field] = self.Library.Options[field].Value:ToHex()
        end
        theme["FontFace"] = self.Library.Options["FontFace"].Value

        writefile(self.Folder .. "/themes/" .. file .. ".json", httpService:JSONEncode(theme))
    end

    function ThemeManager:Delete(name)
        if not name then
            return false, "no config file is selected"
        end

        local file = self.Folder .. "/themes/" .. name .. ".json"
        if not isfile(file) then
            return false, "invalid file"
        end

        local success = pcall(delfile, file)
        if not success then
            return false, "delete file error"
        end

        return true
    end

    function ThemeManager:ReloadCustomThemes()
        local list = listfiles(self.Folder .. "/themes")

        local out = {}
        for i = 1, #list do
            local file = list[i]
            if file:sub(-5) == ".json" then
                -- i hate this but it has to be done ...

                local pos = file:find(".json", 1, true)
                local start = pos

                local char = file:sub(pos, pos)
                while char ~= "/" and char ~= "\\" and char ~= "" do
                    pos = pos - 1
                    char = file:sub(pos, pos)
                end

                if char == "/" or char == "\\" then
                    table.insert(out, file:sub(pos + 1, start - 1))
                end
            end
        end

        return out
    end

    --// GUI \\--
    function ThemeManager:CreateThemeManager(groupbox)
        groupbox
            :AddLabel("Background color")
            :AddColorPicker("BackgroundColor", { Default = self.Library.Scheme.BackgroundColor })
        groupbox:AddLabel("Main color"):AddColorPicker("MainColor", { Default = self.Library.Scheme.MainColor })
        groupbox:AddLabel("Accent color"):AddColorPicker("AccentColor", { Default = self.Library.Scheme.AccentColor })
        groupbox
            :AddLabel("Outline color")
            :AddColorPicker("OutlineColor", { Default = self.Library.Scheme.OutlineColor })
        groupbox:AddLabel("Font color"):AddColorPicker("FontColor", { Default = self.Library.Scheme.FontColor })
        groupbox:AddDropdown("FontFace", {
            Text = "Font Face",
            Default = "Code",
            Values = { "BuilderSans", "Code", "Fantasy", "Gotham", "Jura", "Roboto", "RobotoMono", "SourceSans" },
        })

        local ThemesArray = {}
        for Name, Theme in pairs(self.BuiltInThemes) do
            table.insert(ThemesArray, Name)
        end

        table.sort(ThemesArray, function(a, b)
            return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1]
        end)

        groupbox:AddDivider()

        groupbox:AddDropdown("ThemeManager_ThemeList", { Text = "Theme list", Values = ThemesArray, Default = 1 })
        groupbox:AddButton("Set as default", function()
            self:SaveDefault(self.Library.Options.ThemeManager_ThemeList.Value)
            self.Library:Notify(
                string.format("Set default theme to %q", self.Library.Options.ThemeManager_ThemeList.Value)
            )
        end)

        self.Library.Options.ThemeManager_ThemeList:OnChanged(function()
            self:ApplyTheme(self.Library.Options.ThemeManager_ThemeList.Value)
        end)

        groupbox:AddDivider()

        groupbox:AddInput("ThemeManager_CustomThemeName", { Text = "Custom theme name" })
        groupbox:AddButton("Create theme", function()
            self:SaveCustomTheme(self.Library.Options.ThemeManager_CustomThemeName.Value)

            self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
            self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
        end)

        groupbox:AddDivider()

        groupbox:AddDropdown(
            "ThemeManager_CustomThemeList",
            { Text = "Custom themes", Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 }
        )
        groupbox:AddButton("Load theme", function()
            local name = self.Library.Options.ThemeManager_CustomThemeList.Value

            self:ApplyTheme(name)
            self.Library:Notify(string.format("Loaded theme %q", name))
        end)
        groupbox:AddButton("Overwrite theme", function()
            local name = self.Library.Options.ThemeManager_CustomThemeList.Value

            self:SaveCustomTheme(name)
            self.Library:Notify(string.format("Overwrote config %q", name))
        end)
        groupbox:AddButton("Delete theme", function()
            local name = self.Library.Options.ThemeManager_CustomThemeList.Value

            local success, err = self:Delete(name)
            if not success then
                return self.Library:Notify("Failed to delete theme: " .. err)
            end

            self.Library:Notify(string.format("Deleted theme %q", name))
            self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
            self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
        end)
        groupbox:AddButton("Refresh list", function()
            self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
            self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
        end)
        groupbox:AddButton("Set as default", function()
            if
                self.Library.Options.ThemeManager_CustomThemeList.Value ~= nil
                and self.Library.Options.ThemeManager_CustomThemeList.Value ~= ""
            then
                self:SaveDefault(self.Library.Options.ThemeManager_CustomThemeList.Value)
                self.Library:Notify(
                    string.format("Set default theme to %q", self.Library.Options.ThemeManager_CustomThemeList.Value)
                )
            end
        end)
        groupbox:AddButton("Reset default", function()
            local success = pcall(delfile, self.Folder .. "/themes/default.txt")
            if not success then
                return self.Library:Notify("Failed to reset default: delete file error")
            end

            self.Library:Notify("Set default theme to nothing")
            self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
            self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
        end)

        self:LoadDefault()
        self.AppliedToTab = true

        local function UpdateTheme()
            self:ThemeUpdate()
        end
        self.Library.Options.BackgroundColor:OnChanged(UpdateTheme)
        self.Library.Options.MainColor:OnChanged(UpdateTheme)
        self.Library.Options.AccentColor:OnChanged(UpdateTheme)
        self.Library.Options.OutlineColor:OnChanged(UpdateTheme)
        self.Library.Options.FontColor:OnChanged(UpdateTheme)
        self.Library.Options.FontFace:OnChanged(function(Value)
            self.Library:SetFont(Enum.Font[Value])
            self.Library:UpdateColorsUsingRegistry()
        end)
    end

    function ThemeManager:CreateGroupBox(tab)
        assert(self.Library, "Must set ThemeManager.Library first!")
        return tab:AddLeftGroupbox("Themes", "paintbrush")
    end

    function ThemeManager:ApplyToTab(tab)
        assert(self.Library, "Must set ThemeManager.Library first!")
        local groupbox = self:CreateGroupBox(tab)
        self:CreateThemeManager(groupbox)
    end

    function ThemeManager:ApplyToGroupbox(groupbox)
        assert(self.Library, "Must set ThemeManager.Library first!")
        self:CreateThemeManager(groupbox)
    end

    ThemeManager:BuildFolderTree()
end

getgenv().ObsidianThemeManager = ThemeManager
return ThemeManager
