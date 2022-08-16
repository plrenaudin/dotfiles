# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

BLACK = '#29414f'
RED = '#ec5f67'
GREEN = '#99c794'
YELLOW = '#fac863'
BLUE = '#6699cc'
MAGENTA = '#c594c5'
CYAN = '#5fb3b3'
WHITE = '#ffffff'

mod = "mod4"
terminal = guess_terminal()
home = os.path.expanduser('~')

@lazy.function
def float_to_front(qtile):
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.cmd_bring_to_front()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "m", lazy.window.toggle_fullscreen(), desc='toggle window between minimum and maximum sizes'),
    Key([mod, "shift"], "Tab", lazy.group.next_window(), desc='cycle through window'),
    Key([mod, "control"], "f", float_to_front, desc='brign all floating to front'),
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc='toggle floating'),
    Key([], "F12", lazy.group["scratchpad"].dropdown_toggle('term'), desc='Dropdown terminal'),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -c 0 sset Master 1- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -c 0 sset Master 1+ unmute")),

    # Brightness
    Key([], "XF86MonBrightnessDown", lazy.spawn('brightnessctl s 2000-')),
    Key([], "XF86MonBrightnessUp", lazy.spawn('brightnessctl s +2000')),

    Key([mod], "Print", lazy.spawn("flameshot gui")),

    Key([mod], "e", lazy.spawn("thunar")),
]

groups = (
    Group('1', label='', layout='monadtall', spawn='brave'),
    Group('2', label='', layout='monadtall', spawn='code', matches=[Match(wm_class=["code"])]),
    Group('3', label='', layout='columns'),
    Group('4', label='', layout='monadtall'),
    Group('6', label='', layout='monadtall'),
    Group('5', label='⛁', layout='monadtall'),
    Group('7', label='★', layout='monadtall'),
    Group('8', label='★', layout='monadtall'),
    ScratchPad('scratchpad', [DropDown(
        'term', "alacritty", width=0.9, height=0.9,
        x=0.05, y=0.05, opacity=1.0, on_focus_lost_hide=False
    )])
)

for i, group in enumerate(groups[:-1], 1):
    # to another group
    keys.append(Key([mod], str(i), lazy.group[group.name].toscreen()))
    # Send current window to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(group.name, switch_group=True)))

layouts = [
    layout.MonadTall(border_focus=GREEN, border_width=1, ratio=0.62, single_border_width=0),
    layout.Columns(border_width=1,border_focus="#4CAF50"),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=1,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper = "/home/plrenaudin/Pictures/wallpaper/wall2.jpg",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.GroupBox(highlight_method='line', highlight_color='00000000',this_current_screen_border=WHITE),
                widget.Spacer(length=5),
                widget.CurrentLayoutIcon(scale=.7),
                widget.Spacer(),
                widget.CPUGraph(border_width=0, margin_y=1, fill_color=f"{RED}.3", graph_color=RED),
                widget.MemoryGraph(border_width=0, margin_y=1, fill_color=f"{GREEN}.3",graph_color=GREEN),
                widget.NetGraph(border_width=0, margin_y=1, fill_color=f"{BLUE}.3", graph_color=BLUE),
                widget.Systray(),
                widget.Battery( format="{char} {percent:2.0%}", charge_char=" ", discharge_char=" ", empty_char=" ", full_char=" ", unknown_char=" ", low_percentage=0.2, low_foreground=RED, show_short_text=False, notify_below=15),
                widget.Volume( emoji=True, padding=5),
                widget.CheckUpdates( colour_have_updates=RED, colour_no_updates=WHITE, custom_command="checkupdates", display_format=" {updates}", no_update_string=" ", update_interval=3200),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            ],
            22,
            background = "#00000000",
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_focus='#00000000',
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="thunar"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_type='utility'),
		Match(wm_type='notification'),
		Match(wm_type='toolbar'),
		Match(wm_type='splash'),
		Match(wm_type='dialog'),
		Match(wm_class='file_progress'),
		Match(wm_class='confirm'),
		Match(wm_class='dialog'),
		Match(wm_class='download'),
		Match(wm_class='notification'),
		Match(wm_class='zoom'),
		Match(wm_class='error'),
		Match(wm_class='ulauncher'),
		Match(wm_class='Thunar'),
		Match(wm_class='confirmreset'),  # gitk
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

@hook.subscribe.startup_once
def start_once():
    if qtile.core.name == 'x11':
        subprocess.call([home + '/.config/qtile/autostart.sh'])

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
