import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> fetchHealthData() async {
    final url = '$baseUrl/healthdata';
    return await http.get(Uri.parse(url));
  }

  // Add other API methods here
}
