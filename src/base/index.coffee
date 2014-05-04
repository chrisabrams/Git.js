Q     = require 'q'
path  = require 'path'
spawn = require('child_process').spawn

module.exports = class Base

  ###
  spawn {Function}

  Arguments:

  When options are passed:
  options {Object} Optional options to help with how spawn resolves & returns data
  options.code   {Function} Callback which returns error code before resolving
  options.debug {Boolean} Whether to console.log (hopefully) useful information
  options.defaultValue {Mixed} Provide a default value to be returned if stdout/stderr don't provide any data
  options.resolveOnClose {Boolean} Resolve on process close, regardless if stdout returned data
  options.resolveOnError {Boolean} Resolve on stderr, regardless if stdout returned data
  options.stdout {Function} Callback which returns stdout data before resolving
  options.stderr {Function} Callback which returns stderr data before resolving

  Description:
  Runs commands.

  ###

  spawn: () ->

    processData = false

    d = Q.defer()

    # No options were called; just run the command straight up
    if typeof arguments[0] isnt 'object'

      if options?.debug
        console.log "arguments", arguments

      proc = spawn.apply @, arguments

    # Options were passed; most likely to run callbacks on stdout/stderr
    else

      options = arguments[0]

      args = Array.prototype.slice.call(arguments)
      args.shift()

      if options?.debug
        console.log "args", args
    
      proc = spawn.apply @, args

    # Things went well; we got the data we requested
    proc.stdout.on 'data', (data) ->

      processData = true

      if options?.debug
        console.log "stdout", data.toString()

      res = data
      
      # Run optional passed callback on data
      if options?.stdout

        res = options.stdout.call @, data

      # For more info, see the close method below
      unless options?.resolveOnClose

        d.resolve(res)

    # Something went wrong
    proc.stderr.on 'data', (data) ->

      if options?.debug
        console.log "stderr", data.toString()

      res = data

      # Run optional passed callback on error data
      if options?.stderr
        res = options.stderr.call @, data

      ###
      For some odd reason, the git sometimes returns to stderr when one would
      expect it to return to stdout.

      Unfortunately this error has existed since 2010:
      http://git.661346.n2.nabble.com/Bugreport-Git-responds-with-stderr-instead-of-stdout-td4959280.html

      The main culprit is that Git has numerous authors and for some unknown
      reason, they think that "git checkout -b foo" should return on stderr
      instead of stdout. Explain that one to me and I'll buy you a case of wine.
      ###

      if options?.resolveOnError

        d.resolve res

      else

        d.reject res

    # Get the error code
    proc.on 'close', (code) ->

      if options?.debug
        console.log "code", code.toString()

      # Run optional passed callback on code
      if options?.close
        options.close.call @ code

      # Sometimes a command has no data; in this case, the resolution must happen on close
      # Optionally the option has been given to resolve on close even when data is returned
      if options?.resolveOnClose or not processData

        # Some commands expect a value back even when no data is returned
        if options?.defaultValue
          d.resolve(options.defaultValue)

        else
          d.resolve()

    return d.promise

  spawnRef: () ->

    return spawn.apply @, arguments
