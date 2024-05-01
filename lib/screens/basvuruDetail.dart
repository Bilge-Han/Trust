import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperBasvuru.dart';
import 'package:trust/dataService/SQLHelperIlan.dart';

class BasvuruDetail extends StatefulWidget {
  int personid;
  int ilanid;
  List<Map<String, dynamic>> persons;
  List<Map<String, dynamic>> ilan;
  BasvuruDetail(this.personid, this.persons, this.ilan, this.ilanid);

  @override
  State<BasvuruDetail> createState() =>
      _BasvuruDetailState(personid, persons, ilan, ilanid);
}

class _BasvuruDetailState extends State<BasvuruDetail> {
  int person_id;
  int ilan_id;
  List<Map<String, dynamic>> _persons;
  List<Map<String, dynamic>> _ilan;
  _BasvuruDetailState(this.person_id, this._persons, this._ilan, this.ilan_id);
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperIlan.getItems();
    setState(() {
      _ilan = data;
      _isLoading = false;
    });
  }

  void _companyTake() async {}
  Future<void> _addItem() async {
    await SQLHelperBasvuru.createItem(
      ilan_id,
      person_id,
      _ilan[ilan_id]['companyid'],
      _ilan[ilan_id]['companyName'],
      "basvuru",
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Başvurunuz başarıyla gönderildi.!'),
    ));
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.chevron_left,
                        size: 40.0, color: Colors.black)),
                backgroundColor: Colors.black38.withOpacity(0.25),
                shadowColor: Colors.greenAccent.withAlpha(150),
                title: const Text("İlan Detayları",
                    style: TextStyle(color: Colors.black)),
              ),
              body: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SizedBox(
                  height: 850.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.black38.withOpacity(0.10),
                      shadowColor: Colors.greenAccent.withAlpha(150),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.account_box,
                              color: Colors.blue,
                              size: 26.0,
                            ),
                            title: const Text(
                              "Firma  Adı",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                            subtitle: Text(_ilan[ilan_id]['companyName']),
                          ),
                          // const Divider(
                          //   color: Colors.blue,
                          //   indent: 16.0,
                          // ),
                          ListTile(
                            leading: const Icon(
                              Icons.mark_chat_unread_outlined,
                              color: Colors.blue,
                              size: 26.0,
                            ),
                            title: const Text(
                              "Alan",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            subtitle: Text(_ilan[ilan_id]['alan']),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.maps_home_work_outlined,
                              color: Colors.blue,
                              size: 26.0,
                            ),
                            title: const Text(
                              "Lokasyon",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            subtitle: Text(
                              _ilan[ilan_id]['lokasyon'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.insert_chart_outlined_rounded,
                              color: Colors.blue,
                              size: 26.0,
                            ),
                            title: const Text(
                              "Kriter",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                            subtitle: Text(
                              _ilan[ilan_id]['kriter'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.date_range,
                              color: Colors.blue,
                              size: 26.0,
                            ),
                            title: const Text(
                              "Son Başvuru Tarihi",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                            subtitle: Text(
                              _ilan[ilan_id]['tarih'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                          ListTile(
                            title: const TextField(
                                decoration: InputDecoration(
                                    hintText:
                                        'Başvuru için istenen ek bilgileri giriniz.')),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            // leading: IconButton(
                            //   icon: Icon(Icons.check_circle),
                            //   onPressed: () => print('select'),
                            // ),
                            title: FlatButton(
                              padding:
                                  const EdgeInsets.only(left: 120, right: 20),
                              onPressed: () {
                                _addItem();
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text('Başvur'),
                                  //Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
