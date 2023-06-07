import 'package:flutter/material.dart';
import 'package:supermarket_sales_data/app_services.dart';
import 'package:supermarket_sales_data/home.dart';
import 'package:supermarket_sales_data/realm_services.dart';
import 'login.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() async {
  fetchData();
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
        debugShowCheckedModeBanner: false,
        title: 'Supermarket Sales Data Visualizer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: currentUser != null ? '/home' : '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/home' : (context) => HomeScreen(),
        },
      ),
    );
  }
}

void fetchData() async {
  final url = 'https://ap-south-1.aws.data.mongodb-api.com/app/data-tezyh/endpoint/data/v1/action/find';

  final payload = jsonEncode({
    "collection": "collection_1",
    "database": "sales_data",
    "dataSource": "Cluster0",
    "filter": {},
    "sort": {
      "completedAt": 1
    },
    "limit": 10
  });

  final headers = {
    'Content-Type': 'application/json',
    'Access-Control-Request-Headers': '*',
    'api-key': 'ns2Qvk5jJAf7AW5WuJ5pKuh1GncnOih65BUpbB6BubQN7c6MX4JT2npnL0vZO2gw',
  };

  final response = await http.post(Uri.parse(url), headers: headers, body: payload);

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    List<String> invoiceIds = [];
    List<String> branches = [];
    List<String> cities = [];
    List<String> customerTypes = [];
    List<String> genders = [];
    List<String> productLines = [];
    List<double> unitPrices = [];
    List<int> quantities = [];
    List<double> taxes = [];
    List<double> totals = [];
    List<String> dates = [];
    List<String> times = [];
    List<String> payments = [];
    List<double> cogs = [];
    List<double> grossMarginPercentages = [];
    List<double> grossIncomes = [];
    List<double> ratings = [];

    for (var document in responseData) {
      invoiceIds.add(document['Invoice ID']);
      branches.add(document['Branch']);
      cities.add(document['City']);
      customerTypes.add(document['Customer type']);
      genders.add(document['Gender']);
      productLines.add(document['Product line']);
      unitPrices.add(document['Unit price'].toDouble());
      quantities.add(document['Quantity']);
      taxes.add(document['Tax 5%'].toDouble());
      totals.add(document['Total'].toDouble());
      dates.add(document['Date']);
      times.add(document['Time']);
      payments.add(document['Payment']);
      cogs.add(document['cogs'].toDouble());
      grossMarginPercentages.add(document['gross margin percentage'].toDouble());
      grossIncomes.add(document['gross income'].toDouble());
      ratings.add(document['Rating'].toDouble());
    }

    // Print the lists for verification
    print(invoiceIds);
    print(branches);
    print(cities);
    // ... and so on for other lists
  } else {
    print('Error: ${response.statusCode}');
  }
}






