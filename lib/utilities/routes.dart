import 'package:trust/dataService/adminCompanyService.dart';
import 'package:trust/screens/admin.dart';
import 'package:trust/screens/home_isalan.dart';
import 'package:trust/screens/home_isveren.dart';
import 'package:trust/screens/login_isalan.dart';
import 'package:trust/screens/login_isveren.dart';
import 'package:trust/screens/profile_isalan.dart';
import 'package:trust/screens/register_home.dart';
import 'package:trust/screens/register_isalan.dart';
import 'package:trust/screens/register_isveren.dart';
import 'package:meta/dart2js.dart';

import 'package:flutter/cupertino.dart';
import 'package:trust/screens/login_home.dart';
import 'package:trust/utilities/constants.dart';
import 'constants.dart';

class Routes {
  int? id;
  static final routes = <String, WidgetBuilder>{
    Constants.ROUTE_HOME_ISALAN_PAGE: (BuildContext context) =>
        HomeIsAlan(1, []),
    Constants.ROUTE_HOME_ISVEREN_PAGE: (BuildContext context) =>
        HomeIsVeren(1, []),
    Constants.ROUTE_LOGIN_HOME_PAGE: (BuildContext context) => LoginHomePage(),
    Constants.ROUTE_LOGIN_ISALAN_PAGE: (BuildContext context) =>
        LoginIsalanPage(),
    Constants.ROUTE_LOGIN_ISVEREN_PAGE: (BuildContext context) =>
        LoginIsVerenPage(),
    Constants.ROUTE_REGISTER_HOME_PAGE: (BuildContext context) =>
        RegisterHomePage(),
    Constants.ROUTE_REGISTER_ISALAN_PAGE: (BuildContext context) =>
        RegisterIsAlanPage(),
    Constants.ROUTE_REGISTER_ISVEREN_PAGE: (BuildContext context) =>
        RegisterIsVerenPage(),
    Constants.ROUTE_ADMIN_PAGE: (BuildContext context) => AdminHomePage(),
    Constants.ROUTE_PROFILE_ISALAN_PAGE: (BuildContext context) =>
        ProfileIsAlanPage(1, []),
    Constants.ROUTE_ADMIN_COMPANY_SERVICE_PAGE: (BuildContext context) =>
        AdminCompanyService(),
  };
}
