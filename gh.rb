require "formula"

class Gh < Formula
  VERSION = "0.26.0"
  ARCH = if MacOS.prefer_64_bit?
           "amd64"
         else
           "386"
         end
  SHA1 = if MacOS.prefer_64_bit?
           "f7f5fe32d9c96ed2b134bdb18671602255458874"
         else
           "0f2cd7d0408ef8398576b2fbb7504f8a21b8eac3"
         end

  homepage "https://github.com/jingweno/gh"
  head "https://github.com/jingweno/gh.git"
  url "https://github.com/jingweno/gh/releases/download/v#{VERSION}/gh_#{VERSION}-snapshot_darwin_#{ARCH}.zip"
  sha1 SHA1
  version VERSION

  def install
    bin.install "gh"
    bash_completion.install "gh.bash_completion.sh"
    zsh_completion.install "gh.zsh_completion" => "_gh"
  end

  def caveats; <<-EOS.undent
  To upgrade gh, run `brew upgrade https://raw.github.com/jingweno/gh/master/homebrew/gh.rb`

  More information here: https://github.com/jingweno/gh/blob/master/README.md
    EOS
  end

  test do
    assert_equal VERSION, `#{bin}/gh version`.split.last
  end
end
