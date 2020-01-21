# conky
This is my conky theme.

The lua file refers to http://u-scripts.blogspot.com/2010/10/graph-widget.html and https://github.com/fisadev/conky-draw

# install
this conky theme use `upower` command to check battery, `audtool` command to check musicplayer  
install upower and audacious command
```
sudo apt-get install upower audacious
```
```
cd ~/.config/conky
git clone git@github.com:lati-urr/conky.git
```

# startup
run this command
```
conky -c ~/.cofnig/conky/conky_left.conf -p 10
conky -c ~/.config/conky/conky_right.conf -p 10
```

# screenshot
![screenshot](https://github.com/lati-urr/conky/blob/image/conky_demo.jpg)

# You should change first
### text.lua
At first line in write_text(), there is 
```
local font = def.font or 'Digital'
```
Digital is not popular font, you should use the default font name
### left_config.lua
In text_elements, there is
```
sh="upower -i $(upower -e | grep BAT1) | grep state | awk '{print $2}'",
```
you should check this sh command
this command result is battery status, |charging|discharging|fully-charged| is ok
if your PC has only one battery, you should change BAT1 to BAT0
### right_config.lua
In text_settings,
you should change arg name of wifimodule(wlp3s0)
### conky_left.conf
change font
change forecast image link, firstly set ![tenki.jp](https://static.tenki.jp/static-images/rainmesh/60/pref-15-large.jpg)
### conky_right.conf
change font
change RSS link, firstly set ![techchurch](https://jp.techcrunch.com/feed/)


# settings
## left_config.lua
### elements
refer to ![conky-draw](https://github.com/fisadev/conky-draw)

### text_elements

| key | description |
| -------- | ------------------------------------------------------------------------------- |
| pos | set position, ex. pos={0,10} |
| sh | display result of sh command, ex. sh='date "+%H:%M:%S"' |
| text | display text ex. text="Hello!" |
| name,arg | display conky value if you want conky_value ${cpu cpu0}, name='cpu', arg='cpu0' |
| unit | only shows if name,arg display, ex. unit='k/s' |
| color | set color ex. color=0x00ff00 |
| align | set align {|center|right|,|top|middle|bottom|} |
| font | set font | 
| size | set fontsize |

priority:  
sh > text > name & arg  
text shows only if sh is nil  
name & arg shows only if sh and text are nil  
### audacious_elements
this is supports only audacious.
audacious_elements has some table.
the specific key of table is specific action.

| key | action |
| --------- | --------------------------------------------------------------------------------------- |
| status | display audacious status icon |
| thumbnail | display music thumbnail, set x,y,h,w,align,file(empty) refer to left_config.lua example |

## right_config.lua
### graph_settings
refer to ![Graph-Widget](http://u-scripts.blogspot.com/2010/10/graph-widget.html)

### text_settings
same text_elements
### image_settings

| key | description |
| ----- | ----------------------------------------------------------------------------------------- |
| x | set x position |
| y | set y position |
| w | set width of display image |
| h | set height of display image | 
| file | set image path |
| align | if you set 'center'(align='center'), display center of the area(x,y,h,w) with same aspect |
