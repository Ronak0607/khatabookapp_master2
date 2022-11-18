import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khatabookapp/Model/HomeModel.dart';
import 'package:khatabookapp/view/CustomerDetails.dart';
import 'package:khatabookapp/view/historyscreen.dart';

import '../controller/HomeController.dart';
import '../dbHelper.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtAdd = TextEditingController();

  TextEditingController utxtName = TextEditingController();
  TextEditingController utxtMobile = TextEditingController();
  TextEditingController utxtAdd = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    DbHelper db = DbHelper();
    homeController.clientList.value = await db.readData();
    homeController!.TotalAmountHomeSum();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
      backgroundColor: Color(0xfff3f3f3),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 150,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),

                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 4, top: 8, bottom: 8, left: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffdcfff9),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Text(
                                      "\u{20B9} ${homeController.homeTotal}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff0b9e84),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "You will get",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff0b9e84),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8, top: 8, bottom: 8, left: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffffe9ec),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Text(
                                      "\u{20B9} ${homeController.homePanding}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffdf2f3a),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "You will give",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffdf2f3a),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                    ),
                    child: TextButton(onPressed: (){
                      Get.to(historyScreen());

                    },child: Text("VIEW HISTORY",style: TextStyle(fontSize: 18)),),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.search),
                          width: 18,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                    itemCount: homeController.clientList.value.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 12,
                                    color: Color(0x1d000000))
                              ]),
                          child: ListTile(
                            leading: Image.network(
                                "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-File.png"),
                            title: Text(
                                "${homeController.clientList.value[index]['name']}"),
                            subtitle: Text(
                                "${homeController.clientList.value[index]['mobile']}"),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      DbHelper db = DbHelper();
                                      db.deleteData(
                                          '${homeController.clientList.value[index]['id']}');
                                      getdata();
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        utxtName = TextEditingController(
                                            text:
                                                "${homeController.clientList.value[index]['name']}");
                                        utxtMobile = TextEditingController(
                                            text:
                                                "${homeController.clientList.value[index]['mobile']}");
                                        utxtAdd = TextEditingController(
                                            text:
                                                "${homeController.clientList.value[index]['Address']}");
                                        Get.defaultDialog(
                                            content: Column(
                                          children: [
                                            TextField(
                                              controller: utxtName,
                                              decoration: InputDecoration(
                                                  hintText: "Name"),
                                            ),
                                            TextField(
                                              controller: utxtMobile,
                                              decoration: InputDecoration(
                                                  hintText: "Mobile"),
                                            ),
                                            TextField(
                                              controller: utxtAdd,
                                              decoration: InputDecoration(
                                                  hintText: "Address"),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  DbHelper db = DbHelper();
                                                  db.updateData(
                                                      '${homeController.clientList.value[index]['id']}',
                                                      utxtName.text,
                                                      utxtMobile.text,
                                                      utxtAdd.text);
                                                  getdata();
                                                  Get.back();
                                                },
                                                child: Text("Submit"))
                                          ],
                                        ));
                                      },
                                      icon: Icon(Icons.edit))
                                ],
                              ),
                            ),
                            onTap: () {
                              homeController!.homeModel = HomeModel(
                                id: homeController!
                                    .clientList.value[index]['id']
                                    .toString(),
                                Address: homeController!.clientList.value[index]
                                    ['Address'],
                                mobile: homeController!.clientList.value[index]
                                    ['mobile'],
                                name: homeController!.clientList.value[index]
                                    ['name'],
                              );

                              Get.to(customerDetails());
                            },
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.defaultDialog(
              title: ("Customer Details"),
              content: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Column(
                  children: [
                    TextField(
                      controller: txtName,
                      decoration: InputDecoration(hintText: "Name"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: txtMobile,
                      decoration: InputDecoration(hintText: "mobile"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: txtAdd,
                      decoration: InputDecoration(hintText: "Address"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          DbHelper db = DbHelper();
                          db.datainsert(
                              txtName.text, txtMobile.text, txtAdd.text);
                          getdata();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff3564cc),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                        child: Text(
                          "Submit",
                        ))
                  ],
                ),
              ));
        },
        icon: Icon(Icons.person_add),
        label: Text("ADD CUSTOMER"),
        backgroundColor: Color(0xff3564cc),
      ),
    ));
  }
}
