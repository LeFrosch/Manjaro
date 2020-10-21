conky.config = {

	--Various settings

	background = true,					-- forked to background
	cpu_avg_samples = 2,				-- The number of samples to average for CPU monitoring.
	diskio_avg_samples = 2,				-- The number of samples to average for disk I/O monitoring.
	double_buffer = true,				-- Use the Xdbe extension? (eliminates flicker)
	if_up_strictness = 'address',		-- how strict if testing interface is up - up, link or address
	net_avg_samples = 2,				-- The number of samples to average for net data
	no_buffers = true,					-- Subtract (file system) buffers from used memory?
	temperature_unit = 'celsius',		-- fahrenheit or celsius
	text_buffer_size = 2048,			-- size of buffer for display of content of large variables - default 256
	update_interval = 2,				-- update interval
	imlib_cache_size = 0,              	-- disable image cache to get a new spotify cover per song


	--Placement

	alignment = 'top_right',			-- top_left,top_middle,top_right,bottom_left,bottom_middle,bottom_right,
							-- middle_left,middle_middle,middle_right,none
	--Arch Duoscreen
	--gap_x = -1910,
	gap_x = 15,					-- pixels between right or left border
	gap_y = 15,					-- pixels between bottom or left border
	minimum_height = 600,				-- minimum height of window
	minimum_width = 300,				-- minimum height of window
	maximum_width = 300,				-- maximum height of window

	--Graphical

	border_inner_margin = 10, 			-- margin between border and text
	border_outer_margin = 5, 			-- margin between border and edge of window
	border_width = 0,					-- border width in pixels
	default_bar_width = 80,				-- default is 0 - full width
	default_bar_height = 10,			-- default is 6
	default_gauge_height = 25,			-- default is 25
	default_gauge_width =40,			-- default is 40
	default_graph_height = 40,			-- default is 25
	default_graph_width = 0,			-- default is 0 - full width
	default_shade_color = '#000000',		-- default shading colour
	default_outline_color = '#000000',		-- default outline colour
	draw_borders = false,				-- draw borders around text
	draw_graph_borders = true,			-- draw borders around graphs
	draw_shades = false,				-- draw shades
	draw_outline = false,				-- draw outline
	stippled_borders = 0,				-- dashing the border

	--Textual

	extra_newline = false,				-- extra newline at the end - for asesome's wiboxes
	format_human_readable = true,		-- KiB, MiB rather then number of bytes
	font = 'Roboto Mono:size=10',  		-- font for complete conky unless in code defined
	max_text_width = 0,					-- 0 will make sure line does not get broken if width too smal
	max_user_text = 16384,				-- max text in conky default 16384
	override_utf8_locale = true,		-- force UTF8 requires xft
	short_units = true,					-- shorten units from KiB to k
	top_name_width = 21,				-- width for $top name value default 15
	top_name_verbose = false,			-- If true, top name shows the full command line of  each  process - Default value is false.
	uppercase = false,					-- uppercase or not
	use_spacer = 'none',				-- adds spaces around certain objects to align - default none
	use_xft = true,						-- xft font - anti-aliased font
	xftalpha = 1,						-- alpha of the xft font - between 0-1

	--Windows

	own_window = true,					-- create your own window to draw
	own_window_argb_value = 100,		-- real transparency - composite manager required 0-255
	own_window_argb_visual = true,		-- use ARGB - composite manager required
	own_window_colour = '#000000',		-- set colour if own_window_transparent no
	own_window_transparent = false,		-- if own_window_argb_visual is true sets background opacity 0%
	own_window_title = 'system_conky',	-- set the name manually  - default conky "hostname"
	own_window_type = 'desktop',		-- if own_window true options are: normal/override/dock/desktop/panel
	
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',  -- if own_window true - just hints - own_window_type sets it


	--Colours

	default_color = '#d3dae3',  				-- default color and border color
	color1 = '#16A085',
	color2 = '#64a5d1',
	color5 = '#3498db',

};

function split (inputstr, sep)
	local t = {}

	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

fileRead = false
file = io.open("events", "rb")

if file then
	events = ""
	for line in file:lines() do 
		splited = split(line, ";")
		if splited[3] ~= nil then
			fileRead = true
			events = "${offset 30}"..splited[1].."${goto 95}"..splited[2].."${goto 150}"..splited[3].."\n"..events
		end
	end
	events = "${color2}${offset 30}From${goto 95}To${goto 150}Subject${color}\n"..events
end

if not fileRead then
	events = "${color2}${offset 30}No Events for to day :)"
end

conky.text = [[
${color6}${voffset 4}${font GE Inspira:size=40}${alignc}${time %l}:${time %M} ${time %p}${font}${color}
${color6}${voffset 4}${font GE Inspira:size=12}${alignc}${time %A} ${time %B} ${time %e}, ${time %Y}${font}${color}

${color5}${font Roboto:size=10}${voffset 2}S Y S T E M   ${hr 2}${font}${color}
${color2}Kernel:${color}${alignr}${exec uname} ${exec uname -r}
#Nvidia: ${alignr}${execp  nvidia-smi --query-supported-clocks=gpu_name --format=csv,noheader}
#Nvidia Driver: ${alignr}${execi 60000 nvidia-smi | grep "Driver Version"| awk {'print $3'}}
${color2}Uptime:${color} ${alignr}${uptime}
${color2}CPU Freq:${color} $alignr${freq} MHz
${color2}CPU Temp:${color} $alignr${execi 10 sensors | grep 'Core 0' | awk {'print $3'}}

${color2}CPU Cores:${color} 
${cpu cpu1}%${goto 55}${cpubar cpu1} ${alignr}${offset -10}${cpu cpu7}%${alignr}${cpubar cpu7}
${cpu cpu2}%${goto 55}${cpubar cpu2} ${alignr}${offset -10}${cpu cpu8}%${alignr}${cpubar cpu8}
${cpu cpu3}%${goto 55}${cpubar cpu3} ${alignr}${offset -10}${cpu cpu9}%${alignr}${cpubar cpu9}
${cpu cpu4}%${goto 55}${cpubar cpu4} ${alignr}${offset -10}${cpu cpu10}%${alignr}${cpubar cpu10}
${cpu cpu5}%${goto 55}${cpubar cpu5} ${alignr}${offset -10}${cpu cpu11}%${alignr}${cpubar cpu11}
${cpu cpu6}%${goto 55}${cpubar cpu6} ${alignr}${offset -10}${cpu cpu12}%${alignr}${cpubar cpu12}

${color5}${font Roboto:size=10}M E M O R Y   ${hr 2}${font}${color}
${color2}${offset 30}RAM: ${color} ${alignr}${offset -10}${mem} / ${memmax}${alignr}${membar}
${color2}${offset 30}Swap:${color} ${alignr}${offset -10}${swap} / ${swapmax}${alignr}${swapbar}

${color2}Top Processes${goto 222}cpu%${goto 274}mem%${color}
${voffset 4}     1  -  ${top_mem name 1}${alignr}${goto 170} ${goto 222}${top_mem cpu 1} ${goto 274}${top_mem mem 1}
     2  -  ${top_mem name 2}${alignr}${goto 170} ${goto 222}${top_mem cpu 2} ${goto 274}${top_mem mem 2}
     3  -  ${top_mem name 3}${alignr}${goto 170} ${goto 222}${top_mem cpu 3} ${goto 274}${top_mem mem 3}
     4  -  ${top_mem name 4}${alignr}${goto 170} ${goto 222}${top_mem cpu 4} ${goto 274}${top_mem mem 4}
     5  -  ${top_mem name 5}${alignr}${goto 170} ${goto 222}${top_mem cpu 5} ${goto 274}${top_mem mem 5}

${color5}${font Roboto:size=10}D R I V E S   ${hr 2}${font}${color}
${offset 30}${color2}Root  -  SSD:${color} ${alignr}${offset -10}${fs_used /} / ${fs_size /}${alignr}${fs_bar}
${offset 30}${color2}I/O Read:${color} ${alignr}${offset -10}${diskio_read /dev/sda6}${alignr}${diskiograph_read sda6 8,100}
${offset 30}${color2}I/O Write:${color} ${alignr}${offset -10}${diskio_write /dev/sda6}${alignr}${diskiograph_write sda6 8,100}

${offset 30}${color2}Home :${color} ${alignr}${offset -10}${fs_used /home} / ${fs_size /home}${alignr}${fs_bar}
${offset 30}${color2}I/O Read:${color} ${alignr}${offset -10}${diskio_read /dev/sdb3}${alignr}${diskiograph_read sdb3 8,100}
${offset 30}${color2}I/O Write:${color} ${alignr}${offset -10}${diskio_write /dev/sdb3}${alignr}${diskiograph_write sdb3 8,100}

${color5}${color5}${font Roboto:size=10}N E T W O R K   ${hr 2}${font}${color}
${color2}${offset 30}IP Address: ${color} ${alignr}${offset -10$}${addrs eno1}
${color2}${offset 30}Eth Up:${color} ${alignr}${offset -10$}${upspeed eno1}${alignr}${upspeedgraph eno1 8,100}
${color2}${offset 30}Eth Down:${color} ${alignr}${offset -10$}${downspeed eno1}${alignr}${downspeedgraph eno1 8,100}

${color5}${color5}${font Roboto:size=10}G R A P H I C S   ${hr 2}${font}${color}
${offset 30}${color2}GPU Temp:${color} ${alignr}+${execi 60 nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader} °C
${offset 30}${color2}GPU Clock:${color} ${alignr}${execi 60 nvidia-settings -q GPUCurrentClockFreqs | grep -m 1 Attribute | awk '{print $4}' | sed -e 's/\.//' | cut -d, -f1} MHz

${color5}${color5}${font Roboto:size=10}E V E N T S   ${hr 2}${font}${color}

]] .. events;
