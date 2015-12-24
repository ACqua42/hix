
module.exports = class HixEditorView
	constructor: (editor) ->
		@editorView = atom.views.getView editor
		@dom = @createDom()

	revert: ->
		@dom.parentNode?.replaceChild @editorView, @dom

	createDom: ->
		div = document.createElement 'div'
		div.innerHTML = 'more sane way to do this.'
		return div
