#!/bin/bash

IMAGE_NAME="build_go_project"

# Default parameters
WORKSPACE="$(pwd)"
OS=$(uname -s | tr "[:upper:]" "[:lower:]")
ARCH=$(uname -m)

# Parse parameters
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -w|--workspace) WORKSPACE="$2"; shift ;;
        -O|--os) OS="$2"; shift ;;
        -a|--architecture) ARCH="$2"; shift ;;
        -h|--help)
            echo "Usage: $0 [-h,--help] [-w,--workspace <workspace>] [-O,--os <os>] [-a,--architecture <architecture>]"
            echo ""
            echo "  -w, --workspace    Set the workspace directory (default: current directory)"
            echo "  -O, --os           Set the operating system (default: current OS)"
            echo "  -a, --architecture Set the architecture (default: current architecture)"
            echo "  -h, --help         Show this help message"
            echo ""
            exit 0
            ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

echo "[+] Starting build Go Project docker with parameters:"
echo "  | WORKSPACE: ${WORKSPACE}"
echo "  | OS: ${OS}"
echo "  | ARCH: ${ARCH}"
echo ""

docker run \
    --rm \
    -v "${WORKSPACE}:/workspace" \
    -it ${IMAGE_NAME}:latest \
    ${OS} ${ARCH}
