import 'package:flutter/material.dart';
import 'package:trust/dataService/adminCompanyService.dart';
import 'package:trust/dataService/adminPersonService.dart';
import 'package:trust/utilities/constants.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 48),
              child: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // buildNavigation(
                      //   text: "Ürünler",
                      //   icon: Icons.menu_open,
                      //   widget: AdminProductServicePage(),
                      //   context: context,
                      // ),
                      buildNavigation(
                        text: "Kişiler",
                        icon: Icons.person,
                        widget: AdminPersonServicePage(),
                        context: context,
                      ),
                      const SizedBox(height: 55),
                      buildNavigation(
                        text: "Şirketler",
                        icon: Icons.business_center,
                        widget: AdminCompanyService(),
                        context: context,
                      ),
                      const SizedBox(height: 55),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Constants.ROUTE_LOGIN_HOME_PAGE);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Successfully Log Out!'),
                              backgroundColor: Colors.black87,
                            ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Log Out",
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ))
                    ],
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

buildNavigation({
  required String text,
  required IconData icon,
  Widget? widget,
  BuildContext? context,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context!, MaterialPageRoute(builder: (context) {
        return widget!;
      }));
    },
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xFFE0ECF8)),
          child: Icon(
            icon,
            color: Color(0xFF0001FC),
            size: 18,
          ),
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF1F53E4),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
