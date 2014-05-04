path = require 'path'

Git  = require path.join(process.cwd(), './index.js')

describe 'Branch', ->

  beforeEach (done) ->

    git = new Git

    git.init().done ->

      done()

  afterEach (done) ->

    git = new Git

    git.destroy().done ->

      done()

  it 'should have no local branches', (done) ->

    git = new Git

    git.branch.list().done (res) ->

      expect(res).to.be.an 'array'
      expect(res.length).to.equal 0

      done()

  it 'should create a branch', (done) ->

    git = new Git

    git.branch.create({name: 'foo'}).done (res) ->

      expect(res).to.be.a 'boolean'
      expect(res).to.be.true

      done()

  it 'should create a branch (shorthand)', (done) ->

    git = new Git

    git.branch.create('foo').done (res) ->

      expect(res).to.be.a 'boolean'
      expect(res).to.be.true

      done()
