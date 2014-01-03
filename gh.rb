require "formula"
require "tmpdir"

class Gh < Formula
  VERSION = "1.0.0"

  homepage "https://github.com/jingweno/gh"
  head "https://github.com/jingweno/gh.git"
  url "https://github.com/jingweno/gh/archive/v#{VERSION}.zip"
  sha1 "f8a1b726f0b7f7a263004628e1ebc2828aad4b2a"
  version VERSION

  depends_on "go" => :build

  def install
    gopath = ENV["GOPATH"] = Dir.mktmpdir("gh-")

    gh_source_dir = File.join(gopath, "src", "github.com", "jingweno", "gh")
    FileUtils.mkdir_p gh_source_dir
    FileUtils.cp_r File.join("#{FileUtils.pwd}", "."), gh_source_dir

    # TODO: encapsulate in a script after 1.0.0
    system "script/bootstrap"
    godep =  File.join(ENV["GOPATH"], "bin", "godep")
    system godep, "go", "build", "-o", "gh"

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
