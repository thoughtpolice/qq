# SPDX-FileCopyrightText: © 2024 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@root//buck/shims/qq.bzl", "qq")

[
    qq.export_file(
        name = file,
        src = file,
    ) for file in glob(["*"], exclude = ["BUILD", "PACKAGE"])
]
