module.exports = (grunt) ->

	grunt.initConfig



    copy:
      source_css:
        expand: true
        cwd:  'source/assets/css/'
        src:  '**/*.css'
        dest: '.tmp/assets/css/'

      build_css:
        expand: true
        cwd:  '.tmp/assets/css/'
        src:  ['**/*.css', '**/*.map']
        dest: 'build/assets/css/'

      source_js:
        expand: true
        cwd:  'source/assets/js/'
        src:  '**/*.js'
        dest: '.tmp/assets/js/'

      build_js:
        expand: true
        cwd: '.tmp/assets/js/'
        src: ['**/*.js', '**/*.map']
        dest: 'build/assets/js/'

      build_html:
        expand: true
        cwd: 'source/'
        src: ['**/*.html']
        dest: 'build/'

      build_svg:
        expand: true
        cwd: 'source/assets/svg/'
        src: ['**/*.svg']
        dest: 'build/assets/svg/'

    shell:
      build:
        command: 'rm -rf .tmp'

    sass:
      options:
        precision: 7
        sourcemap: true
      build:
        files: {
          '.tmp/assets/css/style.css': 'source/assets/sass/style.scss'
        }





    autoprefixer:
      options:
        browsers: ['last 2 version', 'ie 9', '> 1%']
      build:
        expand: true
        flatten: true
        cwd: '.tmp/assets/css/'
        src: '**/*.css'
        dest: '.tmp/assets/css/'






    coffee:
      build:
        options:
          bare: true
          sourceMap: true
        flatten: true
        expand: true
        cwd: 'source/assets/coffee/'
        src: ['*.coffee']
        dest: '.tmp/assets/js/'
        ext: '.js'



    watch:
      html:
        files: 'source/**/*.html'
        tasks: 'html'

      css:
        files: ['source/assets/css/**/*.css', 'source/assets/sass/**/*.scss']
        tasks: 'css'

      js:
        files: ['source/assets/js/**/*.js', 'source/assets/coffee/**/*.coffee']
        tasks: 'js'






    # !Load Tasks
    require("load-grunt-tasks") grunt

    # !Register Tasks
    grunt.registerTask 'default', [
      'shell'

      'css'

      'js'

      'html'

      'copy:build_svg'

      'watch'
    ]

    grunt.registerTask 'html', [
      'copy:build_html'
    ]

    grunt.registerTask 'css', [
      'sass'
      'copy:source_css'
      'autoprefixer'
      'copy:build_css'
    ]

    grunt.registerTask 'js', [
      'coffee'
      'copy:source_js'
      'copy:build_js'
    ]