module.exports = class HixByteView
	constructor: (@editorView) ->
		@dom = document.createElement 'bytes'
		@reloadDom()

	getElement: -> @dom

	reloadDom: ->
		@dom.innerHTML = ''

		buffer = @editorView.editor.buffer
		curRow = null

		for byte, i in buffer
			if (i % 16) is 0
				if i > 0
					@dom.appendChild curRow
				curRow = document.createElement 'byte-row'

			byteString = byte.toString(16).toUpperCase()
			byteString = "#{'00'.substring byteString.length}#{byteString}"
			byteElem = document.createElement 'byte'
			byteElem.dataset.offset = i

			@stylizeByte byteElem, byte, i

			byteElem.appendChild document.createTextNode byteString
			curRow.appendChild byteElem

	stylizeByte: (elem, byte, offset) ->
		if byte is 0
			elem.classList.add 'zero'
