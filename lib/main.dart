import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:lazyloadgetx/api/api.dart';
import 'package:lazyloadgetx/controllers/bookcontrollers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final initBooksController = Get.put(BooksControllers());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lazyload GetX'),
      ),
      body: FutureBuilder(
        future: getBooksList(6, 0),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            initBooksController.initData(snapshot.data.books, snapshot.data.count);
            return const LazyLoad();
          }
          else if(snapshot.hasError){
            return const Center(
              child: Text('Something Wrong'),
            );
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class LazyLoad extends StatelessWidget {
  const LazyLoad({super.key});

  @override
  Widget build(BuildContext context) {
    final booksControllers = Get.put(BooksControllers());
    final width = MediaQuery.of(context).size.width;
    final ScrollController _scrollController = ScrollController();
     _scrollController.addListener((){
    if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent && booksControllers.books.length < booksControllers.count!) { 
            booksControllers.fetchData();
      }
    });
    return GetX<BooksControllers>(
        builder: (controller){
          return ListView.builder(
            controller: _scrollController,
            itemCount: controller.books.length+1,
            itemBuilder: (BuildContext context, int index){
              if(index < controller.books.length){
                return Container(
                  width: width,
                  height: 160,
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Image.network(
                        width: 90,
                        height: 120,
                        controller.books[index].image!
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                              height: 20,
                          ),
                          SizedBox(
                            width: width*0.55,
                            child: Text(
                               controller.books[index].name!,
                            ),
                          ),
                          const SizedBox(
                              height: 10,
                          ),
                          Text('฿ ${ controller.books[index].price}',style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 24
                          ),)
                        ],
                      )
                    ],
                  ),
                );
              }
              else{
                if(controller.books.length == controller.count){
                  return const SizedBox();
                }
                else{
                  return SizedBox(
                    width: width,
                    height: 50,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }
            }
          );
        },
      );
  }
}