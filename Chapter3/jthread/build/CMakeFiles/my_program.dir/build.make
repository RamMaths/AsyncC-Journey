# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.31

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/build

# Include any dependencies generated for this target.
include CMakeFiles/my_program.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/my_program.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/my_program.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/my_program.dir/flags.make

CMakeFiles/my_program.dir/codegen:
.PHONY : CMakeFiles/my_program.dir/codegen

CMakeFiles/my_program.dir/jthread.cpp.o: CMakeFiles/my_program.dir/flags.make
CMakeFiles/my_program.dir/jthread.cpp.o: /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/jthread.cpp
CMakeFiles/my_program.dir/jthread.cpp.o: CMakeFiles/my_program.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/my_program.dir/jthread.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/my_program.dir/jthread.cpp.o -MF CMakeFiles/my_program.dir/jthread.cpp.o.d -o CMakeFiles/my_program.dir/jthread.cpp.o -c /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/jthread.cpp

CMakeFiles/my_program.dir/jthread.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/my_program.dir/jthread.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/jthread.cpp > CMakeFiles/my_program.dir/jthread.cpp.i

CMakeFiles/my_program.dir/jthread.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/my_program.dir/jthread.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/jthread.cpp -o CMakeFiles/my_program.dir/jthread.cpp.s

# Object files for target my_program
my_program_OBJECTS = \
"CMakeFiles/my_program.dir/jthread.cpp.o"

# External object files for target my_program
my_program_EXTERNAL_OBJECTS =

my_program: CMakeFiles/my_program.dir/jthread.cpp.o
my_program: CMakeFiles/my_program.dir/build.make
my_program: CMakeFiles/my_program.dir/compiler_depend.ts
my_program: CMakeFiles/my_program.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable my_program"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/my_program.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/my_program.dir/build: my_program
.PHONY : CMakeFiles/my_program.dir/build

CMakeFiles/my_program.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/my_program.dir/cmake_clean.cmake
.PHONY : CMakeFiles/my_program.dir/clean

CMakeFiles/my_program.dir/depend:
	cd /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/build /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/build /home/ram/Documents/Programming/c++/AsyncC++Journey/Chapter3/jthread/build/CMakeFiles/my_program.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/my_program.dir/depend

