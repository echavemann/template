from conan import ConanFile
from conan.tools.cmake import cmake_layout


class TemplateRecipe(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps", "CMakeToolchain"

    def requirements(self):
        self.requires("gtest/1.15.0")
        self.requires("fmt/11.1.1")

    def layout(self):
        cmake_layout(self)
