module AffinityDesigner
  class Settings
    def self.reset
      FileUtils.rm_r("#{Dir.home}/Library/Containers/com.seriflabs.affinitydesigner")
      true
    rescue
      false
    end
  end
end
