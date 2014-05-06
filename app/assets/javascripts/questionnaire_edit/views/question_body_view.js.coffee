QuestionnaireEdit.QuestionBodyView = Ember.View.extend
  templateName: (->
    "question_body/#{_.string.underscored @get('content.type').replace("Questions::", "")}"
  ).property('content.type')
  
  radioLayoutClass: ( ->
    "layout-#{@get "content.radioLayout"}"
  ).property('content.radioLayout')