class Codemarp < Formula
  include Language::Python::Virtualenv

  desc "Visualize code architecture, call graphs, and control flow"
  homepage "https://github.com/haddyadnan/codemarp"
  url "https://github.com/haddyadnan/codemarp/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "ee613843671fec9087e5566c3d9d660eed8aa89e22b9cc33fd9c13892a0d90e3"
  license "MIT"

  depends_on "python@3.12"

  resource "tree-sitter" do
    url "https://files.pythonhosted.org/packages/66/7c/0350cfc47faadc0d3cf7d8237a4e34032b3014ddf4a12ded9933e1648b55/tree-sitter-0.25.2.tar.gz"
    sha256 "fe43c158555da46723b28b52e058ad444195afd1db3ca7720c59a254544e9c20"
  end

  resource "tree-sitter-python" do
    url "https://files.pythonhosted.org/packages/b8/8b/c992ff0e768cb6768d5c96234579bf8842b3a633db641455d86dd30d5dac/tree_sitter_python-0.25.0.tar.gz"
    sha256 "b13e090f725f5b9c86aa455a268553c65cadf325471ad5b65cd29cac8a1a68ac"
  end

  on_arm do
    resource "tree-sitter-typescript" do
      url "https://files.pythonhosted.org/packages/8f/2f/1f36fda564518d84593f2740d5905ac127d590baf5c5753cef2a88a89c15/tree_sitter_typescript-0.23.2-cp39-abi3-macosx_11_0_arm64.whl"
      sha256 "c7cc1b0ff5d91bac863b0e38b1578d5505e718156c9db577c8baea2557f66de8"
    end
  end

  on_intel do
    resource "tree-sitter-typescript" do
      url "https://files.pythonhosted.org/packages/28/95/4c00680866280e008e81dd621fd4d3f54aa3dad1b76b857a19da1b2cc426/tree_sitter_typescript-0.23.2-cp39-abi3-macosx_10_9_x86_64.whl"
      sha256 "3cd752d70d8e5371fdac6a9a4df9d8924b63b6998d268586f7d374c9fba2a478"
    end
  end

  def install
    venv = virtualenv_create(libexec, "python3.12")

    venv.pip_install resource("tree-sitter")
    venv.pip_install resource("tree-sitter-python")

    resource("tree-sitter-typescript").stage do
      wheel = Pathname.pwd/Dir["*.whl"].fetch
      system libexec/"bin/python", "-m", "pip", "install", "--no-deps", "--no-index", wheel
    end

    venv.pip_install_and_link buildpath
  end


    venv.pip_install_and_link buildpath
  end



  test do
    system "#{bin}/codemarp", "--version"
  end
end
