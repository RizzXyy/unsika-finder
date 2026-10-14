import 'package:flutter/material.dart';

// ===== Model =====
class RiwayatItem {
  final String nama;
  final String jenis; // 'Hilang' atau 'Temuan'
  final String tanggal;
  final String status; // 'Siap Diambil', 'Selesai', 'Ditemukan'
  final String? gambar; // path asset, boleh null

  const RiwayatItem({
    required this.nama,
    required this.jenis,
    required this.tanggal,
    required this.status,
    this.gambar,
  });
}

// ===== Data (nama file sesuai folder assets/images) =====
const List<RiwayatItem> daftarRiwayat = [
  RiwayatItem(
    nama: 'Kunci Motor',
    jenis: 'Temuan',
    tanggal: '12 Oktober 2026',
    status: 'Siap Diambil',
    gambar: 'assets/images/kuncimotor.jpg',
  ),
  RiwayatItem(
    nama: 'Charger Laptop',
    jenis: 'Hilang',
    tanggal: '12 Oktober 2026',
    status: 'Selesai',
    gambar: 'assets/images/chargerlaptop.png',
  ),
  RiwayatItem(
    nama: 'Earphone',
    jenis: 'Temuan',
    tanggal: '11 Oktober 2026',
    status: 'Ditemukan',
    gambar: 'assets/images/earphone.jpg',
  ),
  RiwayatItem(
    nama: 'Stand Holder',
    jenis: 'Hilang',
    tanggal: '09 Oktober 2026',
    status: 'Ditemukan',
    gambar: 'assets/images/standholder.jpg',
  ),
  RiwayatItem(
    nama: 'Handphone',
    jenis: 'Temuan',
    tanggal: '08 Oktober 2026',
    status: 'Selesai',
    gambar: 'assets/images/handphone.png',
  ),
  RiwayatItem(
    nama: 'Kipas Tangan',
    jenis: 'Temuan',
    tanggal: '05 Oktober 2026',
    status: 'Siap Diambil',
    gambar: 'assets/images/kipastangan.jpg',
  ),
  RiwayatItem(
    nama: 'Tumbler',
    jenis: 'Hilang',
    tanggal: '02 Oktober 2026',
    status: 'Ditemukan',
    gambar: 'assets/images/tumbler.jpg',
  ),
];

// ===== Screen =====
class HistoryScreen extends StatefulWidget {
  final VoidCallback onBack;
  const HistoryScreen({super.key, required this.onBack});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static const Color maroon = Color(0xFF7A0C2E);
  String _filter = 'Semua';

  List<RiwayatItem> get _hasil => _filter == 'Semua'
      ? daftarRiwayat
      : daftarRiwayat.where((e) => e.jenis == _filter).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Riwayat Laporan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _hasil.length,
              itemBuilder: (context, i) => RiwayatCard(item: _hasil[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    const tabs = ['Semua', 'Hilang', 'Temuan'];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: tabs.map((t) {
          final aktif = _filter == t;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _filter = t),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: aktif ? maroon : Colors.transparent,
                  borderRadius: BorderRadius.circular(26),
                ),
                alignment: Alignment.center,
                child: Text(
                  t,
                  style: TextStyle(
                    color: aktif ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ===== Card =====
class RiwayatCard extends StatelessWidget {
  final RiwayatItem item;
  const RiwayatCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isHilang = item.jenis == 'Hilang';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black87, width: 1),
      ),
      child: Row(
        children: [
          _Gambar(path: item.gambar),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.nama,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    _StatusChip(status: item.status),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      item.jenis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: isHilang
                            ? const Color(0xFF7A0C2E)
                            : const Color(0xFF0F5132),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.tanggal,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Gambar barang (ganti placeholder abu-abu) =====
class _Gambar extends StatelessWidget {
  final String? path;
  const _Gambar({this.path});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: 64,
      height: 64,
      color: Colors.grey.shade300,
      child: const Icon(Icons.image_outlined, color: Colors.grey),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: path == null
          ? placeholder
          : Image.asset(
        path!,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => placeholder,
      ),
    );
  }
}

// ===== Chip status =====
class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    switch (status) {
      case 'Siap Diambil':
        bg = const Color(0xFFDDE3FA);
        fg = const Color(0xFF2B3A8C);
        break;
      case 'Ditemukan':
        bg = const Color(0xFFD9F2E3);
        fg = const Color(0xFF0F5132);
        break;
      default: // Selesai
        bg = const Color(0xFFE3E3E3);
        fg = Colors.black87;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w500),
      ),
    );
  }
}