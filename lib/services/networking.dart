import 'package:http/http.dart' as http;
import 'dart:convert';

// We could always use this class in the future if we want networking functionality.
class Networking {
  final Uri url;
  Networking(this.url);

  Future getData() async {
    //in json format. it is like a map format.
    http.Response response = await http.get(url);
    // this shows us the status of the url by numbers #200 is good
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
