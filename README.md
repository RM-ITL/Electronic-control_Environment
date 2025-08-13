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
- [六、更新：Git使用和上传代码到github](#六更新：Git使用和上传代码到github)
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
- <img width="407" height="258" alt="Snipaste_2025-08-08_15-58-23" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_15-58-23.png" />
- 后点击鼠标右键，选择显示更多选项，进入后如下图，选择用vscode打开（有些人这里可能没有这个选项，我后面会写解决方法）
- <img width="861" height="419" alt="屏幕截图 2025-08-08 153249" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202025-08-08%20153249.png" />
- 用vscode打开后等一会，直到你左下角出现如下图按键：
- <img width="404" height="99" alt="Snipaste_2025-08-08_16-01-48" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-01-48.png" />
- 你打开.vscode文件夹，找到c_cpp_properties.json，把下图的路径改为你自己工具链的路径
- <img width="1217" height="488" alt="Snipaste_2025-08-08_16-06-32" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-06-32.png" />
- 这个路径需要你打开之前的arm-gnu-toolchain,找到bin文件夹，再打开找到arm-none-eabi-gcc.exe，点击右键复制路径，将路径替换原来路径。这里要注意"",复制的路径自带双引号，还有注意\要改为/
- <img width="1166" height="763" alt="屏幕截图 2025-08-08 160941" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202025-08-08%20160941.png" />
- 此时你的侧面栏应该类似这样，打开update_config.sh
- <img width="201" height="559" alt="Snipaste_2025-08-08_16-02-46" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-02-46.png" />
- update_config.sh是一个脚本它会将你的.vsocde文件夹里的所有文件改为适应你当前工程的文件，按照这个文件开头写的方法使用就行，举个例子：
- launch.json红框里的这部分是错误的，因为我用的是妙板，应该是stm32h7x.cfg,现在我使用这个脚本
- <img width="741" height="567" alt="Snipaste_2025-08-08_16-16-36" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-16-36.png" />
- ctrl+esc下面那个键打开终端输入执行脚本命令后出现下图
- <img width="480" height="441" alt="Snipaste_2025-08-08_16-20-38" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-20-38.png" />
- <img width="480" height="221" alt="Snipaste_2025-08-08_16-21-54" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-21-54.png" />
- <img width="347" height="110" alt="Snipaste_2025-08-08_16-22-18" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-22-18.png" />
- <img width="386" height="299" alt="Snipaste_2025-08-08_16-24-24" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-24-24.png" />
- 我们可以看到错误已经被自动修改（这其实也不能说是完全意义上的错误修改，而且自动适应当前工程，它只会去看芯片名和工程名是不是与当前一致，别的错误不会改）
- 此时让我们再看到左下角几个按键，下图是它对应的作用，其中configure生成工程后只需要按一次就可以了，后面不需要重复使用，除非你把build文件夹删了
- <img width="423" height="326" alt="Snipaste_2025-08-08_16-29-53" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-29-53.png" />
- 现在我依次点击configure,build,flash(dap)进行工程的配置，编译，烧录
- 配置完后会多一个build文件夹
- <img width="113" height="177" alt="Snipaste_2025-08-08_16-33-41" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-33-41.png" />
- 最后可以看到此时已经成功烧录，妙板点灯成功
- <img width="327" height="172" alt="Snipaste_2025-08-08_16-34-55" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-34-55.png" />
- ![微信图片_2025-08-08_164437_176](https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_2025-08-08_164437_176.jpg)

- 如果需要自己添加文件夹,.c和.h文件需要做一些操作包含目录。首先打开主CMakeLists.txt,找到如下图所示位置
- <img width="740" height="308" alt="Snipaste_2025-08-08_16-37-58" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-37-58.png" />
- 我现在就自己添加了一个BSP文件夹和bsp_led.c和bsp_led.h文件，所以我的这里需要做相应改变，如下图
- <img width="472" height="314" alt="Snipaste_2025-08-08_16-38-33" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-38-33.png" />

### 已更新jlink烧录和调试
- 需要将更新后的.vscode文件夹、flash.jlink和update_config.sh下载好复制到工程里，然后你还需要在主CMakeLists.txt的最后加上CMake.txt文件里的一段话，否则将无法烧录
- <img width="490" height="300" alt="Snipaste_2025-08-09_08-47-28" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-09_08-47-28.png" />

## 四、调试
### 这套工具好处在与还能进行调试
- 点击左侧栏的调试，这里我选择DAP进行无线调试
- <img width="546" height="366" alt="Snipaste_2025-08-08_16-46-31" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-46-31.png" />
- <img width="1158" height="725" alt="屏幕截图 2025-08-08 164544" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202025-08-08%20164544.png" />
- 这里我选择r这个变量，鼠标右键把它加入监视
- <img width="955" height="938" alt="屏幕截图 2025-08-08 164844" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202025-08-08%20164844.png" />
- 同时我在这里打一个断点，鼠标左边点一下就行
- <img width="789" height="325" alt="Snipaste_2025-08-08_16-49-56" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-49-56.png" />
- 现在r为5，我运行一下，可以看到r变为了7，符合代码逻辑
- <img width="490" height="271" alt="Snipaste_2025-08-08_16-52-18" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-52-18.png" />
- <img width="490" height="271" alt="Snipaste_2025-08-08_16-53-04" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-53-04.png" />
-如果我想要进行动态显示，只需要把r加入下面的cortex live watch里，我把断点取消，你会看到r一直在改变
- <img width="379" height="363" alt="Snipaste_2025-08-08_16-54-52" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-08_16-54-52.png" />

## 六、更新：Git使用和上传代码到github
- 首先在github里创建一个代码仓库
- <img width="430" height="450" alt="Snipaste_2025-08-13_07-30-27" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-30-27.png" />
- 点击New后我们可以看到这样的界面，先填入你仓库名字，再给一些介绍，选择仓库是否对外开放（一般选择Public）,是否添加阅读文件（这里我们选择是），是否选择仓库模板(这里我们不选择)，是否选择开源协议（这里我也不选择），然后点击Create repository创建仓库
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-30-49" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-30-49.png" />
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-34-25" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-34-25.png" />
- 创建完后我们可以看到这样的页面
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-34-48" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-34-48.png" />
- 我们点击右上角的Code，复制仓库链接
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-35-23" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-35-23.png" />
- 接下来我们在本地创建一个文件夹用来放上传仓库的文件
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-36-29" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-36-29.png" />
- 我们进入文件夹，点击鼠标右键选择显示更多选项，然后点击Open Git Bash here，在git里输入git init，然后回车（后面所有指令输入完都是回车运行）
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-37-35" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-37-35.png" />
- 然后我们可以看到生成了一个.git文件，看不到的点击查看，打开显示，选择隐藏的项目
- <img width="470" height="450" alt="屏幕截图 2025-08-13 073829" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/屏幕截图 2025-08-13 073829.png" />
- 我们接下来再把要上传的代码复制到这个文件夹
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-39-24" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-39-24.png" />
- 在git里输入git add .（注意这里字母和.之间有一个空格）
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-40-04" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-40-04.png" />
- 运行完指令后，输入git commit -m "第一次上传代码"，""这里面的内容可以自己随便填写，一般填写的是上传代码更新的内容
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-41-05" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-41-05.png" />
- 运行完后，我们再输入git branch -M main
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-41-50" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-41-50.png" />
- 运行完后，我再输入git remote add origin + 你刚刚复制的链接（这里的粘贴只能通过鼠标右键，ctrl+v没用）
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-43-09" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-43-09.png" />
-  <img width="470" height="450" alt="屏幕截图 2025-08-13 074242" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/屏幕截图 2025-08-13 074242.png" />
- 运行完后，我们再输入git push -u origin main,上传代码到仓库
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-43-45" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-43-45.png" />
- 然后运行完我们可以看到报错了，这是因为两个仓库内容不一致（因为我们创建仓库时，生成了README.md文件，本地没有）
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-45-30" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-45-30.png" />
- 这里我们输入git pull origin main --allow-unrelated-histories，进行历史版本合并
- 运行完后，会进入这样的界面，我们按一下键盘上的 Esc 键，输入（:wq），按回车，保存并退出。
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-51-39" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-51-39.png" />
- 最后我们再输入git push origin main 即可上传代码
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-43-45" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-43-45.png" />
- 我们来到网址上刚刚创建的代码仓库，刷新可以看到，上传的代码已经在这里了
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-52-45" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-52-45.png" />
- 如果我们的代码仓库有内容更新了，我们想让本地的也进行更新，可以打开本地的文件夹，一样是Open Git Bash here, 输入git pull origin main
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-54-25" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-54-25.png" />
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-55-02" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-55-02.png" />
- 此时我们可以看到我们的文件已经更新了
- <img width="470" height="450" alt="Snipaste_2025-08-13_07-55-33" src="https://github.com/RM-ITL/Electronic-control_Environment/blob/main/images/Snipaste_2025-08-13_07-55-33.png" />
## 五、写在最后
- jlink烧录和下载已经更新
- 用别人工程前先把他的build文件夹删除，重新生成，不然会出现路径错误问题
- 因为我也刚学不久，有些地方可能有bug或不足，欢迎及时和我反馈QQ:3305708832
- 感谢B站大佬linkyourbin，ControlCoreX,大家如果想了解更多关于工具链的知识可以看https://b23.tv/k3Q2581和https://b23.tv/gj3xWhn
- 当前已知问题stm32f103系列芯片脚本改完后，芯片选择不对，需要自行修改。




