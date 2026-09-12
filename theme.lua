-- theme.lua
-- Palette et geometrie, au meme endroit.
--
-- Tout ce qui est "apparence" passe par ici. Pour reskinner la config
-- entiere, tu n'as que ce fichier a toucher : look.lua et les scripts
-- lisent leurs valeurs depuis cette table.
--
-- Palette : Tokyo Night Storm.

local c = {
  bg        = "1a1b26",
  bg_light  = "24283b",
  fg        = "c0caf5",
  dim       = "565f89",
  accent    = "7aa2f7",
  accent_2  = "bb9af7",
  red       = "f7768e",
  green     = "9ece6a",
  yellow    = "e0af68",
}

return {
  colors = c,

  -- Helper : "7aa2f7" + opacite -> "rgba(7aa2f7ee)"
  rgba = function(hex, alpha)
    return "rgba(" .. hex .. (alpha or "ff") .. ")"
  end,

  -- Geometrie. Esprit Omarchy : espacements serres, angles nets,
  -- pas d'ombre, tout l'accent visuel porte par la bordure active.
  geometry = {
    gaps_in     = 4,
    gaps_out    = 8,
    border_size = 2,
    rounding    = 0,
  },
}