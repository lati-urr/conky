function conky_set_settings()
	graph_settings={
    {
	    name="cpu",
	    arg="cpu0",
	    max=100,
      x=595,
      y=75,
      width=200,
      height=60,
      nb_values=200,
      foreground=false,
      fg_bd_size=1,
      fg_bd_colour={{0,0x3bbafd,1}},
      bg_colour={{0,0x000000,0},{1,0x000000,0.5}},
    },
    {
	    name="cpu",
	    arg="cpu1",
	    max=100,
      x=800,
      y=75,
      width=200,
      height=60,
      nb_values=200,
      foreground=false,
      fg_bd_size=1,
      fg_bd_colour={{0,0x3bbafd,1}},
      bg_colour={{0,0x000000,0},{1,0x000000,0.5}},
    },
    {
	    name="cpu",
	    arg="cpu2",
	    max=100,
      x=595,
      y=145,
      width=200,
      height=60,
      nb_values=200,
      foreground=false,
      fg_bd_size=1,
      fg_bd_colour={{0,0x3bbafd,1}},
      bg_colour={{0,0x000000,0},{1,0x000000,0.5}},
    },
    {
	    name="cpu",
	    arg="cpu3",
	    max=100,
      x=800,
      y=145,
      width=200,
      height=60,
      nb_values=200,
      foreground=false,
      fg_bd_size=1,
      fg_bd_colour={{0,0x3bbafd,1}},
      bg_colour={{0,0x000000,0},{1,0x000000,0.5}},
    },
    {
	    name="memperc",
	    arg="",
      max=100,
      x=595,
      y=405,
      width=405,
      height=100,
      nb_values=405,
      foreground=false,
      fg_bd_size=1,
      fg_bd_colour={{0,0x3bbafd,1}},
      bg_colour={{0,0x000000,0},{1,0x000000,0.5}},
    },
    {
      name="downspeedf",
      arg="wlp3s0",
      max=2000,
      draw_me="${if_existing /sys/class/net/wlp3s0/operstate up}1${endif}",
      x=0,
      y=370,
      width=290,
      height=100,
      bg_colour={{0,0x000000,0},{1,0x000000,0.5}},
      fg_colour={{0,0x0000ff,0.3},{1,0x0000ff,1}},
      fg_orientation="ww",
    },
    {
      name="upspeedf",
      arg="wlp3s0",
      max=2000,
      draw_me="${if_existing /sys/class/net/wlp3s0/operstate up}1${endif}",
      x=300,
      y=370,
      width=290,
      height=100,
      bg_colour={{0,0x000000,0},{1,0x000000,0.5}},
      fg_colour={{0,0x00ff00,0.3},{1,0x00ff00,1}},
      fg_orientation="ww",
    },
    {
      name="loadavg",
      arg="1",
      x=300,
      y=145,
      max=10,
      width=290,
      height=120,
      foreground=false,
      fg_bd_size=1,
      fg_bd_colour={{1,0xccccff,1}},
      bg_colour={{0,0x000000,0},{1,0x000000,1}},
    },
    {
      name="loadavg",
      arg="2",
      x=300,
      y=145,
      max=10,
      width=290,
      height=120,
      foreground=false,
      background=false,
      fg_bd_size=1,
      fg_bd_colour={{1,0x3bbaff,1}},
      bg_colour={{0,0x303F3F,1},{1,0x303F3F,0.5}},
    },
    {
      name="loadavg",
      arg="3",
      x=300,
      y=145,
      max=10,
      width=290,
      height=120,
      foreground=false,
      background=false,
      fg_bd_size=1,
      fg_bd_colour={{1,0x0000ff,1}},
      bg_colour={{0,0x303F3F,1},{1,0x303F3F,0.5}},
    },
  }
  text_settings={
    {
      pos={300,16},
      text='LOAD',
      size=16,
    },
    {
      pos={0,250},
      text='NETWORK',
      size=16,
    },
    {
      pos={360,210},
      name='loadavg',
      arg='1',
      color=0xccccff,
    },
    {
      pos={420,210},
      name='loadavg',
      arg='2',
      color=0x3bbaff,
    },
    {
      pos={480,210},
      name='loadavg',
      arg='3',
      color=0x0000ff,
    },
    {
      pos={695,50},
      name='cpu',
      arg='cpu0',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={900,50},
      name='cpu',
      arg='cpu1',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={695,120},
      name='cpu',
      arg='cpu2',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={900,120},
      name='cpu',
      arg='cpu3',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={797.5,360},
      name='mem',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={145,315},
      name='downspeedf',
      arg='wlp3s0',
      unit=' k/s',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={0,275},
      text='↓',
      size=14,
      align={'left','bottom'},
      font='IPAPGothic',
    },
    {
      pos={300,275},
      text='↑',
      size=14,
      align={'left','bottom'},
      font='IPAPGothic',
    },
    {
      pos={445,315},
      name='upspeedf',
      arg='wlp3s0',
      unit=' k/s',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={285,270},
      name='totaldown',
      arg='wlp3s0',
      size=18,
      align={'right','bottom'},
      interval=10,
    },
    {
      pos={585,270},
      name='totalup',
      arg='wlp3s0',
      size=18,
      align={'right','bottom'},
      interval=10,
    },
    {
      pos={170,420},
      text='SSID',
      align={'right','bottom'},
      size=18,
    },
    {
      pos={170,450},
      text='QUALITY',
      align={'right','bottom'},
      size=18,
    },
    {
      pos={170,480},
      text='MAC',
      align={'right','bottom'},
      size=18,
    },
    {
      pos={170,510},
      text='LAN IP',
      align={'right','bottom'},
      size=18,
    },
    {
      pos={570,420},
      name='wireless_essid',
      arg='wlp3s0',
      align={'right','bottom'},
      size=14,
      font='IPAPGothic',
      interval=5,
    },
    {
      pos={570,450},
      name='wireless_link_qual_perc',
      arg='wlp3s0',
      warn={60,0xffff00},
      alert={40,0xff0000},
      size=18,
      align={'right','bottom'},
      interval=5,
    },
    {
      pos={570,480},
      name='wireless_ap',
      arg='wlp3s0',
      size=18,
      align={'right','bottom'},
      interval=30,
    },
    {
      pos={570,510},
      name='addrs',
      arg='wlp3s0',
      size=18,
      align={'right','bottom'},
      interval=30,
    },
  }
end


--[[
  GRAPH widget v1.1 by wlourf (07.01.2011)
	this widget draws some graphs with some effects
	http://u-scripts.blogspot.com/2010/10/graph-widget.html

  To call the script in a conky, use, before TEXT
	lua_load /path/to/the/script/graph.lua
	lua_draw_hook_pre main_graph
  and add one line (blank or not) after TEXT


  Parameters are :
  3 parameters are mandatory
  name		- the name of the conky variable to display,
  for example for {$cpu cpu0}, just write name="cpu"
  arg			- the argument of the above variable,
  for example for {$cpu cpu1}, just write arg="cpu1"
  arg can be a numerical value if name=""
  max			- the maximum value the above variable can reach,
  for example for {$cpu cpu1}, just write max=100 or less or more

  Optional parameters:
  x,y 		- coordinates of the bottom-left corner of the graph,
  relative to the top-left corner of the conky window
  default =  bottom-left corner of the conky window
  width       - width of the graph, default = 100 pixels
  height      - height of the graph, default = 20 pixels
  nb_values   - number of values to display in the graph, default=width
  i.e. 1 pixel for 1 value
  autoscale   - if set to true, calculate the max value of the y axis and
  doesn't use the max parameter above, default=false
  skew_x      - skew graph around x axis, défaut = 0
  skew_y      - skew graph around y axis, défaut = 0
  angle	    - angle of rotation of the graph in degress, default = 0
  i.e. a horizontal graph)
  inverse     - if set to true, graph are draw from right to left, default=false
  background  - if set to false, background is not drawn, default=true
  foreground  - if set to false, foreground is not drawn, default=true
  foreground = plain graph
  bg_bd_size  - size of the border of the background, default=0=no border
  fg_bd_size  - size of the border of the foreground, default=0=no border


  Colours tables below are defined into braces :
  {position in the gradient (0 to 1), colour in hexadecimal, alpha (0 to 1)}
  example for a single colour table :
  {{0,0xFFAA00,1}} position parameter doesn't matter
  example for a two-colours table :
  {{0,0xFFAA00,1},{1,0x00AA00,1}} or {{0.5,0xFFAA00,1},{1,0x00AA00,1}}
  example for a three-colours table :
  {{0,0xFFAA00,1},{0.5,0xFF0000,1},{1,0x00AA00,1}}

  bg_colour	- colour table for background,
  default = {{0,0x000000,.5},{1,0xFFFFFF,.5}}
  fg_colour	- colour table for foreground,
  default = {{0,0x00FFFF,1},{1,0x0000FF,1}}
  bg_bd_colour- colour table for background border,
  default = {{1,0xFFFFFF,1}}
  fg_bd_colour- colour table for foreground border,
  default = {{1,0xFFFF00,1}}

  bg_orientation, bg_bd_orientation, fg_orientation, fg_bd_orientation,
  - "orientation" defines the starting point of the gradient,
  default="nn"
  there are 8 available starting points :
  "nw","nn","ne","ee","se","ss","sw","ww"
  (n for north, w for west ...)
  theses 8 points are the 4 corners + the 4 middles of graph
  so a gradient "nn" will go from "nn" to "ss"
  a gradient "nw" will go from "nw" to "se"

  draw_me     - if set to false, graph is not drawn (default = true)
  it can be used with a conky string, if the string returns 1, the graph is drawn :
  example : "${if_empty ${wireless_essid wlan0}}${else}1$endif",

  v1.0 (31/10/2010) original release
  v1.1 (07/01/2011) Add draw_me parameter and correct memory leaks, thanks to "Creamy Goodness"
  text is parsed inside the function, not in the array of settings

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation version 3 (GPLv3)

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
  MA 02110-1301, USA.
]]
