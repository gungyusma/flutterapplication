import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class DestinationScreen extends StatefulWidget {
  final Map destination;
  final List<Map> activity;
  DestinationScreen(this.destination, this.activity);

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐';
    }
    return Text(stars);
  }

  Map aktiviti = {};
  @override
  Future<Map> gaetdata(String doc) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("aktivitas/" + doc);
    DatabaseEvent event = await ref.once();
    aktiviti = event.snapshot.value as Map;
    return aktiviti;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
        
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ]),
                child: Hero(
                  tag: widget.destination['imageUrl'],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image(
                      image: AssetImage(widget.destination['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        // IconButton(
                        //   icon: Icon(Icons.search),
                        //   iconSize: 30.0,
                        //   color: Colors.black,
                        //   onPressed: () => Navigator.pop(context),
                        // ),
                        // IconButton(
                        //   icon: Icon(FontAwesomeIcons.sortAmountDown),
                        //   iconSize: 25.0,
                        //   color: Colors.black,
                        //   onPressed: () => Navigator.pop(context),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.destination['city'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 15.0,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 5.0),
                        Text(widget.destination['country'],
                            style: TextStyle(
                                color: Colors.white70, fontSize: 20.0)),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20.0,
                bottom: 20.0,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white70,
                  size: 25.0,
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                itemCount: widget.destination['activities'].length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: gaetdata(widget.destination['activities'][index]),
                    builder: (context, snapshot) {
                      Map aktivitas = {};
                    if (snapshot.hasData) {
                      aktivitas = snapshot.data as Map;
                      print(aktivitas['imageUrl']);
                      return Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 120.0,
                                      child: Text(
                                        aktivitas['name'],
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text('${aktivitas['price']} K',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        Text(
                                          '/ pax',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15.0),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Text(aktivitas['type'],
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10.0)),
                                _buildRatingStars(aktivitas['rating']),
                                SizedBox(height: 10.0),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      width: 70.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(aktivitas['startTimes'][0]),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      width: 70.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text(aktivitas['startTimes'][1]),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20.0,
                          top: 15.0,
                          bottom: 15.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              width: 100.0,
                              image: AssetImage(aktivitas['imageUrl']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    );;
                    } else {
                      return Text('Loading...');
                    }                   
                    }
                  );
                }),
          )
        ],
      ),
    );
  }
}
