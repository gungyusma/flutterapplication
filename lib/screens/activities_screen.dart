import 'package:flutter/material.dart';
import '../models/activity_model.dart';
import '../models/destination_model.dart';

class ActivitiesScreen extends StatelessWidget {
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐';
    }
    return Text(stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
          itemCount: aktivitastersedia.length,
          itemBuilder: (BuildContext context, int index) {
            Activity activity = aktivitastersedia[index];
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                  height: 190,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 120.0,
                              child: Text(
                                activity.name,
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
                                Text('${activity.price}K',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                    )),
                                Text(
                                  '/ pax',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13.0),
                                )
                              ],
                            ),
                          ],
                        ),
                        Text(activity.type,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        _buildRatingStars(activity.rating),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              width: 70.0,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(activity.startTimes[0]),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              padding: EdgeInsets.all(5.0),
                              width: 70.0,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Color.fromARGB(255, 0, 0, 0),
                                  onSurface: Colors.white,
                                  fixedSize: Size(70, 15),
                                  shape: const BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Pesan aktivitas ini?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Tidak'),
                                        child: const Text('Tidak'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Iya'),
                                        child: const Text('Iya'),
                                      ),
                                    ],
                                  ),
                                ),
                                child: const Text('pesan'),
                              ),
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
                      width: 110.0,
                      image: AssetImage(activity.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            );
          }),
    ));
  }
}
