import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../utils/toast_msg.dart';
class DemoApi {
  static Map<String, dynamic> apiData = {};

  static Future<Map<String, dynamic>> getAPI({required String url}) async {
    final result=await Connectivity().checkConnectivity();
    log('result$result');
    log('url$url');
    if(result==ConnectivityResult.mobile || result==ConnectivityResult.wifi){
      try {
      final resposne =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 60));
      if (resposne.statusCode == 200) {
        final body = jsonDecode(resposne.body);
        if(url==ApiUrl.getCategory){
          apiData['category']=[];
          apiData['category']=body;
          return apiData;
        }
        else{
        return body;

        }
        
      } else if (resposne.statusCode == 500) {
        ToastMsg.setMsg(
            msg: "Internal server error occurred. please try again later.");
      
      }
    } on TimeoutException catch (e) {
      ToastMsg.setMsg(msg: "Please try again after some time.");
      log('on timeout:${e.message}');
      
    } catch (e) {
      ToastMsg.setMsg(msg: e.toString());
      log('error:$e');
      
    }
    }
    else{
      ToastMsg.setMsg(msg: 'Please connect internet.');
      
    }

    return apiData;
    

    
  }

  static displyLabel() {
    return LoadingAnimationWidget.threeRotatingDots(
      color: Colors.blue,
      size: 200,
    );
  }
}
