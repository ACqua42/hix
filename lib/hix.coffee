{CompositeDisposable} = require 'atom'
HixEditor = require './hix-editor'

getElementPath = (target)->
	(target.getAttribute 'data-path') if target? and target.getAttribute?

module.exports = Hix =
	subscriptions: null

	activate: (state) ->
		# events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
		@subscriptions = new CompositeDisposable

		# register command that toggles this view
		@subscriptions.add atom.commands.add 'atom-workspace', 'hix:toggle': => @toggle()
		@subscriptions.add atom.commands.add 'atom-workspace', 'hix:open': (e)=>
			@open getElementPath e.target

	deactivate: ->
		@subscriptions.dispose()

	serialize: -> {}

	open: (path)->
		return if not path
		atom.workspace.open(path).then => @toggle on

	toggle: (forceHex=off)->
		pane = atom.workspace.getActivePane();
		return if not pane

		activeItem = pane.getActiveItem()
		index = pane.getActiveItemIndex()
		if activeItem.getText? or activeItem.getPath?
			if activeItem.hixEditor?
				if not forceHex
					activeItem.hixEditor.revert()
					delete activeItem.hixEditor
			else
				activeItem.hixEditor = new HixEditor activeItem, pane
