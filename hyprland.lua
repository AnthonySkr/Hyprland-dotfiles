-- hyprland.lua
-- Point d'entree. Ordre de chargement uniquement, aucune config ici.
--
-- L'ordre compte :
--   1. env en premier, les variables doivent etre posees avant
--      l'initialisation du serveur d'affichage ;
--   2. puis du plus structurel au plus cosmetique ;
--   3. autostart en dernier, une fois que tout est en place.
--
-- vars.lua et theme.lua ne sont pas listes ici : ils ne font rien par
-- eux-memes, ils sont charges a la demande par les modules qui en ont
-- besoin, via require().

require("env")
require("monitors")
require("input")
require("look")
require("animations")
require("rules")
require("binds")
require("autostart")