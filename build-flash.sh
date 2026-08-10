#!/usr/bin/env bash

set -euo pipefail

usage() {
    cat <<'EOF'
Usage:
  ./build-flash.sh SOURCE.S
  ./build-flash.sh --flash PORT SOURCE.S

Examples:
  ./build-flash.sh blink.S
  ./build-flash.sh --flash /dev/ttyACM0 blink.S

The first form only builds the program. The second form builds it and then
uploads the generated HEX file to an Arduino Uno R3.
EOF
}

flash_port=""
source_file=""

while (($# > 0)); do
    case "$1" in
        --flash)
            if (($# < 2)); then
                echo "error: --flash requires a serial port" >&2
                usage >&2
                exit 2
            fi
            flash_port="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        -*)
            echo "error: unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
        *)
            if [[ -n "$source_file" ]]; then
                echo "error: provide exactly one source file" >&2
                usage >&2
                exit 2
            fi
            source_file="$1"
            shift
            ;;
    esac
done

if [[ -z "$source_file" ]]; then
    echo "error: missing AVR assembly source file" >&2
    usage >&2
    exit 2
fi

if [[ ! -f "$source_file" ]]; then
    echo "error: source file not found: $source_file" >&2
    exit 1
fi

case "$source_file" in
    *.S|*.s) ;;
    *)
        echo "error: source file must end in .S or .s" >&2
        exit 1
        ;;
esac

for tool in avr-gcc avr-objcopy avr-size; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "error: required tool is unavailable: $tool" >&2
        exit 1
    fi
done

source_dir="$(cd -- "$(dirname -- "$source_file")" && pwd)"
source_name="$(basename -- "$source_file")"
program_name="${source_name%.*}"
source_path="$source_dir/$source_name"
build_dir="$source_dir/build"
object_file="$build_dir/$program_name.o"
elf_file="$build_dir/$program_name.elf"
hex_file="$build_dir/$program_name.hex"
mcu="atmega328p"

mkdir -p -- "$build_dir"

echo "Assembling $source_name for $mcu..."
avr-gcc -mmcu="$mcu" -x assembler-with-cpp -c "$source_path" -o "$object_file"

echo "Linking $elf_file..."
avr-gcc -mmcu="$mcu" -nostartfiles -nostdlib "$object_file" -o "$elf_file"

echo "Creating $hex_file..."
avr-objcopy -O ihex -R .eeprom "$elf_file" "$hex_file"

avr-size "$elf_file"
echo "Build complete: $hex_file"

if [[ -z "$flash_port" ]]; then
    echo "Not flashing. Use --flash PORT when you are ready."
    exit 0
fi

if ! command -v avrdude >/dev/null 2>&1; then
    echo "error: required flashing tool is unavailable: avrdude" >&2
    exit 1
fi

if [[ ! -c "$flash_port" ]]; then
    echo "error: serial port is not a character device: $flash_port" >&2
    exit 1
fi

echo "Flashing $hex_file through $flash_port..."
avrdude \
    -p "$mcu" \
    -c arduino \
    -P "$flash_port" \
    -b 115200 \
    -D \
    -U "flash:w:$hex_file:i"

echo "Flash complete."
