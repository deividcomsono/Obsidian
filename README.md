# Obsidian

Obsidian is a feature-rich UI library for Roblox, written in Luau.

## Installation

Install the package with [Wally](https://github.com/UpliftGames/wally):

```toml
[dependencies]
Obsidian = "deividcomsono/obsidian@25.12.2"
```

The package exports the library and the optional Save Manager and Theme Manager addons. Type definitions are available in `Library.d.luau` for Luau tooling:

```lua
local Obsidian = require(path.to.Obsidian)

local Library = Obsidian.Library
local SaveManager = Obsidian.SaveManager
local ThemeManager = Obsidian.ThemeManager
```

For the complete API documentation, see <https://docs.mspaint.cc/obsidian>.

## Local development

The repository uses [Rokit](https://github.com/rojo-rbx/rokit) to manage tools. Run `rokit install` to install the pinned Wally version, then use the package from your local project.

## License

Obsidian is available under the MIT license. See [LICENSE](LICENSE).
