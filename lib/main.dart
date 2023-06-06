import 'package:flutter/material.dart';
import 'package:supermarket_sales_data/app_services.dart';
import 'package:supermarket_sales_data/home.dart';
import 'package:supermarket_sales_data/realm_services.dart';
import 'login.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final realmConfig = json.decode(await rootBundle.loadString('assets/config/app_config.json'));
  String appId = realmConfig['appId'];
  Uri baseUrl = Uri.parse(realmConfig['baseUrl']);


  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppServices>(create: (_) => AppServices(appId, baseUrl)),
    ChangeNotifierProxyProvider<AppServices, RealmServices?>(
      // RealmServices can only be initialized only if the user is logged in.
        create: (context) => null,
        update: (BuildContext context, AppServices appServices, RealmServices? realmServices) {
          return appServices.app.currentUser != null ? RealmServices(appServices.app) : null;
        }),
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<RealmServices?>(context, listen: false)?.currentUser;

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        title: 'Supermarket Sales Data Visualizer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: currentUser != null ? '/home' : '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/home' : (context) => const HomeScreen(),
        },
      ),
    );
  }
}






