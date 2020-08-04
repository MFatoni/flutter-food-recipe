import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrecipes_flutter/model/data_food.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.info, this.index, this.image, this.name})
      : super(key: key);
  final String info;
  final String image;
  final String name;
  final int index;

  @override
  DetailScreenState createState() => new DetailScreenState();
}

// Home page state class
class DetailScreenState extends State<DetailScreen> {
  List<FoodDetail> foodDetail = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: getWidget());
  }

  getDetail() {
    if (foodDetail.length == 0) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new Text(
        "${foodDetail[0].strInstructionsDetail}",
        textAlign: TextAlign.justify,
      );
    }
  }

  Widget getWidget() {
    return Center(
      child: ListView(
        children: <Widget>[
          Hero(
            tag: 'detail${widget.index}',
            child: AspectRatio(
              aspectRatio: 10 / 5,
              child: Container(
                margin:
                    EdgeInsets.only(top: 30.0, bottom: 20, left: 30, right: 30),
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
                    image: NetworkImage("${widget.image}"),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Center(
              child: Text("${widget.name}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            margin: EdgeInsets.only(bottom: 10.0),
          ),
          Container(
            child: getDetail(),
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          ),
        ],
      ),
    );
  }

  loadData() async {
    String dataURL =
        "https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.info}";
    http.Response response = await http.get(dataURL);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        foodDetail = (responseJson['meals'] as List)
            .map((p) => FoodDetail.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
