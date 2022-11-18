import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? db;

  Future<Database> checkDatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await createDatabase();
    }
  }

  Future<Database> createDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, "rnw.db");
    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query =
          "CREATE TABLE client(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,mobile TEXT,Address TEXT)";
      String productquery = "CREATE TABLE product("
          "productID INTEGER PRIMARY KEY AUTOINCREMENT, productNAME TEXT , productQUANTITY TEXT, productPRICE TEXT , currentDATE TEXT , paymentSTATUS INTEGER, paymentDueDATE TEXT, paymentTYPE TEXT, clientID INTEGER)";
      db.execute(query);
      db.execute(productquery);
    });
  }

  Future<void> datainsert(String n1, String m1, String a1) async {
    db = await checkDatabase();
    db?.insert("client", {"name": n1, "mobile": m1, "address": a1});
  }

  Future<List<Map>> readData() async {
    db = await checkDatabase();
    String query = "SELECT * FROM client";
    List<Map> clientList = await db!.rawQuery(query, null);

    return clientList;
  }

  void deleteData(String id) async {
    db = await checkDatabase();
    db!.delete("client", where: "id = ?", whereArgs: [int.parse(id)]);
  }

  void updateData(String id, String n1, String m1, String a1) async {
    db = await checkDatabase();
    db?.update("client", {"name": n1, "mobile": m1, "address": a1},
        where: "id = ?", whereArgs: [int.parse(id)]);
  }

  // Product Data

  void insertProductData(String pname, String pquantity, String pprice, String currentdate, int paymentstatus, String duedate, String paymenttype, String cid)
  async {
    db = await checkDatabase();
    db!.insert("product", {"productNAME": pname, "productQUANTITY": pquantity, "productPRICE": pprice, "currentDATE": currentdate, "paymentSTATUS": paymentstatus, "paymentDueDATE": duedate, "paymentTYPE": paymenttype, "clientID": cid
    });
  }

  Future<List<Map>> readProductData(String id)async
  {
    db = await checkDatabase();
    String productquery ="SELECT * FROM product where clientID = $id";
    List<Map> productList = await db!.rawQuery(productquery,null);
    return productList;
  }

  Future<List<Map>> readProductSumData()async
  {
    db = await checkDatabase();
    String productquery ="SELECT * FROM product";
    List<Map> productList1 = await db!.rawQuery(productquery,null);
    return productList1;
  }
}
