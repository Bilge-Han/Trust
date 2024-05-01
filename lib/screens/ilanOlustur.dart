import 'package:flutter/material.dart';
import 'package:trust/components/bottomNavigation_company.dart';
import 'package:trust/dataService/SQLHelperIlan.dart';
import 'package:trust/dataService/SQLHelperIsVeren.dart';

class IlanOlustur extends StatefulWidget {
  int? id;
  List<Map<String, dynamic>> companies = [];
  IlanOlustur(this.id, this.companies);
  @override
  // ignore: no_logic_in_create_state
  State<IlanOlustur> createState() => _IlanOlusturState(id!, companies);
}

class _IlanOlusturState extends State<IlanOlustur> {
  int _id;
  List<Map<String, dynamic>> _companies = [];
  _IlanOlusturState(this._id, this._companies);
  Future<void> ilanControl(String companyName, String sector, String alan,
      String lokasyon, String kriter, String tarih, int? id) async {
    if (companyName != '' &&
        sector != '' &&
        alan != '' &&
        lokasyon != '' &&
        kriter != '' &&
        tarih != '') {
      await _addItem();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Lütfen Eksik Bilgileri Doldurunuz.'),
        backgroundColor: Colors.deepOrangeAccent,
      ));
    }
  }

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

  var _selectedSehir = "Ankara";
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

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _alanController = TextEditingController();
  final TextEditingController _lokasyonController = TextEditingController();
  final TextEditingController _kriterController = TextEditingController();
  final TextEditingController _tarihController = TextEditingController();
  Future<void> _addItem() async {
    await SQLHelperIlan.createItem(
        _id,
        _companies[_id]['companyName'],
        _companies[_id]['sector'],
        _alanController.text,
        _selectedSehir,
        _kriterController.text,
        _tarihController.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('İlan başarıyla oluşturuldu.!'),
    ));
    _refreshIlanlar();
  }

  Widget build(BuildContext context) {
    int? id = null;

    final _dropDownButton = DropdownButton<String>(
      value: _selectedSehir,
      iconSize: 30,
      icon: const Icon(
        Icons.arrow_drop_down_circle_sharp,
        color: Colors.greenAccent,
      ),
      dropdownColor: Colors.greenAccent.withOpacity(0.25),
      borderRadius: BorderRadius.circular(10),
      items: _sehirler.map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (var value) {
        setState(() {
          _selectedSehir = value.toString();
        });
      },
    );
    final alanField = TextField(
        controller: _alanController,
        decoration: const InputDecoration(hintText: 'Aranan İş Pozisyonu'));
    final lokasyonField = TextField(
        controller: _lokasyonController,
        decoration: const InputDecoration(hintText: 'Lokasyon'));
    final kriterField = TextField(
        controller: _kriterController,
        decoration: const InputDecoration(hintText: 'Kriter'));
    final tarihField = TextField(
        controller: _tarihController,
        decoration: const InputDecoration(hintText: 'Son Başvuru Tarihi'));
    final registerButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent.withOpacity(0.25)),
      onPressed: () async {
        if (id == null) {
          ilanControl(
              _companies[_id]['companyName'],
              _companies[_id]['sector'],
              _alanController.text,
              _selectedSehir,
              _kriterController.text,
              _tarihController.text,
              _id);
        }
        _companyNameController.text = '';
        _sectorController.text = '';
        _alanController.text = '';
        _lokasyonController.text = "";
        _kriterController.text = '';
        _tarihController.text = '';
      },
      child: const Text(
        'Create New',
        style: TextStyle(backgroundColor: Colors.transparent),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('İlan Ekle'),
                backgroundColor: Colors.black38.withOpacity(0.25),
                shadowColor: Colors.greenAccent.withAlpha(150),
              ),
              body: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // TextField(
                          //     controller: _companyNameController,
                          //     decoration:
                          //         const InputDecoration(hintText: 'Şirket Adı')),
                          // const SizedBox(height: 20),
                          // TextField(
                          //     controller: _sectorController,
                          //     decoration:
                          //         const InputDecoration(hintText: 'Sektör')),
                          // const SizedBox(height: 20),
                          alanField,
                          const SizedBox(height: 20),
                          //lokasyonField,
                          const SizedBox(height: 20),
                          kriterField,
                          const SizedBox(height: 20),
                          tarihField,
                          const SizedBox(height: 20),
                          // DropdownButton<String>(
                          //   value: _selectedSehir,
                          //   iconSize: 30,
                          //   icon: const Icon(
                          //     Icons.arrow_drop_down_circle_sharp,
                          //     color: Colors.greenAccent,
                          //   ),
                          //   dropdownColor: Colors.greenAccent.withOpacity(0.25),
                          //   borderRadius: BorderRadius.circular(10),
                          //   items: _sehirler.map((String value) {
                          //     return DropdownMenuItem<String>(
                          //         value: value, child: Text(value));
                          //   }).toList(),
                          //   onChanged: (var value) {
                          //     setState(() {
                          //       _selectedSehir = value.toString();
                          //     });
                          //   },
                          // ),
                          _dropDownButton,
                          const SizedBox(height: 20),
                          registerButton
                        ],
                      ),
                    ),
            ),
            bottomNavigationBarCompany(
                page: "profile",
                context: context,
                id: _id,
                companies: _companies),
          ],
        ),
      ),
    );
  }
}
