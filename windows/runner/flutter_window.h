#ifndef RUNNER_FLUTTER_WINDOW_H_
#define RUNNER_FLUTTER_WINDOW_H_

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>

#include <memory>

#include "win32_window.h"

class FlutterWindow : public Win32Window {
 public:
  explicit FlutterWindow(const flutter::DartProject& project);
  virtual ~FlutterWindow();

 protected:
  bool OnCreate() override;
  void OnDestroy() override;
  LRESULT MessageHandler(HWND window, UINT const message, WPARAM const wparam,
                         LPARAM const lparam) noexcept override;

 private:
  // Windows clipboard history (Win+V) delivers its selection as WM_PASTE to the
  // focused window. The Flutter engine has no handler for that message, so it
  // is intercepted on the view's HWND and forwarded to Dart.
  static LRESULT CALLBACK ViewWindowProc(HWND window, UINT message,
                                         WPARAM wparam,
                                         LPARAM lparam) noexcept;
  void SubclassViewWindow();
  void RestoreViewWindow();
  void NotifyPaste();

  // OLE drag-and-drop (used by the `file_drop` plugin) is blocked by UIPI when
  // this process runs elevated, because Explorer lives at a lower integrity
  // level. The legacy WM_DROPFILES mechanism still works in that case once the
  // window message filter is widened, so both are kept: OLE drives the hover
  // overlay, WM_DROPFILES is the fallback that actually delivers elevated drops.
  void EnableLegacyFileDrop();
  void HandleDropFiles(WPARAM wparam);

  flutter::DartProject project_;
  std::unique_ptr<flutter::FlutterViewController> flutter_controller_;
  std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>>
      clipboard_channel_;
  std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>>
      file_drop_channel_;
  HWND view_window_ = nullptr;
  WNDPROC original_view_proc_ = nullptr;
};

#endif  // RUNNER_FLUTTER_WINDOW_H_
