import 'package:flutter/material.dart';

class productPase extends StatefulWidget {
  const productPase({Key? key}) : super(key: key);

  @override
  State<productPase> createState() => _productPaseState();
}

class _productPaseState extends State<productPase> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("My Business", style: TextStyle(fontSize: 17)),
        leading: Icon(Icons.book_outlined),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xff487eea), Color(0xff3564cc)]),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(
              label: Text("Customer Product"),
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder()
            ),),
            SizedBox(height: 10,),
            TextField(decoration: InputDecoration(
              label: Text("Amout"),
              prefixIcon: Icon(Icons.currency_rupee),
              border: OutlineInputBorder()
            ),),
            SizedBox(height: 10,),
            TextField(decoration: InputDecoration(
              label: Text("Date"),
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder()
            ),),
            SizedBox(height: 10,),
            TextField(decoration: InputDecoration(
              label: Text("Time"),
              prefixIcon: Icon(Icons.timelapse_outlined),
              border: OutlineInputBorder()
            ),),
          ],
        ),
      ),
    ));
  }
}
