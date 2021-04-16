# const {
#   ignoreDefaultArgs = false,
#   args = [],
#   dumpio = false,
#   executablePath = null,
#   pipe = false,
#   env = process.env,
#   handleSIGINT = true,
#   handleSIGTERM = true,
#   handleSIGHUP = true,
#   ignoreHTTPSErrors = false,
#   defaultViewport = {width: 800, height: 600},
#   slowMo = 0,
#   timeout = 30000
# } = options;
# const {
#   devtools = false,
#   headless = !devtools,
#   args = [],
#   userDataDir = null
# } = options;

module Puppeteer::Launcher
  class LaunchOptions
    # @property {string=} executablePath
    # @property {boolean|Array<string>=} ignoreDefaultArgs
    # @property {boolean=} handleSIGINT
    # @property {boolean=} handleSIGTERM
    # @property {boolean=} handleSIGHUP
    # @property {number=} timeout
    # @property {boolean=} dumpio
    # @property {!Object<string, string | undefined>=} env
    # @property {boolean=} pipe
    def initialize(options)
      @executable_path = options[:executable_path]
      @ignore_default_args = options[:ignore_default_args] || false
      @handle_SIGINT = options[:handle_SIGINT] || true
      @handle_SIGTERM = options[:handle_SIGTERM] || true
      @handle_SIGHUP = options[:handle_SIGHUP] || true
      @timeout = options[:timeout] || 30000
      @dumpio = options[:dumpio] || false
      @env = options[:env] || ENV
      @pipe = options[:pipe] || false
    end

    attr_reader :executable_path, :ignore_default_args, :timeout, :env

    def handle_SIGINT?
      @handle_SIGINT
    end

    def handle_SIGTERM?
      @handle_SIGTERM
    end

    def handle_SIGHUP?
      @handle_SIGHUP
    end

    def dumpio?
      @dumpio
    end

    def pipe?
      @pipe
    end
  end
end
