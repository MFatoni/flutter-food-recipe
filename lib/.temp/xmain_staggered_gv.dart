import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> _listViewData = [
    "Rendang",
    "Bebek Peking",
  ];
  final List<String> _listViewDataImage = [
    "https://cdn.idntimes.com/content-images/community/2019/06/resep-rendang-8e5883dca37fcbce339f8237bdd838c3_600x400.jpg",
    "http://2.bp.blogspot.com/-B6ijdSocYKU/VLJ1fmp988I/AAAAAAAAAGE/61rQWWo2fHo/s1600/bebek-peking-3.jpg",
  ];
  final List<String> _listViewDataInfo = [
    "Rendang adalah masakan daging dengan bumbu rempah-rempah yang berasal dari Minangkabau. Masakan ini dihasilkan dari proses memasak yang dipanaskan berulang-ulang menggunakan santan sampai kuahnya kering sama sekali. Proses memasaknya memakan waktu berjam-jam (biasanya sekitar empat jam) hingga yang tinggal hanyalah potongan daging berwarna hitam pekat. Dalam suhu ruangan, rendang dapat bertahan hingga berminggu-minggu. Rendang yang dimasak dalam waktu yang lebih singkat dan santannya belum mengering disebut kalio, berwarna coklat terang keemasan. Rendang dapat dijumpai di Rumah Makan Padang di seluruh dunia. Masakan ini populer di Indonesia dan negara-negara Asia Tenggara lainnya, seperti Malaysia, Singapura, Brunei, Filipina, dan Thailand. Di daerah asalnya, Minangkabau, rendang disajikan di berbagai upacara adat dan perhelatan istimewa. Meskipun rendang merupakan masakan tradisional Minangkabau, teknik memasak serta pilihan dan penggunaan bumbu rendang berbeda-berda menurut daerah. ",
    "Bebek Peking adalah makanan tradisional di Tiongkok yang berasal dari Beijing. Makanan bebek Peking ini juga ditemui di Taiwan, dibawa oleh pemerintahan nasionalis Kuomintang yang kalah perang saudara dan mundur ke Taiwan tahun 1949. Bebek Peking dibuat menggunakan daging bebek khusus diternakkan untuk makanan ini. Bebek-bebek digemukkan dengan cara memberikan makanan bergizi, pada saat bebek-bebek kekenyangan, peternak-peternak mungkin saja memasukkan makanan ke dalam kerongkongan sang bebek secara paksa. Ini yang kemudian menjadikan bebek Peking juga dikenal dengan nama bebek isi. Bebek tadi disajikan setelah dipanggang dengan kayu-kayu bakar khusus yang akan menambah wangi daging bebek yang dipanggang. ",
  ];
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
        body: StaggeredGridView.countBuilder(
            itemCount: _listViewData.length,
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return Column(children: <Widget>[
                Card(
                  margin: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailScreen(
                                name: _listViewData[index],
                                image: _listViewDataImage[index],
                                info: _listViewDataInfo[index]);
                          },
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 18.0 / 15.0,
                          child: Image.network(
                            _listViewDataImage[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  _listViewData[index],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]);
            },

            staggeredTileBuilder: (int index) => StaggeredTile.fit(1)),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text("Messages"),
          ),
        ]),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  DetailScreen({Key key, this.name, this.image, this.info}) : super(key: key);
  final String name;
  final String image;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Detail Makanan'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 150.0,
                ),
                margin: const EdgeInsets.all(20.0),
                width: 200,
                height: 200,
              ),
              Container(
                child: Text(name),
                margin: const EdgeInsets.all(10.0),
              ),
              Container(
                child: Text(
                  info,
                  textAlign: TextAlign.justify,
                ),
                margin: const EdgeInsets.only(left: 30, right: 30),
              ),
            ],
          ),
        ));
  }
}
