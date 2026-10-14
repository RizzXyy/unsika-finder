import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/lost_item.dart';
import '../widgets/page_header.dart';

class DetailScreen extends StatefulWidget {
  final LostItem item;
  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _page = 0;

  LostItem get item => widget.item;

  // Foto bawaan (assets) berdasarkan nama barang, dipakai kalau item.images kosong.
  static const Map<String, String> _assetByName = {
    'dompet': 'assets/images/dompet.jpeg',
    'ktm': 'assets/images/ktm.jpg',
    'tas': 'assets/images/tas.jpg',
    'tumbler': 'assets/images/tumbler.jpg',
    'kuncimotor': 'assets/images/kuncimotor.jpg',
    'chargerlaptop': 'assets/images/chargerlaptop.png',
    'earphone': 'assets/images/earphone.jpg',
    'handphone': 'assets/images/handphone.png',
    'standholder': 'assets/images/standholder.jpg',
    'kipastangan': 'assets/images/kipastangan.jpg',
  };

  List<String> get _sources {
    if (item.images.isNotEmpty) return item.images;
    final key = item.name.toLowerCase().replaceAll(' ', '');
    for (final e in _assetByName.entries) {
      if (key.contains(e.key)) return [e.value];
    }
    return [];
  }

  int get _pageCount => _sources.isEmpty ? 1 : _sources.length;

  @override
  Widget build(BuildContext context) {
    final badgeBg =
    item.found ? const Color(0xFFD9F0E4) : const Color(0xFFFFD9D9);
    final badgeFg =
    item.found ? const Color(0xFF1B5E3A) : const Color(0xFFE53935);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(
                title: 'Detail Barang',
                onBack: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
              _photoCarousel(),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(item.name,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w800)),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    child: Text(item.statusLabel,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: badgeFg)),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _infoRow(Icons.sell_outlined, 'Kategori', item.category),
              _infoRow(Icons.location_on_outlined, 'Lokasi', item.location),
              _infoRow(Icons.calendar_month_outlined, 'Tanggal', item.date),
              _infoRow(
                  Icons.description_outlined, 'Deskripsi', item.description),
              const SizedBox(height: 14),
              _contactCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _photoCarousel() {
    final sources = _sources;
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: _pageCount,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (_, i) {
                if (sources.isEmpty) return _placeholder();
                final src = sources[i];
                if (src.startsWith('assets/')) {
                  return Image.asset(
                    src,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, _, _) => _placeholder(),
                  );
                }
                return Image.network(
                  src,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, _, _) => _placeholder(),
                );
              },
            ),
            if (_pageCount > 1)
              Positioned(
                right: 14,
                bottom: 10,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0x66000000),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('${_page + 1}/$_pageCount',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() => Container(
    color: Colors.grey.shade300,
    child: const Center(
      child: Icon(Icons.image_outlined, size: 52, color: Colors.grey),
    ),
  );

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 26, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(fontSize: 12, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.found ? 'Kontak Penemu' : 'Kontak Pelapor',
              style:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFD9F0E4),
                child: Icon(Icons.person, color: Color(0xFF1B5E3A), size: 30),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.contactName,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w800)),
                  Text(item.contactPhone,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton.icon(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Buka WhatsApp: ${item.contactPhone}')),
              ),
              icon: const Icon(Icons.chat, size: 16),
              label: const Text('Chat WhatsApp',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059F6E),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}