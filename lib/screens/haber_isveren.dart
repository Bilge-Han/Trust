import 'package:flutter/material.dart';
import 'package:trust/components/bottomNavigation_company.dart';
import 'package:trust/components/bottomNavigation_person.dart';
import 'package:trust/dataService/SQLHelperHaber.dart';
import 'package:trust/screens/haberDetail.dart';

class HaberIsVerenPage extends StatefulWidget {
  int? id;
  List<Map<String, dynamic>> companies = [];
  HaberIsVerenPage(this.id, this.companies);

  @override
  State<HaberIsVerenPage> createState() =>
      _HaberIsVerenPageState(id!, companies);
}

class _HaberIsVerenPageState extends State<HaberIsVerenPage> {
  int _id;
  List<Map<String, dynamic>> _companies = [];
  _HaberIsVerenPageState(this._id, this._companies);

  List<Map<String, dynamic>> _haberler = [];
  bool _isLoading = true;
  void _refreshHaberler() async {
    final data = await SQLHelperHaber.getItems();
    setState(() {
      _haberler = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshHaberler();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(' Haberler '),
              backgroundColor: Colors.black38.withOpacity(0.25),
              shadowColor: Colors.greenAccent.withAlpha(150),
            ),
            body: _buildProductListPage(),
          ),
          bottomNavigationBarCompany(
              page: "home", context: context, id: _id, companies: _companies)
        ],
      )),
    );
  }

  _buildProductListPage() {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: _haberler.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildFilterWidgets(screenSize);
          } else if (index == _haberler.length) {
            return const SizedBox(height: 12.0);
          } else {
            return _buildProductListRow(index);
          }
        },
      ),
    );
  }

  _buildFilterWidgets(Size screenSize) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      width: screenSize.width,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          color: Colors.black38.withOpacity(0.25),
          shadowColor: Colors.greenAccent.withAlpha(150),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton("Sırala"),
                Container(
                  color: Colors.black,
                  width: 2.0,
                  height: 24.0,
                ),
                _buildFilterButton("Filtrele"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFilterButton(String title) {
    return InkWell(
      onTap: () {
        //print(title);
      },
      child: Row(
        children: [
          Icon(Icons.arrow_drop_down, color: Colors.black),
          SizedBox(width: 2.0),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildProductListRow(index) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return ProductDetail(index, _products);
        // }));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Card(
          color: Colors.black38.withOpacity(0.25),
          shadowColor: Colors.greenAccent.withAlpha(150),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  child: Image.asset(_haberler[index]['imageUrl1']),
                  // height: 250.0,
                  width: MediaQuery.of(context).size.width / 1,
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(_haberler[index]['baslik'],
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black)),
                    const SizedBox(height: 2.0),
                    ListTile(
                      title: Text(
                        _haberler[index]['icerik'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(255),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: IconButton(
                        icon: Icon(Icons.info_outlined),
                        onPressed: () => print('select'),
                      ),
                      title: FlatButton(
                        padding: const EdgeInsets.only(left: 120, right: 20),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HaberDetailPage(index, _haberler);
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            const Text('Detaylı Bilgi'),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                        //color: Colors.greenAccent.withOpacity(0.55),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
