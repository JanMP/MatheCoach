{ Mongo } = require "meteor/mongo"
{ Meteor } = require "meteor/meteor"

{ Scores } = require "/imports/api/scores.coffee"

require "./users.coffee"

Submissions = new Mongo.Collection "submissions"
Submissions.schema = new SimpleSchema
  userId :
    type : String
  moduleKey :
    type : String
  level :
    type : Number
  answerCorrect :
    type : Boolean
  score :
    type : Number
  date :
    type : Date
  description :
    type : String
  problem :
    type : String
  answer :
    type : String
    optional : true
  skipExpression :
    type : Boolean
    optional : true
  SVGData :
    type : Object
    optional : true
    blackbox : true
  functionData :
    type : Object
    optional : true
    blackbox : true
  customTemplateName :
    type : String
    optional : true
  customTemplateData :
    type : Object
    optional : true
    blackbox : true
Submissions.attachSchema Submissions.schema
exports.Submissions = Submissions

exports.resetSubmissions = new ValidatedMethod
  name : "resetSubmissions"
  validate :
    new SimpleSchema
      moduleKey :
        type : String
    .validator()
  run : ({moduleKey}) ->
    unless @userId
      throw new Meteor.Error "not logged-in"
    LevelScores.remove
      userId : @userId
      moduleKey : moduleKey

exports.insertSubmission = new ValidatedMethod
  name : "insertSubmission"
  validate :
    new SimpleSchema
      moduleKey :
        type : String
      level :
        type : Number
      answerCorrect :
        type : Boolean
      score :
        type : Number
      description :
        type : String
      problem :
        type : String
      answer :
        type : String
      date :
        type : Date
      skipExpression :
        type : Boolean
        optional : true
      SVGData :
        type : Object
        optional : true
        blackbox : true
      functionData :
        type : Object
        optional : true
        blackbox : true
      customTemplateName :
        type : String
        optional : true
      customTemplateData :
        type : Object
        optional : true
        blackbox : true
    .validator()
  run : ( submission )->
    unless @userId
      throw new Meteor.Error "not logged-in"
    now = new Date()
    submission.userId = @userId
    unless submission.answerCorrect
      submission.score = 0
    Submissions.insert submission
    Meteor.users.update @userId,
      $set :
        lastActive : now
    if submission.answerCorrect
      selector =
        userId : @userId
        category : submission.moduleKey
      Scores.update selector,
        {$inc : {score : submission.score}},
        {upsert : true}
    return true
