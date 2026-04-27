class Codemarp < Formula
  include Language::Python::Virtualenv

  desc "Visualize code architecture, call graphs, and control flow"
  homepage "https://github.com/haddyadnan/codemarp"
  url "https://github.com/haddyadnan/codemarp/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "ee613843671fec9087e5566c3d9d660eed8aa89e22b9cc33fd9c13892a0d90e3"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/codemarp", "--help"
  end
end
