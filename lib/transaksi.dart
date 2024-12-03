import 'keranjang.dart';

class Transaksi {
  DateTime tanggal;
  Keranjang keranjang;
  double total;

  Transaksi(this.keranjang)
      : tanggal = DateTime.now(),
        total = keranjang.hitungTotal();
}
