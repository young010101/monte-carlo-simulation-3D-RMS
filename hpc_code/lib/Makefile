NVCC          := nvcc

# internal flags
NVCCFLAGS   :=

# Debug build flags
ifeq ($(dbg),1)
      NVCCFLAGS += -g -G
      BUILD_TYPE := debug
else
      BUILD_TYPE := release
endif

ALL_CCFLAGS :=
ALL_CCFLAGS += $(NVCCFLAGS)
ALL_CCFLAGS += --std=c++14 -Iinclude


SRCS := src/Simparams.cpp src/main_PGSE.cu src/save_results.cu
OBGS := $(SRCS:%.cpp=%.o)
OBGS := $(OBGS:%.cu=%.o)
BINS := $(SRCS:%.cpp=%) $(SRCS:%.cu=%)



TARGET = sim_PGSE

ECHOORNO=0

# Target rules
all: build

build: $(TARGET)

check.deps:
ifeq ($(ECHOORNO), 0)
	@echo $(OBGS)
else
	@echo "Sample is ready - all dependencies have been met"
endif

%.o:%.cu
	$(NVCC) $(ALL_CCFLAGS) -o $@ -c $<

%.o:%.cpp
	$(NVCC) $(ALL_CCFLAGS) -o $@ -c $<

$(TARGET): $(OBGS)
	$(NVCC) $(ALL_LDFLAGS) -o $@ $+
	mkdir -p ../../../bin/$(BUILD_TYPE)
	cp $@ ../../../bin/$(BUILD_TYPE)

run: build
	./$(TARGET)

testrun: build

clean:
	rm -f $(TARGET) $(OBGS)
	rm -rf ../../../bin/$(BUILD_TYPE)/$(TARGET)

clobber: clean
