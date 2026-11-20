import 'package:bett_box/common/string.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('同一 base64 图标重复解码返回同一字节实例', () {
    const src = 'data:image/png;base64,iVBORw0KGgo=';
    final bytes = src.getBase64;
    expect(bytes, [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);
    expect(identical(src.getBase64, bytes), isTrue);
  });

  test('非 base64 或内容无效时返回空', () {
    expect('https://example.com/icon.png'.getBase64, isNull);
    expect('data:image/png;base64,'.getBase64, isNull);
    expect('data:image/png;base64,@@@'.getBase64, isNull);
  });

  group('isProfileFileName', () {
    test('接受 yaml / yml 扩展名', () {
      expect('config.yaml'.isProfileFileName, isTrue);
      expect('config.yml'.isProfileFileName, isTrue);
      expect('我的 配置.yml'.isProfileFileName, isTrue);
    });

    test('扩展名大小写不敏感', () {
      expect('CONFIG.YAML'.isProfileFileName, isTrue);
      expect('Config.Yml'.isProfileFileName, isTrue);
    });

    test('拒绝其他扩展名与伪装文件名', () {
      expect('config.json'.isProfileFileName, isFalse);
      expect('config.yaml.txt'.isProfileFileName, isFalse);
      expect('yaml'.isProfileFileName, isFalse);
      expect(''.isProfileFileName, isFalse);
    });
  });
}
