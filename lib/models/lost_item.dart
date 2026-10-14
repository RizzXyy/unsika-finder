/// Data satu laporan barang (hilang / ditemukan)
class LostItem {
  final String name;
  final String category; // Elektronik / Dokumen / Tas / Kunci
  final String date;
  final String location;
  final String description;
  final bool found; // true = Ditemukan, false = Hilang
  final String contactName;
  final String contactPhone;
  final List<String> images; // URL foto (boleh kosong)

  const LostItem({
    required this.name,
    required this.category,
    required this.date,
    required this.location,
    required this.description,
    required this.found,
    required this.contactName,
    required this.contactPhone,
    this.images = const [],
  });

  String get statusLabel => found ? 'Ditemukan' : 'Hilang';
}