fs    = require 'fs'
path  = require 'path'
spawn = require('child_process').spawn

Git   = require path.join(process.cwd(), './index.js')

describe 'Init', ->

  it 'should init a git repository', (done) ->

    options =
      cwd: __testTempPath

    git = new Git

    git.init(options).done (res) ->

      exists = fs.existsSync(path.join(__testTempPath, '.git'))

      expect(exists).to.be.true

      proc = spawn('rm', ['-rf', '.git'], {cwd: __testTempPath})

      proc.on 'close', ->

        done()
