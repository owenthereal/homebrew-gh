require "formula"
require "tmpdir"

class Gh < Formula
  VERSION = "1.0.0"
  SOURCE_SHA1 = "f8a1b726f0b7f7a263004628e1ebc2828aad4b2a"
  BOTTLE_SHA1 = "005547557e9c0290e561d2238996bb96cff9eb78"

  homepage "https://github.com/jingweno/gh"
  url "https://github.com/jingweno/gh/archive/v#{VERSION}.zip"
  sha1 SOURCE_SHA1
  head "https://github.com/jingweno/gh.git"

  bottle do
    root_url "https://github.com/jingweno/gh/releases/download/v#{VERSION}"
    prefix :any
    cellar :any
    sha1 BOTTLE_SHA1 => :mavericks
  end

  depends_on "go" => :build

  def install
    gopath = Dir.mktmpdir("gh-")
    ENV["GOPATH"] = "#{gopath}:#{File.join(FileUtils.pwd, "Godeps", "_workspace")}"

    gh_source_dir = File.join(gopath, "src", "github.com", "jingweno", "gh")
    FileUtils.mkdir_p gh_source_dir
    FileUtils.cp_r File.join(FileUtils.pwd, "."), gh_source_dir

    system "go", "build", "-o", "gh"

    bin.install "gh"
    bash_completion.install "etc/gh.bash_completion.sh"
    zsh_completion.install "etc/gh.zsh_completion" => "_gh"
  end

  def caveats; <<-EOS.undent
  To upgrade gh, run `brew update` and `brew upgrade gh`

  More information here: https://github.com/jingweno/gh/blob/master/README.md
    EOS
  end

  test do
    assert_equal VERSION, `#{bin}/gh version`.split.last
  end
end
