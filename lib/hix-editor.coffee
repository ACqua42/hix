HixEditorView = require './hix-editor-view'

module.exports = class HixEditor
	constructor: (@editor) ->
		@view = new HixEditorView @editor

	revert: -> @view.revert()
