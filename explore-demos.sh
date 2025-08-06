#!/bin/bash
# Explore the Hailo AI demos collection

echo "🚀 Hailo AI Demos Collection Explorer"
echo "====================================="
echo

# Check Hailo device
echo "🔧 System Status:"
if command -v hailortcli &> /dev/null; then
    echo "✅ Hailo runtime installed"
    hailortcli scan 2>/dev/null && echo "✅ Hailo device detected" || echo "⚠️  No Hailo device found"
else
    echo "⚠️  Hailo runtime not found"
fi
echo

# List available demos
echo "📂 Available Demos:"
echo
echo "1️⃣  Official Examples (official-examples/)"
if [ -d "official-examples" ]; then
    echo "   - basic_pipelines: Object detection, pose estimation"
    echo "   - CLIP: Text-to-image search"
    echo "   - Fruit Ninja: Pose-controlled game"
    echo "   - NavigAItor: Visual navigation robot"
fi
echo

echo "2️⃣  TAPPAS Pipelines (community-projects/tappas/)"
if [ -d "community-projects/tappas" ]; then
    echo "   - High-performance optimized AI pipelines"
    echo "   - GStreamer integration"
    echo "   - Multi-stream support"
fi
echo

echo "3️⃣  DeGirum PySDK (community-projects/degirum-hailo-examples/)"
if [ -d "community-projects/degirum-hailo-examples" ]; then
    echo "   - Python SDK for Hailo accelerators"
    echo "   - Easy-to-use API"
    echo "   - Model zoo integration"
fi
echo

echo "4️⃣  C++ YOLOv8 (community-projects/cpp-yolov8-example/)"
if [ -d "community-projects/cpp-yolov8-example" ]; then
    echo "   - High-performance C++ implementation"
    echo "   - Direct HailoRT API usage"
    echo "   - Minimal dependencies"
fi
echo

echo "5️⃣  ROS2 Integration (community-projects/hailo-ros2-integration/)"
if [ -d "community-projects/hailo-ros2-integration" ]; then
    echo "   - ROS2 nodes for Hailo inference"
    echo "   - Robotics applications"
    echo "   - Sensor fusion support"
fi
echo

# Quick start suggestions
echo "🎯 Quick Start:"
echo "---"
echo "# Update all submodules to latest:"
echo "git submodule update --remote --merge"
echo
echo "# Run a basic demo (requires camera):"
echo "cd official-examples/basic_pipelines && ./detection.sh"
echo
echo "# Explore a specific project:"
echo "cd community-projects/tappas && ls -la"
echo

echo "📚 Documentation:"
echo "- Main README: README.md"
echo "- Each project has its own README in its directory"
echo

echo "Happy exploring! 🎉"