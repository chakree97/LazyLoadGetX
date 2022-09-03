class BooksModel{
  final List<Books>? books;
  final int? count;

  BooksModel({
    this.books,
    this.count
  });

  factory BooksModel.fromJson(Map<String,dynamic> json)=> BooksModel(
    books: List<Books>.from(json["books"].map((result)=> Books.fromJson(result))),
    count: json["count"]
  );
}

class Books{
  final String? id;
  final String? name;
  final String? image;
  final String? description;
  final String? file;
  final num? price;
  final num? favorite;  

  Books({
    this.id,
    this.name,
    this.image,
    this.description,
    this.file,
    this.price,
    this.favorite
  });

  factory Books.fromJson(Map<String,dynamic>json) => Books(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    file: json["file"],
    price: json["price"],
    favorite: json["favorite"]
  );
}
