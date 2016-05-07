# mobile-build
> 让移动端布局开发更加容易

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
|   |     |——_function //@mixin和@function都在这里
|   |     |——sass //样式源文件
│   ├── css //编译后css文件在这里
│   ├── example //案例
│   └── images //图片资源
│
└── dist	//文件压缩打包后的文件夹,执行grunt 或 grunt build生成
    ├── css
```

### 劣势

- 未能解决1px的描边问题

### 用法

####在scss文件中引入_mobile-mixin.scss

```scss
@import "compass", "mobile-mixin";
```

**注：** "compass"是compass默认需要引，"mobile-mixin"才是我们要引进的_mobile-mixin.scss文件。插件都是通过开关形式开启和关闭的，具体配置相如下

```scss
$rem-base: 16px !default;//设计搞尺寸，默认值16px，是依据设计稿字体大小定制的。同时，你也可以根据设计搞的宽度来订（例如：320 480 640 720 750，但不仅限与此）,其与字体大小对应关系12:320 18:480 24:640 27:720。
$reset:false !default;//是否开启样式重置
$Response:false !default;//是否开启自适应功能
```
具体使用如下：
```scss
$rem-base: 27;// or 720
$reset:true;// 开启样式重置
@import "compass", "mobile-mixin";
```
**注：** 不需要修改的配置可以不写，根据自己的实际情况决定是否开启

### 准备
1. 需要先安装sass和compass[安装教程](http://www.w3cplus.com/sassguide/install.html)
2. [mac上ruby安装的教程](http://itcourses.cs.unh.edu/assets/docs/704/reports/fall11/Ruby%20on%20Rails%20Tutorial%20-%20Eric%20Callan.pdf)

```bash
> git clone https://github.com/121595113/mobile-build.git
> cd mobile-build
> compass watch
```
