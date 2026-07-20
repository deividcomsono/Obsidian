local ObsidianTypes = require("./obsidian/Library.d")

return {
    Library = (require("./obsidian/Library") :: any) :: ObsidianTypes.Library,
    Types = require("./obsidian/Library.d"),
    SaveManager = require("./obsidian/addons/SaveManager"),
    ThemeManager = require("./obsidian/addons/ThemeManager")
}
