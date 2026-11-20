import 'dart:convert';

import 'package:bett_box/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('userAgent 字段可序列化与反序列化', () {
    const customUa = 'CattboxTest/1.0';
    final profile = Profile.normal(
      url: 'https://example.com/sub',
    ).copyWith(userAgent: customUa);

    final json =
        jsonDecode(jsonEncode(profile.toJson())) as Map<String, dynamic>;
    expect(json['userAgent'], customUa);
    expect(Profile.fromJson(json).userAgent, customUa);
  });

  test('旧配置缺少 userAgent 时为 null', () {
    final json =
        jsonDecode(jsonEncode(Profile.normal().toJson()))
              as Map<String, dynamic>
          ..remove('userAgent');

    expect(Profile.fromJson(json).userAgent, isNull);
  });
}
