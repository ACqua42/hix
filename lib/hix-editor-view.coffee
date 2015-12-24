HixOffsetsView = require './hix-offsets-view'

module.exports = class HixEditorView
	constructor: (@editor, @textEditor) ->
		@textEditorView = atom.views.getView @textEditor

		@dom = @createDom()
		@reloadDom()
		@activate()

	activate: ->
		@textEditorView.parentNode?.replaceChild @dom, @textEditorView
		@hookupEvents()
	revert: ->
		@dom.parentNode?.replaceChild @textEditorView, @dom
		@textEditorView.focus()
	show: -> @dom.style.display = null
	hide: -> @dom.style.display = 'none'

	hookupEvents: ->

	createDom: ->
		dom = document.createElement 'hix-editor'

		dom.style.fontFamily = atom.config.get 'editor.fontFamily'
		dom.style.fontSize = atom.config.get 'editor.fontSize'

		return dom

	reloadDom: ->
		@dom.innerHTML = '';

		@offsets = @createOffsets()

		@dom.appendChild @offsets.getElement()

	createOffsets: -> new HixOffsetsView @
