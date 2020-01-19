require 'imlib2'

function hexa_to_rgb(color, alpha)
  -- ugh, whish this wans't an oneliner
  return ((color / 0x10000) % 0x100) / 255.,
  ((color / 0x100) % 0x100) / 255.,
  (color % 0x100) / 255.,
  alpha
end

function write_text(cr, def, updates)
  local font = def.font or 'Digital'
  local fontSize = def.size or 24
  local fontSlant = CAIRO_FONT_SLANT_NORMAL
  local fontWeight = CAIRO_FONT_WEIGHT_NORMAL
  -- if def.font[2] and def.font[2] % 2 == 1 then
  --   fontWeight = CAIRO_FONT_WEIGHT_BOLD
  -- end
  -- if def.font[2] and def.font[2] / 2 >= 1 then
  --   fontWeight = CAIRO_FONT_SLANT_ITALIC
  -- end
  cairo_select_font_face(cr, font, fontSlant, fontWeight)
  cairo_set_font_size(cr, fontSize)
  cairo_set_source_rgba(cr, hexa_to_rgb( def.color or 0x3bbafd, def.alpha or 1))
  local interval = def.interval or 1
  local text
  if updates % interval == 0 or conky_start == 1 then
    if def.sh ~= nil then
      local handle = io.popen(def.sh)
      local result = handle:read("*a")
      handle:close()
      if def.operator ~= nil then
        value = string.gsub(result, "\n", "")
        value = string.gsub(value, "-", "")
        default = def.operator['default'] or ''
        def.cache = def.operator[value] or default
      else
        def.cache = string.gsub(result, "\n", "")
      end
    else
      if def.text ~= nil then
        def.cache = def.text
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
        def.cache = tostring(value) .. def.unit
      end
    end
  end
  text = def.cache
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

function image (im)--
	x = nil
	x = (im.x or 0)
	y = nil
	y = (im.y or 0)
	w = nil
	w = (im.w or 0)
	h = nil
	h = (im.h or 0)
	file = nil
	file = tostring (im.file)
	if file == nil then print ("set image file") end
	---------------------------------------------
	local show = imlib_load_image (file)

	if show == nil then return end
	imlib_context_set_image (show)
	if tonumber (w) == 0 then
		width = imlib_image_get_width ()
	else
		width = tonumber (w)
	end

	if tonumber (h) == 0 then
		height = imlib_image_get_height ()
	else
		height = tonumber (h)
	end
	imlib_context_set_image (show)
	local scaled = imlib_create_cropped_scaled_image (0, 0,
                                                    imlib_image_get_width (),
                                                    imlib_image_get_height (),
                                                    width, height)
	imlib_free_image ()
	imlib_context_set_image (scaled)
	imlib_render_image_on_drawable (x, y)
	imlib_free_image ()
	show = nil
end
