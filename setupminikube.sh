#!/bin/bash

# Colors for colorized output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


# Function to determine best memory allocation
get_best_memory() {
    # Get total system memory (in MB) using 'free' command and awk
    total_memory=$(free -m | awk '/^Mem:/{print $2}')
    
    # Assuming we'll use 75% of total memory for Minikube
    echo $(($total_memory * 25 / 100))
}
# Function to determine best CPU allocation
get_best_cpus() {
    # Get total number of CPUs using 'nproc'
    echo $(nproc)
}

# Function to start Minikube
start_minikube() {
    memory=$1
    cpus=$2
    echo -e "${GREEN}⚙️ Starting Minikube with memory: $memory""MB and CPUs: $cpus${NC}"
    minikube start --cpus $cpus --memory $memory
}

# Function to seek user's validation for continuing the process
seek_user_validation() {
    echo -e "${RED}🛑 ATTENTION!${NC}"
    echo "The following actions will be performed:"
    echo "1. 🏗️ 🐳 Docker images will be built using docker-compose."
    echo "1. 🏗️ 🐳 Docker images will be built using docker-compose."
    echo "2. ⚙️ Minikube will be started with best calculated memory and CPU allocations."
    echo "3. 🚢 The built Docker images will be loaded into Minikube."
    echo "4. 🔐 Maui secrets will be created or updated in the 'maui' namespace."
    echo "5. 📦 The deployment and service configuration will be applied to Kubernetes."
    echo ""
    read -p "Do you want to proceed? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "${RED}Operation aborted by the user.${NC}"
        exit 1
    fi
}
# Main script execution starts here
echo -e "${GREEN}Welcome to the Kubernetes setup script!${NC}"



# Seek user validation to proceed
seek_user_validation
update_deployment_file maui-data-integration_fast_api:latest

# Start Minikube
memory=$(get_best_memory)
cpus=$(get_best_cpus)
start_minikube $memory $cpus

#!/bin/bash

# Define the addons to be enabled
addons=(
    "metrics-server"
    #"ingress"
    #"efk"
    "dashboard"
    #"inspektor-gadget"
    #"metallb"
    #"helm-tiller"
)

# Enable each addon in Minikube
for addon in "${addons[@]}"; do
    echo "Enabling $addon..."
    minikube addons enable "$addon"
done

echo "All specified addons have been enabled."




# Configure Docker CLI to use Minikube's Docker daemon
echo -e "${GREEN}🚢 Configuring Docker to use Minikube's Docker daemon...${NC}"
eval $(minikube -p minikube docker-env)


# Build docker images directly into Minikube's Docker daemon
echo -e "${GREEN}🏗️ 🐳 Building Docker images directly in Minikube's Docker daemon...${NC}"
#docker build  -t test_ansible .  && docker run -it test_ansible  


echo -e "${GREEN}🚀 Kubernetes setup completed successfully!${NC}"