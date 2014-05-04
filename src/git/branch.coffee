Base  = require '../base/index'

module.exports = class Branch extends Base

  ###
  create {Function}

  Arguments:
  options {Object}
  options.branch {String} Name of branch to branch from (no pun intended)
  options.name {String} Name of new branch
  options.remote {String} Name of remote. Optional argument, but if used, branch is required.

  Description:
  Creates a new git branch

  return {Promise}
         {Promise.resolve} {Boolean}

  ###

  create: (options) ->

    spawnOptions =
      resolveOnError: true
      stderr: ->
        return true

    if typeof options is 'object'
      name = options.name

    else
      name = options

    spawnArgs = ['checkout', '-b', name]

    if options.remote and options.branch

      spawnArgs = spawnArgs.concat ["#{options.remote}/#{options.branch}"]

    else if options.branch

      spawnArgs = spawnArgs.concat [options.branch]

    return @spawn(spawnOptions, 'git', spawnArgs)


  ###
  list {Function}

  return {Promise}
         {Promise.resolve} {Array}

  Comments:
  spawnOptions.stdout() is taking (for example):
  * master
    foo

  and instead returning it as an array: ['master', 'foo']

  ###

  list: (option) ->

    spawnOptions =
      defaultValue: []
      stdout: (data) ->
        return data.toString().replace('* ', '').replace(/\s{2,}/g, ' ').split(' ')

    return @spawn(spawnOptions, 'git', ['branch'])
