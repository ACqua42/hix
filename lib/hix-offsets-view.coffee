module.exports = class HixOffsetsView
	constructor: (@editorView) ->
		@dom = document.createElement 'offsets'

		@reloadDom()

	getElement: -> @dom

	reloadDom: ->
		@dom.innerHTML = '';

		bufferLength = @editorView.editor.buffer.length
		offsetRows = Math.ceil (bufferLength / 16)

		for i in [0...offsetRows]
			offset = i * 16
			offset16 = offset.toString(16).toUpperCase()
			offsetString = "#{'00000000'.substring offset16.length}#{offset16}"
			offsetString = "#{offsetString.substring 0, 4} #{offsetString.substring 4}"

			span = document.createElement 'offset'

			span.appendChild document.createTextNode offsetString
			@dom.appendChild span
