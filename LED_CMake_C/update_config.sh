#!/bin/bash
# 使用方法：
# 将chmod +x update_config.sh
# ./update_config.sh按前后顺序依次输入终端



# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "工作目录: $SCRIPT_DIR"

# 从.ioc文件中提取项目信息
get_project_info() {
    # 查找.ioc文件
    IOC_FILE=$(find "$SCRIPT_DIR" -maxdepth 1 -name "*.ioc" | head -n 1)
    
    if [ -z "$IOC_FILE" ]; then
        echo "未找到.ioc文件，使用默认配置"
        PROJECT_NAME=$(basename "$SCRIPT_DIR")
        CHIP_SERIES="stm32h7"
        # 从CMakeLists.txt中获取正确的芯片定义
        get_chip_define_from_cmake
        return
    fi
    
    echo "找到项目文件: $(basename "$IOC_FILE")"
    
    # 提取芯片信息
    CHIP_FULL_NAME=$(grep -E "^Mcu\.CPN=" "$IOC_FILE" | cut -d '=' -f 2)
    if [ -z "$CHIP_FULL_NAME" ]; then
        CHIP_FULL_NAME="STM32H723VGT6"
    fi
    
    echo "芯片型号: $CHIP_FULL_NAME"
    
    # 提取项目名称（使用目录名）
    PROJECT_NAME=$(basename "$SCRIPT_DIR")
    echo "项目名称: $PROJECT_NAME"
    
    # 从完整芯片型号中提取系列
    if [[ $CHIP_FULL_NAME =~ STM32([A-Z][0-9]) ]]; then
        CHIP_SERIES="stm32${BASH_REMATCH[1],,}"  # 转为小写
    else
        CHIP_SERIES="stm32h7"
    fi
    
    echo "芯片系列: $CHIP_SERIES"
    
    # 从CMakeLists.txt中获取正确的芯片定义
    get_chip_define_from_cmake
}

# 从CMakeLists.txt中获取芯片定义
get_chip_define_from_cmake() {
    CMAKE_FILE="$SCRIPT_DIR/cmake/stm32cubemx/CMakeLists.txt"
    
    if [ -f "$CMAKE_FILE" ]; then
        CHIP_DEFINE=$(grep -E "STM32[A-Z0-9]+xx" "$CMAKE_FILE" | head -n 1 | tr -d '[:space:]')
        if [ -n "$CHIP_DEFINE" ]; then
            echo "从CMakeLists.txt中提取芯片定义: $CHIP_DEFINE"
        else
            echo "在CMakeLists.txt中未找到芯片定义，使用默认值"
            CHIP_DEFINE="STM32H723xx"
        fi
    else
        echo "未找到CMakeLists.txt，使用默认芯片定义"
        CHIP_DEFINE="STM32H723xx"
    fi
}

# 根据完整芯片名称获取J-Link设备名称（去掉最后两位）
get_jlink_device_name() {
    # 从完整芯片型号中提取J-Link设备名称，去掉最后两位字符
    if [[ $CHIP_FULL_NAME =~ (STM32[A-Z0-9]+) ]]; then
        # 提取基本型号并去掉最后两位字符
        BASE_NAME="${BASH_REMATCH[1]}"
        # 去掉最后两位字符
        JLINK_DEVICE="${BASE_NAME%??}"
        echo "$JLINK_DEVICE"
    else
        # 默认处理方式
        case "$CHIP_SERIES" in
            "stm32f4")
                JLINK_DEVICE="STM32F407"
                ;;
            "stm32f7")
                JLINK_DEVICE="STM32F7"
                ;;
            "stm32h7")
                JLINK_DEVICE="STM32H7"
                ;;
            *)
                JLINK_DEVICE="${CHIP_SERIES^^}"
                ;;
        esac
        echo "$JLINK_DEVICE"
    fi
}

# 更新c_cpp_properties.json
update_c_cpp_properties() {
    C_CPP_FILE="$SCRIPT_DIR/.vscode/c_cpp_properties.json"
    
    echo "正在检查 $C_CPP_FILE"
    
    if [ ! -f "$C_CPP_FILE" ]; then
        echo "未找到 $C_CPP_FILE"
        return 1
    fi
    
    echo "文件存在，开始更新芯片定义..."
    
    # 显示更新前的内容
    echo "更新前的芯片定义:"
    grep "STM32.*xx" "$C_CPP_FILE" || echo "未找到芯片定义"
    
    # 使用sed替换芯片定义
    # 先删除旧的STM32定义
    sed -i '/"STM32.*xx"/d' "$C_CPP_FILE"
    # 在USE_HAL_DRIVER后添加新的芯片定义
    sed -i "/\"USE_HAL_DRIVER\"/a\                \"$CHIP_DEFINE\"" "$C_CPP_FILE"
    
    # 显示更新后的内容
    echo "更新后的芯片定义:"
    grep "STM32.*xx" "$C_CPP_FILE" || echo "未找到芯片定义"
    
    echo "已更新 $C_CPP_FILE 中的芯片定义为 $CHIP_DEFINE"
}

# 更新launch.json
update_launch_json() {
    LAUNCH_FILE="$SCRIPT_DIR/.vscode/launch.json"
    
    echo "正在检查 $LAUNCH_FILE"
    
    if [ ! -f "$LAUNCH_FILE" ]; then
        echo "未找到 $LAUNCH_FILE"
        return 1
    fi
    
    echo "文件存在，开始更新配置..."
    
    # 显示更新前的内容
    echo "更新前的可执行文件路径:"
    grep '"executable"' "$LAUNCH_FILE"
    
    echo "更新前的目标配置:"
    grep "target/[a-zA-Z0-9]*\.cfg" "$LAUNCH_FILE"
    
    # 更新可执行文件路径
    ELF_PATH="build/${PROJECT_NAME}.elf"
    sed -i "s|\"executable\": \"[^\"]*\"|\"executable\": \"$ELF_PATH\"|" "$LAUNCH_FILE"
    
    # 更新configFiles中的目标配置
    TARGET_CFG="target/${CHIP_SERIES}x.cfg"
    sed -i "s|target/[a-zA-Z0-9]\+\.cfg|$TARGET_CFG|g" "$LAUNCH_FILE"
    
    # 从完整芯片型号中提取正确的设备名称并更新J-Link配置
    # 去掉完整型号的最后两位字符，以确保J-Link兼容性
    JLINK_DEVICE=$(get_jlink_device_name)
    echo "更新J-Link设备名称为: $JLINK_DEVICE"
    sed -i "s/\"device\": \"[^\"]*\"/\"device\": \"$JLINK_DEVICE\"/g" "$LAUNCH_FILE"
    
    # 显示更新后的内容
    echo "更新后的可执行文件路径:"
    grep '"executable"' "$LAUNCH_FILE"
    
    echo "更新后的目标配置:"
    grep "target/[a-zA-Z0-9]*\.cfg" "$LAUNCH_FILE"
    
    echo "更新后的设备名称:"
    grep '"device"' "$LAUNCH_FILE"
    
    echo "已更新 $LAUNCH_FILE 中的可执行文件路径为 $ELF_PATH"
    echo "已更新 $LAUNCH_FILE 中的目标配置为 $TARGET_CFG"
}

# 更新flash.jlink
update_flash_jlink() {
    FLASH_FILE="$SCRIPT_DIR/flash.jlink"
    
    echo "正在检查 $FLASH_FILE"
    
    if [ ! -f "$FLASH_FILE" ]; then
        echo "未找到 $FLASH_FILE"
        return 1
    fi
    
    echo "文件存在，开始更新设备名称..."
    
    # 显示更新前的内容
    echo "更新前的设备名称:"
    grep "device =" "$FLASH_FILE"
    
    # 更新flash.jlink中的设备名称
    JLINK_DEVICE=$(get_jlink_device_name)
    echo "更新J-Link设备名称为: $JLINK_DEVICE"
    sed -i "s/device = .*/device = $JLINK_DEVICE/" "$FLASH_FILE"
    
    # 显示更新后的内容
    echo "更新后的设备名称:"
    grep "device =" "$FLASH_FILE"
    
    echo "已更新 $FLASH_FILE 中的设备名称为 $JLINK_DEVICE"
}

# 更新tasks.json
update_tasks_json() {
    TASKS_FILE="$SCRIPT_DIR/.vscode/tasks.json"
    
    echo "正在检查 $TASKS_FILE"
    
    if [ ! -f "$TASKS_FILE" ]; then
        echo "未找到 $TASKS_FILE"
        return 1
    fi
    
    echo "文件存在，开始更新配置..."
    
    # 显示更新前的目标配置
    echo "更新前的目标配置:"
    grep "target/[a-zA-Z0-9]*\.cfg" "$TASKS_FILE" || echo "未找到目标配置"
    
    # 显示更新前的可执行文件路径
    echo "更新前的程序路径:"
    grep "program .*\.elf" "$TASKS_FILE" || echo "未找到程序路径"
    
    # 更新目标配置文件
    TARGET_CFG="target/${CHIP_SERIES}x.cfg"
    sed -i "s|target/[a-zA-Z0-9]\+\.cfg|$TARGET_CFG|g" "$TASKS_FILE"
    
    # 更新可执行文件路径
    ELF_PATH="./build/${PROJECT_NAME}.elf"
    sed -i "s|program \./build/[A-Za-z0-9_-]\+\.elf|program $ELF_PATH|g" "$TASKS_FILE"
    
    # 显示更新后的内容
    echo "更新后的目标配置:"
    grep "target/[a-zA-Z0-9]*\.cfg" "$TASKS_FILE" || echo "未找到目标配置"
    
    echo "更新后的程序路径:"
    grep "program .*\.elf" "$TASKS_FILE" || echo "未找到程序路径"
    
    echo "已更新 $TASKS_FILE 中的目标配置为 $TARGET_CFG"
    echo "已更新 $TASKS_FILE 中的可执行文件路径为 $ELF_PATH"
}

# 主函数
main() {
    echo "开始更新VS Code配置文件..."
    
    # 获取项目信息
    get_project_info
    
    echo "========================"
    echo "项目名称: $PROJECT_NAME"
    echo "芯片系列: $CHIP_SERIES"
    echo "芯片定义: $CHIP_DEFINE"
    echo "芯片型号: $CHIP_FULL_NAME"
    echo "========================"
    
    # 更新配置文件
    echo ""
    echo "=== 更新 c_cpp_properties.json ==="
    update_c_cpp_properties
    
    echo ""
    echo "=== 更新 launch.json ==="
    update_launch_json
    
    echo ""
    echo "=== 更新 flash.jlink ==="
    update_flash_jlink
    
    echo ""
    echo "=== 更新 tasks.json ==="
    update_tasks_json
    
    echo ""
    echo "配置文件更新完成!"
    echo "现在您可以使用适配当前项目的配置进行编译和调试了。"
}

# 执行主函数
main