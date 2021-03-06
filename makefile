
CC = gcc
CFLAGS = -std=gnu99 -Wall -Wextra -shared -fPIC -ggdb
LDFLAGS = 
INCLUDE_DIR = include/
BINARY_DIR = bin/
BUILD_DIR = build/
SOURCE_DIR = source/

TARGET = Engine3D
SOURCE = $(wildcard source/*.c)
OBJECT = $(patsubst %,$(BUILD_DIR)%, $(notdir $(SOURCE:.c=.o)))

all: $(TARGET)

$(TARGET): directory $(OBJECT)
	@echo "Linking..."
	@echo "--------------------------------------------------------------------------------"
	$(CC) $(SOURCE) -I $(INCLUDE_DIR) $(CFLAGS) $(LDFLAGS) -o $(BINARY_DIR)lib$(TARGET).so
	@echo "--------------------------------------------------------------------------------"
	@echo "Finished!\n"

$(BUILD_DIR)%.o: $(SOURCE_DIR)%.c
	$(CC) -I $(INCLUDE_DIR) -c $< -o $@

directory: 
	mkdir -p $(BINARY_DIR) $(BUILD_DIR)


TEST_CFLAGS = -std=gnu99 -Wall -Wextra -ggdb
TEST_LDFLAGS = -lSDL2 -lSDL2_image -lSDL2_ttf -lm -l$(TARGET)
TEST_DIR = test/
TEST_BUILD_DIR = build/test/

test: $(TARGET)
	mkdir -p $(TEST_BUILD_DIR)
	$(CC) $(TEST_CFLAGS) -I $(INCLUDE_DIR) -c $(TEST_DIR)Main.c -o $(TEST_BUILD_DIR)Main.o
	$(CC) $(TEST_BUILD_DIR)Main.o -Wl,-rpath=$(shell pwd)/$(BINARY_DIR) -L$(BINARY_DIR) $(TEST_LDFLAGS) -o $(BINARY_DIR)Test 

clean:
	rm -rf $(BINARY_DIR) $(BUILD_DIR)
