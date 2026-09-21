# twyn-ios-release

Build output. **Do not edit anything here by hand** — every file is produced by
`scripts/release.sh` in [twyn-ios-sdk](https://github.com/Varmeta-App/twyn-ios-sdk), and the next
release overwrites it.

The source lives in that repository. This one exists so host apps can take prebuilt XCFrameworks
without read access to the source, the same way the Android SDK ships an AAR rather than sources.

## Using it

```ruby
source 'git@github.com:Varmeta-App/twyn-ios-release.git'
source 'https://cdn.cocoapods.org/'

pod 'Twyn'           # core + facade
pod 'TwynFirebase'   # only if Twyn should deliver to Firebase
pod 'TwynCommon'     # the shared typed vocabulary
pod 'TwynGame'       # or TwynShopping / TwynContent
```

`import Twyn`, then call `Twyn.track(...)` — identical to the Android call site.

## Layout

Each pod has a directory holding the XCFrameworks it vendors. `Twyn` holds two: `Twyn`, the
one-line re-export shim a caller imports, and `TwynSDK`, the core it re-exports. A module may not
contain a public type with its own name and still produce a usable `.swiftinterface`, which is why
the core is not itself called `Twyn`.

| Release | Source commit |
|---|---|
| 1.0.0 | `1e0631dc4ffbd988b67ead19a1a019f90b57eb4a` |
