import 'package:flutter/material.dart';

/// Alamat foto barang di folder assets: itemPhoto('dompet') -> assets/images/items/dompet.png
String itemPhoto(String fileName) => 'assets/images/items/$fileName.png';

/// Menampilkan foto barang. Bisa dari asset (assets/...) atau internet (http...).
/// Kalau foto kosong / gagal dimuat, tampil kotak abu-abu dengan ikon.
class ItemImage extends StatelessWidget {
  final String? path;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ItemImage({
    super.key,
    this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  Widget _placeholder() => Container(
    width: width,
    height: height,
    color: Colors.grey.shade300,
    child: const Center(
      child: Icon(Icons.image_outlined, color: Colors.grey),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final p = path;
    if (p == null || p.isEmpty) return _placeholder();

    if (p.startsWith('http')) {
      return Image.network(p,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, _, _) => _placeholder());
    }
    return Image.asset(p,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _placeholder());
  }
}