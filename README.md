# qq

> [!WARNING]
> You probably don't want to be here. Read on for more details.

This repository contains my extremely experimental, not-production-ready,
outright dangerous work that is all based around
[Jujutsu](https://github.com/martinvonz/jj).

The code here is different than the code I contribute directly to upstream;
**the work here is too experimental for now.** Perhaps one day this repository
might be obsolete and most of my work will all be in Jujutsu itself. But for now
having a separate repository is the best way to iterate quickly without
disturbing everyone and while researching, and in practice I'll always want a
laboratory to cook things up.

In short, you probably don't want to bother with this stuff unless you're
direcly working with me on it, so you know what you're up against.

This project uses [Buck2](https://buck2.build) for the build system and has
significant infrastructure to drive it. One goal &mdash; among others &mdash; is
to explore build system <-> filesystem <-> version control integration, and this
requires a system like Buck to achieve (so using it is a good way to figure that
out.)

If you have questions or want to help out, you can contact me, `@aseipp`, on the
[Jujutsu Discord](https://discord.gg/dkmfj3aGQN).

## TODO

Broadly unorganized and in no particular order.

### General

TBD.

### Upstream Jujutsu

TBD.

### Buck2

- Toolchains
  - [ ] Hermetic toolchain
    - [ ] Rust
    - [ ] Clang (all platforms)
    - Windows
      - [ ] Is hermetic MSVC possible?
- DevEx improvements
  - Turnkey Codespaces for instant-hacking
    - [ ] Pre-warmed/Pre-built devcontainer
      - Current boot time is ~several minutes on a cold start
    - [ ] Tested on macOS, Windows, Linux
    - [x] ~~devcontainer that can be launched from GitHub UI~~
    - [x] ~~`dotslash`, `rust-analyzer`, `buck2`, `rust-project` preinstalled~~
    - [x] ~~Working `buck2 build`/`rust-analyzer` support on first click~~
      - Fixed by [facebook/buck2@da5ede70e160dbc2c2ec948a16b57f9ac9ba165f](https://github.com/facebook/buck2/commit/da5ede70e160dbc2c2ec948a16b57f9ac9ba165f)
  - [x] Target Determination
    - `supertd` is available (from **[buck2-change-detector](https://github.com/facebookincubator/buck2-change-detector/tree/main/btd)**)
  - Dependency monitoring + security updates
    - [ ] Dependabot integration with our third-party `Cargo.toml`?
      - How would we run `reindeer buckify`?
    - [x] ~~**[osv.dev](https://osv.dev)** integration?~~
      - [x] ~~RUSTSEC support based on `Cargo.lock`~~
      - [x] ~~Generic 3rd party support (BoringSSL, zstd, etc)~~
        - Still needs testing: `mimalloc`, `capnproto`, `zlib`
      - Open issues:
        - [x] ~~Querying Git Repos <https://github.com/google/osv.dev/issues/2576>~~
- Platform support
  - macOS
    - [ ] x86_64 macOS support
      - Requires x86_64 binaries for `smoltar`; needs `macos-13` runners
  - Windows
    - [ ] `aarch64-windows` support
      - Should come in Q4 2024 when GHA runners are available?
    - [ ] [windows_shim for DotSlash](https://dotslash-cli.com/docs/windows/),
          improving Windows ergonomics
      - Requires committing `.exe` files, so size is absolutely critical
      - Does not exist upstream; TBA

Upstream bugs and PRs:

- Offline build support &mdash; **unclear how to proceed**
  - [ ] Import 3rd party library source code into the repository?
  - [x] ~~Reindeer support for `.crate` files: <https://github.com/facebookincubator/reindeer/pull/46>~~
- Log & build reporting
  - [ ] `buck log --trace-id ...` OSS support: <https://github.com/facebook/buck2/pull/770>
    - **Patched** in https://github.com/thoughtpolice/buck2 fork used by this repo.
    - Can replay any GHA build (within ~24hrs) with a known Build ID
    - <https://github.com/facebook/buck2/pull/702>
  - [ ] Bazel Event Stream support: <https://github.com/facebook/buck2/pull/811>
    - See also: <https://github.com/facebook/buck2/pull/685>
    - Will allow us to abstract away underlying CI to some extent
- RE/AC support:
  - [ ] `rust_library` caching for `local_only=True` (TBA)
  - [ ] Missing support for local execution `ActionCache` support
    - **Patched** in https://github.com/thoughtpolice/buck2 fork used by this repo.
    - <https://github.com/facebook/buck2/pull/765>
    - <https://github.com/facebook/buck2/pull/771>
  - [ ] Wrong hashing algorithm used for upload permission checks <https://github.com/facebook/buck2/pull/784>
    - **Patched** in https://github.com/thoughtpolice/buck2 fork used by this repo.
  - [ ] Block on concurrent blob uploads <https://github.com/facebook/buck2/pull/750>
    - **Patched** in https://github.com/thoughtpolice/buck2 fork used by this repo.
  - [x] ~~File size logic bugs <https://github.com/facebook/buck2/pull/639>~~
  - [x] ~~Buggy concurrency limiter: <https://github.com/facebook/buck2/pull/642>~~
  - [x] ~~Failure diagonstics <https://github.com/facebook/buck2/pull/656>~~
- `rust-analyzer` + `rust-project`
  - [ ] rust-project: add support for specifying `buck2` exe <https://github.com/facebook/buck2/pull/774>
  - [x] ~~`linked_projects` support: <https://github.com/rust-lang/rust-analyzer/pull/17246>~~
  - [x] ~~Unbreak OSS use of `rust-project`: <https://github.com/facebook/buck2/pull/659>~~
  - [x] ~~`--sysroot-mode` support for `rust-project`: <https://github.com/facebook/buck2/pull/745>~~
  - [x] ~~`rust-project check` is broken: <https://github.com/facebook/buck2/pull/754>~~
  - [x] ~~Invalid dep graph due to lack of `sysroot_src`~~
  - [x] ~~Prebuilt `rust-project` binaries + dotslash: <https://github.com/facebook/buck2/pull/766>~~
- UX improvements
  - [ ] `buck2 test` should build targets too <https://github.com/facebook/buck2/pull/702>
  - [x] ~~Aggressively annoying download warnings <https://github.com/facebook/buck2/issues/316>~~
    - **Patched** in https://github.com/thoughtpolice/buck2 fork used by this repo.
  - [x] ~~Improve `ValidationInfo` failure messages <https://github.com/facebook/buck2/pull/769>~~
  - [x] ~~Add subtarget information to test name <https://github.com/facebook/buck2/pull/743>~~
- Platform support
  - [x] ~~`buck2` aarch64-linux binaries don't with 16k page size <https://github.com/facebook/buck2/pull/693>~~

## License

Apache 2.0.
