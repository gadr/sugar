module.exports = (grunt) ->
  pkg = grunt.file.readJSON('package.json')

  verbose = grunt.option('verbose')
  
  open = "http://localhost:3000"

  errorHandler = (err, req, res, next) -> 
    errString = err.code?.red ? err.toString().red
    grunt.log.warn(errString, req.url.yellow)
              
  config =
    clean:
      main: ['build']

    copy:
      main:
        files: [
          expand: true
          cwd: 'src/'
          src: ['**', '!**/*.coffee', '!**/*.less']
          dest: "build/"
        ]

    coffee:
      main:
        files: [
          expand: true
          cwd: 'src/'
          src: ['**/*.coffee']
          dest: "build/"
          ext: '.js'
        ]

    less:
      main:
        files: [
          expand: true
          cwd: 'src/'
          src: ['main.less']
          dest: "build/"
          ext: '.css'
        ]

    cssmin:
      main:
        expand: true
        cwd: 'build/'
        src: ['*.css', '!*.min.css']
        dest: 'build/'
        ext: '.min.css'

    uglify:
      options:
        mangle: false
      main:
        files: [{
          expand: true
          cwd: 'build/'
          src: ['*.js', '!*.min.js']
          dest: 'build/'
          ext: '.min.js'
        }]

    imagemin:
      main:
        files: [
          expand: true
          cwd: 'src/'
          src: ['**/*.{png,jpg,gif}']
          dest: 'build/'
        ]

    connect:
      http:
        options:
          hostname: "*"
          open: open
          port: 3000
          middleware: [
            require('connect-livereload')({disableCompression: true})
            require('connect').static('./build/')
            errorHandler
          ]

    watch:
      options:
        livereload: true
        spawn: false
      coffee:
        files: ['src/**/*.coffee']
        tasks: ['coffee']
      less:
        files: ['src/**/*.less']
        tasks: ['less']
      images:
        files: ['src/**/*.{png,jpg,gif}']
        tasks: ['imagemin']
      main:
        files: ['src/**/*.*']
        tasks: ['copy']
      grunt:
        files: ['Gruntfile.coffee']

  tasks =
    # Building block tasks
    build: ['clean', 'copy:main', 'coffee', 'less', 'imagemin']
    min: ['uglify', 'cssmin'] # minifies files
    # Deploy tasks
    dist: ['build', 'min'] # Dist - minifies files
    test: []
    # Development tasks
    default: ['build', 'connect', 'watch']
    devmin: ['build', 'min',
             'connect:http:keepalive'] # Minifies files and serve

  # Project configuration.
  grunt.initConfig config
  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-'
  grunt.registerTask taskName, taskArray for taskName, taskArray of tasks
