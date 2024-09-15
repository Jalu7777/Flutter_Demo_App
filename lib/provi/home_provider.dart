import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app_demo/repository/demo_api.dart';
import 'package:flutter_app_demo/utils/api_url.dart';

class HomeProvider extends ChangeNotifier {
  
  List arrData = [];
  List arrFilterData = [];
  List arrCategory=[];
  bool catLabel=false;
  bool label = false;
  

  getData() async {
    log('inn');
    label = true;

    Map<String, dynamic> responseData =
        await DemoApi.getAPI(url: ApiUrl.getProduct);
    // DemoApi.getAPI(url: "https://dummyjson.com/products").then((responseData){
    if (responseData.isEmpty) {
      label = false;
      arrFilterData = [];
      arrData = [];
    } else {
      if (responseData['products'].isNotEmpty) {
        label = false;
        arrFilterData = [];
        arrData = [];
        arrData = responseData['products'];
        arrFilterData = responseData['products'];
        } else {
        label = false;
        arrData = [];
        arrFilterData = [];

      }
    }
    notifyListeners();
  }

  getCategory() async {
    log('inn');
    catLabel = true;

    Map<String, dynamic> responseData =
        await DemoApi.getAPI(url: ApiUrl.getCategory);
    
    if (responseData.isEmpty) {
      catLabel = false;
      arrCategory = [];
      } else {
      if (responseData['category'].isNotEmpty) {

        catLabel = false;
        arrCategory=[];
        arrCategory=responseData['category'];
      } else {
        catLabel = false;
        arrCategory=[];
      }
    }
    notifyListeners();
  }

  addCatInd(int index) {
    arrCategory[index]['isCat'] = '1';
    
    notifyListeners();
  }

  removeCatInd(int index) {
    arrCategory[index]['isCat'] = '0';
    notifyListeners();
  }

  addBrandData(index) {
    arrFilterData[index]['isSelected'] = '1';
    notifyListeners();
  }

  removeBrandData(int index) {
    arrFilterData[index]['isSelected'] = '0';
    notifyListeners();
  }

  filterData({required String flag}) async {
    label=true;
    notifyListeners();

    if (flag.toString() == 'Apply') {
      await Future.delayed(const Duration(seconds: 3), () {
        if(arrFilterData.every((element) => element['isSelected'].toString()=='0')){
          arrData=arrFilterData;
        }
        else{
           arrData = arrFilterData
            .where((element) => element['isSelected'].toString() == '1')
            .toList();
        }
       
        // arrData.forEach((element) { 
        //   element['isCat']='0';
        // });
      });
    } else {
      await Future.delayed(const Duration(seconds: 3), () {
        arrFilterData.forEach((element) {
          element['isSelected'] = '0';
          // element['isCat'] = '0';
        });
        arrData = arrFilterData;
      });
    }
    label=false;
    notifyListeners();
  }
}
