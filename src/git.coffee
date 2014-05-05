Base   = require './base/index'
#Branch = require './git/branch'
Q      = require 'q'

module.exports = class Git extends Base

  ###
  add {Function}

  Arguments:
  When no arguments are passed, the current working directory will add all changes
  to files that have been previously staged.

  When arguments are passed:  
  options {Object}
  options.force {Boolean} Whether to force add files
  options.path {String} Path to files to be added

  return {Promise}

  ###

  add: (options) ->

    spawnOptions =
      resolveOnClose: true

    spawnArgs = ['add']

    # If no arguments are passed, then just add the current working directory
    unless arguments.length > 0
      spawnArgs = spawnArgs.concat ['.']

    if options?.force
      spawnArgs = spawnArgs.concat ['-f']

    spawnArgs = spawnArgs.concat [options.path]

    return @spawn(spawnOptions, 'git', spawnArgs)

  branch: new (require './git/branch')

  commit: () ->

  ###
  destroy {Function}

  return {Promise}
         {Promise.resolve} {Boolean}

  ###

  destroy: (options) ->

    spawnOptions =
      resolveOnClose: true

    if options?.cwd
      spawnOptions.cwd = options.cwd

    return @spawn(spawnOptions, 'rm', ['-rf', '.git'])

  ###
  init {Function}

  return {Promise}
         {Promise.resolve} {Boolean}

  ###

  init: (options) ->

    spawnOptions = {}

    if options?.cwd
      spawnOptions.cwd = options.cwd

    return @spawn(spawnOptions, 'git', ['init'])

  remove: ->
