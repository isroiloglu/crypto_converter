import 'package:crypto_converter/models/coin_model.dart';

abstract class BaseCryptoRepository {
  Future<List<Coin>> getTopCoins({int page});

  void dispose();
}
