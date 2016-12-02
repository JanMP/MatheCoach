require "./calculator.jade"

_ = require "lodash"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

math = require "mathjs"

{ teXifyAM } =
  require "/imports/client/mathproblems/renderAM.coffee"

{ AMString } =
  require "/imports/client/mathproblems/AMString.coffee"

Template.calculator.viewmodel
  input : ""

  amString : ->
    try
      output = new AMString(@input())
        .markReserved()
        .removeWhitespace()
        .productify()
        .unmarkReserved()
        .value()
    catch error
      console.log error
      output = "error"
    output

  nerdamerTeX : ->
    try
      output = nerdamer(@amString()).toTeX()
    catch error
      output = "error"
    output