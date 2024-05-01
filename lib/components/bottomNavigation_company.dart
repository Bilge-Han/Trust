import 'package:flutter/material.dart';
import 'package:trust/dataService/adminHaberService.dart';
import 'package:trust/screens/haber_isveren.dart';
import 'package:trust/screens/profile_isveren.dart';

Widget bottomNavigationBarCompany({
  required String page,
  required BuildContext context,
  required int? id,
  required List<Map<String, dynamic>> companies,
}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, -3),
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10),
        ],
        color: const Color(0xFFEFF5FB),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavIcon(
            iconData: Icons.home_filled,
            active: page == "home",
            widget: HaberIsVerenPage(id, companies),
            context: context,
          ),
          buildNavIcon(
              iconData: Icons.fiber_new_sharp,
              active: page == "haber",
              widget: const AdminHaberService(),
              context: context),
          // buildNavIcon(
          //   iconData: Icons.add_business,
          //   active: page == "ilans",
          //   widget: AdminIlanServicePage(id!),
          //   context: context,
          // ),
          buildNavIcon(
            iconData: Icons.person,
            active: page == "profile",
            widget: ProfileIsVerenPage(id!, companies),
            context: context,
          ),
        ],
      ),
    ),
  );
}

Widget buildNavIcon(
    {required IconData iconData,
    required bool active,
    Widget? widget,
    BuildContext? context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context!, MaterialPageRoute(builder: (context) {
        return widget!;
      }));
    },
    child: Icon(
      iconData,
      size: 15,
      color: Color(active ? 0xFF0001FC : 0xFF0A1034),
    ),
  );
}
