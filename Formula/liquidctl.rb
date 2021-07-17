class Liquidctl < Formula
  include Language::Python::Virtualenv

  desc "Cross-platform tool and drivers for liquid coolers and other devices"
  homepage "https://github.com/jonasmalacofilho/liquidctl"
  url "https://files.pythonhosted.org/packages/cb/53/6edf9da254d2e80580b116c45a7c50edaf055917bf6d771185a5adf52d2a/liquidctl-1.7.1.tar.gz"
  sha256 "10f650b9486ddac184330940550433685ae0abc70b66fe92d994042491aab356"
  license "GPL-3.0-or-later"
  head "https://github.com/jonasmalacofilho/liquidctl.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bf3bec6b1f8be19d0de4e4ef7bb9af2051934a15495bb6e45bc0b63ec0087abf"
    sha256 cellar: :any_skip_relocation, big_sur:       "a089eb2685330ac3bf1322eb906d47c6177e3e5a77b364ad0816bd7cb9649017"
    sha256 cellar: :any_skip_relocation, catalina:      "eedcdcf5295a3f17a13ab6d6036d450084d2d4d68630869446fab21e31be43ba"
    sha256 cellar: :any_skip_relocation, mojave:        "5e99343a6a073c75bb90bc9fa648742375e55cf8429a16aaa6a367a2479baeab"
  end

  depends_on "libusb"
  depends_on "python@3.9"

  resource "colorlog" do
    url "https://files.pythonhosted.org/packages/07/d4/ac5127f7d7e022caf740b9f624e5b9fe9a69fefc0f4f9c047b1e9298c87a/colorlog-5.0.1.tar.gz"
    sha256 "f17c013a06962b02f4449ee07cfdbe6b287df29efc2c9a1515b4a376f4e588ea"
  end

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "hidapi" do
    url "https://files.pythonhosted.org/packages/99/9b/5c41756461308a5b2d8dcbcd6eaa2f1c1bc60f0a6aa743b58cab756a92e1/hidapi-0.10.1.tar.gz"
    sha256 "a1170b18050bc57fae3840a51084e8252fd319c0fc6043d68c8501deb0e25846"
  end

  resource "pyusb" do
    url "https://files.pythonhosted.org/packages/d9/6e/433a5614132576289b8643fe598dd5d51b16e130fd591564be952e15bb45/pyusb-1.2.1.tar.gz"
    sha256 "a4cc7404a203144754164b8b40994e2849fde1cfff06b08492f12fff9d9de7b9"
  end

  def install
    # customize liquidctl --version
    ENV["DIST_NAME"] = "homebrew"
    ENV["DIST_PACKAGE"] = "liquidctl #{version}"

    virtualenv_install_with_resources

    man_page = buildpath/"liquidctl.8"
    # setting the is_macos register to 1 adjusts the man page for macOS
    inreplace man_page, ".nr is_macos 0", ".nr is_macos 1"
    man.mkpath
    man8.install man_page
  end

  test do
    shell_output "#{bin}/liquidctl list --verbose --debug"
  end
end
