import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './data_food.dart';
import 'package:foodrecipes_flutter/view/detail_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "Desert",
    home: Desert(),
  ));
}

class Desert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "Fatoni's Resto Menu";
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            )
          ],
        ),
        body: GridView.builder(
          itemCount: DataDesert.listViewData.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Column(
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
                                  name: DataDesert.listViewData[index],
                                  image: DataDesert.listViewDataImage[index],
                                  info: DataDesert.listViewDataInfo[index],
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
                                DataDesert.listViewDataImage[index],
                                fit: BoxFit.cover,
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
                                    DataDesert.listViewData[index],
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
            );
          },
        ),
      ),
    );
  }
}
