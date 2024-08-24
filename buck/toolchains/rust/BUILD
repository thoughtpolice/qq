# SPDX-FileCopyrightText: © 2024 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@prelude//toolchains:rust.bzl", "system_rust_toolchain")

common_rustc_flags = [
    # don't use the parallel frontend; buck2 isn't jobserver aware, and so
    # this can lead to N processes using N threads a piece, oversubscribing
    # the CPU <https://github.com/facebook/buck2/issues/653>
    "-Zthreads=1",
]

os_rustc_flags = select({
    'config//os:linux': [
        # on Linux, use mold + compressed debug sections
        "-Clink-arg=-fuse-ld=mold",
        # FIXME issue: nixos/nixpkgs#347795 <https://github.com/NixOS/nixpkgs/issues/347795>
        # "-Clink-arg=-Wl,--compress-debug-sections=zstd",
        # emit relocations for BOLT
        "-Clink-arg=-Wl,--emit-relocs",
    ],
    'config//os:windows': [
        # NOTE: on Windows, link the CRT statically so that users don't need
        # a copy of vcruntime140.dll on their machines. its distribution is...
        # complex
        "-Ctarget-feature=+crt-static",
    ],
    'DEFAULT': [],
})

base_rustc_flags = common_rustc_flags + os_rustc_flags

system_rust_toolchain(
    name = "rust-debug",
    default_edition = "2021",
    rustc_flags = base_rustc_flags
)

system_rust_toolchain(
    name = "rust-release",
    default_edition = "2021",
    rustc_flags = base_rustc_flags + [
        "-Copt-level=3",
        "-Cdebuginfo=none",
        "-Cdebug-assertions=false",
        "-Coverflow-checks=false",
        "-Ccodegen-units=1",
        "-Cpanic=abort",
        "-Clto=thin",
        "-Zdylib-lto",
    ],
)

toolchain_alias(
    name = 'rust',
    actual = select({
        "mode//:debug": ":rust-debug",
        "mode//:release": ":rust-release",
    }),
)
