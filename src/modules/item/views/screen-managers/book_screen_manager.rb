require_relative '../components/book_component'
require_relative './item_screen_manager'

class BookScreenManager < ItemScreenManager
  def initialize(
    create_book:,
    list_books:,
    genres_screen_manager:,
    authors_screen_manager:,
    labels_screen_manager:
  )
    super(
      item_component_class: BookComponent,
      list_items: list_books,
      genres_screen_manager: genres_screen_manager,
      authors_screen_manager: authors_screen_manager,
      labels_screen_manager: labels_screen_manager,
      entity_type: 'book'
    )
    @create_book = create_book
  end

  def handle_create_book
    handle_errors do
      item_attrs = handle_create_item

      return unless item_attrs

      publisher = get_user_input('Who published this book? ')
      cover_state = get_user_input('What is the state of the book [good/bad]: ')

      new_book = @create_book.call(
        publisher: publisher,
        cover_state: cover_state,
        **item_attrs
      )

      print_success_entity_creation(new_book)
    end
  end

  def handle_list_books
    handle_list_all('No books available.')
  end
end
