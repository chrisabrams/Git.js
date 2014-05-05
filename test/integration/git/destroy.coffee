fs    = require 'fs'
path  = require 'path'
spawn = require('child_process').spawn

Git   = require path.join(process.cwd(), './index.js')

describe 'Destroy', ->

  it 'should destroy a git repository', (done) ->

    # Init a repo to be destroyed
    proc = spawn('git', ['init'], {cwd: __testTempPath})

    proc.on 'close', ->

      options =
        cwd: __testTempPath

      git = new Git

      git.destroy(options).done (res) ->

          exists = fs.existsSync(path.join(__testTempPath, '.git'))

          expect(exists).to.be.false

          done()
