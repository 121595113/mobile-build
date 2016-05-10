# mobile-build
> 让移动端开发布局更加容易

### 新增特性

- 合图引用支持base64的方式，用法如下

```scss
...
@include rem-sprites(...,$line-image:true);
// or
div{
    @include rem-sprite(...,$line-image:true);
}
```

- 适配手机自定义

```scss
...
$Response:true;// 此项为true，下面的配置才有效
$mediaArrays:(320 480 640 720);//默认$mediaArrays:(320 360 400 480 540 640 720) !default;
@import "compass", "mobile-mixin";
```

### 介绍

- `mobile-build`是一个移动端布局开发解决方案。使用`mobile-build`可以让移动端布局开发更容易。
- 保证不同设备下的统一视觉体验。
- 支持任意尺寸的设计图，不局限于特定尺寸的设计图。
- 支持单一项目，多种设计图尺寸，专为解决大型，长周期项目。
- 提供`px-to-rem`转换方法，CSS布局，零成本转换，原始值不丢失。
- 遵循视觉一致性原则。在不同大小的屏幕和不同的设备像素密度下，让你的页面看起来是一样的。
- 不仅便捷了你的布局，同时它使用起来异常简单。可能你会说 `talk is cheap,show me the code`，那我现在列下mobile-build整个项目的目录结构。

```javascript
├── app	//所有的源文件目录
│   ├── _source //sass源文件以及封装的@mixin
│   │     ├──_bat //window下的批处理脚本
│   │     ├──_config //compass的ruby配置文件
│   │     ├──_sh //Mac下的批处理脚本
│   │     ├──_function //@mixin和@function都在这里
│   │     └──sass //样式源文件
│   ├── css //编译后css文件在这里
│   ├── example //案例
│   └── images //图片资源
│
└── dist	//文件压缩打包后的文件夹,执行grunt 或 grunt build生成
    ├── css
```

### 劣势

- 未能解决1px的描边问题

### 准备
1. 需要先安装sass和compass[安装教程](http://www.w3cplus.com/sassguide/install.html)
2. [mac上ruby安装的教程](http://itcourses.cs.unh.edu/assets/docs/704/reports/fall11/Ruby%20on%20Rails%20Tutorial%20-%20Eric%20Callan.pdf)
3. 下载项目文件到本地
```bash
> git clone https://github.com/121595113/mobile-build.git
```

###使用

####一、 使用批处理脚本

1. window系统可以双击_bat文件夹下的window下的批处理脚本*.bat结尾的文件,然后根据提示输入相应的指令即可。"d"表示开发模式，"p"表示生产模式，"n"表示取消；
2. Mac系统可以终端cd到_sh的文件下，然后将*.sh结尾的文件拖到终端里回车执行。不加参数默认执行的是开发模式，如果加"－p"参数回车后执行的是生产模式。

**注：**开发模式主要执行compass watch文件监听，而生产模式主要执行compass compile样式压缩的任务，可以根据自己的项目修改*.rb的配置项，里面都有相应的注释说明

####二、 使用grunt自动化构建工具

1. 首先确保您已安装了node和grunt。node的安装属于傻瓜式的安装，到[node官网](https://nodejs.org/en/)下载电脑对应的版本双击安装就可以了。
2. grunt使用npm安装，在安装node的时候node已经为我们安装了npm。在命令行执行

```bash
> npm install -g grunt-cli
```
将grunt安装到全局

```bash
> cd mobile-build
> npm install
> npm dedupe
> grunt server
```
此时修改会对.scss文件实时监听，想压缩打包css文件可以执行

```bash
> grunt build
```

### 用法

####在scss文件中引入_mobile-mixin.scss
```scss
@import "compass", "mobile-mixin";
```
**注：** "compass"是compass默认需要引入的，"mobile-mixin"才是我们要引进的_mobile-mixin.scss文件。其中包括样式重置模块、rem-calc()模块、自适应模块、精灵合图模块，而这些大部分都是通过开关形式开启和关闭的，具体配置相如下
```scss
$reset:false !default;//是否开启样式重置
$rem-base: 16px !default;//用于计算rem的基数，默认值16px，是依据设计稿字体大小定制的。同时，你也可以根据设计搞的宽度来订（例如：320 480 640 720 750，但不仅限与此）,其与字体大小对应关系12:320 18:480 24:640 27:720。
$Response:false !default;//是否开启自适应功能
```
具体使用如下：
```scss
$rem-base: 27;// or 720
$reset:true;// 开启样式重置
@import "compass", "mobile-mixin";
```
**注：** 不需要修改的配置可以不写，根据自己的实际情况决定是否开启，rem-sprite模块是没有开关功能的，不用的时候不会消耗什么性能

### 功能模块详解

- [_rem-calc.scss](https://github.com/121595113/mobile-build/wiki/rem-calc)
- [_rem-sprites.scss](https://github.com/121595113/mobile-build/wiki/rem-sprites)
- [_Response.scss](https://github.com/121595113/mobile-build/wiki/Response)
 
### 下载

- [v1.0.1](https://github.com/121595113/mobile-build/archive/1.0.1.zip)修复总宽度和单个图片使用基数不一致的问题
- [v1.0.0](https://github.com/121595113/mobile-build/archive/1.0.0.zip)正式版
（完）
