type ObsidianTypes = require("./Library.d")

return {
    Library = (require("./Library") :: any) :: ObsidianTypes.Library,
    SaveManager = require("./addons/SaveManager"),
    ThemeManager = require("./addons/ThemeManager")
}
