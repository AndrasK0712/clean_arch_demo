import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Kiểm thử kiến trúc: quét các dòng import/export để chứng minh Dependency Rule.
///   Presentation -> Domain <- Data
List<String> _violations(String dir, List<RegExp> forbidden) {
  final found = <String>[];
  final files = Directory(dir)
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  for (final file in files) {
    final lines = file.readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      if (!line.startsWith('import ') && !line.startsWith('export ')) continue;
      for (final pattern in forbidden) {
        if (pattern.hasMatch(line)) {
          found.add('${file.path}:${i + 1}  ->  $line');
        }
      }
    }
  }
  return found;
}

void main() {
  const root = 'lib/features/post';

  test('Domain KHÔNG phụ thuộc Data, Presentation, Flutter, Dio', () {
    final v = _violations('$root/domain', [
      RegExp(r'/data/'),
      RegExp(r'/presentation/'),
      RegExp(r'package:flutter/'),
      RegExp(r'package:flutter_bloc/'),
      RegExp(r'package:dio/'),
    ]);
    expect(v, isEmpty, reason: v.join('\n'));
  });

  test('Presentation KHÔNG phụ thuộc trực tiếp Data (DataSource/Repository impl/Dio)', () {
    final v = _violations('$root/presentation', [
      RegExp(r'/data/'),
      RegExp(r'package:dio/'),
    ]);
    expect(v, isEmpty, reason: v.join('\n'));
  });
}
