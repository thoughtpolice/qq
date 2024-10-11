# SPDX-FileCopyrightText: © 2024 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@prelude//:paths.bzl", "paths")
load("@root//buck/shims/qq.bzl", "qq")

TESTS = map(lambda f: (paths.split_extension(f)[0], f), glob(['*.c']))

[
    qq.cxx_binary(
        name = '{}-exe'.format(f),
        srcs = [ src ],
        deps = [ 'third-party//mimalloc:mimalloc' ],
    ) for (f, src) in TESTS
]

[
    qq.command_test(
        name = '{}-test'.format(f),
        cmd = [ "$(exe :{}-exe)".format(f) ],
    ) for (f, _) in TESTS
]
