fs    = require 'fs'
path  = require 'path'
spawn = require('child_process').spawn

Git   = require path.join(process.cwd(), './index.js')

describe 'Destroy', ->

  it 'should destroy a git repository', (done) ->

    git = new Git

    git.destroy().done (res) ->

      proc = spawn('rm', ['-rf', '.git'])

      proc.on 'close', ->

        exists = fs.existsSync(path.join(process.cwd(), '.git'))

        expect(exists).to.be.false

        done()
