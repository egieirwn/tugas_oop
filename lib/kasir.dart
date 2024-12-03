import 'transaksi.dart';

class Kasir {
  String nama;
  List<Transaksi> daftarTransaksi = [];

  Kasir(this.nama);

  void tambahTransaksi(Transaksi transaksi) {
    daftarTransaksi.add(transaksi);
  }

  void cetakLaporan() {
    print("Laporan Penjualan oleh $nama:");
    for (var transaksi in daftarTransaksi) {
      print("Tanggal: ${transaksi.tanggal},\nTotal: ${transaksi.total.toStringAsFixed(2)}");
    }
  }
}
