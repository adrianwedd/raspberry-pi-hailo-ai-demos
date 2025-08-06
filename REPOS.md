# 📚 Complete Hailo AI Repository Collection

## 🏢 Official Repositories
| Repository | Description | Stars | Language |
|------------|-------------|-------|----------|
| [hailo-rpi5-examples](official-repositories/hailo-rpi5-examples) | Official Raspberry Pi 5 examples with pose estimation, CLIP, games | ⭐ High | Python |
| [tappas](official-repositories/tappas) | High-performance GStreamer AI pipelines | ⭐ High | C++/Python |
| [hailo-model-zoo](official-repositories/hailo-model-zoo) | Pre-trained models and conversion tools | ⭐ High | Python |
| [hailo-app-examples](official-repositories/hailo-app-examples) | Multi-language inference examples | ⭐ Med | C++/Python |
| [hailort](official-repositories/hailort) | Open-source runtime framework | ⭐ High | C++ |

## 🎯 YOLO Implementations
| Repository | Description | Performance | Platform |
|------------|-------------|-------------|----------|
| [hailo-yolo-guide](yolo-implementations/hailo-yolo-guide) | Complete YOLO conversion guide | Excellent | x86/RPi5 |
| [cpp-yolov8](yolo-implementations/cpp-yolov8) | Minimal C++ YOLOv8 for Pi5 | 30+ FPS | RPi5 |
| [rpi5-yolov8-utility](yolo-implementations/rpi5-yolov8-utility) | ML tool with batch processing | Optimized | RPi5 |
| [seeed-benchmarks](yolo-implementations/seeed-benchmarks) | Performance evaluation suite | Detailed | RPi CM4 |

## 👁️ Computer Vision Applications
| Repository | Description | Use Case | Status |
|------------|-------------|----------|--------|
| [gesture-recognition](computer-vision/gesture-recognition) | Hand gesture detection | HCI | Active |
| [hailo8-detection](computer-vision/hailo8-detection) | OpenCV integration examples | General | Active |

## 🤖 Robotics Integration
| Repository | Description | Framework | ROS Version |
|------------|-------------|-----------|-------------|
| [hailo-ros2](robotics-integration/hailo-ros2) | TAPPAS + ROS2 integration | ROS2 | Humble/Iron |

## 🌟 Community Projects
| Repository | Description | Category | Difficulty |
|------------|-------------|----------|------------|
| [degirum-examples](community-projects/degirum-examples) | DeGirum PySDK with Hailo | SDK | Beginner |
| [hailo-api-detector](community-projects/hailo-api-detector) | CodeProject AI compatible | Server | Intermediate |
| [seeed-zero-to-hero](community-projects/seeed-zero-to-hero) | Complete tutorial series | Education | Beginner |

## 🔧 Tools & Utilities
| Repository | Description | Purpose | Type |
|------------|-------------|---------|------|
| [seeed-toolbox](tools-utilities/seeed-toolbox) | ONNX to HEF conversion | Model Conversion | CLI |
| [meta-hailo-yocto](tools-utilities/meta-hailo-yocto) | Yocto layers for embedded | Build System | Meta |

## 📊 Repository Statistics
- **Total Repositories**: 18 active submodules
- **Categories**: 6 organized folders
- **Languages**: Python, C++, C, Bash
- **Platforms**: Raspberry Pi 5, x86_64, Embedded Linux
- **AI Processors**: Hailo-8L (13 TOPS), Hailo-8 (26 TOPS)

## 🚀 Quick Start by Category

### For Beginners
1. Start with `community-projects/seeed-zero-to-hero`
2. Try `official-repositories/hailo-rpi5-examples`
3. Explore `community-projects/degirum-examples`

### For YOLO Users
1. Follow `yolo-implementations/hailo-yolo-guide`
2. Use `yolo-implementations/cpp-yolov8` for performance
3. Benchmark with `yolo-implementations/seeed-benchmarks`

### For Robotics
1. Integrate with `robotics-integration/hailo-ros2`
2. Use `official-repositories/tappas` for pipelines

### For Production
1. Build with `official-repositories/hailort`
2. Deploy using `tools-utilities/meta-hailo-yocto`
3. Serve with `community-projects/hailo-api-detector`

## 🔄 Keeping Repositories Updated

```bash
# Update all submodules
git submodule update --remote --merge

# Update specific category
git submodule update --remote official-repositories/*

# Check status
git submodule status
```

## 📈 Performance Benchmarks

| Model | Repository | FPS | Accuracy | Power |
|-------|------------|-----|----------|-------|
| YOLOv8s | cpp-yolov8 | 30+ | High | +3W |
| YOLOv6n | hailo-rpi5-examples | 25+ | Good | +2W |
| YOLOv8-pose | rpi5-yolov8-utility | 20+ | High | +3W |
| CLIP | hailo-rpi5-examples | 15+ | Excellent | +4W |

## 🎓 Learning Path

```mermaid
graph LR
    A[Beginner] --> B[Zero to Hero Tutorial]
    B --> C[Official Examples]
    C --> D[YOLO Guide]
    D --> E[Custom Models]
    E --> F[Production Deployment]
```

## 🤝 Contributing

To add a new repository:
1. Fork this collection
2. Add submodule: `git submodule add [URL] [category]/[name]`
3. Update this REPOS.md file
4. Submit pull request

## 📝 License & Credits

Each submodule maintains its own license. Please check individual repositories for specific licensing terms.

---
*Last updated: 2025-08-06*