type deividcomsonoTypes = require("./Library.d")

return {
    Library = (require("./Library") :: any) :: deividcomsonoTypes.Library,
    SaveManager = require("./addons/SaveManager"),
    ThemeManager = require("./addons/ThemeManager")
}
