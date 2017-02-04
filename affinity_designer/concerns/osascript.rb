module Osascript
  def tell(application, commands)
    commands = [commands] unless commands.is_a? Array
    run_osa(
      ["tell application \"#{application}\""] +
      commands +
      ["end tell"]
    )
  end

  def run_osa(collection)
    script = "osascript"
    script += collection.map { |s| " -e '#{s}'" }.join
    output = `#{script}`
    output.strip
  end
end
