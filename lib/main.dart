
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shop3/abdelrahmanamr!.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homescreen(),
    );

  }
}
class homescreen extends StatefulWidget {


  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreen();
}
class _homescreen extends State<homescreen> {

  Dio dio = Dio();
  String url = 'https://fakestoreapi.com/products';
  List<dynamic> Shopmodel = [];

  @override
  void inistate() {
    super.initState();
    getdata();
  }

  Future<List<dynamic>> getdata() async {
    Response response = await dio.get(url);
    print(response.data);
    print(response.statusCode);
    Shopmodel = response.data.map((item) => shopmodel.fromJson(item)).toList();
    return Shopmodel;
  }
@override 
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text(
            'stalk shop'
        ),
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: ((context, snapshot) {
          return snapshot.hasData ? ListView.builder(
            itemCount: Shopmodel.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Image.network('${Shopmodel[index].image}',

                ),
                subtitle: Container(
                  color: Colors.white,
                  alignment: Alignment.topCenter,
                  child: Text(
                    'price=${Shopmodel[index].price}',

                    style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

              );
            },)
              : snapshot.hasError ?
          Text('sorry')
              : Center(child: CupertinoActivityIndicator());
        }),)
  );
}
}
