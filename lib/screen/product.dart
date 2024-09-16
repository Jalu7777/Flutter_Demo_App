import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_demo/provi/product_provider.dart';
import 'package:flutter_app_demo/utils/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  Map<dynamic, dynamic> data = {};
  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    // data ={};

    productProvider = Provider.of<ProductProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: customText(text: 'Product', fsize: 18, fcolor: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  text: data['title'].toString() == 'null' ||
                          data['title'].toString() == ''
                      ? 'NA'
                      : data['title'].toString(),
                  fontWeight: FontWeight.bold,
                  fsize: 16),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              customSizedBoxHeight(),
              CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    height: 150,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      productProvider.getIndex(index);
                    },
                  ),
                  items: data['images']
                      .map<Widget>(
                        (images) => Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                              imageUrl: images,
                              placeholder: (context, url) =>
                                  Image.asset('assets/place_holder.jpg'),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/no_image.png')),
                        ),
                      )
                      .toList()),
              customSizedBoxHeight(),
              Center(
                child: Consumer<ProductProvider>(
                    builder: (context, value, child) => AnimatedSmoothIndicator(
                          activeIndex: productProvider.index,
                          count: data['images'].length,
                          effect: const SlideEffect(
                              activeDotColor: Colors.deepPurple,
                              type: SlideType.slideUnder),
                        )),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              customSizedBoxHeight(),
              customRichText(
                  title1: 'Category:- ',
                  title2: data['category'].toString() == '' ||
                          data['category'].toString() == 'null'
                      ? 'NA'
                      : data['category'].toString(),
                  t1Weight: FontWeight.bold,t2Size: 14),
              customSizedBoxHeight(),
              customRichText(
                  title1: 'Description:- ',
                  title2: data['description'].toString() == '' ||
                          data['description'].toString() == 'null'
                      ? 'NA'
                      : data['description'].toString(),
                  t1Weight: FontWeight.bold,t2Size: 14),
              customSizedBoxHeight(),
              if (data['reviews'].isNotEmpty) ...{
                customText(
                    text: 'Reviews', fontWeight: FontWeight.bold, fsize: 15),
                customSizedBoxHeight(),
                ListView.builder(
                    itemCount: data['reviews'].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customRichText(
                                  title1: data['reviews'][index]
                                                      ['reviewerName']
                                                  .toString() ==
                                              '' ||
                                          data['reviews'][index]
                                                      ['reviewerName']
                                                  .toString() ==
                                              'null'
                                      ? 'NA'
                                      : '${data['reviews'][index]['reviewerName']} on'
                                          .toString(),
                                  title2: data['reviews'][index]['date']
                                                  .toString() ==
                                              '' ||
                                          data['reviews'][index]['date']
                                                  .toString() ==
                                              'null'
                                      ? ""
                                      : " ${DateFormat('dd MMM yyyy').format(DateTime.parse(data['reviews'][index]['date'].toString()))}",
                                  t1Color: Colors.black,
                                  t2Color: Colors.black54,
                                  t2Size: 14
                                  ),
                        
                              customSizedBoxHeight(),
                              Row(
                                children: [
                                  customText(
                                      text: 'Rating:- ',
                                      fcolor: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fsize: 15),
                                  if (data['reviews'][index]['rating']
                                              .toString() ==
                                          'null' ||
                                      data['reviews'][index]['rating']
                                              .toString() ==
                                          '') ...{
                                    customText(
                                      text: 'NA',
                                    ),
                                  } else ...{
                                    RatingBar(
                                        size: 18,
                                        initialRating: data['reviews'][index]
                                                ['rating']
                                            .toDouble(),
                                        filledIcon: Icons.star,
                                        emptyIcon: Icons.star_border,
                                        onRatingChanged: (value) {})
                                  }
                                ],
                              ),
                              customSizedBoxHeight(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                      text: 'Comment:- ',
                                      fsize: 15,
                                      fontWeight: FontWeight.bold,
                                      fcolor: Colors.black54),
                                  Expanded(
                                    child: customText(
                                        text: data['reviews'][index]
                                                            ['comment']
                                                        .toString() ==
                                                    'null' ||
                                                data['reviews'][index]
                                                            ['comment']
                                                        .toString() ==
                                                    ''
                                            ? 'NA'
                                            : data['reviews'][index]
                                                    ['comment']
                                                .toString(),
                                        fsize: 14),
                                  ),
                                ],
                              )
                              ],
                          ),
                        ))
              },
            ],
          ),
        ),
      ),
    );
  }
}
