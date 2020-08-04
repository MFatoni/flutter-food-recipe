import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key key, this.name, this.image, this.info, this.index})
      : super(key: key);
  final String name;
  final String image;
  final String info;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Detail'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Center(
        child: ListView(
          children: <Widget>[
            Hero(
              tag: 'detail$index',
              child: AspectRatio(
                aspectRatio: 10 / 5,
                child: Container(
                  margin: EdgeInsets.only(
                      top: 30.0, bottom: 20, left: 30, right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(60, 0, 0, 0),
                          blurRadius: 5.0,
                          offset: Offset(5.0, 5.0))
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child:
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              margin: EdgeInsets.only(bottom: 10.0),
            ),
            Container(
              child: Text(
                info,
                textAlign: TextAlign.justify,
              ),
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            ),
          ],
        ),
      ),
    );
  }
}
