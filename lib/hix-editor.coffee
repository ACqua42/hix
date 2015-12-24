module.exports = class HixEditor
	constructor: (@editor) ->

	getEditor: -> @editor
	getTitle: -> "#{@editor.getTitle()} <hex>"


	createViewProvider: ->
		div = document.createElement 'div'
		div.innerHTML = "lul"
		return div

HixEditor.dispenseViewProvider = (editor, env) ->
	editor.createViewProvider env
