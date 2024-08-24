# SPDX-FileCopyrightText: © 2024 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@prelude//toolchains:cxx.bzl", "system_cxx_toolchain")

cxx_flags = select({
    'config//os:linux': [
        '-std=gnu++17',
    ],
    'config//os:macos': [
        '-std=gnu++17', '-stdlib=libc++'
    ],
    'config//os:windows': [
        '/std:c++17',
        '/Zc:__cplusplus',
        '/Zc:inline',
        '/Zc:wchar_t',
        '/Zc:forScope',
        '/fp:precise',
    ],
})

cxx_warn_flags = select({
    "config//os:macos": [
        # NOTE (aseipp): some apparently ancient zlib code in the zlib-sys crate
        # needs this, otherwise builds fail on sufficiently recent macOS systems due
        # to C2X support officially making this an error by default
        "-Wno-implicit-function-declaration",
    ],
    "DEFAULT": [],
})

cxx_link_flags = select({
    "config//os:linux": [
        # on Linux, always use mold + zstd debug sections
        "-fuse-ld=mold",
        # FIXME issue: nixos/nixpkgs#347795 <https://github.com/NixOS/nixpkgs/issues/347795>
        #"-Wl,--compress-debug-sections=zstd",
        # emit relocations for BOLT
        "-Wl,--emit-relocs",
    ],

    "config//os:macos": [
        # on macOS, use the new parallel linker
        "-fuse-ld=/usr/bin/ld",
        "-ld_new",
        "-framework",
        "Security",
    ],

    # on Windows, suffer
    "config//os:windows": [
        "advapi32.lib",
        "winhttp.lib",
        "rpcrt4.lib",
        "ole32.lib",
        "crypt32.lib",
        "secur32.lib",
        "shell32.lib",
        "user32.lib",
    ],
})

debug_opt_flags = select({
    "config//os:windows": ["/Od"],
    "DEFAULT": ["-Og"],
})

release_opt_flags = select({
    "config//os:windows": ["/O2"],
    "DEFAULT": ["-O3"],
})

cxx_compiler_type = select({
    'config//os:windows': 'windows',
    'DEFAULT': 'clang',
})

cxx_linker = select({
    "config//os:windows": "link.exe",
    "config//os:macos": "clang++",
    "DEFAULT": "clang++",
})

system_cxx_toolchain(
    name = "cxx-debug",
    compiler_type = cxx_compiler_type,
    c_flags = debug_opt_flags + cxx_warn_flags,
    cxx_flags = cxx_flags + debug_opt_flags + cxx_warn_flags,
    linker = cxx_linker,
    link_flags = cxx_link_flags,
)

system_cxx_toolchain(
    name = "cxx-release",
    compiler_type = cxx_compiler_type,
    c_flags = release_opt_flags + cxx_warn_flags,
    cxx_flags = cxx_flags + release_opt_flags + cxx_warn_flags,
    linker = cxx_linker,
    link_flags = cxx_link_flags,
)

toolchain_alias(
    name = 'cxx',
    actual = select({
        "mode//:debug": ":cxx-debug",
        "mode//:release": ":cxx-release",
    }),
)
