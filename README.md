# mobile-build
> 让移动端布局更加容易，方便后期维护

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
$mediaArrays:(320 480 640 720);//默认320 360 400 480 540 640 720
@import "compass", "mobile-mixin";
```
### 主要功能

1. 专为手机端定制的重置样式
2. px轻松转rem，操作简单，维护更方便
3. 适配各种手机尺寸
4. 精灵合图，合图后的单位采用rem，并且支持base64方式引用

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
3. 下载项目文件到本地[zip](https://github.com/121595113/mobile-build/releases)或git执行
```bash
> git clone https://github.com/121595113/mobile-build.git
```

### 使用

#### 方法一、 使用批处理脚本

1. window系统可以双击_bat文件夹下的window下的批处理脚本*.bat结尾的文件,然后根据提示输入相应的指令即可。"d"表示开发模式，"p"表示生产模式，"n"表示取消；
2. Mac系统可以终端cd到_sh的文件下，然后将*.sh结尾的文件拖到终端里回车执行。不加参数默认执行的是开发模式，如果加"－p"参数回车后执行的是生产模式。

**注：**开发模式主要执行compass watch文件监听，而生产模式主要执行compass compile样式压缩的任务，可以根据自己的项目修改*.rb的配置项，里面都有相应的注释说明

#### 方法二、 使用grunt自动化构建工具

1.首先确保您已安装了node和grunt。node的安装属于傻瓜式的安装，到[node官网](https://nodejs.org/en/)下载电脑对应的版本双击安装就可以了。
2.grunt使用npm安装，在安装node的时候node已经为我们安装了npm。命令行执行下面的命令将grunt安装到全局
```bash
> npm install -g grunt-cli
```
3.命令行cd到已下载的项目的根目录下，也就是package.json所在的目录执行下面命令安装node依赖
```bash
> npm install
```
4.如果你的npm是最新的版本npm3，可以执行下面的命令拉平node_modules文件夹（此步可忽略）
```bash
> npm dedupe
```
5.执行下面的命令开启实时监听，到此可以愉快的编码了
```bash
> grunt server
```
6.项目最后需要合并压缩css,并且需要为兼容不同的浏览器添加厂商前缀，执行
```bash
> grunt build
```

### scss怎么写

#### 一、在scss文件中引入_mobile-mixin.scss

```scss
@import "compass", "mobile-mixin";
```

#### 二、可配置项如下：

```scss
$reset:true; // 是否开启样式重置,默认false
$rem-base: 720; // 用于计算rem的基数，默认值16px，依据设计稿字体大小而定。也可以根据设计搞的宽度来定，如：320 480 640 720 750，但不仅限与此。字体大小与设计稿的对应关系12:320 18:480 24:640 27:720。
$Response:true; // 是否开启自适应功能，默认为false
$mediaArrays:(320 375 480 640 720); // 可自定义适配手机数组，默认支持320 360 400 480 540 640 720的手机

//合图功能默认集成到mobile-mixin，不需要配置
@import "compass", "mobile-mixin";
```

### 功能模块详解

#### 一、@function

##### rem-calc($values[, $base-value]) 将px转换成rem的函数
- `$value` 必填参数，可以是数值，也可以是数组。单位`px`可以省略，数组中支持`auto`
- `$base-value` 可选参数，用来计算rem的基准值。默认值是全局设置的`$rem-base`，可以根据字体大小设置，也可以根据设计稿大小设置

使用案例：
```scss
div{
    width: rem-calc(28);
    height: rem-calc(24px, 27);// 27是字体大小
    margin: rem-calc(10 auto 20);
    background-size: rem-calc(10px 20,720);// 720是设计稿大小
}
```

- [_rem-calc.scss](https://github.com/121595113/mobile-build/wiki/rem-calc)
- [_rem-sprites.scss](https://github.com/121595113/mobile-build/wiki/rem-sprites)
- [_Response.scss](https://github.com/121595113/mobile-build/wiki/Response)
 

（完）
