import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperBasvuru.dart';
import 'package:trust/dataService/SQLHelperIlan.dart';
import 'package:trust/dataService/SQLHelperIsAlan.dart';

class BasvuruListPage extends StatefulWidget {
  int id;
  BasvuruListPage(this.id);
  @override
  State<BasvuruListPage> createState() => _BasvuruListPageState(id);
}

class _BasvuruListPageState extends State<BasvuruListPage> {
  int _id;

  _BasvuruListPageState(this._id);
  List<Map<String, dynamic>> _persons = [];
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperIsAlan.getItems();
    setState(() {
      _persons = data;
    });
  }

  List<Map<String, dynamic>> _basvurular = [];
  void _refreshBasvuru() async {
    final data = await SQLHelperBasvuru.getItems();
    setState(() {
      _basvurular = data;
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> _ilanlar = [];
  void _refreshIlanlar() async {
    final data = await SQLHelperIlan.getItems();
    setState(() {
      _ilanlar = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons();
    _refreshBasvuru();
    _refreshIlanlar();
  }

  void _deleteItem(int id) async {
    await SQLHelperBasvuru.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Başvurunuz başarıyla silindi.!'),
      backgroundColor: Colors.redAccent,
    ));
    _refreshBasvuru();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Başvurularım'),
        backgroundColor: Colors.black38.withOpacity(0.25),
        shadowColor: Colors.greenAccent.withAlpha(150),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: _basvurular.length,
                  itemBuilder: (context, index) {
                    if (_basvurular[index]['personid'] == _id) {
                      if (_basvurular[index]['sonuc'] == "kabul") {
                        return buildProfileCard(
                            index,
                            _id,
                            _basvurular[index]['ilanid'] - 1,
                            _basvurular,
                            _ilanlar,
                            _persons,
                            Colors.green);
                      } else if (_basvurular[index]['sonuc'] == "red") {
                        return buildProfileCard(
                            index,
                            _id,
                            _basvurular[index]['ilanid'] - 1,
                            _basvurular,
                            _ilanlar,
                            _persons,
                            Colors.red);
                      } else if (_basvurular[index]['sonuc'] == "basvuru") {
                        return buildProfileCard(
                            index,
                            _id,
                            _basvurular[index]['ilanid'] - 1,
                            _basvurular,
                            _ilanlar,
                            _persons,
                            Colors.white.withOpacity(0.01));
                      } else {
                        return SizedBox();
                      }
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
    );
  }

  Widget buildProfileCard(int basvuruId, int personId, int ilanId, _basvuru,
      _ilan, _person, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: SizedBox(
        height: 480.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.business_rounded,
                    color: Colors.indigoAccent,
                    size: 26.0,
                  ),
                  title: const Text(
                    "Firma Adı",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(_ilan[ilanId]['companyName']),
                ),
                const Divider(
                  color: Colors.indigoAccent,
                  indent: 16.0,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.indigoAccent,
                    size: 26.0,
                  ),
                  title: const Text(
                    "Alan",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(_ilan[ilanId]['alan']),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.indigoAccent,
                    size: 26.0,
                  ),
                  title: const Text(
                    "Lokasyon",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(_ilan[ilanId]['lokasyon']),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.date_range,
                    color: Colors.indigoAccent,
                    size: 26.0,
                  ),
                  title: const Text(
                    "Başvurulan Tarihi",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    _basvuru[basvuruId]['tarih'],
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.mode_standby_outlined,
                    color: Colors.indigoAccent,
                    size: 26.0,
                  ),
                  title: const Text(
                    "Başvuru durumu",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    _basvuru[basvuruId]['sonuc'],
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                ListTile(
                  trailing: SizedBox(
                    width: 180,
                    child: Row(
                      children: [
                        const Text("Başvuruyu Geri Çek",
                            style: TextStyle(color: Colors.black)),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () => _deleteItem(basvuruId),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            color: color,
            shadowColor: Colors.greenAccent.withAlpha(150),
          ),
        ),
      ),
    );
  }
}
