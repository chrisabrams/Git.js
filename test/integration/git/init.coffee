fs    = require 'fs'
path  = require 'path'
spawn = require('child_process').spawn

Git   = require path.join(process.cwd(), './index.js')

describe 'Init', ->

  it 'should init a git repository', (done) ->

    git = new Git

    git.init().done (res) ->

      exists = fs.existsSync(path.join(process.cwd(), '.git'))

      expect(exists).to.be.true

      proc = spawn('rm', ['-rf', '.git'])

      proc.on 'close', ->

        done()
