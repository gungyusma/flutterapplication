import 'package:flutter/material.dart';
import 'package:flutter_travel_ui_starter/screens/explore_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/explore_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExploreCarrousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Tempat terpopuler',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              // GestureDetector(
              //   onTap: () => print('See All'),
              //   child: Text('See All',
              //       style: TextStyle(
              //           color: Theme.of(context).primaryColor,
              //           fontSize: 16.0,
              //           fontWeight: FontWeight.w600,
              //           letterSpacing: 1.0)),
              // ),
            ],
          ),
        ),
        Container(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendations.length,
            itemBuilder: (BuildContext context, int index) {
              RecommendedModel recommendation = recommendations[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExploreScreen(recommendation),
                    )),
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: 210.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 290.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(0, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Text(
                                //   '${destination.activities.length} activities',
                                //   style: TextStyle(
                                //       fontSize: 18.0,
                                //       fontWeight: FontWeight.w600,
                                //       wordSpacing: 2),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            // BoxShadow(
                            //   color: Colors.black26,
                            //   offset: Offset(0.0, 2.0),
                            //   blurRadius: 6.0,
                            // )
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Hero(
                              tag: recommendation.image,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  height: 310.0,
                                  width: 200.0,
                                  image: CachedNetworkImageProvider(
                                      recommendation.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 15.0,
                              bottom: 10.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    recommendation.name,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 10.0,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(recommendation.price.toString(),
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
