# SPDX-FileCopyrightText: © 2024 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@root//buck/shims/qq.bzl", "qq")

export_file(
    name = 'qq.capnp',
    src = 'qq.capnp',
)

genrule(
    name = 'qq_capnp.rs',
    srcs = [':qq.capnp'],
    # we have to use 'outs' so that $OUT is a directory, instead of a file
    outs = { 'qq_capnp.rs': [ 'qq_capnp.rs' ] },
    default_outs = [ 'qq_capnp.rs' ],
    cmd = """
        $(exe third-party//capnp:capnp_tool) \
          compile -o $(location third-party//capnp:capnpc-rust):$OUT \
          qq.capnp
    """,
)

qq.write_file(
    name = 'lib.rs',
    contents = [
        'mod qq_capnp;',
        'pub use qq_capnp::*;',
    ],
)

# layer this into a filegroup so that buck2-rust-project and rust-analyzer can
# more easily find the source code for this crate
filegroup(
    name = 'qq-capnp-src',
    srcs = {
        'qq_capnp.rs': ':qq_capnp.rs',
        'lib.rs': ':lib.rs',
    },
)

qq.rust_library(
    name = 'qq-capnp',
    srcs = [':qq-capnp-src'],
    crate_root = 'qq-capnp-src/lib.rs',
    deps = [
        'third-party//rust:capnp',
    ],
    visibility = [ 'PUBLIC' ],
)
