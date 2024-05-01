import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperBasvuru.dart';
import 'package:trust/dataService/SQLHelperIlan.dart';
import 'package:trust/dataService/SQLHelperIsAlan.dart';

// İŞ VEREN 4vgames@gmail.com şifre 123
// İŞ ALAN bilgehan@gmail.com şifre 123
class BasvurularListPage extends StatefulWidget {
  int id;
  BasvurularListPage(this.id);
  @override
  State<BasvurularListPage> createState() => _BasvurularListPageState(id);
}

class _BasvurularListPageState extends State<BasvurularListPage> {
  int _id;

  _BasvurularListPageState(this._id);
  List<Map<String, dynamic>> _persons = [];
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperIsAlan.getItems();
    setState(() {
      _persons = data;
      _isLoading = false;
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
      _isLoading = false;
    });
  }

  Future<void> _updateItem(int id, _basvurular, String sonuc) async {
    await SQLHelperBasvuru.updateItem(
        id,
        _basvurular[id]['ilanid'],
        _basvurular[id]['personid'],
        _basvurular[id]['companyid'],
        _basvurular[id]['companyName'],
        sonuc,
        DateTime.now().toString());

    _refreshBasvuru();
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons();
    _refreshBasvuru();
    _refreshIlanlar();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Başvurular'),
        backgroundColor: Colors.black38.withOpacity(0.25),
        shadowColor: Colors.greenAccent.withAlpha(150),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _basvurular.length,
              itemBuilder: (context, index) {
                if (_basvurular[index]['companyid'] == _id) {
                  return buildProfileCard(
                      index,
                      _basvurular[index]['personid'],
                      _basvurular[index]['ilanid'],
                      _basvurular,
                      _ilanlar,
                      _persons,
                      Colors.transparent.withOpacity(0.25));
                } else {
                  return SizedBox();
                }
              }),
    );
  }

  Widget buildProfileCard(int basvuru_id, int person_id, int ilan_id, _basvuru,
      _ilan, _person, Color color) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(107)),
      child: SizedBox(
        height: 450.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.info_sharp,
                    color: Colors.indigoAccent,
                    size: 26.0,
                  ),
                  title: const Text(
                    "İlan Adı",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(_ilan[ilan_id - 1]['alan']),
                ),
                const Divider(
                  color: Colors.blue,
                  indent: 16.0,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.indigoAccent,
                    size: 26.0,
                  ),
                  title: const Text(
                    "Başvuran Kişi",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(_persons[person_id]['name'] +
                      "  " +
                      _persons[person_id]['surName']),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.history_edu_sharp,
                    color: Colors.indigoAccent,
                    size: 26.0,
                  ),
                  title: const Text(
                    "Cv",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(_persons[person_id]['ilgiAlan']),
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
                    _basvuru[basvuru_id]['tarih'],
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  // leading: IconButton(
                  //   icon: Icon(Icons.check_circle),
                  //   onPressed: () => print('select'),
                  // ),
                  title: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.greenAccent),
                    //padding: EdgeInsets.only(left: 100, right: 20),
                    onPressed: () {
                      _updateItem(basvuru_id, _basvuru, "kabul");
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Başvuru kabul edildi.!'),
                        backgroundColor: Colors.greenAccent,
                      ));
                      //Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Başvuruyu Kabul Et'),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    //color: Colors.greenAccent,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  // leading: IconButton(
                  //   icon: Icon(Icons.check_circle),
                  //   onPressed: () => print('select'),
                  // ),
                  title: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),

                    onPressed: () {
                      _updateItem(basvuru_id, _basvuru, "red");
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Başvuru red edildi.!'),
                        backgroundColor: Colors.redAccent,
                      ));
                      //Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Başvuruyu Red Et'),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    //color: Colors.redAccent,
                  ),
                ),
              ],
            ),
            color: Colors.black38.withOpacity(0.25),
            shadowColor: Colors.greenAccent.withAlpha(150),
          ),
        ),
      ),
    );
  }
}
