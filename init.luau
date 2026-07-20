local ObsidianTypes = require("./Library.d")

return {
    Library = (require("./Library") :: any) :: ObsidianTypes.Library,
    Types = require("./Library.d"),
    SaveManager = require("./addons/SaveManager"),
    ThemeManager = require("./addons/ThemeManager")
}
