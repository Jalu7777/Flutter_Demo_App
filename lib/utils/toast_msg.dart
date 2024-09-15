
import 'package:flutter/material.dart';


import 'package:fluttertoast/fluttertoast.dart';
class ToastMsg{
static setMsg({required String msg}){
  return Fluttertoast.showToast(msg: msg,backgroundColor: Colors.black,textColor: Colors.white,fontSize: 20);
}
}