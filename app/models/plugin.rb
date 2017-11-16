module WPScan
  # WordPress Plugin
  class Plugin < WpItem
    # See WpItem
    def initialize(slug, target, opts = {})
      super(slug, target, opts)

      @uri = Addressable::URI.parse(target.url("wp-content/plugins/#{slug}/"))
    end

    # @return [ JSON ]
    def db_data
      DB::Plugin.db_data(slug)
    end

    # @param [ Hash ] opts
    #
    # @return [ WPScan::Version, false ]
    def version(opts = {})
      @version = Finders::PluginVersion::Base.find(self, version_detection_opts.merge(opts)) if @version.nil?

      @version
    end
  end
end
