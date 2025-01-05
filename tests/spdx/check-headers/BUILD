# SPDX-FileCopyrightText: © 2024-2025 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@root//buck/shims:qq.bzl", "qq")

python_bootstrap_binary(
    name = 'check-spdx',
    main = 'main.py',
    tests = [ ':check-spdx-test' ],
)

qq.run_test(
    name = 'check-spdx-test',
    dep = ":check-spdx",
)
