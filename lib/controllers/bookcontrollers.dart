import 'package:get/get.dart';
import 'package:lazyloadgetx/api/api.dart';
import 'package:lazyloadgetx/model/books.dart';

class BooksControllers extends GetxController{
  var lazycount = 1;
  var books = <Books>[].obs;
  int? count;

  void initData(List<Books> initbooks,int initcount){
    for(var element in initbooks){
      books.add(element);
    }
    count = initcount;
  }

  void fetchData() async{
    var res = await getBooksList(6, lazycount++);
    count = res.count;
    for (var element in res.books!) {
      books.add(element);
    }
  }
}