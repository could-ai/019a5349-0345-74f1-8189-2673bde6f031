import 'package:http/http.dart' as http;
import 'dart:convert';

class SyncService {
  // Placeholder for Google Sheets sync via a published Apps Script endpoint
  final String endpointUrl = 'https://script.google.com/macros/s/YOUR_SCRIPT_ID/exec';

  Future<bool> pushTasks(List<Map<String, dynamic>> tasks) async {
    final response = await http.post(Uri.parse(endpointUrl), body: jsonEncode({'tasks': tasks}));
    return response.statusCode == 200;
  }

  Future<List<dynamic>?> fetchTasks() async {
    final response = await http.get(Uri.parse(endpointUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['tasks'];
    }
    return null;
  }
}