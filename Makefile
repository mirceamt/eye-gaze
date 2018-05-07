# Makefile for Project Timeline
#
# Your compiler
CXX = g++ -std=c++14

# Compilation flags
# '-g' turns debugging flags on.
# Not Using O2 flag for optimisation.
CXXFLAGS = -g -I./include -I/opt/X11/include -I/usr/X11R6/include -I/usr/X11/include/GL -I/usr/X11/include -I/usr/local/include -I./src/dlib/all/source.cpp -ljpeg -mavx -lm -lX11 -lGL -lpthread -DDLIB_HAVE_BLAS -DNDEBUG  -DDLIB_JPEG_SUPPORT -DDLIB_HAVE_AVX  -O3 `pkg-config --cflags opencv`

# Linker flags
# When you need to add a library
LDFLAGS = -ljpeg -mavx -lm -L/opt/X11/lib -lX11 -lGL -lGLU -lglut -lpthread -DDLIB_HAVE_BLAS -DNDEBUG  -DDLIB_JPEG_SUPPORT -DDLIB_HAVE_AVX  -O3 `pkg-config --libs opencv`

# all is a target
# $(VAR) gives value of the variable.
# $@ stores the target
# $^ stores the dependency
all: bin/oic

bin/oic: obj/dlib.o obj/faceDetection.o obj/pupilDetection.o obj/kalmanFilters.o obj/util.o obj/oic.o
	$(CXX) -o $@ $^ $(LDFLAGS)

obj/dlib.o: src/dlib/all/source.cpp
	mkdir -p obj bin
	$(CXX) -c $(CXXFLAGS) -o $@ $<

obj/faceDetection.o: src/faceDetection.cpp
	$(CXX) -c $(CXXFLAGS) -o $@ $<

obj/pupilDetection.o: src/pupilDetection.cpp
	$(CXX) -c $(CXXFLAGS) -o $@ $<

obj/kalmanFilters.o: src/kalmanFilters.cpp
	$(CXX) -c $(CXXFLAGS) -o $@ $<

obj/util.o: src/util.cpp
	$(CXX) -c $(CXXFLAGS) -o $@ $<

obj/oic.o: src/oic.cpp
	$(CXX) -c $(CXXFLAGS) -o $@ $<

# .PHONY tells make that 'all' or 'clean' aren't _actually_ files, and always
# execute the compilation action when 'make all' or 'make clean' are used
.PHONY: all oic

# Delete all the temporary files we've created so far
clean:
	rm -rf obj/*.o
	rm -rf bin/oic

