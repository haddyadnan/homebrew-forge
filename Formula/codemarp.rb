class Codemarp < Formula
  include Language::Python::Virtualenv

  desc "Visualize code architecture, call graphs, and control flow"
  homepage "https://github.com/haddyadnan/codemarp"
  url "https://github.com/haddyadnan/codemarp/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "dce6573ef4e1ad6c2e88c7093f70bf4b0f0881d71f237890a8f6ef520e9ce5ca"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/codemarp", "--help"
  end
end
