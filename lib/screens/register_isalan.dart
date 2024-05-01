import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperIsAlan.dart';
import 'package:trust/utilities/constants.dart';
import 'package:trust/utilities/routes.dart';

class RegisterIsAlanPage extends StatefulWidget {
  const RegisterIsAlanPage({Key? key}) : super(key: key);

  @override
  State<RegisterIsAlanPage> createState() => _RegisterIsAlanPageState();
}

class _RegisterIsAlanPageState extends State<RegisterIsAlanPage> {
  Future<bool> registerControl(String name, String surName, String gmail,
      String password, String Alan, _isAlanlars, context) async {
    bool logcon = false;
    if (name != '' &&
        surName != '' &&
        gmail != '' &&
        password != '' &&
        Alan != '') {
      for (var i = 0; i < _isAlanlars.length; i++) {
        if (_isAlanlars[i]['gmail'] == gmail) {
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
      if (logcon == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Logging'),
          backgroundColor: Colors.greenAccent,
        ));
        // await SQLHelperIsAlan.createItem(
        //     name, surName, gmail, password, ilgiAlan);
        await _addItem();
        _gmailController.text = '';
        _passwordController.text = '';
        Navigator.of(context).pushNamed(Constants.ROUTE_LOGIN_ISALAN_PAGE);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('not empty'),
        backgroundColor: Colors.redAccent,
      ));
    }
    return logcon;
  }

  List<Map<String, dynamic>> _isAlanlar = [];
  bool _isLoading = true;
  void _refreshPersons() async {
    final data = await SQLHelperIsAlan.getItems();
    setState(() {
      _isAlanlar = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshPersons(); // Loading the diary when the app starts
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _AlanController = TextEditingController();
  Future<void> _addItem() async {
    await SQLHelperIsAlan.createItem(
        _nameController.text,
        _surNameController.text,
        _gmailController.text,
        _passwordController.text,
        _AlanController.text);
    _refreshPersons();
  }

  @override
  Widget build(BuildContext context) {
    bool _logging = false;
    final nameField = TextField(
      controller: _nameController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Ad",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final surNameField = TextField(
      controller: _surNameController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Soy Ad",
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
      controller: _AlanController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "İlgi Alanı",
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
        onPressed: () async {
          registerControl(
              _nameController.text,
              _surNameController.text,
              _gmailController.text,
              _passwordController.text,
              _AlanController.text,
              _isAlanlar,
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
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 120,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              nameField,
                              const SizedBox(height: 5),
                              surNameField,
                              const SizedBox(height: 5),
                              gmailField,
                              const SizedBox(height: 5),
                              passwordField,
                              const SizedBox(height: 5),
                              password2Field,
                              const SizedBox(height: 5),
                              registerButton,
                              const SizedBox(height: 10),
                              firstRegisterButton
                            ],
                          ),
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
