# SPDX-FileCopyrightText: © 2024-2025 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@prelude//utils/buckconfig.bzl", "read_choice")
load(":defs.bzl", "generate_platforms", "default_platforms")

build_config = read_choice("project", "buildmode", [
    "debug",
    "release",
], "debug")

default_constraints = [
    # build mode: debug or release
    ('mode//:{}'.format(build_config))
]

generate_platforms(default_platforms, default_constraints)
