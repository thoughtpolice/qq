# SPDX-FileCopyrightText: © 2024 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load(":defs.bzl", "download_deno", "deno_toolchain")

DENO_VERSION = '2.0.0'

ALL_DENO_VERSIONS = {
    '2.0.0': [
        ('aarch64-unknown-linux-gnu', 'a76ada742b4e7670b1c50783cd01be200a38ae2439be583dd07c8069d387f99e'),
        ('aarch64-apple-darwin', 'ad122b1c8c823378469fb4972c0cc6dafc01353dfa5c7303d199bdc1dee9d5e9'),
        ('x86_64-unknown-linux-gnu', 'd201b812bbc6cc2565012e52c2a9cb9965d768afd28bbc2ba29ae667bf7250a6'),
        ('x86_64-pc-windows-msvc', '34ea525eeaae3ef2eb72e5f7c237fbf844fa900e6b8e666c5db2553f56f9d382'),
    ],
    '1.46.3': [
        ('aarch64-unknown-linux-gnu', 'acf7e0110e186fc515a1b7367d9c56a9f0205ad448c1c08ab769b8e3ce6f700f'),
        ('aarch64-apple-darwin', 'e74f8ddd6d8205654905a4e42b5a605ab110722a7898aef68bc35d6e704c2946'),
        ('x86_64-unknown-linux-gnu', '39bb1d21ad19c16fcb14f9d58fb542c2bccf0cd92c19aee8127ac5112b48bf83'),
        ('x86_64-pc-windows-msvc', 'd9428daa1b3763bdf562054d0fc40832658515b7071c7f7e98d61961adc2d61a'),
    ],
}

[
    download_deno(version = version, hashes = hashes)
    for version, hashes in ALL_DENO_VERSIONS.items()
]

[
    deno_toolchain(
        name = f'deno-{version}',
        deno = select({
            'config//cpu:arm64': select({
                'config//os:linux': [ f'$(location :{version}-aarch64-unknown-linux-gnu)/deno' ],
                'config//os:macos': [ f'$(location :{version}-aarch64-apple-darwin)/deno' ],
            }),
            'config//cpu:x86_64': select({
                'config//os:linux':   [ f'$(location :{version}-x86_64-unknown-linux-gnu)/deno' ],
                'config//os:windows': [ f'$(location :{version}-x86_64-pc-windows-msvc)/deno.exe' ],
            }),
        }),
    ) for version in ALL_DENO_VERSIONS.keys()
]

toolchain_alias(
    name = 'deno',
    actual = f':deno-{DENO_VERSION}',
)
