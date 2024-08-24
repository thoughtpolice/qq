# SPDX-FileCopyrightText: © 2024 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@root//buck/shims:qq.bzl", "qq")

SOURCE_DIRS = [
    'buck',
    'src',
    'tests',
]

qq.command_test(
    name = 'lint',
    cmd = [
        'dotslash',
        '$(location //buck/bin:buck2)',
        '--isolation-dir', 'buck2-lint-tests',
        'starlark',
        'lint',
    ] + SOURCE_DIRS,
)
