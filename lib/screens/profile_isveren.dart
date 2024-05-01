import 'package:flutter/material.dart';
import 'package:trust/components/bottomNavigation_company.dart';
import 'package:trust/dataService/SQLHelperIsVeren.dart';
import 'package:trust/dataService/adminCompanyService.dart';
import 'package:trust/screens/ilanOlustur.dart';
import 'package:trust/screens/list_basvurular.dart';
import 'package:trust/screens/list_ilanlar%C4%B1m.dart';
import 'package:trust/screens/login_home.dart';
import 'package:trust/screens/profile_edit_isveren.dart';

class ProfileIsVerenPage extends StatefulWidget {
  int id;
  List<Map<String, dynamic>> companies = [];
  ProfileIsVerenPage(this.id, this.companies);
  @override
  State<StatefulWidget> createState() =>
      _ProfileIsVerenPageState(id, companies);
}

class _ProfileIsVerenPageState extends State<ProfileIsVerenPage> {
  int _id;
  List<Map<String, dynamic>> _companies = [];
  _ProfileIsVerenPageState(this._id, this._companies);

  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperIsVeren.getItems();
    setState(() {
      _companies = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons();
  }

  var _selectedSehir;
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lokasyonController = TextEditingController();
  final TextEditingController _vergiController = TextEditingController();
  Future<void> _updateItem(int id) async {
    await SQLHelperIsVeren.updateItem(
        id,
        _companyNameController.text,
        _sectorController.text,
        _gmailController.text,
        _passwordController.text,
        _selectedSehir,
        _vergiController.text);
    _refreshPersons();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profilim'),
        backgroundColor: Colors.black38.withOpacity(0.25),
        shadowColor: Colors.greenAccent.withAlpha(150),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Başlık
                        //header("Profilim", context),
                        SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return buildProfileCard(
                                      context,
                                      _companies[_id]['companyName'],
                                      _companies[_id]['sector'],
                                      _companies[_id]['gmail'],
                                      _companies,
                                      _id);
                                }
                                //else if (index == 1) {
                                //   return buildCategory("Profili düzenle", context,
                                //       const AdminCompanyService(), Colors.cyanAccent);
                                // } else if (index == 1) {
                                //   return buildCategory("İlan Ekle", context,
                                //       AdminIlanServicePage(), Colors.blueGrey);
                                // } else if (index == 2) {
                                //   return buildCategory("Çıkış Yap", context,
                                //       LoginHomePage(), Colors.red);
                                // }
                                else {
                                  return const SizedBox(height: 0.0);
                                }
                              }),
                        ),
                      ],
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
  Future<bool> registerControl(
      String companyName,
      String sector,
      String gmail,
      String password,
      String selectedsehir,
      String vergi,
      _isVerenlers,
      context,
      int? id) async {
    bool logcon = false;
    if (companyName != '' &&
        sector != '' &&
        gmail != '' &&
        password != '' &&
        selectedsehir != "" &&
        vergi != '') {
      // _isVerenlers[i]['gmail'] == gmail &&
      //       _isVerenlers[id]['gmail'] != gmail) ||
      //   (_isVerenlers[i]['vergi'] == vergi &&
      //       _isVerenlers[id]['vergi'] != vergi)
      for (var i = 0; i < _isVerenlers.length; i++) {
        if (_isVerenlers[i]['gmail'] == gmail ||
            _isVerenlers[i]['vergi'] == vergi) {
          logcon = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('this gmail is already in using'),
            backgroundColor: Colors.amberAccent,
          ));
          break;
        } else {
          logcon = true;
        }
      }
      if (logcon == true && id == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Logging'),
          backgroundColor: Colors.greenAccent,
        ));
        //await _addItem();
      } else if (logcon == true && id != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Updating'),
          backgroundColor: Colors.lightGreenAccent,
        ));
        await _updateItem(id);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('not empty'),
        backgroundColor: Colors.redAccent,
      ));
    }
    Navigator.of(context).pop();
    return logcon;
  }

  void _showForm(int? id, _companies, context) async {
    if (id != null) {
      // final existingJournal =
      //     _companies.firstWhere((element) => element['id'] == id);
      _companyNameController.text = _companies[id]['companyName'];
      _sectorController.text = _companies[id]['sector'];
      _gmailController.text = _companies[id]['gmail'];
      _passwordController.text = _companies[id]['password'];
      _selectedSehir = _companies[id]['lokasyon'];
      _vergiController.text = _companies[id]['vergi'];
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                      controller: _companyNameController,
                      decoration:
                          const InputDecoration(hintText: 'companyName')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _sectorController,
                      decoration: const InputDecoration(hintText: 'sector')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _gmailController,
                      decoration: const InputDecoration(hintText: 'gmail')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(hintText: 'password')),
                  const SizedBox(height: 20),
                  TextField(
                      controller: _vergiController,
                      decoration: const InputDecoration(hintText: 'vergi')),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedSehir,
                    iconSize: 30,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_sharp,
                      color: Colors.greenAccent,
                    ),
                    dropdownColor: Colors.greenAccent.withOpacity(0.25),
                    focusColor: Colors.greenAccent,
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
                      if (id == null) {
                        await registerControl(
                            _companyNameController.text,
                            _sectorController.text,
                            _gmailController.text,
                            _passwordController.text,
                            _selectedSehir,
                            _vergiController.text,
                            _companies,
                            context,
                            id);
                      }
                      if (id != null) {
                        await registerControl(
                            _companyNameController.text,
                            _sectorController.text,
                            _gmailController.text,
                            _passwordController.text,
                            _selectedSehir,
                            _vergiController.text,
                            _companies,
                            context,
                            id);
                      }
                      _companyNameController.text = '';
                      _sectorController.text = '';
                      _gmailController.text = '';
                      _passwordController.text = '';
                      _lokasyonController.text = '';
                      _vergiController.text = '';
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  Widget buildProfileCard(BuildContext context, String name, String alan,
      String gmail, List<Map<String, dynamic>> _companies, int _id) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: SizedBox(
        height: 680.0,
        child: Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.account_box,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                subtitle: Text(alan),
              ),
              const Divider(
                color: Colors.greenAccent,
                indent: 26.0,
              ),
              ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: Text(
                  gmail,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.greenAccent,
                  size: 26.0,
                ),
                title: Text(
                  "İletişim",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return buildProfileEdit(context, _companies, _id);
                      } else if (index == 1) {
                        return buildCategory(
                          "İlanlarım",
                          context,
                          IlanListePage(_id, _companies),
                          Colors.black38.withOpacity(0.25),
                        );
                      } else if (index == 2) {
                        return buildCategory(
                          "İlan Ekle",
                          context,
                          IlanOlustur(_id, _companies),
                          Colors.black38.withOpacity(0.25),
                        );
                      } else if (index == 3) {
                        return buildCategory(
                          "Başvurular",
                          context,
                          BasvurularListPage(_id),
                          Colors.black38.withOpacity(0.25),
                        );
                      } else if (index == 4) {
                        return buildCategory(
                            "Çıkış Yap", context, LoginHomePage(), Colors.red);
                      } else {
                        return const SizedBox(height: 0.0);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory(
      String title, BuildContext context, Widget widget, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget;
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withAlpha(150),
                blurRadius: 4,
                offset: const Offset(0, 4),
              )
            ]),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A1034)),
        ),
      ),
    );
  }

  Widget buildProfileEdit(BuildContext context, _companies, int _id) {
    return GestureDetector(
      onTap: () {
        _showForm(_id, _companies, context);
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withAlpha(150),
                blurRadius: 4,
                offset: const Offset(0, 4),
              )
            ]),
        child: const Text(
          ("Profili Düzenle"),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A1034)),
        ),
      ),
    );
  }
}
