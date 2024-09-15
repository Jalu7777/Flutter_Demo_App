import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/utils/routes.dart';

class Splah extends StatefulWidget {
  const Splah({super.key});

  @override
  State<Splah> createState() => _SplahState();
}

class _SplahState extends State<Splah> {
  // final controller=Pro
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),()=>Navigator.pushReplacementNamed(context, RoutesName.homeRoute));    
    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Image.asset('assets/product.png'),
        ),
      )
    );
  }
}