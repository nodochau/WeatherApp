import 'package:http/http.dart' as http;

class NetworkHelper {
  // ignore: prefer_typing_uninitialized_variables
  final url;
  int resCode = 0;

  NetworkHelper(this.url);

  Future<String> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Failed to get data from internet. Check your network';
    }
  }
}
