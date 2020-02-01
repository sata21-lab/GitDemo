import 'package:flutter/material.dart';
import 'package:jd_project/pages/tabs.dart';
import 'package:jd_project/provider/CarProvider.dart';
import 'package:jd_project/provider/UserProvider.dart';
import 'package:jd_project/router/routers.dart';
import 'package:provider/provider.dart';

import 'provider/checkoutProider.dart';

void main() => runApp(MainHome());

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(builder: (_) => Counter()),
        ChangeNotifierProvider(builder: (_) => CarProvider()),
        ChangeNotifierProvider(builder: (_) => UsersProvider()),
        ChangeNotifierProvider(builder: (_) => ChecksOutProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainHomeBody(),
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(primaryColor: Colors.white),
      ),
    );
  }
}

class MainHomeBody extends StatefulWidget {
  @override
  _MainHomeBodyState createState() => _MainHomeBodyState();
}

class _MainHomeBodyState extends State<MainHomeBody> {
  @override
  Widget build(BuildContext context) {
    return Tabs();
  }
}
