import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier{
  int index=0;
  void getIndex(int index){
    this.index=index;
    notifyListeners();
  }
}