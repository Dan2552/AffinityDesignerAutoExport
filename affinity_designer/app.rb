require_relative "concerns/osascript"

module AffinityDesigner
  class App
    include Osascript

    def open_app(filename = "")
      system("open -a \"Affinity Designer\" -- #{filename}")
    end

    def focus
      tell "Affinity Designer", "activate"
    end

    def dismiss_popup
      tell "System Events", [
        "key code 53",
        "delay 2",
        "key code 53",
        "delay 2"
      ]
    end

    def resize(width, height)
      tell "System Events", [
        "set size of front window of application process \"Affinity Designer\" to {#{width}, #{height}}"
      ]
    end

    def position(x, y)
      tell "System Events", [
        "set position of front window of application process \"Affinity Designer\" to {#{x}, #{y}}"
      ]
    end

    def open_export_menu
      tell "System Events", "keystroke \"s\" using { command down, shift down, option down }"
    end

    def close_app
      return unless running?
      system("kill $(ps aux | grep \"[A]ffinity Designer\" | awk '{print $2;}')")
      close_app
    end

    def running?
      system("ps aux | grep \"[A]ffinity Designer\" >/dev/null")
      $?.exitstatus == 0
    end

    def export_menu_select_png
      system("cliclick c:44,130")
    end

    def export_menu_toggle_dimension_lock
      system("cliclick c:250,190")
    end

    def export_menu_fill_dimensions(width, height)
      system("cliclick c:311,190")
      tell "System Events", [
        "keystroke \"a\" using { command down }",
        "delay 0.5",
        "keystroke \"#{width}\"",
        "delay 0.5",
        "keystroke \"px\"",
        "delay 0.5",
        "keystroke tab",
        "delay 0.5",
        "keystroke \"a\" using { command down }",
        "delay 0.5",
        "keystroke \"#{height}\"",
        "delay 0.5",
        "keystroke \"px\"",
        "keystroke tab",
        "delay 1"
      ]
    end

    def export_menu_export(directory, filename)
      directory = directory[1, directory.length]
      system("cliclick c:550,380")
      sleep 4
      focus
      sleep 2
      tell "System Events", "keystroke \"/\""
      sleep 2
      focus
      sleep 1
      tell "System Events", [
        "set the clipboard to \"#{directory}\"",
        "keystroke \"v\" using { command down }",
        "delay 2",
        "keystroke return",
        "delay 8",
        "keystroke \"#{filename}\"",
        "keystroke return"
      ]
      sleep 8
    end

    def position_and_resize_for_manipulation
      resize(620, 200)
      position(0, 0)
    end
  end
end
