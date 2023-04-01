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
ALL_CCFLAGS += --std=c++14

ECHOORNO=0

# Target rules
all: build

build: sim_PGSE

check.deps:
ifeq ($(ECHOORNO), 0)
	@echo "Sample will be waived due to the above missing dependencies"
else
	@echo "Sample is ready - all dependencies have been met"
endif

sim_PGSE.o:main_PGSE.cu
	$(EXEC) $(NVCC) $(ALL_CCFLAGS) -o $@ -c $<

sim_PGSE: sim_PGSE.o
	$(EXEC) $(NVCC) $(ALL_LDFLAGS) -o $@ $+
	$(EXEC) mkdir -p ../../../bin/$(BUILD_TYPE)
	$(EXEC) cp $@ ../../../bin/$(BUILD_TYPE)

run: build
	$(EXEC) ./sim_PGSE

testrun: build

clean:
	rm -f sim_PGSE sim_PGSE.o
	rm -rf ../../../bin/$(BUILD_TYPE)/sim_PGSE

clobber: clean
