import 'produk.dart';

class Keranjang {
  List<Map<Produk, int>> items = [];

  void tambahProduk(Produk produk, int jumlah) {
    items.add({produk: jumlah});
  }

  void hapusProduk(Produk produk) {
    items.removeWhere((item) => item.keys.first == produk);
  }

  double hitungTotal() {
    double total = 0.0;
    for (var item in items) {
      var produk = item.keys.first;
      var jumlah = item[produk]!;
      total += produk.harga * jumlah;
    }
    return total;
  }
}
