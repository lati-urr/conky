-- Define your visual elements here
-- For examples, and a complete list on the possible elements and their
-- properties, go to https://github.com/fisadev/conky-draw/
-- (and be sure to use the lastest version)

elements = {
  {
    kind = 'ring_graph',
    center = {x = 160, y = 200},
    conky_value = 'battery_percent BAT0',
    radius = 70,
    graduated = true,
    change_color_on_critical = false,
    number_graduation=100,
    start_angle = 135,
    end_angle = 405,
    color= 0x00E5FF,
    background_color= 0xD75600,
    bar_thickness=10,
    background_thickness=10,
  },
  {
    kind = 'ring_graph',
    center = {x = 160, y = 200},
    conky_value = 'battery_percent BAT1',
    radius = 85,
    graduated = true,
    change_color_on_critical = false,
    number_graduation=100,
    start_angle = 135,
    end_angle = 405,
    color= 0x00E5FF,
    background_color= 0xD75600,
    bar_thickness=10,
    background_thickness=10,
  },
  {
    kind = 'bar_graph',
    conky_value = 'fs_used_perc /home/',
    from = {x = 30, y = 400},
    to = {x = 320, y = 400},

    background_thickness = 10,
    background_color = 0x00E5FF,

    bar_thickness = 10,
    bar_color = 0x00E5FF,

    critical_threshold = 80,

    change_color_on_critical = true,
    change_thickness_on_critical = true,

    background_color_critical = 0xFFA0A0,
    background_thickness_critical = 10,

    bar_color_critical = 0xFF0000,
    bar_thickness_critical = 13,
  },
}

text_elements = {
  {
    pos={0,10},
    text='system',
    align={'left','middle'},
    size=16,
  },
  {
    pos={520,220},
    sh='date "+%H:%M:%S"',
    align={'center','middle'},
    size=70,
  },
  {
    pos={160,290},
    sh='~/.config/conky/battery.sh',
    align={'center','middle'},
    font="IPAPGothic",
    size=32,
    color=0x00e5ff,
    interval=20,
  },
  {
    pos={290,40},
    name='kernel',
    align={'right','middle'},
    size=16,
    interval=3600,
  },
  {
    pos={290,55},
    name='uptime',
    align={'right','middle'},
    size=16,
    interval=5,
  },
  -- {
  --   pos={290,420},
  --   name='diskio',
  --   arg='/dev/nvme0n1p4',
  --   align={'right','middle'},
  --   size=16,
  --   interval=5,
  -- },
  {
    pos={30,40},
    text='KERNEL',
    align={'left','middle'},
    size=16,
  },
  {
    pos={30,55},
    text='UPTIME',
    align={'left','middle'},
    size=16,
  },
  {
    pos={30,380},
    text='DISK',
    align={'left','middle'},
    size=16,
  },
  -- {
  --   pos={30,420},
  --   text='R/W',
  --   align={'left','middle'},
  --   size=16,
  -- },
  {
    pos={160,200},
    sh="upower -i $(upower -e | grep BAT1) | grep state | awk '{print $2}'",
    font='Font Awesome',
    align={'center','middle'},
    size=36,
    color=0x00e5ff,
    interval=5,
    operator={
      discharging = '',
      charging = '',
      fullycharged = '',
      default = '?',
    },
  }
}
audacious_elements = {
  audacious = {
    pos={0,545},
    text='audacious',
    align={'left','center'},
    size=16,
  },
  status = {
    pos={30,940},
    font='Font Awesome',
    text='',
    align={'left','top'},
    size=48,
  },
  title = {
    pos={320,930},
    font='IPAPGothic',
    size=20,
    sh='audtool current-song',
    align={'center','middle'},
  },
  artist = {
    pos={640,950},
    font='IPAPGothic',
    size=14,
    sh='audtool current-song-tuple-data artist',
    align={'right','middle'},
  },
  time = {
    pos={640,970},
    sh='echo $(audtool current-song-output-length) / $(audtool current-song-length)',
    align={'right','middle'},
    size=18,
  },
  thumbnail = {
    x = 0,
    y = 550,
    h = 360,
    w = 640,
    align = 'center',
    file = '',
  }
}
