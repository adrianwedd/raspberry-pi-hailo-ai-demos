#!/bin/bash
# Script to add remaining repositories to reach 50 total

echo "Adding remaining repositories to reach 50 total..."

# Educational and community resources
echo "Adding educational resources..."
git submodule add https://github.com/Seeed-Studio/wiki-documents.git educational-resources/seeed-wiki || true
git submodule add https://github.com/opensensor/rpi5-resources.git educational-resources/rpi5-resources || true
git submodule add https://github.com/geerlingguy/raspberry-pi-pcie-devices.git educational-resources/pi-pcie-devices || true

# Surveillance and security specific
echo "Adding surveillance projects..."
git submodule add https://github.com/ultralytics/ultralytics.git surveillance-security/ultralytics-yolo || true
git submodule add https://github.com/AUTOMATIC1111/stable-diffusion-webui.git community-projects/stable-diffusion || true

# Additional YOLO and detection projects
echo "Adding more YOLO implementations..."
git submodule add https://github.com/WongKinYiu/yolov7.git yolo-implementations/yolov7-base || true
git submodule add https://github.com/ultralytics/yolov5.git yolo-implementations/yolov5-base || true

# Performance and benchmarking
echo "Adding benchmarking tools..."
git submodule add https://github.com/NVIDIA/TensorRT.git tools-utilities/tensorrt-comparison || true
git submodule add https://github.com/onnx/onnx.git tools-utilities/onnx-tools || true

# Docker and deployment
echo "Adding deployment tools..."
git submodule add https://github.com/docker/awesome-compose.git web-apis/docker-compose-examples || true

# IoT and embedded projects
echo "Adding IoT projects..."
git submodule add https://github.com/eclipse/paho.mqtt.python.git embedded-systems/mqtt-client || true
git submodule add https://github.com/home-assistant/core.git community-projects/home-assistant-core || true

# Computer vision libraries and tools
echo "Adding CV tools..."
git submodule add https://github.com/opencv/opencv.git computer-vision/opencv-base || true
git submodule add https://github.com/opencv/opencv-python.git computer-vision/opencv-python || true

# Model conversion and optimization tools
echo "Adding model tools..."
git submodule add https://github.com/onnx/onnxruntime.git tools-utilities/onnxruntime || true
git submodule add https://github.com/tensorflow/tensorflow.git tools-utilities/tensorflow || true
git submodule add https://github.com/pytorch/pytorch.git tools-utilities/pytorch || true

# Additional framework integrations
echo "Adding framework integrations..."
git submodule add https://github.com/ros2/ros2.git robotics-integration/ros2-core || true
git submodule add https://github.com/microsoft/onnxjs.git web-apis/onnxjs || true

# Creative and interactive projects
echo "Adding creative projects..."
git submodule add https://github.com/tensorflow/tfjs.git community-projects/tensorflow-js || true
git submodule add https://github.com/gradio-app/gradio.git web-apis/gradio-interface || true

# Count current submodules
CURRENT_COUNT=$(git submodule status | wc -l)
echo "Current submodule count: $CURRENT_COUNT"

if [ $CURRENT_COUNT -lt 50 ]; then
    echo "Need to add more repositories to reach 50..."
    # Add more placeholder/example repositories
    git submodule add https://github.com/streamlit/streamlit.git web-apis/streamlit || true
    git submodule add https://github.com/fastapi/fastapi.git web-apis/fastapi || true
fi

# Final count
FINAL_COUNT=$(git submodule status | wc -l)
echo "Final submodule count: $FINAL_COUNT"