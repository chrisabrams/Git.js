path = require 'path'

Git  = require path.join(process.cwd(), './index.js')

describe 'Branch', ->

  beforeEach (done) ->

    options =
      cwd: __testTempPath

    git = new Git

    git.init(options).done ->

      done()

  afterEach (done) ->

    options =
      cwd: __testTempPath

    git = new Git

    git.destroy(options).done ->

      done()

  it 'should have no local branches', (done) ->

    options =
      cwd: __testTempPath

    git = new Git

    git.branch.list(options).done (res) ->

      expect(res).to.be.an 'array'
      expect(res.length).to.equal 0

      done()

  it 'should create a branch', (done) ->

    options =
      cwd: __testTempPath
      name: 'foo'

    git = new Git

    git.branch.create(options).done (res) ->

      expect(res).to.be.a 'boolean'
      expect(res).to.be.true

      done()
