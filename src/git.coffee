Base = require './base/index'
Q    = require 'q'

module.exports = class Git extends Base

  branch: new (require './git/branch')

  ###
  destroy {Function}

  return {Promise}
         {Promise.resolve} {Boolean}

  ###

  destroy: ->

    spawnOptions =
      resolveOnClose: true

    return @spawn(spawnOptions, 'rm', ['-rf', '.git'])

  ###
  init {Function}

  return {Promise}
         {Promise.resolve} {Boolean}

  ###

  init: ->

    spawnOptions = {}

    return @spawn(spawnOptions, 'git', ['init'])
