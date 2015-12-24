module.exports = class HixTextView
	constructor: (@editorView) ->
		@dom = document.createElement 'ascii' # at risk of the <text> element actually being something
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
				curRow = document.createElement 'ascii-row'

			charString = @getCharacterString byte
			charElem = document.createElement 'char'
			charElem.dataset.offset = i

			@stylizeChar charElem, byte, i

			charElem.appendChild document.createTextNode charString
			curRow.appendChild charElem

	isVisibleChar: (char) -> 32 <= char <= 126

	getCharacterString: (char) ->
		return String.fromCharCode(char) if @isVisibleChar char
		return '.'

	stylizeChar: (elem, byte, offset) ->
		if not @isVisibleChar byte
			elem.classList.add 'zero'
