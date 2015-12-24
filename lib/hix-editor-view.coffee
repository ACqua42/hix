module.exports = class HixEditorView
	constructor: (editor) ->
		@editorView = atom.views.getView editor

		@dom = @createDom()
		@reloadDom()

		@editorView.parentNode.replaceChild @dom, @editorView

	revert: ->
		@dom.parentNode?.replaceChild @editorView, @dom
		@editorView.focus()

	createDom: ->
		div = document.createElement 'hix-editor'
		return div

	reloadDom: ->
		@dom.innerHTML = '';
