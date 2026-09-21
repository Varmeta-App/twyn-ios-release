# Twyn ships as six pods, not one pod with six subspecs.
#
# That is forced, not stylistic: CocoaPods subspecs do not produce separate modules. Every
# subspec of a pod compiles into that pod's single module, so `Twyn/Common` would be
# `import Twyn`, not `import TwynCommon` -- and every generated file in this package, plus
# every call site in a host app, imports the module by name. Six pods keep those names and
# map one-to-one onto the six Maven artifacts the Android SDK publishes.
#
# The version is written out here rather than read from the VERSION file. A podspec has to
# stand alone: once it is pushed to a spec repo, the file is stored by itself and nothing
# beside it exists to read. scripts/check-version-consistency.sh asserts every podspec
# matches VERSION, which turns a repeated literal into a checked one -- the same arrangement
# the Android modules use, where each of the six build files states the version too.

Pod::Spec.new do |s|
  s.name             = 'Twyn'
  s.version          = '1.0.0'
  s.summary          = 'Twyn analytics core: the wire vocabulary, the naming rule and the runtime.'
  s.description      = <<-DESC
The core of the Twyn analytics SDK: the event pipeline, the consent gate, the
session stamper and the generated wire vocabulary shared with the Android SDK.

Declares no third-party dependencies at all. Take this pod alone if you want to
deliver events yourself by implementing TwynFirebaseAdapting.
  DESC
  s.homepage         = 'https://github.com/Varmeta-App/twyn-ios-sdk'
  s.license          = { :type => 'Proprietary', :text => 'Copyright (c) VarMeta. All rights reserved.' }
  s.author           = { 'VarMeta' => 'mobile@varmeta.com' }
  s.source           = { :git => 'git@github.com:Varmeta-App/twyn-ios-release.git', :tag => s.version.to_s }

  # Matches Package.swift. The floor comes from the analytics dependency's own manifest.
  s.ios.deployment_target = '15.0'

  # The package builds in Swift 6 language mode, which is what `.swiftLanguageMode(.v6)`
  # states in Package.swift. Anything less would compile this source under rules it was
  # not written for and let data races back in.
  s.swift_versions   = ['6.0']


  # ── Binary distribution ─────────────────────────────────────────────────────
  # Ships as prebuilt XCFrameworks, matching how the Android SDK ships an AAR rather than
  # sources. `s.source` is the release repository, which holds nothing but build output --
  # the source of truth stays in twyn-ios-sdk and the binaries are produced from it by
  # scripts/build-xcframeworks.sh.
  #
  # Every framework is static and carries a `.swiftinterface`, so a host app does not have to
  # match the compiler that built it. `static_framework` tells CocoaPods that, which it needs
  # in order to link dependents correctly.
  s.static_framework = true
  s.vendored_frameworks = 'Twyn/Twyn.xcframework', 'Twyn/TwynSDK.xcframework'

  # The privacy manifest travels inside TwynSDK.xcframework, where Xcode picks it up from the
  # framework root -- an SDK cannot lean on its host app's manifest to describe its own use of
  # required-reason APIs.
end
