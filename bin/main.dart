import 'dart:io';
import '../lib/kasir.dart';
import '../lib/keranjang.dart';
import '../lib/produk.dart';
import '../lib/transaksi.dart';

void main() {
  var produk1 = Produk("Buku", 20000, 50);
  var produk2 = Produk("Pensil", 5000, 100);
  var produk3 = Produk("Kertas", 10000, 20);
  var produk4 = Produk("Pulpen", 5000, 100);

  var daftarProduk = [produk1, produk2, produk3, produk4];

  // keranjang dan kasir
  var keranjang = Keranjang();
  var kasir = Kasir("Kasir Default");
  bool running = true;

  print("Selamat datang di TOKO JAYA ABADI!");

  while (running) {
    try {
      print("\nPilih menu:");
      print("1. Lihat Produk");
      print("2. Tambah Produk ke Keranjang");
      print("3. Hapus Produk dari Keranjang");
      print("4. Lihat Keranjang");
      print("5. Cek Struk");
      print("6. Laporan Penjualan");
      print("7. Keluar");
      stdout.write("Masukkan pilihan: ");

      var pilihanInput = stdin.readLineSync()?.trim();
      if (pilihanInput == null || pilihanInput.isEmpty) {
        print("Masukan tidak boleh kosong.");
        continue;
      }

      var pilihan = int.tryParse(pilihanInput);
      if (pilihan == null || pilihan < 1 || pilihan > 7) {
        print("Pilihan tidak valid. Masukkan angka antara 1 dan 7.");
        continue;
      }

      switch (pilihan) {
        case 1: // Lihat Produk
          print("\nDaftar Produk:");
          for (var i = 0; i < daftarProduk.length; i++) {
            print(
                "${i + 1}. ${daftarProduk[i].nama} - Rp${daftarProduk[i].harga} (Stok: ${daftarProduk[i].stok})");
          }
          break;

        case 2: // Tambah Produk
          print("\nDaftar Produk:");
          for (var i = 0; i < daftarProduk.length; i++) {
            print(
                "${i + 1}. ${daftarProduk[i].nama} - Rp${daftarProduk[i].harga} (Stok: ${daftarProduk[i].stok})");
          }

          stdout.write("\nPilih produk untuk ditambahkan ke keranjang (1-${daftarProduk.length}): ");
          var produkIndexInput = stdin.readLineSync()?.trim();
          var produkIndex = int.tryParse(produkIndexInput ?? "");
          if (produkIndex == null || produkIndex < 1 || produkIndex > daftarProduk.length) {
            print("Pilihan produk tidak valid.");
            break;
          }

          var produkDipilih = daftarProduk[produkIndex - 1];
          stdout.write("Masukkan jumlah untuk produk ${produkDipilih.nama}: ");
          var jumlahInput = stdin.readLineSync()?.trim();
          var jumlah = int.tryParse(jumlahInput ?? "");
          if (jumlah == null || jumlah <= 0 || jumlah > produkDipilih.stok) {
            print("Jumlah tidak valid atau stok tidak mencukupi.");
            break;
          }

          keranjang.tambahProduk(produkDipilih, jumlah);
          produkDipilih.kurangiStok(jumlah);
          print("Produk ${produkDipilih.nama} sebanyak $jumlah berhasil ditambahkan ke keranjang.");
          break;

        case 3: // Hapus Produk dari Keranjang
          if (keranjang.items.isEmpty) {
            print("Keranjang kosong.");
          } else {
            print("\nDaftar produk di keranjang:");
            for (var i = 0; i < keranjang.items.length; i++) {
              var produk = keranjang.items[i].keys.first;
              var jumlah = keranjang.items[i][produk]!;
              print("${i + 1}. ${produk.nama} - Jumlah: $jumlah");
            }
            stdout.write("Pilih produk yang ingin dihapus dari keranjang (1-${keranjang.items.length}): ");
            var indexInput = stdin.readLineSync()?.trim();
            var index = int.tryParse(indexInput ?? "");
            if (index == null || index < 1 || index > keranjang.items.length) {
              print("Pilihan tidak valid.");
            } else {
              var produkDihapus = keranjang.items[index - 1].keys.first;
              keranjang.hapusProduk(produkDihapus);
              print("Produk ${produkDihapus.nama} berhasil dihapus dari keranjang.");
            }
          }
          break;

        case 4: // Lihat Keranjang
          print("\nProduk dalam keranjang:");
          if (keranjang.items.isEmpty) {
            print("Keranjang kosong.");
          } else {
            for (var item in keranjang.items) {
              var produk = item.keys.first;
              var jumlah = item[produk]!;
              print("- ${produk.nama} x $jumlah (Rp${produk.harga * jumlah})");
            }
          }
          print("Total Belanja: Rp${keranjang.hitungTotal().toStringAsFixed(2)}");
          break;

        case 5: // Checkout
          if (keranjang.items.isEmpty) {
            print("Keranjang kosong. Tambahkan produk terlebih dahulu.");
          } else {
            stdout.write("Masukkan nama kasir: ");
            var namaKasir = stdin.readLineSync()?.trim() ?? "Kasir";
            kasir.nama = namaKasir;

            var transaksi = Transaksi(keranjang);
            kasir.tambahTransaksi(transaksi);

            print("\nCheckout berhasil!");
            print("Total Belanja: Rp${keranjang.hitungTotal().toStringAsFixed(2)}");
            keranjang = Keranjang(); // Reset keranjang
          }
          break;

        case 6: // Laporan Penjualan
          kasir.cetakLaporan();
          break;

        case 7: // untuk keluar
          running = false;
          print("Terima kasih telah berbelanja di toko kami");
          break;

        default:
          print("Pilihan tidak valid. Silakan coba lagi.");
          break;
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }
}
