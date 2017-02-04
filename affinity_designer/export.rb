module AffinityDesigner
  # Opens Affinity Designer and automatically exports a PNG. This is achieved by opening the app, and controlling mouse
  # movements and keypresses. Note: running this will clear all saved app preferences (everything will be reset to
  # default settings)
  class Export
    attr_reader :input
    attr_reader :out_target_directory
    attr_reader :out_filename

    # - parameter input: Full filepath to afdesign
    # - parameter out_target_directory: Directory to export png
    # - parameter out_filename: Filename of the png
    def initialize(input, out_target_directory, out_filename)
      @input = input
      @out_target_directory = out_target_directory
      @out_filename = out_filename
    end

    # - parameter width: PNG width
    # - parameter width: PNG height
    # - parameter skip_if_file_exists: When true, export will do nothing if target PNG already exists
    def export(width, height, skip_if_file_exists = true)
      return if skip_if_file_exists && exists?

      create_target_directory!

      app.close_app
      settings.reset
      app.open_app(input)
      sleep 10
      app.focus
      app.dismiss_popup
      app.position_and_resize_for_manipulation
      app.open_export_menu
      sleep 1
      app.export_menu_toggle_dimension_lock
      app.export_menu_fill_dimensions(width, height)
      sleep 3
      app.export_menu_export(out_target_directory, out_filename)
      sleep 10
      app.close_app
    end

    private

    def app
      @app ||= AffinityDesigner::App.new
    end

    def settings
      AffinityDesigner::Settings
    end

    def exists?
      File.exist?("#{out_target_directory}/#{out_filename}")
    end

    def create_target_directory!
      FileUtils.mkpath(out_target_directory) unless File.directory?(out_target_directory)
    end
  end
end
