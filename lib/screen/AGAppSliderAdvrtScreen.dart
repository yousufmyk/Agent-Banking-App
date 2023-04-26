import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
  
  
class  AGAppSliderAdvert extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
            
          //1st Image of Slider
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage("images/mobile_banking/meta-logo.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
            
          //2nd Image of Slider
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage("images/mobile_banking/download.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
            
          //3rd Image of Slider
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage("images/mobile_banking/images_(1)-2021-02-16-14-59-46.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
            
          // Container(
          //   margin: EdgeInsets.all(6.0),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8.0),
          //     image: DecorationImage(
          //       image: AssetImage("images/mobile_banking/ezgif.com-webp-to-jpg (1).jpg"),
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),
          //4th Image of Slider
          // Container(
          //   margin: EdgeInsets.all(6.0),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8.0),
          //     image: DecorationImage(
          //       image: NetworkImage("ADD IMAGE URL HERE"),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
            
          // //5th Image of Slider
          // Container(
          //   margin: EdgeInsets.all(6.0),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8.0),
          //     image: DecorationImage(
          //       image: NetworkImage("ADD IMAGE URL HERE"),
          
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
  
    ],
        
      //Slider Container properties
        options: CarouselOptions(
          
          height: 180.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 18 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
    );
  }
}