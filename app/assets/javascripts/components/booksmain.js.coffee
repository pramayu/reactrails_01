{ div, h1, a, span, img, h3, p, input, textarea, form, button } = React.DOM
BookForm = React.createFactory React.createClass
	
	getInitialState: ->
		title: ''
		sinopsis: ''
		price: ''
		published_on: ''
		status: ''

	handleChange: (e) ->
		name = e.target.name
		@setState "#{name}": e.target.value

	handleSubmit: (e) ->
		e.preventDefault()
		$.post '/books', { book: @state }, (data) =>
			@props.handleNewBook data
			@setState @getInitialState()
		, 'JSON'

	render: ->
		form className: 'susu', onSubmit: @handleSubmit,
			div className: 'form-group',
				input
					type: 'text',
					className: 'form-control',
					name: 'title',
					value: @state.title,
					onChange: @handleChange
					placeholder: 'Title'
			div className: 'form-group',
				textarea
					type: 'text',
					className: 'form-control',
					name: 'sinopsis',
					value: @state.sinopsis,
					onChange: @handleChange
					placeholder: 'Sinopsis'
			div className: 'form-group',
				input
					type: 'number',
					name: 'price',
					className: 'form-control',
					value: @state.price,
					onChange: @handleChange
					placeholder: 'Price'
			div className: 'form-group',
				input
					type: 'date',
					className: 'form-control',
					name: 'published_on',
					value: @state.published_on,
					onChange: @handleChange
					placeholder: 'Published on'
			div className: 'form-group',
				input
					type: 'hidden',
					className: 'form-control',
					name: 'published_on',
					value: false,
					onChange: @handleChange
				button
					type: 'submit',
					className: 'btn btn-success',
					'Submit Record'

BookGridItem = React.createFactory React.createClass
	handleDelete: (e) ->
		e.preventDefault()
		$.ajax
			method: 'DELETE'
			url: "/books/#{ @props.book._id["$oid"] }"
			dataType: 'JSON'
			success: () =>
				$(".aha_#{@props.book._id["$oid"]}").fadeOut 'fast', ->
					$(this).remove()

	render: ->
		div className: "col-sm-6 col-md-4 aha_#{ @props.book._id["$oid"]}",
			div className: 'thumbnail',
				img className: 'image', src: 'https://d13yacurqjgara.cloudfront.net/users/767861/screenshots/3180850/xmas_santa_cookies_1x.png'
				div className: 'caption',
					h3 {}, @props.book.title.substring(0, 23) + '...'
					div className: 'col-md-6',
						p {},
							a className: 'btn btn-success', '$' + @props.book.price
					div className: 'col-md-6',
						p className: 'pull-right',
							a className: 'btn btn-danger', onClick: @handleDelete, 'Delete'
					div className: 'clear',

BookGrid = React.createFactory React.createClass
	render: ->
		div className: 'rec',
			_.map @props.books, (book) =>
				BookGridItem(book: book)
			div className: 'clear',

window.BooksMain = React.createClass
	getInitialState: ->
		books: []

	componentWillMount: ->
		@setState(books: @props.books)

	addBook: (book) ->
		books = @state.books.slice()
		books.push book
		@setState books: books

	render: ->
		div className: 'books',
			div className: 'row',
				div className: 'col-md-6 col-sm-offset-3',
					BookForm(handleNewBook: @addBook)
				BookGrid(books: @state.books)

