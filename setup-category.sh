#!/bin/bash
# Setup script for specific Hailo AI demo categories

set -e

CATEGORY=$1
CURRENT_DIR=$(pwd)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Hailo AI Category Setup Script${NC}"
echo "================================="

# Function to check prerequisites
check_prerequisites() {
    echo -e "${YELLOW}Checking prerequisites...${NC}"
    
    # Check for Python
    if ! command -v python3 &> /dev/null; then
        echo -e "${RED}❌ Python3 not found${NC}"
        exit 1
    fi
    
    # Check for HailoRT
    if ! command -v hailortcli &> /dev/null; then
        echo -e "${YELLOW}⚠️  HailoRT not found - some demos may not work${NC}"
    else
        echo -e "${GREEN}✅ HailoRT detected${NC}"
        hailortcli scan 2>/dev/null || echo -e "${YELLOW}⚠️  No Hailo device found${NC}"
    fi
    
    # Check for git
    if ! command -v git &> /dev/null; then
        echo -e "${RED}❌ Git not found${NC}"
        exit 1
    fi
}

# Setup functions for each category
setup_official() {
    echo -e "${GREEN}Setting up Official Repositories...${NC}"
    cd official-repositories
    
    for repo in */; do
        if [ -d "$repo" ]; then
            echo -e "${YELLOW}Setting up $repo${NC}"
            cd "$repo"
            
            # Check for requirements.txt
            if [ -f "requirements.txt" ]; then
                pip3 install -r requirements.txt --user
            fi
            
            # Check for setup.py
            if [ -f "setup.py" ]; then
                pip3 install -e . --user
            fi
            
            cd ..
        fi
    done
    
    cd "$CURRENT_DIR"
    echo -e "${GREEN}✅ Official repositories setup complete${NC}"
}

setup_yolo() {
    echo -e "${GREEN}Setting up YOLO Implementations...${NC}"
    cd yolo-implementations
    
    # Install common YOLO dependencies
    pip3 install ultralytics opencv-python-headless numpy --user
    
    for repo in */; do
        if [ -d "$repo" ]; then
            echo -e "${YELLOW}Setting up $repo${NC}"
            cd "$repo"
            
            # Build C++ projects if needed
            if [ -f "CMakeLists.txt" ]; then
                mkdir -p build
                cd build
                cmake ..
                make -j$(nproc)
                cd ..
            fi
            
            # Install Python requirements
            if [ -f "requirements.txt" ]; then
                pip3 install -r requirements.txt --user
            fi
            
            cd ..
        fi
    done
    
    cd "$CURRENT_DIR"
    echo -e "${GREEN}✅ YOLO implementations setup complete${NC}"
}

setup_cv() {
    echo -e "${GREEN}Setting up Computer Vision Projects...${NC}"
    cd computer-vision
    
    # Install common CV dependencies
    pip3 install opencv-python numpy mediapipe --user
    
    for repo in */; do
        if [ -d "$repo" ]; then
            echo -e "${YELLOW}Setting up $repo${NC}"
            cd "$repo"
            
            if [ -f "requirements.txt" ]; then
                pip3 install -r requirements.txt --user
            fi
            
            cd ..
        fi
    done
    
    cd "$CURRENT_DIR"
    echo -e "${GREEN}✅ Computer Vision projects setup complete${NC}"
}

setup_robotics() {
    echo -e "${GREEN}Setting up Robotics Integration...${NC}"
    cd robotics-integration
    
    # Check for ROS2
    if [ -d "/opt/ros" ]; then
        echo -e "${GREEN}✅ ROS detected${NC}"
    else
        echo -e "${YELLOW}⚠️  ROS not found - robotics demos may not work${NC}"
        echo "Visit https://docs.ros.org for installation instructions"
    fi
    
    for repo in */; do
        if [ -d "$repo" ]; then
            echo -e "${YELLOW}Setting up $repo${NC}"
            cd "$repo"
            
            if [ -f "requirements.txt" ]; then
                pip3 install -r requirements.txt --user
            fi
            
            cd ..
        fi
    done
    
    cd "$CURRENT_DIR"
    echo -e "${GREEN}✅ Robotics integration setup complete${NC}"
}

setup_community() {
    echo -e "${GREEN}Setting up Community Projects...${NC}"
    cd community-projects
    
    for repo in */; do
        if [ -d "$repo" ]; then
            echo -e "${YELLOW}Setting up $repo${NC}"
            cd "$repo"
            
            if [ -f "requirements.txt" ]; then
                pip3 install -r requirements.txt --user
            fi
            
            if [ -f "setup.sh" ]; then
                bash setup.sh
            fi
            
            cd ..
        fi
    done
    
    cd "$CURRENT_DIR"
    echo -e "${GREEN}✅ Community projects setup complete${NC}"
}

setup_tools() {
    echo -e "${GREEN}Setting up Tools & Utilities...${NC}"
    cd tools-utilities
    
    for repo in */; do
        if [ -d "$repo" ]; then
            echo -e "${YELLOW}Setting up $repo${NC}"
            cd "$repo"
            
            if [ -f "requirements.txt" ]; then
                pip3 install -r requirements.txt --user
            fi
            
            if [ -f "install.sh" ]; then
                bash install.sh
            fi
            
            cd ..
        fi
    done
    
    cd "$CURRENT_DIR"
    echo -e "${GREEN}✅ Tools & utilities setup complete${NC}"
}

setup_all() {
    echo -e "${GREEN}Setting up ALL categories...${NC}"
    setup_official
    setup_yolo
    setup_cv
    setup_robotics
    setup_community
    setup_tools
    echo -e "${GREEN}🎉 All categories setup complete!${NC}"
}

# Main script logic
check_prerequisites

case "$CATEGORY" in
    official)
        setup_official
        ;;
    yolo)
        setup_yolo
        ;;
    cv|vision)
        setup_cv
        ;;
    robotics|ros)
        setup_robotics
        ;;
    community)
        setup_community
        ;;
    tools)
        setup_tools
        ;;
    all)
        setup_all
        ;;
    *)
        echo "Usage: $0 {official|yolo|cv|robotics|community|tools|all}"
        echo ""
        echo "Categories:"
        echo "  official   - Official Hailo repositories"
        echo "  yolo       - YOLO implementations"
        echo "  cv/vision  - Computer vision projects"
        echo "  robotics   - ROS/robotics integration"
        echo "  community  - Community projects"
        echo "  tools      - Development tools and utilities"
        echo "  all        - Setup everything"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Setup complete! Next steps:${NC}"
echo "1. Test your Hailo device: hailortcli scan"
echo "2. Explore demos: ./explore-demos.sh"
echo "3. Run a demo: cd [category]/[project] && ./run.sh"