# mobile-build
> 让移动端布局开发更加容易

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

#### _rem-calc.scss

```scss
$rem-base: 16px !default; // 默认根据浏览器默认字体大小设置，可以改成其他值，如（12，18，24，27）。也可以根据设计稿尺寸大小设置，如（320，480，640，720）

// 字符串转数值
@function strip-unit($num) {
    @return $num / ($num * 0 + 1);
}

/**
 * 把px转换成rem
 * @param  {Number,String} $value       要转换的值
 * @param  {Number} $base-value: $rem-base     计算转换参考的基数，默认16px
 * @return {Number,String}              转换后的值
 */
@function convert-to-rem($value, $base-value: $rem-base) {
    // Check if the value is a number
    @if type-of($value) !='number' {
        @if $value !=auto {
            @warn inspect($value) + ' was passed to rem-calc(), which is not a number or "auto".';
        }
        @return $value;
    }
    // Calculate rem if units for $value is not rem
    @if unit($value) !='rem' {
        @if strip-unit($base-value) < 320 {
            $value: strip-unit($value) / strip-unit($base-value) * 1rem;
        }
        @else {
            $value: strip-unit($value) * 320 / strip-unit($base-value) / 12 * 1rem;
        }
    }
    // Turn 0rem into 0
    @if $value==0rem {
        $value: 0;
    }
    @return $value;
}

// ============================
// REM CALC 
// ============================
// New Syntax, allows to optionally calculate on a different base value to counter compounding effect of rem's.
// Call with 1, 2, 3 or 4 parameters, 'px' is not required but supported:
// 
//   rem-calc(10 auto 30px 40);
// 
// Space delimited, if you want to delimit using comma's, wrap it in another pair of brackets
// 
//   rem-calc((10, 20, 30, 40px));
// 
// Optionally call with a different base (eg: 8px) to calculate rem.
// 
//   rem-calc(16px 32px 48px, 8px);
// 
// If you require to comma separate your list
// 
//   rem-calc((16px, 32px, 48), 8px);

/**
 * 将px转换成rem的具体实现
 * @param  {Number,Array} $values      要转换的数值，活着一组要转换的数值
 * @param  {Number} $base-value: $rem-base     计算转换参考的基数，默认16px
 * @return {Number,String}              转换后的值
 */
@function rem-calc($values, $base-value: $rem-base) {
    $rem-values: ();
    $count: length($values);
    @if $count==1 {
        @return convert-to-rem($values, $base-value);
    }
    @for $i from 1 through $count {
        $rem-values: append($rem-values, convert-to-rem(nth($values, $i), $base-value));
    }
    @return $rem-values;
}
```
#### _rem-sprites.scss

```scss
@import "compass";
/**
 * 计算宽度
 * @param  {url} $map       合成后图片的url
 * @param  {图片名称} $item:null 指定图片的名称
 * @param  {Number} $rem-base: $rem-base     合图使用的计算基数，可以根据字体大小也可以根据设计稿尺寸设定
 * @return {Number}            转换后值
 */
@function calc-width($map, $item:null, $rem-base: $rem-base) {
    @if $item {
        @return rem-calc(sprite-width($map, $item), $rem-base);
    }
    @else {
        @return rem-calc(sprite-width($map), $rem-base);
    }
}

/**
 * 计算高度
 * @param  {url} $map       合成后图片的url
 * @param  {图片名称} $item:null 指定图片的名称
 * @param  {Number} $rem-base: $rem-base     合图使用的计算基数，可以根据字体大小也可以根据设计稿尺寸设定
 * @return {Number}            转换后值
 */
@function calc-height($map, $item:null, $rem-base: $rem-base) {
    @if $item {
        @return rem-calc(sprite-height($map, $item), $rem-base);
    }
    @else {
        @return rem-calc(sprite-height($map), $rem-base);
    }
}

$sprites:() !default;
$lists:() !default;
/**
 * 单个合图引用私有mixin
 * @param  {url} $map                合图后的返回的url
 * @param  {图片名称} $name           指定图片的名称
 * @param  {Boolean} $dimensions:true    指定是否输出width和height
 * @param  {Boolean} $active:false       指定是否添加点击状态
 * @param  {Number} $rem-base:$rem-base 合图使用的计算基数，可以根据字体大小也可以根据设计稿尺寸设定
 * @param  {Boolean} $line-image:false   指定图片引用是否采用base,默认为false
 * @return {无}                 
 */
@mixin _rem-sprite($map, $name, $dimensions:true, $active:false, $rem-base:$rem-base,$line-image:false) {
    $dir-name: sprite-map-name($map);
    $my-args: ($dir-name);
    $names: sprite-names($map);
    @if index($sprites, $my-args)==null {
        $sprites: append($sprites, $my-args) !global;
        @debug sprite-url($map);
        @at-root {
            @each $name in $names {
                $iconPosXInSprite: nth(sprite-position($map, $name), 1);
                $iconPosYInSprite: nth(sprite-position($map, $name), 2);
                @if $iconPosXInSprite !=0 {
                    $iconPosXInSprite: $iconPosXInSprite / (sprite-width($map, $name) - sprite-width($map)) * 100%;
                }
                @if $iconPosYInSprite !=0 {
                    $iconPosYInSprite: $iconPosYInSprite / (sprite-height($map, $name) - sprite-height($map)) * 100%;
                }
                $lists: map-merge($lists, (#{$my-args}-size: calc-width($map) calc-height($map))) !global;
                $lists: map-merge($lists, (#{$my-args+"-"+$name}: ( name: $name, width: calc-width($map, $name, $rem-base), height: calc-height($map, $name, $rem-base), position: $iconPosXInSprite $iconPosYInSprite))) !global;
            }
            %#{$my-args} {
                @if $line-image == true {
                    background: inline-sprite($map);
                } @else {
                    background: sprite-url($map);
                }
                background-size: map-get($lists, #{$my-args}-size);
                background-repeat: no-repeat;
            }
            @if $active {
                @each $name in $names {
                    $_activename: #{$my-args+"-"+$name}-active;
                    @if map-has-key($lists, $_activename) {
                        $id-active: map-get($lists, $_activename);
                        %#{$my-args+"-"+map-get($id-active,name)} {
                            @if $dimensions {
                                & {
                                    width: map-get($id-active, width);
                                    height: map-get($id-active, height);
                                    background-position: map-get($id-active, position);
                                }
                            }
                            @else {
                                & {
                                    background-position: map-get($id-active, position);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    & {
        @extend %#{$my-args};
    }
    $id:map-get($lists, #{$my-args+"-"+$name});
    $_activename: #{$my-args+"-"+$name}-active;
    $id-active:map-get($lists, $_activename);
    @if map-has-key($lists, $_activename) {
        &:active {
            @extend %#{$my-args};
            @extend %#{$my-args+"-"+map-get($id-active,name)};
        }
    }
    @if $dimensions {
        & {
            width: map-get($id, width);
            height: map-get($id, height);
            background-position: map-get($id, position);
        }
    }
    @else {
        & {
            background-position: map-get($id, position);
        }
    }
}
/**
 * 合成图片多个引用的私有方法
 * @param  {url} $map                                 合图后的返回的url
 * @param  {Boolean} $dimensions:true                     指定是否输出width和height
 * @param  {Boolean} $active:true                         指定是否添加点击状态
 * @param  {String} $pre-name:null                       class的前缀，默认根据文件夹名称
 * @param  {String} $separator:$default-sprite-separator class中间的连接符
 * @param  {Number} $rem-base:$rem-base                  合图使用的计算基数，可以根据字体大小也可以根据设计稿尺寸设定
 * @param  {Boolean} $line-image:false                    指定图片引用是否采用base,默认为false
 * @return {无}                                      
 */
@mixin _rem-sprites($map, $dimensions:true, $active:true, $pre-name:null, $separator:$default-sprite-separator, $rem-base:$rem-base, $line-image:false) {
    $names: sprite-names($map);
    $dir-name: $pre-name or sprite-map-name($map);
    @each $name in $names {
        .#{$dir-name + $separator + $name} {
            @include _rem-sprite($map, $name, $dimensions, $active, $rem-base, $line-image);
        }
    }
}

/**
 * 公有单个合图图片的引用mixin
 * @param  {String} $dir-name:null      要合成图片的本地地址
 * @param  {图片名称} $name:null          指定图片的名称
 * @param  {Boolean} $dimensions:true    指定是否输出width和height
 * @param  {Boolean} $active:true        指定是否添加点击状态
 * @param  {Number} $rem-base:$rem-base 合图使用的计算基数，可以根据字体大小也可以根据设计稿尺寸设定
 * @param  {Number} $spacing:           0px           合成图片之间的间隔，默认为“0px”
 * @param  {Boolean} $line-image:false   指定图片引用是否采用base,默认为false
 * @return {无}                     
 */
@mixin rem-sprite($dir-name:null, $name:null, $dimensions:true, $active:true, $rem-base:$rem-base, $spacing: 0px, $line-image:false) {
    $map: null;
    @if $dir-name !=null and type-of($dir-name)==string {
        $map: sprite-map($dir-name, $spacing: $spacing);
        @if $name !=null {
            @include _rem-sprite($map, $name, $dimensions, $active, $rem-base, $line-image)
        }
        @else {
            @warn "==== 第二个参数必填，请输入具体的图片名称！====";
        }
    }
    @else {
        @warn "==== 请引入要合成的图片！====";
    }
}

/**
 * 公有多个合图图片的引用mixin
 * @param  {String} $dir-name:null                       要合成图片的本地地址
 * @param  {Boolean} $dimensions:true                     指定是否输出width和height
 * @param  {Boolean} $active:true                         指定是否添加点击状态
 * @param  {String} $pre-name:null                       class的前缀，默认根据文件夹名称
 * @param  {String} $separator:$default-sprite-separator class中间的连接符,默认“-”
 * @param  {Number} $rem-base:$rem-base                  合图使用的计算基数，可以根据字体大小也可以根据设计稿尺寸设定
 * @param  {Number} $spacing:                            0px           合成图片之间的间隔，默认为“0px”
 * @param  {Boolean} $line-image:false                    指定图片引用是否采用base,默认为false
 * @return {无}                                     
 */
@mixin rem-sprites($dir-name:null, $dimensions:true, $active:true, $pre-name:null, $separator:$default-sprite-separator, $rem-base:$rem-base, $spacing: 0px, $line-image:false) {
    $map: null;
    @if $dir-name !=null and type-of($dir-name)==string {
        $map: sprite-map($dir-name, $spacing: $spacing);
        @include _rem-sprites($map, $dimensions, $active, $pre-name, $separator, $rem-base,$line-image);
    }
    @else {
        @warn "==== 请引入要合成的图片！====";
    }
}
```

