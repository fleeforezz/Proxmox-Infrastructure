#!/bin/bash

set -e # Exit on any error

# Default values
ENVIRONMENT="dev"
AUTO_APPROVE=false
PLAN_ONLY=false
VERBOSE=false
WORKING_DIR=""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    cat << EOF
Usage: $0 [ENVIRONMENT] [OPTIONS]

ENVIRONMENT:
    dev         Deploy to development environment (default)
    staging     Deploy to staging environment
    prod        Deploy to production environment

OPTIONS:
    -a, --auto-approve    Auto approve the apply (skip confirmation)
    -p, --plan-only       Only run terraform plan
    -v, --verbose         Enable verbose output
    -w, --working-dir     Specify working directory (default: environments/ENVIRONMENT)
    -h, --help           Show this help message

Examples:
    $0                          # Deploy to dev environment
    $0 prod                     # Deploy to production
    $0 staging --plan-only      # Only plan staging deployment
    $0 prod --auto-approve      # Deploy to prod without confirmation
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        dev|staging|prod)
            ENVIRONMENT="$1"
            shift
            ;;
        -a|--auto-approve)
            AUTO_APPROVE=true
            shift
            ;;
        -p|--plan-only)
            PLAN_ONLY=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -w|--working-dir)
            WORKING_DIR="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Set working directory if not specified
if [[ -z "$WORKING_DIR" ]]; then
    WORKING_DIR="environment/$ENVIRONMENT"
fi

# Check if woking directory exists
