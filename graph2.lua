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


require 'cairo'

function conky_set_settings()
	graph_settings={
    {
	    name="cpu",
	    arg="cpu0",
	    max=100,
      x=595,
      y=90,
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
      y=90,
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
      y=160,
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
      y=160,
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
      y=420,
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
      max=1000,
      draw_me="${if_existing /sys/class/net/wlp3s0/operstate up}1${endif}",
      x=0,
      y=380,
      autoscale=true,
      width=290,
      height=100,
      bg_colour={{0,0x000000,0},{1,0x000000,0.5}},
      fg_colour={{0,0x0000ff,0.3},{1,0x0000ff,1}},
      fg_orientation="ww",
    },
    {
      name="upspeedf",
      arg="wlp3s0",
      max=1000,
      draw_me="${if_existing /sys/class/net/wlp3s0/operstate up}1${endif}",
      x=300,
      y=380,
      autoscale=true,
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
      y=160,
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
      y=160,
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
      y=160,
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
      pos={300,28},
      text='LOAD',
      size=16,
    },
    {
      pos={0,270},
      text='NETWORK',
      size=16,
    },
    {
      pos={360,230},
      name='loadavg',
      arg='1',
      color=0xccccff,
    },
    {
      pos={420,230},
      name='loadavg',
      arg='2',
      color=0x3bbaff,
    },
    {
      pos={480,230},
      name='loadavg',
      arg='3',
      color=0x0000ff,
    },
    {
      pos={695,60},
      name='cpu',
      arg='cpu0',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={900,60},
      name='cpu',
      arg='cpu1',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={695,130},
      name='cpu',
      arg='cpu2',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={900,130},
      name='cpu',
      arg='cpu3',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={797.5,370},
      name='mem',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={145,330},
      name='downspeedf',
      arg='wlp3s0',
      unit=' k/s',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={0,290},
      text='↓',
      size=14,
      align={'left','bottom'},
      font='IPAPGothic',
    },
    {
      pos={300,290},
      text='↑',
      size=14,
      align={'left','bottom'},
      font='IPAPGothic',
    },
    {
      pos={445,330},
      name='upspeedf',
      arg='wlp3s0',
      unit=' k/s',
      size=36,
      color=0x81fffb,
      align={'center','middle'},
    },
    {
      pos={290,285},
      name='totaldown',
      arg='wlp3s0',
      size=18,
      align={'right','bottom'},
    },
    {
      pos={590,285},
      name='totalup',
      arg='wlp3s0',
      size=18,
      align={'right','bottom'},
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
    },
    {
      pos={570,450},
      name='wireless_link_qual_perc',
      arg='wlp3s0',
      warn={60,0xffff00},
      alert={40,0xff0000},
      size=18,
      align={'right','bottom'},
    },
    {
      pos={570,480},
      name='wireless_ap',
      arg='wlp3s0',
      size=18,
      align={'right','bottom'},
    },
    {
      pos={570,510},
      name='addrs',
      arg='wlp3s0',
      size=18,
      align={'right','bottom'},
    },
  }
  reload = 1
  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_face = CAIRO_FONT_WEIGHT_NORMAL
  font = "Digital"
  font_size = 12
end


function check_settings(t)
  --tables are check only when conky start
	if t.name==nil and t.arg==nil then
		print ("No input values ... use parameters 'name'" ..
             " with 'arg' or only parameter 'arg' ")
		return 1
	end

	if t.max==nil then
		print ("No maximum value defined, use 'max'")
		print ("for name=" .. t.name .. " with arg=" .. t.arg)
		return 1
	end
	if t.name==nil then t.name="" end
	if t.arg==nil then t.arg="" end
	return 0
end

function conky_main()

  if conky_window == nil then return end

  local w=conky_window.width
  local h=conky_window.height
  local cs=cairo_xlib_surface_create(conky_window.display,
                                     conky_window.drawable, conky_window.visual, w, h)
  cr=cairo_create(cs)

  updates=tonumber(conky_parse('${updates}'))
  --start drawing after "updates_gap" updates
  --prevent segmentation error for cpu
  updates_gap=5
  if updates<=1 or reload==1 then
    conky_set_settings()
    flagOK=0
    reload=0
    for i in pairs(graph_settings) do
      if graph_settings[i].width==nil then graph_settings[i].width=100 end
      if graph_settings[i].nb_values==nil then
        graph_settings[i].nb_values= graph_settings[i].width
      end
      --create an empty table to store values
      graph_settings[i]["values"]={}
      --beginning point
      graph_settings[i].beg = graph_settings[i].nb_values
      --graph_settings[i].beg = 0
      for j =1, graph_settings[i].nb_values do
        graph_settings[i].values[j]=0
      end
      graph_settings[i].flag_init=true
      flagOK=flagOK + check_settings(graph_settings[i])
    end
    if flagOK>0 then
      --abort script if error in one of the tables
      print ("ERROR : Check the graph_setting table")
      return
    end
  end

  --drawing process
  if updates > updates_gap then
    for i in pairs(graph_settings) do
      if graph_settings[i].draw_me==true then graph_settings[i].draw_me = nil end
      if (graph_settings[i].draw_me==nil or conky_parse(tostring(graph_settings[i].draw_me)) == "1") then
        local nb_values=graph_settings[i].nb_values
        graph_settings[i].automax=0
        for j =1, nb_values do
          if graph_settings[i].values[j+1]==nil then
            graph_settings[i].values[j+1]=0
          end

          graph_settings[i].values[j]=graph_settings[i].values[j+1]
          if j==nb_values then
            --store value
            if graph_settings[i].name=="" then
              value=graph_settings[i].arg
            else
              value=tonumber(conky_parse('${' ..
                                           graph_settings[i].name .. " " ..
                                           graph_settings[i].arg ..'}'))
            end
            graph_settings[i].values[nb_values]=value
          end
          graph_settings[i].automax=math.max(graph_settings[i].automax,
                                             graph_settings[i].values[j])
          --should stop weird glitches at beginning when no values reported yet for upspeed or diskio
          if graph_settings[i].automax == 0 then graph_settings[i].automax = 1 end
        end
        draw_graph(graph_settings[i])
      end
    end
  end
  -- show text
  extents=cairo_text_extents_t:create()
  local utf8 = "cairo"
  cairo_select_font_face (cr, font, font_slant, font_face);
  cairo_set_source_rgba (cr, 59/255, 186/255, 253/255, 1)
  cairo_set_font_size (cr, 16)
  cairo_move_to (cr,335,24)
  cairo_line_to (cr,590,24)
  cairo_stroke (cr)
  cairo_move_to (cr,55,265)
  cairo_line_to (cr,590,265)
  cairo_stroke (cr)
  cairo_move_to (cr,595,530)
  cairo_line_to (cr,1000,530)
  cairo_stroke (cr)
  if text_settings ~= nil then
    for i in pairs(text_settings) do
      write_text(cr, text_settings[i])
    end
  end
  cairo_destroy(cr)
  cairo_surface_destroy(cs)
	updates=nil
	updates_gap=nil
end

function rgbToRgba(color, alpha)
  return ((color / 0x10000) % 0x100) / 255.0,
  ((color / 0x100) % 0x100) / 255.0,
  (color % 0x100) / 255.0,
  alpha
end

function write_text(cr, def)
  local font = def.font or 'Digital'
  local fontSize = def.size or 24
  local fontSlant = CAIRO_FONT_SLANT_NORMAL
  local fontWeight = CAIRO_FONT_WEIGHT_NORMAL
  cairo_select_font_face(cr, font, fontSlant, fontWeight)
  cairo_set_font_size(cr, fontSize)
  cairo_set_source_rgba(cr, rgbToRgba( def.color or 0x3bbafd, def.alpha or 1))
  local text
  if def.text ~= nil then
    text = def.text
  else
    if def.unit == nil then
      def.unit = ''
    end
    value = conky_parse('${' .. (def.name or '') .. ' ' .. (def.arg or '') .. '}')
    -- if def.warn ~= nil then
    --   if tonumber(value) <= def.warn[1] then
    --     cairo_set_source_rgba(cr, rgbToRgba( def.warn[2], def.alpha or 1))
    --   end
    -- end
    -- if def.alert ~= nil then
    --   if tonumber(value) <= def.alert[1] then
    --     cairo_set_source_rgba(cr, rgbToRgba( def.alert[2], def.alpha or 1))
    --   end
    -- end
    text = tostring(value) .. def.unit
  end
  -- if def.font[2] and def.font[2] % 2 == 1 then
  --   fontWeight = CAIRO_FONT_WEIGHT_BOLD
  -- end
  -- if def.font[2] and def.font[2] / 2 >= 1 then
  --   fontWeight = CAIRO_FONT_SLANT_ITALIC
  -- end
  local x = def.pos[1]
  local y = def.pos[2]
  local te = cairo_text_extents_t:create()
  local fe = cairo_font_extents_t:create()
  cairo_text_extents(cr, text, te)
  cairo_font_extents(cr, fe)

  if def.align ~= nil then
    if def.align[1] == 'right' then
      x = x - te.width - te.x_bearing
    elseif def.align[1] == 'center' then
      x = x - te.width/2 - te.x_bearing
    end

    if def.align[2] == 'bottom' then
      y = y - fe.descent
    elseif def.align[2] == 'middle' then
      y = y + te.height/2
    elseif def.align[2] == 'top' then
      y = y + fe.ascent
    end
  end

  cairo_move_to(cr, x, y)
  cairo_show_text(cr, text)
  cairo_new_path(cr)

  local boundingBox = {
    x = x + te.x_bearing,
    y = y + te.y_bearing,
    width = te.width,
    height = te.height,
    right = x + te.x_bearing + te.width,
    bottom = y + te.y_bearing + te.height
  }
  return boundingBox
end

function draw_graph(t)
  --drawing function

  local function rgb_to_r_g_b(colour)
    return ((colour[2] / 0x10000) % 0x100) / 255., ((colour[2] / 0x100) % 0x100) / 255., (colour[2] % 0x100) / 255., colour[3]
  end

	local function linear_orientation(o,w,h)
    --set gradient for bg and bg border
    local p
		if o=="nn" then
			p={w/2,h,w/2,0}
		elseif o=="ne" then
			p={w,h,0,0}
		elseif o=="ww" then
			p={0,h/2,w,h/2}
		elseif o=="se" then
			p={w,0,0,h}
		elseif o=="ss" then
			p={w/2,0,w/2,h}
		elseif o=="ee" then
			p={w,h/2,0,h/2}
		elseif o=="sw" then
			p={0,0,w,h}
		elseif o=="nw" then
			p={0,h,w,0}
		end
		return p
	end

	local function linear_orientation_inv(o,w,h)
    --set gradient for fg and fg border
    local p
		if o=="ss" then
			p={w/2,h,w/2,0}
		elseif o=="sw" then
			p={w,h,0,0}
		elseif o=="ee" then
			p={0,h/2,w,h/2}
		elseif o=="nw" then
			p={w,0,0,h}
		elseif o=="nn" then
			p={w/2,0,w/2,h}
		elseif o=="ww" then
			p={w,h/2,0,h/2}
		elseif o=="ne" then
			p={0,0,w,h}
		elseif o=="se" then
			p={0,h,w,0}
		end
		return p
	end


	--set default values

  --cancel drawing if not needed
	if t.draw_me~=nil and conky_parse(tostring(t.draw_me)) ~= "1" then
		return
	end



	if t.height==nil	then t.height=20 end
	--checked in previous part : width and nb_values

	if t.background==nil    then t.background=true end
	if t.bg_bd_size==nil	then t.bg_bd_size=0 end
	if t.x==nil 		    then t.x=t.bg_bd_size end
	if t.y==nil 		    then t.y=conky_window.height -t.bg_bd_size end
	if t.bg_colour==nil 	then t.bg_colour={{0,0x000000,.5},{1,0xFFFFFF,.5}} end
	if t.bg_bd_colour==nil 	then t.bg_bd_colour={{1,0xFFFFFF,1}} end

	if t.foreground==nil    then t.foreground=true end
	if t.fg_colour==nil 	then t.fg_colour={{0,0x00FFFF,1},{1,0x0000FF,1}} end

	if t.fg_bd_size==nil	then t.fg_bd_size=0 end
	if t.fg_bd_colour==nil  then t.fg_bd_colour={{1,0xFFFF00,1}} end

	if t.autoscale==nil     then t.autoscale=false end
	if t.inverse==nil       then t.inverse=false end
	if t.angle==nil         then t.angle=0 end

	if t.bg_bd_orientation==nil then t.bg_bd_orientation="nn" end
	if t.bg_orientation==nil then t.bg_orientation="nn" end
	if t.fg_bd_orientation==nil then t.fg_bd_orientation="nn" end
	if t.fg_orientation==nil then t.fg_orientation="nn" end

  --check colours tables
	for i=1, #t.fg_colour do
    if #t.fg_colour[i]~=3 then
      print ("error in fg_colour table")
      t.fg_colour[i]={1,0x0000FF,1}
    end
  end

	for i=1, #t.fg_bd_colour do
    if #t.fg_bd_colour[i]~=3 then
      print ("error in fg_bd_colour table")
      t.fg_bd_colour[i]={1,0x00FF00,1}
    end
  end

	for i=1, #t.bg_colour do
    if #t.bg_colour[i]~=3 then
      print ("error in background color table")
      t.bg_colour[i]={1,0xFFFFFF,0.5}
    end
  end

	for i=1, #t.bg_bd_colour do
    if #t.bg_bd_colour[i]~=3 then
      print ("error in background border color table")
      t.bg_bd_colour[i]={1,0xFFFFFF,1}
    end
  end

  --calculate skew parameters if needed
  if t.flag_init then
    if t.skew_x == nil then
      t.skew_x=0
    else
      t.skew_x = math.pi*t.skew_x/180
    end
    if t.skew_y == nil then
      t.skew_y=0
    else
      t.skew_y = math.pi*t.skew_y/180
    end
    t.flag_init=false
	end

  cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
  cairo_set_line_join(cr,CAIRO_LINE_JOIN_ROUND)

  local matrix0 = cairo_matrix_t:create()
  tolua.takeownership(matrix0)
  cairo_save(cr)
  cairo_matrix_init (matrix0, 1,t.skew_y,t.skew_x,1,0,0)
  cairo_transform(cr,matrix0)

  local ratio=t.width/t.nb_values

	cairo_translate(cr,t.x,t.y)
	cairo_rotate(cr,t.angle*math.pi/180)
	cairo_scale(cr,1,-1)

	--background
	if t.background then
    local pts=linear_orientation(t.bg_orientation,t.width,t.height)
		local pat = cairo_pattern_create_linear (pts[1],pts[2],pts[3],pts[4])
		for i=1, #t.bg_colour do
			--print ("i",i,t.colour[i][1], rgb_to_r_g_b(t.colour[i]))
      cairo_pattern_add_color_stop_rgba (pat, t.bg_colour[i][1], rgb_to_r_g_b(t.bg_colour[i]))
		end
		cairo_set_source (cr, pat)
		cairo_rectangle(cr,0,0,t.width,t.height)
		cairo_fill(cr)
		cairo_pattern_destroy(pat)
	end

  --autoscale
  cairo_save(cr)
	if t.autoscale then
		t.max= t.automax*1.1
	end

  local scale_x = t.width/(t.nb_values-1)
	local scale_y = t.height/t.max

  --define first point of the graph
	if updates-updates_gap <t.nb_values then
		t.beg = t.beg - 1
    --next line prevent segmentation error when conky window is redraw
		--quicly when another window "fly" over it
		if t.beg<0 then t.beg=0 end
	else
		t.beg=0
	end
  if t.inverse then cairo_scale(cr,-1,1)
    cairo_translate(cr,-t.width,0) end

	--graph foreground
	if t.foreground then
    local pts_fg=linear_orientation_inv(t.fg_orientation,t.width,t.height)
    local pat = cairo_pattern_create_linear (pts_fg[1],pts_fg[2],pts_fg[3],pts_fg[4])
		for i=1,#t.fg_colour,1 do
			cairo_pattern_add_color_stop_rgba (pat, 1-t.fg_colour[i][1], rgb_to_r_g_b(t.fg_colour[i]))
		end
		cairo_set_source (cr, pat)

		cairo_move_to(cr,t.beg*scale_x,0)
		cairo_line_to(cr,t.beg*scale_x,t.values[t.beg+1]*scale_y)
		for i=t.beg, t.nb_values-1 do
			cairo_line_to(cr,i*scale_x,t.values[i+1]*scale_y)
		end
		cairo_line_to(cr,(t.nb_values-1)*scale_x,0)
		cairo_close_path(cr)
		cairo_fill(cr)
		cairo_pattern_destroy(pat)
	end

	--graph_border
	if t.fg_bd_size>0 then
    local pts=linear_orientation_inv(t.fg_bd_orientation,t.width,t.height)
		local pat = cairo_pattern_create_linear (pts[1],pts[2],pts[3],pts[4])
		for i=1,#t.fg_bd_colour,1 do
			cairo_pattern_add_color_stop_rgba (pat, 1-t.fg_bd_colour[i][1], rgb_to_r_g_b(t.fg_bd_colour[i]))
		end
		cairo_set_source (cr, pat)
		cairo_move_to(cr,t.beg*scale_x,t.values[t.beg+1]*scale_y)
		for i=t.beg, t.nb_values-1 do
			cairo_line_to(cr,i*scale_x,t.values[i+1]*scale_y)
		end
		cairo_set_line_width(cr,t.fg_bd_size)
		cairo_stroke(cr)
		cairo_pattern_destroy(pat)
	end
	cairo_restore(cr)

	--background border
	if t.bg_bd_size>0 then
    local pts=linear_orientation(t.bg_bd_orientation,t.width,t.height)
		local pat = cairo_pattern_create_linear (pts[1],pts[2],pts[3],pts[4])
		for i=1, #t.bg_bd_colour do
			--print ("i",i,t.colour[i][1], rgb_to_r_g_b(t.colour[i]))
      cairo_pattern_add_color_stop_rgba (pat, t.bg_bd_colour[i][1], rgb_to_r_g_b(t.bg_bd_colour[i]))
		end
		cairo_set_source (cr, pat)
		cairo_rectangle(cr,0,0,t.width,t.height)
		cairo_set_line_width(cr,t.bg_bd_size)
		cairo_stroke(cr)
		cairo_pattern_destroy(pat)
	end

	cairo_restore(cr)

end

