# mobile-build
快速创建自适应的手机项目
# sass compass images sprites combines hotcss

## Usage  

### 准备
1. 需要先安装sass和compass[安装教程](http://www.w3cplus.com/sassguide/install.html)
2. [mac上ruby安装的教程](http://itcourses.cs.unh.edu/assets/docs/704/reports/fall11/Ruby%20on%20Rails%20Tutorial%20-%20Eric%20Callan.pdf)

```bash
> git clone https://github.com/liuyan5258/compass-images-sprites.git
> cd compass-images-sprites
> compass watch
```  

### show
1. 放入icons文件中的图标会自动合并在icons-*.png中，期间不需要做任何操作
2. 在px2rem.scss中有px转换成rem的计算
	
		// this is psd width
		$designWidth: 750;

		// 这里是设计稿的实际大小，等雪碧图生成后需要手动补上
		$bigWidth: 128px;
		$bigHeight: 326px;

		@function px2rem ($px) {
			@if (type-of($px) == "number") {
				@return $px / 1px * 320 / $designWidth / 20 * 1rem;
			}
			
			@if (type-of($px) == "list") {
		  		@if (nth($px, 1) == 0 and nth($px, 2) != 0) {
		    		@return 0 nth($px, 2) / 1px * 320 / $designWidth / 20 * 1rem;
		  		} @else if (nth($px, 1) == 0 and nth($px, 2) == 0)  {
		    		@return 0 0;
		  		} @else if (nth($px, 1) != 0 and nth($px, 2) == 0) {
		    		@return nth($px, 1) / 1px * 320 / $designWidth / 20 * 1rem 0;
		  		} @else {
		    		@return nth($px, 1) / 1px * 320 / $designWidth / 20 * 1rem nth($px, 2) / 1px * 320 / $designWidth / 20 * 1rem;
		  		}
			}
		}

		@mixin sprite-info ($icons, $name) {
			width: px2rem(image-width(sprite-file($icons, $name)));
			height: px2rem(image-height(sprite-file($icons, $name)));
			background-image: sprite-url($icons);
			background-position: px2rem(sprite-position($icons, $name));
			background-size: px2rem(($bigWidth, $bigHeight));
			background-repeat: no-repeat;
		}

3. 在screen.scss中代码

		// about sprite-layouts : http://compass-style.org/help/tutorials/spriting/sprite-layouts/
		// [diagonal]:左下右上对角排列
		// [horizontal]:水平排列
		// [vertical]:垂直排列
		// [smart]:比较灵活的一种排列方式
		// [spacing]:每个小图之间的间隙
		// 
		$icons: sprite-map("../images/icons/*.png", $spacing: 1px, $layout: vertical);

		@import 'px2rem';

		nav{
			li.contact{
				@include sprite-info($icons, contact);
			}
			li.key{
				@include sprite-info($icons, key);
			}
		}

4. 自动编译后在css中的样子

		nav li.contact { width: 0.68267rem; height: 0.68267rem; background-image: url('/images/icons-s11a22e331e.png'); background-position: 0 -2.752rem; background-size: 2.73067rem 6.95467rem; background-repeat: no-repeat; }
		nav li.key { width: 0.68267rem; height: 0.68267rem; background-image: url('/images/icons-s11a22e331e.png'); background-position: 0 -3.456rem; background-size: 2.73067rem 6.95467rem; background-repeat: no-repeat; }


5. 如果你用了hotcss来做页面的适配，需要在你用到的html中加入以下代码：

		<!--引入hotcss.js-->
		<script>
		  (function(window,document){(function(){var viewportEl=document.querySelector('meta[name="viewport"]'),hotcssEl=document.querySelector('meta[name="hotcss"]'),dpr=window.devicePixelRatio||1;if(hotcssEl){var hotcssCon=hotcssEl.getAttribute("content");if(hotcssCon){var initialDpr=hotcssCon.match(/initial\-dpr=([\d\.]+)/);if(initialDpr){dpr=parseFloat(initialDpr[1])}}}var scale=1/dpr,content="width=device-width, initial-scale="+scale+", minimum-scale="+scale+", maximum-scale="+scale+", user-scalable=no";if(viewportEl){viewportEl.setAttribute("content",content)}else{viewportEl=document.createElement("meta");viewportEl.setAttribute("name","viewport");viewportEl.setAttribute("content",content);document.head.appendChild(viewportEl)}})();var hotcss={};hotcss.px2rem=function(px,designWidth){if(!designWidth){designWidth=parseInt(hotcss.designWidth,10)}return parseInt(px,10)*320/designWidth/20};hotcss.mresize=function(){var innerWidth=window.innerWidth;if(!innerWidth){return false}document.documentElement.style.fontSize=(innerWidth*20/320)+"px"};hotcss.mresize();window.addEventListener("resize",hotcss.mresize,false);window.addEventListener("load",hotcss.mresize,false);setTimeout(function(){hotcss.mresize()},300);window.hotcss=hotcss})(window,document);
		</script>

### why
制作“雪碧图”一般是前端优化的重要一步，主要作用当然就是减少HTTP请求数，加快页面的加载速度，当然，在生成雪碧图之前可以利用[智图](http://zhitu.isux.us/)工具先优化一下图标。然后，hotcss是一个很好的解决移动端布局的方案，结合它一块儿使用应该效果更好。


### todo
1. 结合gulp使用到自己的项目中

### fix
1. 忽略了background-position也要把px转换成rem



