import 'dart:convert';
import 'package:http/http.dart' as http;

var responseData;

class BarData {
  BarData(this.x, this.y);

  final String x;
  final double y;
}

class PieData {
  PieData(this.x, this.y);
  final String x;
  final double y;
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
    "limit": 1000
  });

  final headers = {
    'Content-Type': 'application/json',
    'Access-Control-Request-Headers': '*',
    'api-key': 'ns2Qvk5jJAf7AW5WuJ5pKuh1GncnOih65BUpbB6BubQN7c6MX4JT2npnL0vZO2gw',
  };

  final response = await http.post(
      Uri.parse(url), headers: headers, body: payload);

  if (response.statusCode == 200) {
    responseData = jsonDecode(response.body);
  } else {
    print('Error: ${response.statusCode}');
  }
}

List<BarData> getBarData(String x_field, String y_field) {
  Map<String, double> map = {};

  for (var document in responseData['documents']) {
    String category = document[x_field];
    double value = double.parse(document[y_field].toStringAsFixed(2));

    // Check if the branch exists in the branchTotals map
    if (map.containsKey(category)) {
      map[category] = map[category]! + value; // Add the total value to the existing branch total
    } else {
      map[category] = value; // Create a new entry for the branch with the total value
    }
  }
  print(map);
  // Convert the branchTotals map into a list of BarData objects
  List<BarData> result = map.entries.map((entry) {
    return BarData(entry.key, entry.value);
  }).toList();

  return result;
}

List<PieData> getPieData(String x_field, String y_field) {
  Map<String, double> map = {};

  for (var document in responseData['documents']) {
    String category = document[x_field];
    double value = double.parse(document[y_field].toStringAsFixed(2));

    // Check if the branch exists in the branchTotals map
    if (map.containsKey(category)) {
      map[category] = map[category]! + value; // Add the total value to the existing branch total
    } else {
      map[category] = value; // Create a new entry for the branch with the total value
    }
  }
  print(map);
  // Convert the branchTotals map into a list of BarData objects
  List<PieData> result = map.entries.map((entry) {
    return PieData(entry.key, entry.value);
  }).toList();

  return result;
}