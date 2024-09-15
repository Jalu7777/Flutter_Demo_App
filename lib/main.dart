import 'package:flutter/material.dart';
import 'package:flutter_app_demo/provi/product_provider.dart';
import 'package:provider/provider.dart';
import 'provi/home_provider.dart';
import 'utils/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: ((_) => ProductProvider())) ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        initialRoute: RoutesName.initialRoute,
        routes: Routes.m1,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


