#ifndef CONFIG_H
#define CONFIG_H

#define PATH(name) "/home/brendan/.config/scripts/blocks/" name

// String used to delimit block outputs in the status.
#define DELIMITER " | "

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 256

// Control whether blocks are clickable.
#define CLICKABLE_BLOCKS 1

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X)             \
    X("", PATH("sb-pacman"), 60, 6)  \
    X("", PATH("sb-nettraff"), 60, 1)  \
    X("", PATH("sb-gpuT"), 60, 2)   \
    X("", PATH("sb-cpuT"), 60, 3) \
    X("", PATH("sb-Mem"), 60, 4) \
    X("", PATH("sb-calendar"), 60, 5)
    // X("", , 0, 6)     \
    // X("", , 0, 7)  \
    // X("", , 0, 8)  \
    // X("", , 5, 9) \
    // X("", , 1, 10)

#endif  // CONFIG_H
