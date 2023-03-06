import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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
      home: const MyHomePage(title: 'API Data'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List allDetails=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getMethod();
    });
  }
  getMethod() async
  {
    try{
    
    // String data = await rootBundle.loadString('JSONWebServer/data.json');
    // final res=await jsonDecode(data);
    String url="https://jsonplaceholder.typicode.com/users";
    final response= await http.get(Uri.parse(url));
    final res=await jsonDecode(response.body);

    setState(() {
      allDetails=res;
      print("setstate");
    });
    print("out setstate");
    }
    catch(e)
    {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black26,
      ),
      body: Center(
        child: ListView.builder(  
          itemCount: allDetails.length,  
          itemBuilder: (context, index) {  
            return ListTile(
              minVerticalPadding: 20, 
              title: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name:- ${allDetails[index]['name']}',style: TextStyle(fontSize: 20),),
                  Text('UserName:- ${allDetails[index]['username']}',style: TextStyle(fontSize: 20)),
                  Text('Email:- ${allDetails[index]['email']}',style: TextStyle(fontSize: 20)),
                  Text('Phone:- ${allDetails[index]['phone']}',style: TextStyle(fontSize: 20)),
                  Text('Company:- ${allDetails[index]['company']['name']}',style: TextStyle(fontSize: 20)),
                ],
              ),
              style: ListTileStyle.drawer,
              selectedColor: Color.fromARGB(255, 234, 239, 243),
              selectedTileColor: Color.fromARGB(255, 91, 92, 91),
              selected: true,
            );  
          },  
        ),  
      ),
    );
  }
}


