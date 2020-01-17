-- Define your visual elements here
-- For examples, and a complete list on the possible elements and their
-- properties, go to https://github.com/fisadev/conky-draw/
-- (and be sure to use the lastest version)

elements = {
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
}

text_elements = {
  {
    pos={160,290},
    sh='~/.config/conky/battery.sh',
    align={'center','middle'},
    font="IPAPGothic",
    size=32,
    color=0x00e5ff,
  },
  {
    pos={290,40},
    name='kernel',
    align={'right','middle'},
    size=16,
  },
  {
    pos={30,40},
    text='KERNEL',
    align={'left','middle'},
    size=16,
  },
  {
    pos={290,55},
    name='uptime',
    align={'right','middle'},
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
  {
    pos={30,420},
    text='R/W',
    align={'left','middle'},
    size=16,
  },
  {
    pos={290,420},
    name='diskio',
    arg='/dev/nvme0n1p4',
    align={'right','middle'},
    size=16,
  },

}
