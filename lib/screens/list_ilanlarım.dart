import 'package:flutter/material.dart';
import 'package:trust/components/bottomNavigation_company.dart';
import 'package:trust/dataService/SQLHelperIlan.dart';
import 'package:trust/utilities/constants.dart';

class IlanListePage extends StatefulWidget {
  int id;
  List<Map<String, dynamic>> companies = [];
  IlanListePage(this.id, this.companies);
  @override
  State<IlanListePage> createState() => _IlanListePageState(id, companies);
}

class _IlanListePageState extends State<IlanListePage> {
  int _id;
  List<Map<String, dynamic>> _companies = [];
  _IlanListePageState(this._id, this._companies);
  Future<void> ilanControl(String companyName, String sector, String alan,
      String lokasyon, String kriter, String tarih, int? id) async {
    if (companyName != '' &&
        sector != '' &&
        alan != '' &&
        lokasyon != '' &&
        kriter != '' &&
        tarih != '') {
      if (id != null) {
        await _updateItem(id);
      }
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Lütfen Eksik Bilgileri Doldurunuz.'),
        backgroundColor: Colors.deepOrangeAccent,
      ));
    }
  }

  List<Map<String, dynamic>> _ilanlar = [];
  bool _isLoading = true;
  void _refreshIlans() async {
    final data = await SQLHelperIlan.getItems();
    setState(() {
      _ilanlar = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshIlans();
  }

  final List<String> _sehirler = [
    "Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Aksaray",
    "Amasya",
    "Ankara",
    "Antalya",
    "Ardahan",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bartın",
    "Batman",
    "Bayburt",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Düzce",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkâri",
    "Hatay",
    "Iğdır",
    "Isparta",
    "İstanbul",
    "İzmir",
    "Kahramanmaraş",
    "Karabük",
    "Karaman",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kilis",
    "Kırıkkale",
    "Kırklareli",
    "Kırşehir",
    "Kocaeli",
    "Konya",
    "Kütahya",
    "Malatya",
    "Manisa",
    "Mardin",
    "Mersin",
    "Muğla",
    "Muş",
    "Nevşehir",
    "Niğde",
    "Ordu",
    "Osmaniye",
    "Rize",
    "Sakarya",
    "Samsun",
    "Şanlıurfa",
    "Siirt",
    "Sinop",
    "Sivas",
    "Şırnak",
    "Tekirdağ",
    "Tokat",
    "Trabzon",
    "Tunceli",
    "Uşak",
    "Van",
    "Yalova",
    "Yozgat",
    "Zonguldak"
  ];
  var _selectedSehir;
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _alanController = TextEditingController();
  final TextEditingController _lokasyonController = TextEditingController();
  final TextEditingController _kriterController = TextEditingController();
  final TextEditingController _tarihController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _ilanlar.firstWhere((element) => element['id'] == id);
      _companyNameController.text = existingJournal['companyName'];
      _sectorController.text = existingJournal['sector'];
      _alanController.text = existingJournal['alan'];
      _selectedSehir = existingJournal['lokasyon'];
      _kriterController.text = existingJournal['kriter'];
      _tarihController.text = existingJournal['tarih'];
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                        controller: _companyNameController,
                        decoration:
                            const InputDecoration(hintText: 'Şirket Adı')),
                    const SizedBox(height: 20),
                    TextField(
                        controller: _sectorController,
                        decoration: const InputDecoration(hintText: 'Sektör')),
                    const SizedBox(height: 20),
                    TextField(
                        controller: _alanController,
                        decoration: const InputDecoration(
                            hintText: 'Aranan İş Pozisyonu')),
                    const SizedBox(height: 20),
                    TextField(
                        controller: _kriterController,
                        decoration: const InputDecoration(hintText: 'Kriter')),
                    const SizedBox(height: 20),
                    TextField(
                        controller: _tarihController,
                        decoration: const InputDecoration(
                            hintText: 'Son Başvuru Tarihi')),
                    const SizedBox(height: 20),
                    DropdownButton<String>(
                      value: _selectedSehir,
                      iconSize: 30,
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_sharp,
                        color: Colors.greenAccent,
                      ),
                      dropdownColor: Colors.greenAccent.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(10),
                      items: _sehirler.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (var value) {
                        setState(() {
                          _selectedSehir = value.toString();
                        });
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent.withOpacity(0.25)),
                      onPressed: () async {
                        if (id != null) {
                          ilanControl(
                              _companyNameController.text,
                              _sectorController.text,
                              _alanController.text,
                              _selectedSehir,
                              _kriterController.text,
                              _tarihController.text,
                              id);
                        }
                        _companyNameController.text = '';
                        _sectorController.text = '';
                        _alanController.text = '';
                        _selectedSehir = "";
                        _kriterController.text = '';
                        _tarihController.text = '';
                      },
                      child: Text(id == null ? 'Create New' : 'Update'),
                    )
                  ],
                ),
              ),
            ));
  }

  Future<void> _updateItem(int id) async {
    await SQLHelperIlan.updateItem(
        id,
        _id,
        _companyNameController.text,
        _sectorController.text,
        _alanController.text,
        _selectedSehir,
        _kriterController.text,
        _tarihController.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('İlan başarıyla güncellendi.!'),
    ));
    _refreshIlans();
  }

  Future<void> _deleteItem(int id) async {
    await SQLHelperIlan.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('İlan başarıyla silindi.!'),
    ));
    _refreshIlans();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('İlanlarım'),
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
                  itemCount: _ilanlar.length,
                  itemBuilder: (context, index) {
                    if (_ilanlar[index]['companyName'] ==
                        _companies[_id]['companyName']) {
                      return Card(
                        color: Colors.greenAccent.withOpacity(0.25),
                        margin: const EdgeInsets.all(15),
                        child: ListTile(
                          title: Text(_ilanlar[index]['companyName']),
                          subtitle: Text(_ilanlar[index]['alan']),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () =>
                                      _showForm(_ilanlar[index]['id']),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteItem(_ilanlar[index]['id']),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(height: 0);
                    }
                  }),
            ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     _companyNameController.text = '';
      //     _sectorController.text = '';
      //     _alanController.text = '';
      //     _lokasyonController.text = '';
      //     _kriterController.text = '';
      //     _tarihController.text = '';
      //     _showForm(null);
      //   },
      // ),
      // bottomNavigationBar: bottomNavigationBarCompany(
      //     page: "profile", context: context, id: _id, companies: _companies),
    );
  }
}
