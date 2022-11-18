import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/HomeController.dart';

class historyScreen extends StatefulWidget {
  const historyScreen({Key? key}) : super(key: key);

  @override
  State<historyScreen> createState() => _historyScreenState();
}

class _historyScreenState extends State<historyScreen> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("History")),
      body: Column(
        children: [
          Obx(
            () =>  Expanded(
              child: ListView.builder(itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 12,
                            color: Color(0x1d000000))
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${DateTime.now().day}"
                                        "/"
                                        "${DateTime.now().month}"
                                        "/"
                                        "${DateTime.now().year}"
                                        "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff000000)),
                                  ),
                                  Text(
                                    "${DateTime.now().hour}"
                                        ":"
                                        "${DateTime.now().minute}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff000000)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                "${homeController!.productList.value[index]['productNAME']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff000000)),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: 70,
                                  color: Color(0xffffe9ec),
                                  child: Center(
                                    child: Text(
                                      "\u{20B9} ${homeController!.productList.value[index]['paymentSTATUS'] == 1 ? '0' : '${homeController!.productList.value[index]['productPRICE']}'}",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffdf2f3a),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: double.infinity,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Color(0xffdcfff9),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomRight:
                                          Radius.circular(8))),
                                  child: Center(
                                    child: Text(
                                      "\u{20B9} ${homeController!.productList.value[index]['paymentSTATUS'] == 0 ? ' 0 ' : '${homeController!.productList.value[index]['productPRICE']}'}",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff0b9e84),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    ));
  }
}
