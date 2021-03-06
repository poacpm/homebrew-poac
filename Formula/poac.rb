class Poac < Formula
  desc "Package manager for C++"
  homepage "https://github.com/poacpm"
  head "https://github.com/poacpm/poac.git", :branch => "main"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "openssl"
  depends_on "libarchive"
  depends_on "libgit2"

  def install
    mkdir "bulid" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end

    man1.install Dir["src/etc/man/man1/*.1"]
    cp "src/etc/poac.bash", "src/etc/poac.zsh"
    bash_completion.install "src/etc/poac.bash" => "poac"
    zsh_completion.install "src/etc/poac.zsh" => "_poac"
  end

  test do
    assert_match /SYNOPSIS/, shell_output("#{bin}/poac --help")
  end
end
