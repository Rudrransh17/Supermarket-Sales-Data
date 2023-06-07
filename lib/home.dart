import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:supermarket_sales_data/app_services.dart';
import 'package:supermarket_sales_data/data.dart';
import 'package:supermarket_sales_data/realm_services.dart';
import 'package:supermarket_sales_data/schemas.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore_for_file: prefer_const_constructors

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<BarData> data;
  late List<PieData> pieData;
  TooltipBehavior? _tooltipBehavior;
  late String barChartX = "Branch";
  late String barChartY = "Total";
  late String PieChartX = "Branch";
  late String PieChartY = "Total";

  @override
  void initState() {
    fetchData();
    _tooltipBehavior =
        TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pieData = getPieData(PieChartX, PieChartY);
    data = getBarData(barChartX, barChartY);
    double maxValBar = data[0].y;
    for (int i = 1; i < data.length; i++) {
      if (data[i].y > maxValBar) {
        maxValBar = data[i].y;
      }
    }
    final realmServices = Provider.of<RealmServices>(context);
    return Provider.of<RealmServices?>(context, listen: false) == null
        ? Container()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 80,
              titleTextStyle: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
              title: const Text(
                'Supermarket Sales Data Visualizer',
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Log out',
                  onPressed: () async => await logOut(context, realmServices),
                ),
              ],
            ),
            body: Row(
              children: [
                Expanded(
                  child: Container(
                    child: SfCartesianChart(
                      enableAxisAnimation: true,
                      tooltipBehavior: _tooltipBehavior,
                      title: ChartTitle(text: "${barChartX} vs ${barChartY}"),
                      primaryXAxis:
                          CategoryAxis(title: AxisTitle(text: barChartX)),
                      primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: maxValBar * 1.2,
                        interval: maxValBar / 10,
                        title: AxisTitle(text: barChartY),
                      ),
                      series: <ChartSeries<BarData, String>>[
                        ColumnSeries<BarData, String>(
                          dataSource: data,
                          xValueMapper: (BarData data, _) => data.x,
                          yValueMapper: (BarData data, _) => data.y,
                          name: 'Gold',
                          color: Color.fromRGBO(8, 142, 255, 1),
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: SfCircularChart(series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<PieData, String>(
                          dataSource: pieData,
                          dataLabelMapper: (PieData pieData, _) => pieData.x as String,
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                          xValueMapper: (PieData pieData, _) => pieData.x,
                          yValueMapper: (PieData pieData, _) => pieData.y)
                    ]),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        Text('Edit Bar Chart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('On X Axis:'),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: barChartX,
                              onChanged: (String? newValue) {
                                // Handle dropdown value change
                                setState(() {
                                  barChartX = newValue!;
                                });
                              },
                              items: <String>[
                                'Branch',
                                'City',
                                'Customer type',
                                'Gender',
                                'Product line',
                                'Payment',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('On Y Axis:'),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: barChartY,
                              onChanged: (String? newValue) {
                                // Handle dropdown value change
                                setState(() {
                                  barChartY = newValue!;
                                });
                              },
                              items: <String>[
                                'Total',
                                'Quantity',
                                'cogs',
                                'gross income',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Text('Edit Pie Chart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Category: '),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: PieChartX,
                              onChanged: (String? newValue) {
                                // Handle dropdown value change
                                setState(() {
                                  PieChartX = newValue!;
                                });
                              },
                              items: <String>[
                                'Branch',
                                'City',
                                'Customer type',
                                'Gender',
                                'Product line',
                                'Payment',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Distribution: '),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: PieChartY,
                              onChanged: (String? newValue) {
                                // Handle dropdown value change
                                setState(() {
                                  PieChartY = newValue!;
                                });
                              },
                              items: <String>[
                                'Total',
                                'Quantity',
                                'cogs',
                                'gross income',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> logOut(BuildContext context, RealmServices realmServices) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    appServices.logOut();
    await realmServices.close();
    Navigator.pushReplacementNamed(context, '/login');
  }
}

Container waitingIndicator() {
  return Container(
    color: Colors.black.withOpacity(0.2),
    child: const Center(child: CircularProgressIndicator()),
  );
}
