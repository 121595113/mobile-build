# mobile-build
> 让移动端布局开发更加容易

### 介绍

- `mobile-build`是一个移动端布局开发解决方案。使用`mobile-build`可以让移动端布局开发更容易。

- 使用rem为单位，为此分装了rem-calc()方法，可以方便的把px转成rem。

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

### 优势

- 保证不同设备下的统一视觉体验。
- 支持任意尺寸的设计图，不局限于特定尺寸的设计图。
- 支持单一项目，多种设计图尺寸，专为解决大型，长周期项目。
- 提供`px-to-rem`转换方法，CSS布局，零成本转换，原始值不丢失。

### 劣势

- 未能解决1px的描边问题

### 准备
1. 需要先安装sass和compass[安装教程](http://www.w3cplus.com/sassguide/install.html)
2. [mac上ruby安装的教程](http://itcourses.cs.unh.edu/assets/docs/704/reports/fall11/Ruby%20on%20Rails%20Tutorial%20-%20Eric%20Callan.pdf)

```bash
> git clone https://github.com/121595113/mobile-build.git
> cd mobile-build
> compass watch
```
