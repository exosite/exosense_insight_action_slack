local Helpers = {}

-- Checks if an array contains a value
function Helpers.has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- Get the standard ExoSense Color from the level
function Helpers.get_color_from_level (level, category)
  local color = "good"
  if (level == 0) -- OK
  then
    color = "#0AC410"
  elseif (level == 1) -- INFO
  then
    color = "#6495ed"
  elseif (level == 2) -- WARNING
  then
    color = "#ECC800"
  elseif (level == 3 and category == "timeout")
  then
    color = "#808080"
  elseif (level == 3) -- CRITICAL
  then
    color = "#D11515"
  elseif (level == 4) -- ERROR
  then
    color = "#510633"
  end
  return color
end

-- Convert numeric level to human readable level
function Helpers.get_severity_from_level (level, category)
  local severity = "Normal"
  if (level == 0)
  then
    severity = "Normal"
  elseif (level == 1)
  then
    severity = "Info"
  elseif (level == 2)
  then
    severity = "Warning"
  elseif (level == 3 and category == "timeout")
  then
    severity = "Timeout"
  elseif (level == 3)
  then
    severity = "Critical"
  elseif (level == 4)
  then
    severity = "Error"
  end
  return severity
end


return Helpers