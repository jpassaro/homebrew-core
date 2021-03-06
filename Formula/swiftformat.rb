class Swiftformat < Formula
  desc "Formatting tool for reformatting Swift code"
  homepage "https://github.com/nicklockwood/SwiftFormat"
  url "https://github.com/nicklockwood/SwiftFormat/archive/0.47.6.tar.gz"
  sha256 "40a1edd87d4ce8b8d36c39a519c29ec9272ffa57608d43ac0f9e58d136095be1"
  license "MIT"
  head "https://github.com/nicklockwood/SwiftFormat.git", shallow: false

  bottle do
    cellar :any_skip_relocation
    sha256 "29a56a0421198b902842633475fac6a866c3d5ab9910224b7c14818e98f9cd0f" => :big_sur
    sha256 "288ad66b0fc5a72233d6d85201adebc3bc92171b7aaeb2c3e83ff0d4decde9ae" => :catalina
    sha256 "4942628e3374b8e1f2224abdcf7f66c7b93797d07d93c1b5b0ef395a28096cdd" => :mojave
  end

  depends_on xcode: ["10.1", :build]

  def install
    xcodebuild "-project",
        "SwiftFormat.xcodeproj",
        "-scheme", "SwiftFormat (Command Line Tool)",
        "CODE_SIGN_IDENTITY=",
        "SYMROOT=build", "OBJROOT=build"
    bin.install "build/Release/swiftformat"
  end

  test do
    (testpath/"potato.swift").write <<~EOS
      struct Potato {
        let baked: Bool
      }
    EOS
    system "#{bin}/swiftformat", "#{testpath}/potato.swift"
  end
end
