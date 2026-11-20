import 'dart:io';

import 'package:bett_box/common/common.dart';
import 'package:bett_box/state.dart';
import 'package:file_drop/file_drop.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

/// Accepts profile files dragged from the OS onto the app window.
///
/// Dragging `.yaml` / `.yml` files over the window shows a hint overlay, and
/// dropping them imports each file exactly like "Add profile -> File".
class DropProfileArea extends StatefulWidget {
  final Widget child;

  const DropProfileArea({super.key, required this.child});

  @override
  State<DropProfileArea> createState() => _DropProfileAreaState();
}

class _DropProfileAreaState extends State<DropProfileArea> {
  /// Native fallback channel, only used when the app runs elevated.
  ///
  /// OLE drag-and-drop is blocked by UIPI across integrity levels, so Explorer
  /// cannot reach the `DropTarget` above. The runner then accepts the legacy
  /// `WM_DROPFILES` message and forwards the paths here.
  static const _nativeChannel = MethodChannel('file_drop_ext');

  bool _dragging = false;
  DateTime? _lastDropAt;

  /// The OLE path and the native `WM_DROPFILES` fallback can both report the
  /// same drop, so only the first report within a short window is honoured.
  bool _acceptDropOnce() {
    final now = DateTime.now();
    final last = _lastDropAt;
    if (last != null &&
        now.difference(last) < const Duration(milliseconds: 1200)) {
      return false;
    }
    _lastDropAt = now;
    return true;
  }

  @override
  void initState() {
    super.initState();
    if (system.isDesktop) {
      _nativeChannel.setMethodCallHandler(_handleNativeDrop);
    }
  }

  @override
  void dispose() {
    if (system.isDesktop) {
      _nativeChannel.setMethodCallHandler(null);
    }
    super.dispose();
  }

  Future<void> _handleNativeDrop(MethodCall call) async {
    if (call.method != 'onFilesDropped') return;
    final arguments = call.arguments;
    final paths = arguments is List
        ? arguments.whereType<String>().toList()
        : const <String>[];
    if (paths.isEmpty || !_acceptDropOnce()) return;
    _setDragging(false);
    await _importPaths(paths);
  }

  Future<void> _importPaths(List<String> paths) async {
    final files = <({String name, Future<Uint8List> Function() readBytes})>[];
    for (final path in paths) {
      final name = path.split(RegExp(r'[\\/]')).last;
      if (!name.isProfileFileName) continue;
      files.add((name: name, readBytes: () => File(path).readAsBytes()));
    }
    if (files.isEmpty) {
      globalState.showNotifier(appLocalizations.dropProfileUnsupported);
      return;
    }
    await globalState.appController.importProfileFiles(files);
  }

  void _setDragging(bool value) {
    if (!mounted || _dragging == value) return;
    setState(() => _dragging = value);
  }

  Future<void> _handleDrop(DropDetails details) async {
    _setDragging(false);
    if (!_acceptDropOnce()) return;

    final files = details.items
        .where((item) => !item.isDirectory && item.name.isProfileFileName)
        .toList();

    if (files.isEmpty) {
      globalState.showNotifier(appLocalizations.dropProfileUnsupported);
      return;
    }

    await globalState.appController.importProfileFiles([
      for (final file in files) (name: file.name, readBytes: file.readAsBytes),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // Touch platforms have no OS-level file drag, so keep them untouched.
    if (!system.isDesktop) {
      return widget.child;
    }
    return DropTarget(
      acceptedKinds: const {DropItemKind.file},
      onDragEntered: (_) => _setDragging(true),
      onDragExited: (_) => _setDragging(false),
      onDrop: _handleDrop,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          widget.child,
          if (_dragging)
            const Positioned.fill(child: IgnorePointer(child: _DropOverlay())),
        ],
      ),
    );
  }
}

class _DropOverlay extends StatelessWidget {
  const _DropOverlay();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isLight = colorScheme.brightness == Brightness.light;
    final primary = colorScheme.primary;
    return ColoredBox(
      color: isLight
          ? colorScheme.surface.withValues(alpha: 0.82)
          : colorScheme.surface.withValues(alpha: 0.88),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primary, width: 2),
            boxShadow: [
              BoxShadow(
                color: primary.withValues(alpha: 0.18),
                blurRadius: 32,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.file_download_outlined, size: 48, color: primary),
              const SizedBox(height: 16),
              Text(
                appLocalizations.dropProfileTitle,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                appLocalizations.dropProfileHint,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
