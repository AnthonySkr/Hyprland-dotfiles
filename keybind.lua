local scrPath = (os.getenv("HOME") or "") .. "/.config/hypr/scripts"
local mainMod = "SUPER"
local ipc = "noctalia msg "

local TERMINAL = "kitty"
local EDITOR = "code"
local EXPLORER = "dolphin"
local BROWSER = "firefox"

-- Application
local KEY_APPLICATION = {
	TERMINAL = ("%s + RETURN"):format(mainMod),
	EXPLORER = ("%s + E"):format(mainMod),
	EDITOR = ("%s + C"):format(mainMod),
	BROWSER = ("%s + B"):format(mainMod),
	MUSIC = ("%s + M"):format(mainMod),
	VIDEO = ("%s + V"):format(mainMod),
}
hl.bind(KEY_APPLICATION.TERMINAL, hl.dsp.exec_cmd(TERMINAL), { description = "Terminal" })
hl.bind(KEY_APPLICATION.EXPLORER, hl.dsp.exec_cmd(EXPLORER), { description = "Explorer" })
hl.bind(KEY_APPLICATION.EDITOR, hl.dsp.exec_cmd(EDITOR), { description = "Editor" })
hl.bind(KEY_APPLICATION.BROWSER, hl.dsp.exec_cmd(BROWSER), { description = "Browser" })
hl.bind(KEY_APPLICATION.MUSIC, hl.dsp.exec_cmd("flatpak run dev.aunetx.deezer"), { description = "Music" })
hl.bind(KEY_APPLICATION.VIDEO, hl.dsp.exec_cmd("mpv --player-operation-mode=pseudo-gui --force-window=immediate"), { description = "Video player" })

-- Core binds
local KEY_CORE = {
	LAUNCHER = ("%s + Space"):format(mainMod),
	CONTROL_CENTER = ("%s + S"):format(mainMod),
	SETTINGS = ("%s + comma"):format(mainMod),
	CHEATSHEET = ("%s + H"):format(mainMod),
	LOCK = ("%s + L"):format(mainMod),

	-- Screenshots
	SHOT_WINDOW = ("%s + PRINT"):format(mainMod),
	SHOT_MONITOR = ("ALT + PRINT"):format(mainMod),
	SHOT_REGION = ("SHIFT + PRINT"):format(mainMod),
	SHOT_ANNOTATE = ("%s + A"):format(mainMod),	
}	
hl.bind(KEY_CORE.LAUNCHER, hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"), { description = "Toggle launcher" })
hl.bind(KEY_CORE.LOCK, hl.dsp.exec_cmd(ipc .. "session lock"), { description = "Lock screen" })
hl.bind(KEY_CORE.CONTROL_CENTER, hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"), { description = "Toggle control center" })
hl.bind(KEY_CORE.SETTINGS, hl.dsp.exec_cmd(ipc .. "settings-toggle"), { description = "Toggle settings" })
hl.bind(KEY_CORE.CHEATSHEET, hl.dsp.exec_cmd(scrPath .. "/cheatsheet.sh"), { description = "Toggle cheatsheet" })
hl.bind(KEY_CORE.SHOT_WINDOW, hl.dsp.exec_cmd("HYPRSHOT_DIR=~/Pictures/Screenshots hyprshot -m window"), { description = "Screenshot window" })
hl.bind(KEY_CORE.SHOT_MONITOR, hl.dsp.exec_cmd("HYPRSHOT_DIR=~/Pictures/Screenshots hyprshot -m output"), { description = "Screenshot monitor" })
hl.bind(KEY_CORE.SHOT_REGION, hl.dsp.exec_cmd("HYPRSHOT_DIR=~/Pictures/Screenshots hyprshot -m region"), { description = "Screenshot region" })
hl.bind(KEY_CORE.SHOT_ANNOTATE, hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | satty --filename - --output-filename ~/Pictures/Screenshots/Screenshot-$(date '+%Y%m%d-%H:%M:%S').png"), { description = "Annotate screenshot" })

-- Window management
local KEY_WINDOW = {
	CLOSE = ("%s + Q"):format(mainMod),
	FLOAT = ("%s + W"):format(mainMod),
	FULLSCREEN = ("%s + F"):format(mainMod),

	-- Mouse
	MOUSE_DRAG = ("%s + mouse:272"):format(mainMod),
	MOUSE_RESIZE = ("%s + mouse:273"):format(mainMod),

	-- Focus
	FOCUS_LEFT = ("%s + left"):format(mainMod),
	FOCUS_RIGHT = ("%s + right"):format(mainMod),
	FOCUS_UP = ("%s + up"):format(mainMod),
	FOCUS_DOWN = ("%s + down"):format(mainMod),

	-- Resize
	RESIZE_RIGHT = ("%s + ALT + right"):format(mainMod),
	RESIZE_LEFT = ("%s + ALT + left"):format(mainMod),
	RESIZE_UP = ("%s + ALT + up"):format(mainMod),
	RESIZE_DOWN = ("%s + ALT + down"):format(mainMod),

	-- Move / Swap
	MOVE_SWAP_LEFT = ("%s + SHIFT + left"):format(mainMod),
	MOVE_SWAP_RIGHT = ("%s + SHIFT + right"):format(mainMod),
	MOVE_SWAP_UP = ("%s + SHIFT + up"):format(mainMod),
	MOVE_SWAP_DOWN = ("%s + SHIFT + down"):format(mainMod),
}	
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"), { description = "Switch windows" })
hl.bind(KEY_WINDOW.CLOSE, hl.dsp.window.close(), { description = "Close window" })
hl.bind(KEY_WINDOW.FLOAT, hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(KEY_WINDOW.FULLSCREEN, hl.dsp.window.fullscreen(), { description = "Toggle fullscreen" })
hl.bind(KEY_WINDOW.MOUSE_DRAG, hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind(KEY_WINDOW.MOUSE_RESIZE, hl.dsp.window.resize(), { mouse = true, description = "Resize window" })
hl.bind(KEY_WINDOW.FOCUS_LEFT, hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind(KEY_WINDOW.FOCUS_RIGHT, hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(KEY_WINDOW.FOCUS_UP, hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind(KEY_WINDOW.FOCUS_DOWN, hl.dsp.focus({ direction = "down" }), { description = "Focus down" })
local RESIZE_STEP = 50
hl.bind(KEY_WINDOW.RESIZE_RIGHT, hl.dsp.window.resize({ x =  RESIZE_STEP, y = 0, relative = true }), { description = "Resize window right" })
hl.bind(KEY_WINDOW.RESIZE_LEFT, hl.dsp.window.resize({ x = -RESIZE_STEP, y = 0, relative = true }), { description = "Resize window left" })
hl.bind(KEY_WINDOW.RESIZE_UP, hl.dsp.window.resize({ x = 0, y = -RESIZE_STEP, relative = true }), { description = "Resize window up" })
hl.bind(KEY_WINDOW.RESIZE_DOWN, hl.dsp.window.resize({ x = 0, y =  RESIZE_STEP, relative = true }), { description = "Resize window down" })
hl.bind(KEY_WINDOW.MOVE_SWAP_LEFT, hl.dsp.window.move({ direction = "left" }), { description = "Move or swap window left" })
hl.bind(KEY_WINDOW.MOVE_SWAP_RIGHT, hl.dsp.window.move({ direction = "right" }), { description = "Move or swap window right" })
hl.bind(KEY_WINDOW.MOVE_SWAP_UP, hl.dsp.window.move({ direction = "up" }), { description = "Move or swap window up" })
hl.bind(KEY_WINDOW.MOVE_SWAP_DOWN, hl.dsp.window.move({ direction = "down" }), { description = "Move or swap window down" })

-- Workspace management
local KEY_WORKSPACE = {
	-- Navigation
	WORKSPACE_NEXT = ("%s + CTRL + right"):format(mainMod),
	SCROLL_WORKSPACE_NEXT = ("%s + mouse_down"):format(mainMod),
	WORKSPACE_PREV = ("%s + CTRL + left"):format(mainMod),
	SCROLL_WORKSPACE_PREV = ("%s + mouse_up"):format(mainMod),
	WORKSPACE_EMPTY = ("%s + CTRL + down"):format(mainMod),

	-- Move window
	MOVE_TO_NEXT_WORKSPACE = ("%s + CTRL + SHIFT + right"):format(mainMod),
	MOVE_TO_PREV_WORKSPACE = ("%s + CTRL + SHIFT + left"):format(mainMod),
}	
hl.bind(KEY_WORKSPACE.WORKSPACE_NEXT, hl.dsp.focus({ workspace = "r+1" }), { description = "Next workspace" })
hl.bind(KEY_WORKSPACE.SCROLL_WORKSPACE_NEXT, hl.dsp.focus({ workspace = "r+1" }), { description = "Next workspace" })
hl.bind(KEY_WORKSPACE.WORKSPACE_PREV, hl.dsp.focus({ workspace = "r-1" }), { description = "Previous workspace" })
hl.bind(KEY_WORKSPACE.SCROLL_WORKSPACE_PREV, hl.dsp.focus({ workspace = "r-1" }), { description = "Previous workspace" })
hl.bind(KEY_WORKSPACE.WORKSPACE_EMPTY, hl.dsp.focus({ workspace = "empty" }), { description = "Empty workspace" })
hl.bind(KEY_WORKSPACE.MOVE_TO_NEXT_WORKSPACE, hl.dsp.window.move({ workspace = "r+1" }), { description = "Move to next workspace" })
hl.bind(KEY_WORKSPACE.MOVE_TO_PREV_WORKSPACE, hl.dsp.window.move({ workspace = "r-1" }), { description = "Move to previous workspace" })

-- Fn keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"), { locked = true })

-- Noctalia Settings
hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})


return true