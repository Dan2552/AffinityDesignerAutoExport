# AffinityDesignerAutoExport

Automate exporting of assets from Affinity Designer.

Opens Affinity Designer and automatically exports a PNG. This is achieved by opening the app, and controlling mouse using movements and keypresses via osascript and cliclick.

Notes:

- `Requires System Preferences` => `Security & Privacy` => `Accessibility` => `Terminal` to be enabled
- Using this will clear all saved Affinity Designer app preferences (everything will be reset to default settings)

##Example usage:

```ruby
input = "/path/to/asset.afdesign"
out_target_directory = "/path/to/output"
out_filename = "asset.png"
size = { width: 128, height: 128 }

exporter = AffinityDesigner::Export.new(input, out_target_directory, out_filename)
exporter.export(size[:width], size[:height])
```
