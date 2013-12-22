require "formula"

class Gh < Formula
  VERSION = "1.0.0"
  ARCH = if MacOS.prefer_64_bit?
           "amd64"
         else
           "386"
         end
  SHA1 = if MacOS.prefer_64_bit?
           "d7f7f30703ce9a24f9c588cb3d7df5d727c11e10"
         else
           "c297a727b430864782307afdc87863bd8da23f45 "
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
