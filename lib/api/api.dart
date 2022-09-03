import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lazyloadgetx/model/books.dart';

Future<BooksModel> getBooksList(int limit,int offset)async{
  var url = Uri.http("localhost:3001", "/books/getbooks/${limit}/${offset}");
  var res = await http.get(url);
  if(res.statusCode == 200){
    BooksModel result = BooksModel.fromJson(json.decode(res.body));
    return result;
  }
  else{
    throw Exception('Failed to download');
  }
}