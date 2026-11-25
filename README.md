# NEBARO Remote Support Client

Source code of the remote support client used by NEBARO Systems GmbH. The client is a modified
build of [RustDesk](https://github.com/rustdesk/rustdesk), licensed under the
[GNU AGPL-3.0](LICENCE). This repository provides the corresponding source as required by the licence:
the exact RustDesk version, our patches and the build instructions.

## Contents

| Path | Purpose |
|---|---|
| `RUSTDESK_VERSION`, `RUSTDESK_COMMIT` | upstream tag and commit the patches apply to |
| `VERSION` | version of the NEBARO client |
| `patches/` | changes against RustDesk (main repository and submodule `libs/hbb_common`) |
| `apply-patches.sh` | applies the patches to a checkout of the pinned commit |
| `BUILD.md` | build instructions and toolchain versions |
| `LICENCE` | GNU AGPL-3.0 |

Every released client has a tag `v<VERSION>` with the patches attached to the release.

## What the patches change

- **Fixed server:** rendezvous server and public key are compiled in and cannot be changed by the
  user. There is no fallback to public RustDesk servers.
- **Configuration compiled in:** settings are set at start-up; no `custom.txt` and no configuration
  from the file name is read.
- **Incoming only:** the client can be controlled, it cannot control other computers.
- **Restricted session:** no file transfer, no terminal, camera, audio, printer, tunnel, recording
  or remote restart. Clipboard without files.
- **Acceptance:** no permanent password. A session is accepted by a click on the device or with
  the one-time password shown in the window.
- **Server only:** no direct or LAN connections, no hole punching, no WebRTC.
- **Encrypted only:** RustDesk continues without encryption when the peer's key is not signed by
  the server key. The patched client breaks off instead, on both sides, and shows the reason in the
  window of the connecting side. No session runs unencrypted.
- **No installation, no autostart:** connections are only possible while the window is open.
- **No contact with rustdesk.com:** update check and device registration are disabled.
- **Branding:** application name "NEBARO Fernwartung", bundle ID `at.nebaro.remote`. RustDesk's
  copyright notices are retained.

Every change is marked with a `NEBARO:` comment in the patched source.
