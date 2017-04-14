{CompositeDisposable} = require 'atom'
HixEditorView = require './hix-editor-view'
fs = require 'fs' # because Atom doesn't like binary stuff and only stores text, which is incorrect

module.exports = class HixEditor
	constructor: (@editor, pane) ->
		@subscriptions = new CompositeDisposable()
		@buffer = new Buffer 0

		fs.readFile @editor.getPath(), (err, @buffer) =>
			throw err if err # try again sir

			@view = new HixEditorView @, @editor

			@subscriptions.add pane.onDidActivate =>
				@view.activate()

			@subscriptions.add pane.onDidChangeActiveItem (item) =>
				if item is @editor
					@view.show()
				else
					@view.hide()

	revert: ->
		@subscriptions.dispose()
		@view.revert()
