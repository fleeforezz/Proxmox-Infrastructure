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
if [[ ! -d "$WORKING_DIR" ]]; then
    print_error "Working directory '$WORKING_DIR' does not exist"
    exit 1
fi

# Check if terraform.tfvars exists
if [[ ! -f "$WORKING_DIR/terraform.tfvars" ]]; then
    print_warning "terraform.tfvars not found in $WORKING_DIR"
    if [[ -f "$WORKING_DIR/terraform.tfvars.example" ]]; then
        print_warning "Found terraform.tfvars.example. Please copy and configure it:"
        print_warning "cp $WORKING_DIR/terraform.tfvars.example $WORKING_DIR/terraform.tfvars"
        exit 1
    fi
fi

# Function to run terraform command with proper error handling
run_terraform() {
    local cmd="$1"
    print_status "Running: terraform $cmd"

    if [[ "$VERBOSE" == "true" ]]; then
        terraform $cmd
    else
        terraform $cmd > /tmp/terraform_output.log 2>&1 || {
            print_error "Terraform command failed. Output:"
            cat /tmp/terraform_output.log
            exit 1
        }
    fi
}

# Function to validate environment for production
validate_production() {
    if [[ "$ENVIRONMENT" == "prod" ]]; then
        print_warning "You are about to deploy to PRODUCTION environment!"
        echo -n "Are you sure you want to continue? (type 'yes' to confirm): "
        read -r confirmation
        if [[ "$confirmation" != "yes" ]]; then
            print_status "Deployment cancelled"
            exit 0
        fi
    fi
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."

    # Check if terraform is installed
    if ! command -v terraform &> /dev/null; then
        print_error "Terraform is not installed or not in PATH"
        exit 1
    fi

    # Check terraform version
    TERRAFORM_VERSION=$(terraform version -json | jq -r '.terraform_version')
    print_status "Using Terraform version: $TERRAFORM_VERSION"

    # Check if required files exist
    local required_files=("$WORKING_DIR/main.tf" "$WORKING_DIR/variables.tf")
    for file in "${required_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            print_error "Required file not found: $file"
        fi
    done

    print_success "Prerequisites check passed"
}

# Function to backup current state
backup_state() {
    if [[ -f "$WORKING_DIR/terraform.tfstate" ]]; then
        local backup_dir="$WORKING_DIR/backups"
        local timestamp=$(date + "%Y%m%d_%H%M%S")
        local backup_file="$backup_dir/terraform.tfstate.backup.$timestamp"

        mkdir -p "$backup_dir"
        cp "$WORKING_DIR/terraform.tfstate" "$backup_file"
        print_status "State backed up to: $backup_file"
    fi
}

# Main deployment function
main() {
    print_status "Starting Terraform deployment for environment: $ENVIRONMENT"
    print_status "Working directory: $WORKING_DIR"

    # Change to working directory
    cd "$WORKING_DIR"

    # Run checks
    check_prerequisites
    validate_production

    # Initialize Terraform
    print_status "Initializing Terraform..."
    run_terraform "init -upgrade"
    print_success "Terraform initialized"

    # Validate configuration
    print_status "Validating Terraform configuration..."
    run_terraform "validate"
    print_success "Configuration is valid"

    # Format check
    print_status "Checking Terraform formatting..."
    if ! terraform fmt -check=true -diff=true; then
        print_warning "Code formatting issues found. Run 'terraform fmt -recursive' to fix." 
    fi

    # Create and show plan
    print_status "Creating depoyment plan..."
    if [[ "$VERBOSE" == "true" ]]; then
        terraform plan -out=tfplan
    else
        terraform plan -out=tfplan > /tmp/terraform_plan.log 2>&1
        echo "Plan created successfully. Use -v flag to see full output."
    fi

    # If plan-only mode, stop here
    if [[ "$PLAN_ONLY" == "true" ]]; then
        print_success "Plan-only mode completed"
        if [[ "$VERBOSE" != "true" ]]; then
            print_status "Plan details:"
            cat /tmp/terraform_plan.log
        fi
        exit 0
    fi

    # Backup state before applying
    backup_state

    # Apply the plan
    if [[ "$AUTO_APPROVE" =="true" ]]; then
        print_status "Auto applying deployment plan..."
        run_terraform "apply tfplan"
    else 
        print_status "Applying deployment plan..."
        terraform apply tfplan
    fi

    # Clean up plan file
    rm -f tfplan

    print_success "Deployment completed successfully!"

    # Show outputs
    print_status "Deployment outputs:"
    terraform_output
}

# Trap to clean up on exit
trap 'rm -f tfplan /tmp/terraform_*.log' EXIT

# Run main function
main