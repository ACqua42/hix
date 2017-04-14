module.exports = class HixByteView
	constructor: (@editorView) ->
		@dom = document.createElement 'bytes'
		@reloadDom()

	getElement: -> @dom

	reloadDom: ->
		@dom.innerHTML = ''

		buffer = @editorView.editor.buffer
		curRow = null

		addRow = => @dom.appendChild curRow

		for byte, i in buffer
			if (i % 16) is 0
				addRow() if i > 0
				curRow = document.createElement 'byte-row'

			byteString = byte.toString(16).toUpperCase()
			byteString = "#{'00'.substring byteString.length}#{byteString}"
			byteElem = document.createElement 'byte'
			byteElem.dataset.offset = i

			@stylizeByte byteElem, byte, i

			byteElem.appendChild document.createTextNode byteString
			curRow.appendChild byteElem

		addRow() if buffer.length % 16 isnt 0

	stylizeByte: (elem, byte, offset) -> elem.classList.add 'zero' if byte is 0
