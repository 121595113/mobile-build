require 'compass/import-once/activate'
# Require any additional compass plugins here.


# Set this to the root of your project when deployed:

http_path = "/"
additional_import_paths = ["_source/_function"]
sass_dir = "_source/sass"
css_dir = "css"
images_dir = "images"

# 压缩文件路径
cssDirCache="#{css_dir}/min/"

# 编译模式 nested，expanded，compact，compressed
output_style = :expanded

# 是否采用相对路径
relative_assets = true

# 是否显示调试注视，建议为false
line_comments = false

# 是否开启调试模式
sourcemap = true


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass


# environment 使用环境
if environment == :development
	sourcemap = false
	output_style = :compressed
end

if environment == :production
	css_dir = "#{cssDirCache}"
	sourcemap = false
	output_style = :compressed

	require "fileutils"
	cssMinIndex = 0
	sassAry = []
	Dir[sass_dir + "/[^\_]*.scss"].each { |file|
		filename = File.basename(file, File.extname(file))
		sassAry.push(filename + File.extname(file))
	}
	on_stylesheet_saved do |file|
		if File.exists?(file)
			filename = File.basename(file, File.extname(file))
			File.rename(file, css_dir + filename + ".min" + File.extname(file))
			cssMinIndex += 1
		end
	    # 删除map后缀文件
	    if File.directory?(css_dir) and cssMinIndex == sassAry.length
	      FileUtils.rm_r Dir.glob("#{css_dir}/../*.map")
	    end 
	    
	    # 移除min文件夹
	    if File.directory?(css_dir) and cssMinIndex == sassAry.length
	    	FileUtils.rm_r(css_dir)
	    end 

end

end
