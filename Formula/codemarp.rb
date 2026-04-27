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

  resource "tree-sitter-typescript" do
    url "https://files.pythonhosted.org/packages/1e/fc/bb52958f7e399250aee093751e9373a6311cadbe76b6e0d109b853757f35/tree_sitter_typescript-0.23.2.tar.gz"
    sha256 "7b167b5827c882261cb7a50dfa0fb567975f9b315e87ed87ad0a0a3aedb3834d"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/codemarp", "--help"
  end
end
