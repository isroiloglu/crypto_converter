import 'dart:convert';

import 'package:crypto_converter/models/coin_model.dart';
import 'package:crypto_converter/repositories/base_crypto_repository.dart';
import 'package:http/http.dart' as http;

class CryptoRepository extends BaseCryptoRepository {
  static const String _baseURL = 'http://newsapi.org';
  static const int perPage = 20;

  final http.Client _httpClient;

  CryptoRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<List<Coin>> getTopCoins({int page}) async {
    List<Coin> coins = [];
    String requestURL =
        '$_baseURL/v2/top-headlines?sources=techcrunch&apiKey=cd99d2feee2b43d18c49f2da40bc3b29';
    try {
      final response = await _httpClient.get(requestURL);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> coinList = data['Data'];
        coinList.forEach(
          (json) => coins.add(Coin.fromJson(json)),
        );
      }
      return coins;
    } catch (err) {
      throw (err);
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
