import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trust/utilities/constants.dart';

class RegisterHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterHomePageState();
}

class _RegisterHomePageState extends State<RegisterHomePage> {
  @override
  Widget build(BuildContext context) {
    final isVerenLoginButton = Material(
      elevation: 85.0,
      borderRadius: BorderRadius.circular(130.0),
      color: Colors.transparent.withOpacity(0.25),
      shadowColor: Colors.transparent.withOpacity(0.75),
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(Constants.ROUTE_REGISTER_ISVEREN_PAGE);
        },
        child: Text(
          "İş Veren Kayıt",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        ),
      ),
    );
    final isAlanLoginButton = Material(
      elevation: 85.0,
      borderRadius: BorderRadius.circular(130.0),
      color: Colors.transparent.withOpacity(0.25),
      shadowColor: Colors.transparent.withOpacity(0.75),
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Constants.ROUTE_REGISTER_ISALAN_PAGE);
        },
        child: Text(
          "İş Alan Kayıt ",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
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
                  padding: EdgeInsets.only(),
                  child: Center(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            isVerenLoginButton,
                            SizedBox(height: 20),
                            isAlanLoginButton,
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
