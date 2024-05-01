import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperIsVeren.dart';
import 'package:trust/screens/home_isveren.dart';
import 'package:trust/utilities/constants.dart';

class RegisterIsVerenPage extends StatefulWidget {
  const RegisterIsVerenPage({Key? key}) : super(key: key);

  @override
  State<RegisterIsVerenPage> createState() => _RegisterIsVerenPagePageState();
}

class _RegisterIsVerenPagePageState extends State<RegisterIsVerenPage> {
  //final List<String> lokation = [];

  Future<bool> registerControl(
      String companyName,
      String sector,
      String gmail,
      String password,
      String lokasyon,
      String vergi,
      _isVerenlers,
      context) async {
    bool logcon = false;
    if (companyName != '' &&
        sector != '' &&
        gmail != '' &&
        password != '' &&
        selectedSehir != '' &&
        vergi != '') {
      for (var i = 0; i < _isVerenlers.length; i++) {
        if (_isVerenlers[i]['gmail'] == gmail ||
            _isVerenlers[i]['vergi'] == vergi) {
          logcon = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('this gmail or vergi no is already in using'),
            backgroundColor: Colors.amberAccent,
          ));
          break;
        } else {
          logcon = true;
        }
      }
      if (logcon == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Kayıt Başarılı'),
          backgroundColor: Colors.greenAccent,
        ));
        await _addItem();
        _gmailController.text = '';
        _passwordController.text = '';
        Navigator.of(context).pushNamed(Constants.ROUTE_LOGIN_ISVEREN_PAGE);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('not empty'),
        backgroundColor: Colors.redAccent,
      ));
    }
    return logcon;
  }

  List<Map<String, dynamic>> _isVerenler = [];
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperIsVeren.getItems();
    setState(() {
      _isVerenler = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons(); // Loading the diary when the app starts
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
  var selectedSehir = "Ankara";
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lokasyonController = TextEditingController();
  final TextEditingController _vergiController = TextEditingController();
  Future<void> _addItem() async {
    await SQLHelperIsVeren.createItem(
        _companyNameController.text,
        _sectorController.text,
        _gmailController.text,
        _passwordController.text,
        selectedSehir,
        _vergiController.text);
    _refreshPersons();
  }

  @override
  Widget build(BuildContext context) {
    bool _logging = false;
    final nameField = TextField(
      controller: _companyNameController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Şirket Adı",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final surNameField = TextField(
      controller: _sectorController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Sektör",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final gmailField = TextField(
      controller: _gmailController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: " Gmail ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Parola",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final password2Field = TextField(
      controller: _lokasyonController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Lokasyon",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final _dropDownButton = DropdownButton<String>(
      value: selectedSehir,
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
          selectedSehir = value.toString();
        });
      },
    );
    final vergiField = TextField(
      controller: _vergiController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Vergi Numarası",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.black38.withOpacity(0.25),
      shadowColor: Colors.greenAccent.withAlpha(150),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          registerControl(
              _companyNameController.text,
              _sectorController.text,
              _gmailController.text,
              _passwordController.text,
              _lokasyonController.text,
              _vergiController.text,
              _isVerenler,
              context);
        },
        // ignore: prefer_const_constructors
        child: Text(
          "Kayıt Ol",
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
        ),
      ),
    );
    final firstRegisterButton = Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.black38.withOpacity(0.25),
      shadowColor: Colors.greenAccent.withAlpha(150),
      child: MaterialButton(
        // minWidth: MediaQuery.of(context).size.width,
        minWidth: 5,
        height: 5,
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        onPressed: () async {
          await _addItem();
          _gmailController.text = '';
          _passwordController.text = '';
          Navigator.of(context).pushNamed(Constants.ROUTE_LOGIN_ISALAN_PAGE);
        },
        // ignore: prefer_const_constructors
        child: Text(
          "İlk Kayıt",
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
        ),
      ),
    );
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
              body: Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 15,
                          // this will prevent the soft keyboard from covering the text fields
                          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            nameField,
                            const SizedBox(height: 5),
                            surNameField,
                            const SizedBox(height: 5),
                            gmailField,
                            const SizedBox(height: 5),
                            passwordField,
                            const SizedBox(height: 5),
                            vergiField,
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "Lokasyon",
                                  style: TextStyle(fontSize: 17.5),
                                ),
                                const SizedBox(width: 25),
                                _dropDownButton
                              ],
                            ),
                            const SizedBox(height: 5),
                            registerButton,
                            const SizedBox(height: 5),
                            firstRegisterButton,
                          ],
                        ),
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
