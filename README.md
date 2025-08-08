# ITL战队电控环境配置

<p align="center">
  <img src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/微信图片_2025-08-08_133219_648.jpg?raw=true" width="100">
</p>

## 序言：
为了有更好的代码开发环境，也为了后续的开发任务，我们迫切需要一个好的开发工具。在使用了各种开发工具后，我总结了一套基于vscode的stm32开发环境。为什么用vscode开发呢？因为vscode有丰富的插件可以下载，具有高度自定义的特点，你完全可以把它打造为一个属于你独一无二的开发工具。下面我来告诉大家如何使用这一套开发环境。（开发环境可能还有些bug，见谅🙏🙏🙏）

## 📑 目录
- [一、开发工具](#一开发工具)
- [二、环境搭建](#二环境搭建)
- [三、工具使用](#三工具使用)
- [四、调试](#四调试)
- [五、写在最后](#五写在最后)

...

## 一、开发工具

### 首先你需要下载一些东西：

- cmake  
- arm-gnu-toolchain  
- ninja  
- openocd
- 这些工具我都放到了这个网盘链接里，大家可以在这里下载https://pan.baidu.com/s/18mWA-K26kCKKWWBVhJbilA?pwd=ITL0 提取码: ITL0 
- 下载完这些后我建议你新建一个Toolchain文件夹，把它们都放到这个文件夹里面。然后这个文件夹建议你放到一个不容易动的位置，不要去改变它的位置，像我这样：
- <img width="470" height="250" alt="Snipaste_2025-08-08_14-04-07" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-04-07.png">。
  
### 你还需要下载vscode、STM32CUBEMX、Git Bash这三个软件请大家自行下载，切记STM32CUBEMX不要下载最新版本，可能会有些bug存在。

## 二、环境搭建
### 下载并解压好这些工具，下面进行环境搭建：
- 打开cmake这个文件夹，找到bin这个文件夹，进入，点击上方复制该路径：
- <img width="470" height="250" alt="屏幕截图 2025-08-08 140936" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202025-08-08%20140936.png" />
像这样。
- 复制完后打开设置，搜索编辑系统环境变量，点击进入
- <img width="470" height="250" alt="屏幕截图 2025-08-08 141158" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202025-08-08%20141158.png" />
- 进入后出现如下页面，点击环境变量进入
- <img width="374" height="418" alt="Snipaste_2025-08-08_14-14-52" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-14-52.png" />
- 进入后出现如下页面，点击path进入
- <img width="470" height="250" alt="Snipaste_2025-08-08_14-15-14" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-15-14.png" />
- 进入后出现如下页面，点击右上角的新键，把刚刚的路径复制进去，复制完后记得点确定。
- <img width="411" height="398" alt="Snipaste_2025-08-08_14-15-36" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-15-36.png" />
- 同理分别复制arm-gnu-toolchainde的bin路径和openocd的bin路径到环境变量里，ninja只需要打开文件夹后复制路径就行，这样你就有这几个路径了：
- <img width="414" height="281" alt="Snipaste_2025-08-08_14-25-57" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-25-57.png" />

### 验证工具是否配置成功：win+R打开命令端，进入
- <img width="313" height="161" alt="Snipaste_2025-08-08_14-28-13" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-28-13.png" />
- <img width="500" height="300" alt="Snipaste_2025-08-08_14-29-22" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-29-22.png" />
-在命令行里依次输入，输入完一条命令后点一次回车
- cmake --version
- ninja --version
- arm-none-eabi-gcc --version
- openocd.exe --version
- 如果有哪一个工具没有配置好，则不会出现对应的版本号。如果你最后出现了所有工具的版本号，恭喜你顺利配置好工具🎉🎉🎉：
- <img width="470" height="250" alt="Snipaste_2025-08-05_11-56-34" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-05_11-56-34.png" />

### 进行软件的配置，这里只进行vscode的配置教学，Git Bash安装方法去自行网上搜索
- 打开vscode，再打开插件
- <img width="620" height="300" alt="Snipaste_2025-08-08_14-42-40" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-42-40.png" />
-你需要下载如下插件：
- C/C++(C/C++ Extension Pack, C/C++ Themes这两个插件想下载就下载，不想下载也可以不下载)
- CMake
- CMake Language Support
- Chinese (Simplified) (简体中文) Language Pack for Visual Studio Code(英语好的可以不用下载)
- Cortex-Debug
- Task Buttons
- <img width="576" height="384" alt="Snipaste_2025-08-08_14-49-31" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-49-31.png" />
- <img width="578" height="54" alt="Snipaste_2025-08-08_14-49-47" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-49-47.png" />
- 安装完插件后重新启动一下vscode，左下角进入点一下齿轮图标，再进入设置
- <img width="500" height="400" alt="屏幕截图 2025-08-08 150008" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202025-08-08%20150008.png" />
- 进入设置后搜索font,如下图，你可以在这里改变字体大小
- <img width="1052" height="616" alt="Snipaste_2025-08-08_14-57-37" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-57-37.png" />
- 搜索zoom，打开后可以进行ctrl+鼠标滚轮缩放字体
- <img width="1058" height="578" alt="Snipaste_2025-08-08_14-58-03" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-58-03.png" />
- 搜索compact,打开
- <img width="1061" height="576" alt="Snipaste_2025-08-08_14-57-20" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-57-20.png" />
- 搜索default terminal, 如图选择Git Bash
- <img width="1059" height="656" alt="Snipaste_2025-08-08_14-59-31" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_14-59-31.png" />
### 到这里环境就配置的差不多了，接下来就是工具的使用

## 三、工具使用
### 这里简单介绍一下构建系统基本层次
- CMake-->make工具-->编译器
这里涉及的知识比较多，不详细展开说，想了解自行查阅资料

### 首先使用STM32CUBENX进行工程配置，这里我配置一个妙板点灯作为例子
-配置完基本的东西后，去Project Manager生成工程，这里Toolchain选择CMake，后生成工程。
- <img width="1082" height="646" alt="Snipaste_2025-08-08_15-28-20" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_15-28-20.png" />
- 生成工程后找到这个工程，点击进入，进入后将下载的.vscode文件夹和update_config.sh复制放到里面，像这样：
- <img width="407" height="258" alt="Snipaste_2025-08-08_15-58-23" src="https://github.com/user-attachments/assets/27bc2805-eaed-4f23-9999-d13ff63ac150" />
- 后点击鼠标右键，选择显示更多选项，进入后如下图，选择用vscode打开（有些人这里可能没有这个选项，我后面会写解决方法）
- <img width="861" height="419" alt="屏幕截图 2025-08-08 153249" src="https://github.com/user-attachments/assets/a537e1cf-c85c-4617-a495-bdd8ef96a4cd" />
- 用vscode打开后等一会，直到你左下角出现如下图按键：
- <img width="404" height="99" alt="Snipaste_2025-08-08_16-01-48" src="https://github.com/user-attachments/assets/e4a76579-a8ed-4dbe-86b2-4c709944926c" />
- 你打开.vscode文件夹，找到c_cpp_properties.json，把下图的路径改为你自己工具链的路径
- <img width="1217" height="488" alt="Snipaste_2025-08-08_16-06-32" src="https://github.com/user-attachments/assets/bb8b9c88-a862-4161-aaa6-13db0b6cc418" />
- 这个路径需要你打开之前的arm-gnu-toolchain,找到bin文件夹，再打开找到arm-none-eabi-gcc.exe，点击右键复制路径，将路径替换原来路径。这里要注意"",复制的路径自带双引号，还有注意\要改为/
- <img width="1166" height="763" alt="屏幕截图 2025-08-08 160941" src="https://github.com/user-attachments/assets/a313dda6-1787-47dd-b98f-b99f10d334bc" />
- 此时你的侧面栏应该类似这样，打开update_config.sh
- <img width="201" height="559" alt="Snipaste_2025-08-08_16-02-46" src="https://github.com/user-attachments/assets/962d2b40-f8f4-4d61-a576-8d18ed750681" />
- update_config.sh是一个脚本它会将你的.vsocde文件夹里的所有文件改为适应你当前工程的文件，按照这个文件开头写的方法使用就行，举个例子：
- launch.json红框里的这部分是错误的，因为我用的是妙板，应该是stm32h7x.cfg,现在我使用这个脚本
- <img width="741" height="567" alt="Snipaste_2025-08-08_16-16-36" src="https://github.com/user-attachments/assets/54553a57-faea-4833-ad13-5383aecfe6b0" />
- ctrl+esc下面那个键打开终端输入执行脚本命令后出现下图
- <img width="480" height="441" alt="Snipaste_2025-08-08_16-20-38" src="https://github.com/user-attachments/assets/7f9cdcdb-0bb5-4111-aba1-737975731706" />
- <img width="480" height="221" alt="Snipaste_2025-08-08_16-21-54" src="https://github.com/user-attachments/assets/8d4369d1-a242-4d0b-a452-649a3fdb181a" />
- <img width="347" height="110" alt="Snipaste_2025-08-08_16-22-18" src="https://github.com/user-attachments/assets/725e2063-22e0-4b96-89c4-1a06469f6aa6" />
- <img width="386" height="299" alt="Snipaste_2025-08-08_16-24-24" src="https://github.com/user-attachments/assets/22052e55-c96f-4220-a6ce-24894b6d1120" />
- 我们可以看到错误已经被自动修改（这其实也不能说是完全意义上的错误修改，而且自动适应当前工程，它只会去看芯片名和工程名是不是与当前一致，别的错误不会改）
- 此时让我们再看到左下角几个按键，下图是它对应的作用，其中configure生成工程后只需要按一次就可以了，后面不需要重复使用，除非你把build文件夹删了
- <img width="423" height="326" alt="Snipaste_2025-08-08_16-29-53" src="https://github.com/user-attachments/assets/f0ceb60b-7536-4baa-a024-3dd543c4b315" />
- 现在我依次点击configure,build,flask(dap)进行工程的配置，编译，烧录
- 配置完后会多一个build文件夹
- <img width="113" height="177" alt="Snipaste_2025-08-08_16-33-41" src="https://github.com/user-attachments/assets/bbca1c64-c8d8-46cf-971c-15741a6fde5f" />
- 最后可以看到此时已经成功烧录，妙板点灯成功
- <img width="327" height="172" alt="Snipaste_2025-08-08_16-34-55" src="https://github.com/user-attachments/assets/e13d0c7e-bea0-44ef-8d3e-270f6b939ab7" />
- ![微信图片_2025-08-08_164437_176](https://github.com/user-attachments/assets/6e0c4169-757f-4df1-8e7d-d7bdb4d93938)

- 如果需要自己添加文件夹,.c和.h文件需要做一些操作包含目录。首先打开主CMakeLists.txt,找到如下图所示位置
- <img width="740" height="308" alt="Snipaste_2025-08-08_16-37-58" src="https://github.com/user-attachments/assets/4995702f-78b0-4045-80e3-5738fba8e893" />
- 我现在就自己添加了一个BSP文件夹和bsp_led.c和bsp_led.h文件，所以我的这里需要做相应改变，如下图
- <img width="472" height="314" alt="Snipaste_2025-08-08_16-38-33" src="https://github.com/user-attachments/assets/58a84a62-fe77-401a-9fc3-dbb781408552" />

## 四、调试
### 这套工具好处在与还能进行调试
- 点击左侧栏的调试，这里我选择DAP进行无线调试
- <img width="546" height="366" alt="Snipaste_2025-08-08_16-46-31" src="https://github.com/user-attachments/assets/6bbc7161-f1fc-4d96-a8ee-8fcabc93b231" />
- <img width="1158" height="725" alt="屏幕截图 2025-08-08 164544" src="https://github.com/user-attachments/assets/ac1a483e-5b35-4f3e-80c2-3f34f2376193" />
- 这里我选择r这个变量，鼠标右键把它加入监视
- <img width="955" height="938" alt="屏幕截图 2025-08-08 164844" src="https://github.com/user-attachments/assets/35c977eb-e250-4293-94fd-c7553dbe8ac2" />
- 同时我在这里打一个断点，鼠标左边点一下就行
- <img width="789" height="325" alt="Snipaste_2025-08-08_16-49-56" src="https://github.com/user-attachments/assets/85bea602-8d2b-47bf-a0c1-3e85cfa16efc" />
- 现在r为5，我运行一下，可以看到r变为了7，符合代码逻辑
- <img width="490" height="271" alt="Snipaste_2025-08-08_16-52-18" src="https://github.com/user-attachments/assets/04d259d6-58b9-4545-8012-923dc4e23674" />
- <img width="490" height="271" alt="Snipaste_2025-08-08_16-52-18" src="https://github.com/user-attachments/assets/8ff46946-03aa-48a9-b411-80a758c86e1c" />
-如果我想要进行动态显示，只需要把r加入下面的cortex live watch里，我把断点取消，你会看到r一直在改变
- <img width="379" height="363" alt="Snipaste_2025-08-08_16-54-52" src="https://github.com/user-attachments/assets/b9c6a5aa-17b8-4417-a3cf-c120a9dab31b" />

## 五、写在最后
- jlink烧录和下载还没有实现，目前有些问题，等我解决后更新
- 因为我也刚学不久，有些地方可能有bug或不足，欢迎及时和我反馈QQ:3305708832
- 感谢B站大佬linkyourbin，ControlCoreX,大家如果想了解更多关于工具链的知识可以看https://b23.tv/k3Q2581和https://b23.tv/gj3xWhn




