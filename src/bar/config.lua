-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function ()
  -- Starts the bar
  hl.exec_cmd("" .. os.getenv("BURYOS_SHELL_BAR"))
end)
