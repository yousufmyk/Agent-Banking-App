import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
  
  
class  AGAppBillPaymentSliderAdvert extends StatelessWidget {

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
                image: AssetImage("images/mobile_banking/images.jpg"),
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
                image: AssetImage("images/mobile_banking/61f2b18150c961c24bf3ea31_white-office-desk-table-with-blank-sheet-text-pay-rent-keyboard-gavel-1.jpeg"),
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
                image: AssetImage("images/mobile_banking/Water_Bill_Online.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
            
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage("images/mobile_banking/3014BankitRechargeImage.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Container(
          //   margin: EdgeInsets.all(6.0),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8.0),
          //     image: DecorationImage(
          //       image: AssetImage( "images/mobile_banking/lifeinsurance.jpg"),
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