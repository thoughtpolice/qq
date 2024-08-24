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
    - [x] ~~devcontainer that can be launched from GitHub UI~~
    - [x] ~~`dotslash`, `rust-analyzer`, `buck2`, `rust-project` preinstalled~~
    - [ ] Working `rust-analyzer` support on first click
      - It seems the official `rust` devcontainer feature is broken?
      - It creates an invalid settings file?
      - All builds fail, but it would otherwise work...
    - [ ] Tested on macOS, Windows, Linux
    - [ ] Pre-warmed/Pre-built devcontainer
      - Current boot time is ~several minutes on a cold start
  - Log shuffling
    - [x] ~~Upload GHA build logs to remote server~~
    - [ ] Upstream Buck2 support for downloading logs
  - [ ] Target Determination
    - Could use **[buck2-change-detector](https://github.com/facebookincubator/buck2-change-detector/tree/main/btd)**
    - However it's a bit of a big hammer, with no provided binaries
    - A simpler solution for our own needs would be OK for a long time
  - Dependency monitoring + security updates
    - [ ] Dependabot integration with our third-party `Cargo.toml`?
      - How would we run `reindeer buckify`?
    - [x] **[osv.dev](https://osv.dev)** integration?
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
  - [ ] Reindeer support for `.crate` files: <https://github.com/facebookincubator/reindeer/>
  - [ ] Import 3rd party library source code into the repository?
- RE/AC support:
  - [ ] Missing support for local execution `ActionCache` support
    - <https://github.com/facebook/buck2/pull/765>
    - <https://github.com/facebook/buck2/pull/764>
  - [x] ~~File size logic bugs <https://github.com/facebook/buck2/pull/639>~~
  - [x] ~~Buggy concurrency limiter: <https://github.com/facebook/buck2/pull/642>~~
  - [ ] Failure diagonstics <https://github.com/facebook/buck2/pull/656>
  - [ ] `rust_library` caching for `local_only=True` (TBA)
- `rust-analyzer` + `rust-project`
  - [x] ~~`linked_projects` support: <https://github.com/rust-lang/rust-analyzer/pull/17246>~~
  - [x] ~~Unbreak OSS use of `rust-project`: <https://github.com/facebook/buck2/pull/659>~~
  - [x] ~~`--sysroot-mode` support for `rust-project`: <https://github.com/facebook/buck2/pull/745>~~
  - [x] ~~`rust-project check` is broken: <https://github.com/facebook/buck2/pull/754>~~
  - [x] ~~Invalid dep graph due to lack of `sysroot_src`~~
    - <https://github.com/facebook/buck2/issues/747>
    - <https://github.com/facebook/buck2/pull/756>
  - [ ] Prebuilt `rust-project` binaries + dotslash: <https://github.com/facebook/buck2/pull/766>
    - Exists in my (light) fork w/ some patches: <https://github.com/thoughtpolice/buck2>
    - Currently provided in this repo for now, but not upstream
- Log shuffling
  - [ ] `buck log --trace-id ...` OSS support: <https://github.com/facebook/buck2/pull/770>
    - Supported in my fork of Buck2 (+ this repo)
    - Can replay any GHA build (within ~24hrs) with a known Build ID
    - <https://github.com/facebook/buck2/pull/702>
- Online build analysis + reporting
  - [ ] Emit CI build events to an external service: <https://github.com/facebook/buck2/pull/685>
    - Will allow us to abstract away underlying CI to some extent
- UX improvements
  - [ ] Improve `ValidationInfo` failure messages <https://github.com/facebook/buck2/pull/769>
  - [ ] Aggressively annoying download warnings <https://github.com/facebook/buck2/issues/316>
    - Also solved by solid offline support
  - [ ] `buck2 test` should build targets too <https://github.com/facebook/buck2/pull/702>
  - [ ] Add subtarget information to test name <https://github.com/facebook/buck2/pull/743>
- Platform support
  - [x] ~~`buck2` aarch64-linux binaries don't with 16k page size
        <https://github.com/facebook/buck2/pull/693>~~

## License

Apache 2.0.
