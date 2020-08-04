import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodrecipes_flutter/view/detail_screen.dart';
import 'package:foodrecipes_flutter/model/data_food.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: "Breakfast",
    home: BreakfastPage(),
  ));
}

class BreakfastPage extends StatefulWidget {
  BreakfastPage({Key key}) : super(key: key);

  @override
  _BreakfastPageState createState() => new _BreakfastPageState();
}

// Home page state class
class _BreakfastPageState extends State<BreakfastPage> {
  List<Food> food = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Breakfast"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            )
          ],
        ),
        body: getBody());
  }

  getBody() {
    if (food.length == 0) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return getGridView();
    }
  }

  GridView getGridView() => new GridView.builder(
      itemCount: 10,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int index) {
    return new GestureDetector(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Card(
              margin: EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailScreen(
                            info: "${food[index].idMeal}",
                            image: "${food[index].strMealThumb}",
                            name: "${food[index].strMeal}",
                            index: index);
                      },
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Hero(
                        tag: 'detail$index',
                        child: Image.network(
                          "${food[index].strMealThumb}",
                          fit: BoxFit.fill,
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "${food[index].strMeal}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  loadData() async {
    String dataURL =
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";
    http.Response response = await http.get(dataURL);
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        food = (responseJson['meals'] as List)
            .map((p) => Food.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
