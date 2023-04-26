import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'WASilverPlanDailogScreen.dart';

class AGAppMainScreenSliderImage extends StatefulWidget {
  const AGAppMainScreenSliderImage({Key? key}) : super(key: key);

  @override
  State<AGAppMainScreenSliderImage> createState() => _AGAppMainScreenSliderImageState();
}

class _AGAppMainScreenSliderImageState extends State<AGAppMainScreenSliderImage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          CarouselSlider(
            items: [
              //1st Image of Slider

              //3rd Image of Slider
              SingleChildScrollView(
                child: Container(
                  height: 100,
                  width: 100,
                  //margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xffeeeeee)
                      // image: DecorationImage(
                      //   image: NetworkImage("https://media.istockphoto.com/id/973190966/photo/high-angle-view-of-people-on-street.jpg?s=612x612&w=0&k=20&c=GMVFJukOSVsOFX3HUQyBMm7VTndqjVcqrgs0X1PjW_Y="),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("First Container")
                      ],
                    ),
                  ),
                ),
              ),

              //4th Image of Slider
              SingleChildScrollView(
                child: Container(
                  height: 100,
                  width: 100,
                  //margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xffeeeeee)
                      // image: DecorationImage(
                      //   image: NetworkImage("https://media.istockphoto.com/id/973190966/photo/high-angle-view-of-people-on-street.jpg?s=612x612&w=0&k=20&c=GMVFJukOSVsOFX3HUQyBMm7VTndqjVcqrgs0X1PjW_Y="),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Second Container")
                      ],
                    ),
                  ),
                ),
              ),

              //5th Image of Slider
               SingleChildScrollView(
                child: Container(
                  height: 100,
                  width: 100,
                  //margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xffeeeeee)
                      // image: DecorationImage(
                      //   image: NetworkImage("https://media.istockphoto.com/id/973190966/photo/high-angle-view-of-people-on-street.jpg?s=612x612&w=0&k=20&c=GMVFJukOSVsOFX3HUQyBMm7VTndqjVcqrgs0X1PjW_Y="),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Third Container")
                      ],
                    ),
                  ),
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              //height: 180.0
              //height: SizeConfig.screenHeight,
              enlargeCenterPage: true,
              autoPlay: true,
              //aspectRatio: 9 / 16,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
        ],
      );
  }
}