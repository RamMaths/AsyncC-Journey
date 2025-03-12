# CMakeLists.txt
cmake_minimum_required(VERSION 3.10)  # Specify the minimum CMake version

project(yield_thread)  # Name of your project

set(CMAKE_CXX_STANDARD 20)  # Set the C++ standard to C++20
set(CMAKE_CXX_STANDARD_REQUIRED ON)  # Require the specified C++ standard

# Add your source files here
add_executable(my_program yield_thread.cpp)
