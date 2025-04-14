import 'package:intl/intl.dart';

String formatRibuan(int nilai) {
  return NumberFormat("#,###", "id_ID").format(nilai);
}

int makanan = 100000;
int transportasi = 50000;
int lainnya = 20000;
int get saldo => makanan + transportasi + lainnya;

// charts method
double makananValue = makanan / saldo * 100;
double transportasiValue = transportasi / saldo * 100;
double lainnyaValue = lainnya / saldo * 100;

double mValue = double.parse(makananValue.toStringAsFixed(2));
double tValue = double.parse(transportasiValue.toStringAsFixed(2));
double lValue = double.parse(lainnyaValue.toStringAsFixed(2));

