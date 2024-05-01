import 'package:flutter/material.dart';
import 'package:trust/components/bottomNavigation_person.dart';
import 'package:trust/dataService/SQLHelperIlan.dart';
import 'package:trust/screens/basvuruDetail.dart';

class HomeIsAlan extends StatefulWidget {
  int id;
  List<Map<String, dynamic>> persons = [];
  HomeIsAlan(this.id, this.persons, {Key? key}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<HomeIsAlan> createState() => _HomeIsAlanState(id, persons);
}

class _HomeIsAlanState extends State<HomeIsAlan> {
  int _id;
  List<Map<String, dynamic>> _persons = [];
  _HomeIsAlanState(this._id, this._persons);
  List<Map<String, dynamic>> _ilanlar = [];
  bool _isLoading = true;
  void _refreshIlanlar() async {
    final data = await SQLHelperIlan.getItems();
    setState(() {
      _ilanlar = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshIlanlar();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(' LYCAN '),
                backgroundColor: Colors.black38.withOpacity(0.25),
                shadowColor: Colors.greenAccent.withAlpha(150),
              ),
              body: _buildProductListPage("title"),
            ),
            //SizedBox(height: 12.0),
            bottomNavigationBar(
                page: "search", context: context, persons: _persons, id: _id),
          ],
        ),
      ),
    );
  }

  _buildProductListPage(String title) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: _ilanlar.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildFilterWidgets(screenSize);
          } else if (index == _ilanlar.length) {
            return const SizedBox(height: 82.0);
          } else {
            return buildProfileCard(
                context,
                _ilanlar[index]['companyName'],
                _ilanlar[index]['sector'],
                _ilanlar[index]['alan'],
                _ilanlar[index]['lokasyon'],
                _ilanlar[index]['kriter'],
                _ilanlar[index]['tarih'],
                _ilanlar,
                _persons,
                _id,
                index);
          }
        },
      ),
    );
  }

  _buildFilterWidgets(Size screenSize) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      width: screenSize.width,
      child: Card(
        color: Colors.black38.withOpacity(0.1),
        shadowColor: Colors.greenAccent.withAlpha(150),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFilterButton("Sırala"),
              Container(
                color: Colors.black,
                width: 2.0,
                height: 14.0,
              ),
              _buildFilterButton("Filtrele"),
            ],
          ),
        ),
      ),
    );
  }

  _buildFilterButton(String title) {
    return InkWell(
      onTap: () {
        print(title);
      },
      child: Row(
        children: [
          const Icon(Icons.arrow_drop_down, color: Colors.black),
          const SizedBox(width: 2.0),
          Text(title),
        ],
      ),
    );
  }

  Widget buildProfileCard(
      BuildContext context,
      String companyName,
      String sector,
      String alan,
      String lokasyon,
      String kriter,
      String tarih,
      List<Map<String, dynamic>> _ilan,
      List<Map<String, dynamic>> _persons,
      int _id,
      int ilan_id) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: SizedBox(
        height: 400.0,
        child: Card(
          color: Colors.white.withOpacity(0.1),
          shadowColor: Colors.greenAccent.withAlpha(150),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.business_rounded,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: const Text(
                  "Firma Adı",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle: Text(companyName),
              ),
              const Divider(
                color: Colors.greenAccent,
                indent: 16.0,
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: const Text(
                  "Alan",
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle: Text(alan),
              ),
              ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: const Text(
                  "Lokasyon",
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle: Text(lokasyon),
              ),
              ListTile(
                leading: const Icon(
                  Icons.date_range,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: const Text(
                  "Son Başvuru Tarihi",
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle: Text(
                  tarih,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                // leading: IconButton(
                //   icon: Icon(Icons.check_circle),
                //   onPressed: () => print('select'),
                // ),
                title: FlatButton(
                  padding: const EdgeInsets.only(left: 120, right: 20),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BasvuruDetail(_id, _persons, _ilan, ilan_id);
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
      ),
    );
  }
}
