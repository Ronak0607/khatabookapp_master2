import 'package:get/get.dart';
import 'package:khatabookapp/Model/HomeModel.dart';

import '../dbHelper.dart';

class HomeController extends GetxController
{
  RxList<Map> clientList = <Map>[].obs;


  RxList<Map> productList = <Map>[].obs;
  RxList<Map> productList1 = <Map>[].obs;

  RxInt clientTotal=0.obs;
  RxInt clientPanding=0.obs;

  RxInt homeTotal=0.obs;
  RxInt homePanding=0.obs;

  HomeModel? homeModel;

  void TotalAmountSum()
  {
    int i =0;
    clientTotal.value=0;
    clientPanding.value=0;

    for(i=0;i<productList.length;i++)
      {
        if(productList[i]['paymentSTATUS']==1)
          {
            clientTotal.value=clientTotal.value+int.parse(productList[i]['productPRICE']);
          }
        else
          {
            clientPanding.value=clientPanding.value+int.parse(productList[i]['productPRICE']);
          }
      }
  }

  void TotalAmountHomeSum()
  async{
    int i =0;
    homeTotal.value=0;
    homePanding.value=0;
    DbHelper db=DbHelper();
    productList1.value= await db.readProductSumData();

    for(i=0;i<productList1.length;i++)
    {
      if(productList1[i]['paymentSTATUS']==1)
      {
        homeTotal.value=homeTotal.value+int.parse(productList1[i]['productPRICE']);
      }
      else
      {
        homePanding.value=homePanding.value+int.parse(productList1[i]['productPRICE']);
      }
    }
  }

}