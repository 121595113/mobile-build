'use strict';
module.exports = function(grunt) {
    // 加载任务
    require('jit-grunt')(grunt);
    // 计算任务所需时间
    require('time-grunt')(grunt);
    // 配置项目路径
    var config = {
        app: 'app',
        dist: 'dist'
    }

    // 配置任务
    grunt.initConfig({
        config: config,
        pkg: grunt.file.readJSON('package.json'),

        clean: {
            build: {
                src: ['<%= config.dist %>']
            },
            server: {
                src: [
                    '<%= config.dist %>/css',
                    '<%= config.dist %>/images',
                    '<%= config.dist %>/*.{gif,jpeg,jpg,png}',
                ]
            }
        },


        compass: {
            development: {
                options: {
                    importPath: '<%= config.app %>/_source/_function/',
                    sassDir: '<%= config.app %>/_source/sass/',
                    cssDir: '<%= config.app %>/css/',
                    imagesDir: '<%= config.app %>/images/',
                    relativeAssets: true,
                    outputStyle: 'expanded',
                    sourcemap: true,
                    noLineComments: true,
                }
            }
        },

        postcss: {
            options: {
                map: true,
                processors: [
                    // Add vendor prefixed styles
                    require('autoprefixer')({
                        browsers: ['> 0.5%', 'last 2 versions', 'Firefox ESR']
                    })
                ]
            },

            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= config.app %>/css/',
                    src: '{,*/}*.css',
                    dest: '<%= config.app %>/css/'
                }]
            }
        },

        cssmin: {
            build: {
                files: [{
                    expand: true,
                    cwd: '<%= config.app %>/css',
                    src: ['{,*/}*.css'],
                    dest: '<%= config.dist %>/css',
                    // ext: '.css'
                }]
            }
        },


        watch: {
            compass: {
                files: '<%= config.app %>/_source/**/*.scss',
                tasks: ['compass', 'newer:postcss']
            },
            gruntfile: {
                files: ['Gruntfile.js']
            }
        },


    });

    // 定义任务

    grunt.registerTask('server', '开启开发模式', function(target) {
        grunt.log.warn('开启开发模式');
        grunt.task.run([
            'clean:server',
            'compass',
            'postcss',
            'cssmin',
            'watch'
        ]);

    });

    grunt.registerTask('build', '开启生产模式', [
        'clean:build',
        'compass',
        'postcss',
        'cssmin'
    ]);

    grunt.registerTask('default', '默认任务', [
        'build'
    ]);

};
