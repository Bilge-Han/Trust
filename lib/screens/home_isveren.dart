import 'package:flutter/material.dart';
import 'package:trust/components/bottomNavigation_company.dart';

class HomeIsVeren extends StatefulWidget {
  int? id;
  List<Map<String, dynamic>> companies = [];
  HomeIsVeren(this.id, this.companies);
  @override
  State<HomeIsVeren> createState() => _HomeIsVerenState(id, companies);
}

class _HomeIsVerenState extends State<HomeIsVeren> {
  int? _id;
  List<Map<String, dynamic>> _companies = [];
  _HomeIsVerenState(this._id, this._companies);
  @override
  Widget build(BuildContext context) {
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
            ),
            bottomNavigationBarCompany(
                page: "home", context: context, id: _id, companies: _companies),
          ],
        ),
      ),
    );
  }
}
