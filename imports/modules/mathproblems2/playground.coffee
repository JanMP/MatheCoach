#this isn't loaded by meteor
#this is just to run test scripts straight from atom

_ = require "lodash"

nerdamer = require "../nerdamer/nerdamer.core.js"
require "../nerdamer/Solve.js"

math = require "../../../node_modules/mathjs"

{ teXifyAM } =
  require "./renderAM.coffee"

console.log nerdamer("(x^2+2*x+1)/(x+1)").text "fractions"