CC = gcc
CFLAGS = -Wall -Werror

SRC_DIR = src
TEST_DIR = tests
BUILD_DIR = build

SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
TEST_FILES = $(wildcard $(TEST_DIR)/*.c)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRC_FILES))
TEST_OBJ_FILES = $(patsubst $(TEST_DIR)/%.c,$(BUILD_DIR)/%.o,$(TEST_FILES))

TARGET = my_program
TEST_TARGET = test_program

.PHONY: all clean build test

all: build test

build: $(BUILD_DIR) $(BUILD_DIR)/$(TARGET)

test: build $(BUILD_DIR)/$(TEST_TARGET)
	./$(BUILD_DIR)/$(TEST_TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/$(TARGET): $(OBJ_FILES)
	$(CC) $(CFLAGS) -o $@ $^

$(BUILD_DIR)/$(TEST_TARGET): $(TEST_OBJ_FILES) $(filter-out $(BUILD_DIR)/main.o, $(OBJ_FILES))
	$(CC) $(CFLAGS) -o $@ $^

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: $(TEST_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf $(BUILD_DIR)
