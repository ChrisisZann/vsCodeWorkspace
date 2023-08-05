#!/bin/bash


# Setup Directories
export LIB_DIR="../lib"

# Include Libs
source "$LIB_DIR/print_lib.sh"

print_red "Hello Red World!!"
for color in {30..37}
do
    print_with_color $color "Hello Colored World!! $color"
done
print_red "another one!!"

for color in {0..255}
do
    print_with_color_8bit $color "Hello Colored World!! $color"
done

# Too long to print all colors
# for r in {0..255}
# do
#     for g in {0..255}
#     do
#         for b in {0..255}
#         do
#             print_with_color_16bit $r $g $b "Hello Colored World!! $r $g $b"
#         done
#     done
# done