type CyanTypes = require("./Library.d")

return {
    Library = (require("./Library") :: any) :: CyanTypes.Library,
    SaveManager = require("./addons/SaveManager"),
    ThemeManager = require("./addons/ThemeManager"),
    ESP = require("./addons/ESP")
}
