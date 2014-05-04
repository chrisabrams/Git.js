"use strict"

module.exports = (grunt) ->

  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: [
            'coffee-script/register'
            './test/helpers.coffee'
          ]
        src: [
          'test/integration/git/init.coffee'
          'test/integration/git/branch.coffee'
          'test/integration/git/destroy.coffee'
        ]

  grunt.registerTask 'test', ['mochaTest']
