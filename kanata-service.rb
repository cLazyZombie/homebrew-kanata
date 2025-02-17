class KanataService < Formula
  desc "Keyboard remapping tool for macOS and Linux"
  homepage "https://github.com/jtroo/kanata"
  url "https://github.com/jtroo/kanata/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "396a379d7620001531b856913a2677baa56fa16c5c9d329f6937dfb57d3ac704"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  service do
    run [opt_bin/"kanata", "-f", "#{Dir.home}/.config/kanata.kbd"]
    keep_alive true
    run_at_load true
    error_log_path var/"log/kanata.log"
    log_path var/"log/kanata.log"
  end

  test do
    system "#{bin}/kanata", "--version"
  end
end
