# SPDX-FileCopyrightText: © 2024-2025 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@root//buck/shims/qq.bzl", "qq")

alias(
    name = 'rust',
    actual = ':mimalloc-rust',
)

qq.rust_library(
    name = 'mimalloc-rust',
    crate = 'mimalloc',
    srcs = glob(['**/*.rs']),
    deps = [ 'third-party//mimalloc:mimalloc' ],
)

qq.rust_test(
    name = 'mimalloc-rust-test',
    srcs = glob(['**/*.rs']),
    deps = [ 'third-party//mimalloc:mimalloc' ],
)
