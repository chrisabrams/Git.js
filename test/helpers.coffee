path = require 'path'

global.__testTempPath = path.join(process.cwd(), './test/tmp')

global.expect = require('chai').expect
