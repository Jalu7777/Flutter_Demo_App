import 'dart:developer';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_demo/provi/home_provider.dart';
import 'package:flutter_app_demo/repository/demo_api.dart';
import 'package:flutter_app_demo/screen/product.dart';
import 'package:flutter_app_demo/utils/routes.dart';
import 'package:flutter_app_demo/utils/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    var a = 45.893;
    a.toStringAsFixed(2);

    homeProvider = Provider.of<HomeProvider>(context, listen: false)
      ..getCategory()
      ..getData();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customText(text: 'Home', fsize: 18, fcolor: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5, top: 5),
            child: IconButton(
                onPressed: () {
                  log("clicked filter");
                  // homeProvider.arrBrand=[];
                  
                  showBrandDialog(homeProvider, context);
                },
                icon: const Icon(
                  Icons.filter_alt_rounded,
                  size: 35,
                )),
          )
        ],
      ),
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, data, child) => data.label == true
              ? const Center(child: CircularProgressIndicator())
              : data.arrData.isEmpty
                  ? Center(child: Image.asset('assets/no_product.png'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: List.generate(
                                  data.arrCategory.length,
                                  (index) => data.arrCategory[index]['name']
                                                  .toString() ==
                                              '' ||
                                          data.arrCategory[index]['name']
                                                  .toString() ==
                                              'null'
                                      ? Container()
                                      : GestureDetector(
                                          onTap: () {
                                            if (data.arrCategory[index]['isCat']
                                                    .toString() ==
                                                '1') {
                                              data.removeCatInd(index);
                                            } else {
                                              data.addCatInd(index);
                                            }
                                          },
                                          child: Container(
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: data.arrCategory[index]['isCat'].toString() == '1'
                                                      ? Colors.black
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: customText(
                                                  text: data.arrCategory[index]
                                                          ['name']
                                                      .toString(),
                                                  fcolor: data.arrCategory[index]
                                                                  ['isCat']
                                                              .toString() ==
                                                          '1'
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fsize: 15)),
                                        )),

                              // ),,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: data.arrData.length,
                              
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      log('clicked product');

                                      Navigator.pushNamed(
                                          context, RoutesName.productRoute,
                                          arguments: data.arrData[index]);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          bottom: 10,
                                          right: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Stack(
                                                  alignment: Alignment.topLeft,
                                                  children: [
                                                    CachedNetworkImage(
                                                        imageUrl: data
                                                            .arrData[index]
                                                                ['thumbnail']
                                                            .toString(),
                                                        placeholder: (context,
                                                                url) =>
                                                            Image.asset(
                                                                'assets/place_holder.jpg'),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                                'assets/no_image.png')),
                                                    if (data.arrData[index][
                                                                    'discountPercentage']
                                                                .toString() ==
                                                            '' ||
                                                        data.arrData[index][
                                                                    'discountPercentage']
                                                                .toString() ==
                                                            'null' ||
                                                        data.arrData[index][
                                                                    'discountPercentage']
                                                                .toInt() <=
                                                            0) ...{
                                                      Container()
                                                    } else ...{
                                                      Transform.rotate(
                                                        angle: -45,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  left: 5,
                                                                  bottom: 25),
                                                          child: customText(
                                                              text:
                                                                  '${data.arrData[index]['discountPercentage'].toStringAsFixed(2)}%',
                                                              fsize: 12,
                                                              fcolor:
                                                                  Colors.red),
                                                        ),
                                                      )
                                                    }
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const VerticalDivider(
                                              color: Colors.black,
                                              thickness: 1,
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, right: 05),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      customRichText(
                                                          title1: 'Product:-',
                                                          title2: data.arrData[
                                                                              index]
                                                                              [
                                                                              'title']
                                                                          .toString() ==
                                                                      '' ||
                                                                  data.arrData[
                                                                              index]
                                                                              [
                                                                              'title']
                                                                          .toString() ==
                                                                      'null'
                                                              ? ' NA'
                                                              : ' ${data.arrData[index]['title'].toString()}'),
                                                      const Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 5,
                                                                top: 10),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                // flex: 2,
                                                                child: customRichText(
                                                                    title1:
                                                                        'Brand:-',
                                                                    title2: data.arrData[index]['brand'].toString() ==
                                                                                '' ||
                                                                            data.arrData[index]['brand'].toString() ==
                                                                                'null'
                                                                        ? ' NA'
                                                                        : ' ${data.arrData[index]['brand'].toString()}')),
                                                            customSizedBoxWidth(
                                                                width: 5),
                                                            Expanded(
                                                                child: customRichText(
                                                                    title1:
                                                                        'Price:-',
                                                                    title2: data.arrData[index]['price'].toString() ==
                                                                                'null' ||
                                                                            data.arrData[index]['price'].toString() ==
                                                                                ''
                                                                        ? ' NA'
                                                                        : ' ${data.arrData[index]['price'].toString()} ₹',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right)),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                        )
                      ],
                    ),
        ),
      ),
    );
  }

  void showBrandDialog(HomeProvider homeData, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              contentPadding: const EdgeInsets.all(10),
              children: [
                if (homeData.arrData.isEmpty) ...{
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset('assets/no_product.png'),
                    ),
                  )
                } else ...{
                  Center(child:customText(text: 'Brands',fontWeight: FontWeight.bold,fsize: 25)),
                  customSizedBoxHeight(height: 15),
                  Consumer<HomeProvider>(
                    builder: (context, data, child) => SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ListView.builder(
                          itemCount: data.arrFilterData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => data
                                          .arrFilterData[index]['brand']
                                          .toString() ==
                                      '' ||
                                  data.arrFilterData[index]['brand']
                                          .toString() ==
                                      'null'
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    log('clicked');

                                    if (data.arrFilterData[index]['isSelected']
                                            .toString() ==
                                        '1') {
                                      data.removeBrandData(index);
                                    } else {
                                      data.addBrandData(index);
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        data.arrFilterData[index]['isSelected']
                                                    .toString() ==
                                                '1'
                                            ? const Icon(Icons.check_box,
                                                size: 30)
                                            : const Icon(
                                                Icons.check_box_outline_blank,
                                                size: 30,
                                              ),
                                        customSizedBoxWidth(width: 10),
                                        Expanded(
                                            child: customText(
                                                text: data.arrFilterData[index]
                                                        ['brand']
                                                    .toString(),
                                                fsize: 15))
                                      ],
                                    ),
                                  ),
                                )),
                    ),
                  ),
                  customSizedBoxHeight(),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          if (homeData.arrFilterData
                              .any((element) => element['isSelected'] == '1')) {
                            homeData.filterData(flag: 'Clear');
                          }
                          Navigator.pop(context);
                          },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey),
                        ),
                        child: customText(text: 'Clear'),
                      )),
                      customSizedBoxWidth(width: 10),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                homeData.filterData(flag: 'Apply');
                                Navigator.pop(context);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue),
                              ),
                              child: customText(text: 'Apply')))
                    ],
                  )
                }
              ],
            ));
  }
}
