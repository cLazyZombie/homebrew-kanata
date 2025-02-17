class KanataService < Formula
  desc "Keyboard remapping tool for macOS and Linux"
  homepage "https://github.com/jtroo/kanata"
  url "https://github.com/jtroo/kanata/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "396a379d7620001531b856913a2677baa56fa16c5c9d329f6937dfb57d3ac704"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  plist_options manual: "kanata -f #{ENV["HOME"]}/.config/kanata.kbd"

  def plist
    user_home = ENV["HOME"]

    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>com.user.kanata-service</string>

        <key>ProgramArguments</key>
        <array>
          <string>/opt/homebrew/bin/kanata</string>
          <string>-f</string>
          <string>#{user_home}/.config/kanata.kbd</string>
        </array>

        <key>RunAtLoad</key>
        <true/>

        <key>KeepAlive</key>
        <true/>
      </dict>
      </plist>
    EOS
  end

  test do
    system "#{bin}/kanata", "--version"
  end
end
