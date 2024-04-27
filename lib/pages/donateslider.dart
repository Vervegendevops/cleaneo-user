import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DonateSlider extends StatefulWidget {
  @override
  _DonateSliderState createState() => _DonateSliderState();
}

class _DonateSliderState extends State<DonateSlider> {
  int _currentIndex = 0;

  final List<String> imageAssetPaths = [
    'assets/images/flag.jpg',
    'assets/images/flag.jpg',
    'assets/images/flag.jpg',
    'assets/images/flag.jpg',
    'assets/images/flag.jpg',
    'assets/images/flag.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: imageAssetPaths.length,
            options: CarouselOptions(
              height: 230.0,
              autoPlay: true,
              enlargeCenterPage: false,
              aspectRatio: 2.0,
              viewportFraction: 2.0,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 194, 44, 44),
                           borderRadius: BorderRadius.circular(16)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            imageAssetPaths[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imageAssetPaths.length, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == _currentIndex
                      ? Color(0xFF67ADCC)
                      : Color.fromARGB(255, 149, 149, 149),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
