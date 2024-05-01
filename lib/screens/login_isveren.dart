import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:trust/dataService/SQLHelperIsVeren.dart';
import 'package:trust/screens/haber_isveren.dart';
import 'package:trust/screens/home_isveren.dart';
import 'package:trust/utilities/constants.dart';

class LoginIsVerenPage extends StatefulWidget {
  @override
  State<LoginIsVerenPage> createState() => _LoginIsVerenPageState();
}

Future<void> loginControl(
    String gmail, String password, _persons, context) async {
  bool logcon = false;
  for (var i = 0; i < _persons.length; i++) {
    if (_persons[i]['gmail'] == gmail && _persons[i]['password'] == password) {
      logcon = true;
      // Navigator.of(context).pushNamed(Constants.ROUTE_HOME_ISVEREN_PAGE);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HaberIsVerenPage(i, _persons);
      }));
    }
  }
  if (logcon == false) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('username or password is wrong'),
    ));
  }
}

class _LoginIsVerenPageState extends State<LoginIsVerenPage> {
  List<Map<String, dynamic>> _persons = [];
  bool _isLoading = true;
  void _refreshProducts() async {
    final data = await SQLHelperIsVeren.getItems();
    setState(() {
      _persons = data;
      _isLoading = false;
    });
  }

  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _refreshProducts(); // Loading the diary when the app starts
  }

  Widget build(BuildContext context) {
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
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.black38.withOpacity(0.25),
      shadowColor: Colors.greenAccent.withAlpha(150),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          loginControl(_gmailController.text, _passwordController.text,
              _persons, context);
        },
        child: const Text(
          "Giriş yap",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
        ),
      ),
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
          Navigator.of(context)
              .pushNamed(Constants.ROUTE_REGISTER_ISVEREN_PAGE);
        },
        child: const Text(
          "Kayıt ol",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.normal),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Image.asset("assets/images/diamond.png"),
                            const SizedBox(height: 10.0),
                            gmailField,
                            const SizedBox(height: 10.0),
                            passwordField,
                            const SizedBox(height: 15.0),
                            loginButton,
                            const SizedBox(height: 10.0),
                            registerButton
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
