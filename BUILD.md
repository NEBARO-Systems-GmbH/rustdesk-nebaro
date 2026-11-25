# Building the client

The client is built like upstream RustDesk (Flutter version). Toolchain versions follow
`.github/workflows/flutter-build.yml` of the pinned RustDesk tag.

| Tool | Version |
|---|---|
| Rust | 1.75 (Windows, bridge), 1.81 (macOS) |
| Flutter | 3.24.5 (Windows x64, macOS x86_64), 3.44.9 (macOS arm64) |
| Flutter for bridge generation | 3.22.3 / 3.44.8 |
| LLVM | 15.0.6 |
| vcpkg | commit as in the upstream workflow |

## Steps

```bash
git clone --recurse-submodules https://github.com/rustdesk/rustdesk.git
cd rustdesk
git checkout "$(cat ../RUSTDESK_COMMIT)"
git submodule update --init --recursive
../apply-patches.sh .

export NEBARO_RENDEZVOUS_SERVER=<server host>
export NEBARO_RS_PUB_KEY=<server public key>
```

Then follow the upstream build for the target platform:

- **Windows (x86_64):** `python3 build.py --portable --flutter`, producing the portable executable.
- **macOS (arm64, x86_64):** `python3 build.py --flutter`, then package the app as a disk image.

Not built compared to upstream: Windows arm64, Sciter UI, MSI installer, printer driver, virtual
display, privacy mode helper, file copy and paste over the clipboard.

The released binaries are signed by NEBARO Systems GmbH (Windows: Azure Artifact Signing, macOS:
Developer ID, notarised).
