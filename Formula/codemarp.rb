class Codemarp < Formula
  include Language::Python::Virtualenv

  desc "Visualize code architecture, call graphs, and control flow"
  homepage "https://github.com/haddyadnan/codemarp"
  url "https://github.com/haddyadnan/codemarp/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "df8a621c1d9f2518e729f1d451658be509ce5902f8ab687cf689fc4a77b7850c"
  license "MIT"

  depends_on "python@3.12"

  resource "tree-sitter" do
    url "https://files.pythonhosted.org/packages/66/7c/0350cfc47faadc0d3cf7d8237a4e34032b3014ddf4a12ded9933e1648b55/tree-sitter-0.25.2.tar.gz"
    sha256 "fe43c158555da46723b28b52e058ad444195afd1db3ca7720c59a254544e9c20"
  end

  on_arm do
    resource "tree-sitter-python" do
      url "https://files.pythonhosted.org/packages/e6/1d/60d8c2a0cc63d6ec4ba4e99ce61b802d2e39ef9db799bdf2a8f932a6cd4b/tree_sitter_python-0.25.0-cp310-abi3-macosx_11_0_arm64.whl"
      sha256 "480c21dbd995b7fe44813e741d71fed10ba695e7caab627fb034e3828469d762"
    end

    resource "tree-sitter-typescript" do
      url "https://files.pythonhosted.org/packages/8f/2f/1f36fda564518d84593f2740d5905ac127d590baf5c5753cef2a88a89c15/tree_sitter_typescript-0.23.2-cp39-abi3-macosx_11_0_arm64.whl"
      sha256 "c7cc1b0ff5d91bac863b0e38b1578d5505e718156c9db577c8baea2557f66de8"
    end
  end

  on_intel do
    resource "tree-sitter-python" do
      url "https://files.pythonhosted.org/packages/cf/64/a4e503c78a4eb3ac46d8e72a29c1b1237fa85238d8e972b063e0751f5a94/tree_sitter_python-0.25.0-cp310-abi3-macosx_10_9_x86_64.whl"
      sha256 "14a79a47ddef72f987d5a2c122d148a812169d7484ff5c75a3db9609d419f361"
    end

    resource "tree-sitter-typescript" do
      url "https://files.pythonhosted.org/packages/28/95/4c00680866280e008e81dd621fd4d3f54aa3dad1b76b857a19da1b2cc426/tree_sitter_typescript-0.23.2-cp39-abi3-macosx_10_9_x86_64.whl"
      sha256 "3cd752d70d8e5371fdac6a9a4df9d8924b63b6998d268586f7d374c9fba2a478"
    end
  end

  def install
    venv = virtualenv_create(libexec, "python3.12")

    venv.pip_install resource("tree-sitter")

    ["tree-sitter-python", "tree-sitter-typescript"].each do |name|
      resource(name).stage do
        wheel = Dir["*.whl"].first
        raise "#{name} wheel not found" if wheel.nil?

        system libexec/"bin/python", "-m", "pip", "install", "--no-deps", "--no-index", Pathname.pwd/wheel
      end
    end

    venv.pip_install_and_link buildpath
  end

  test do
    system "#{bin}/codemarp", "--version"
  end
end
