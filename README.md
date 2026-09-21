# twyn-ios-release

Two jobs, deliberately never in the same commit.

- **`main`** — the private CocoaPods spec repo. Written by `pod repo push`; this is what CocoaPods
  reads to resolve a pod name.
- **tag `<version>`** — the XCFrameworks, on an orphan commit. This is what `s.source` fetches
  during `pod install`.

Everything is produced by `scripts/release.sh` in
[twyn-ios-sdk](https://github.com/Varmeta-App/twyn-ios-sdk). **Nothing here is edited by hand.**

## Using it

```ruby
source 'git@github.com:Varmeta-App/twyn-ios-release.git'
source 'https://cdn.cocoapods.org/'

pod 'Twyn'           # core + facade
pod 'TwynFirebase'   # only if Twyn should deliver to Firebase
pod 'TwynCommon'     # the shared typed vocabulary
pod 'TwynGame'       # or TwynShopping / TwynContent
```

Then `import Twyn` and call `Twyn.track(...)` — the same call site as on Android.
