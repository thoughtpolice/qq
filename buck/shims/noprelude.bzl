# SPDX-FileCopyrightText: © 2024 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

def cxx_library(**_kwargs):
    fail('use load("@root//buck/shims/qq.bzl", "qq") and call qq.cxx_library() instead')

def cxx_binary(**_kwargs):
    fail('use load("@root//buck/shims/qq.bzl", "qq") and call qq.cxx_binary() instead')

def prebuilt_cxx_library(**_kwargs):
    fail('use load("@root//buck/shims/qq.bzl", "qq") and call qq.prebuilt_cxx_library() instead')

def rust_library(**_kwargs):
    fail('use load("@root//buck/shims/qq.bzl", "qq") and call qq.rust_library() instead')

def rust_binary(**_kwargs):
    fail('use load("@root//buck/shims/qq.bzl", "qq") and call qq.rust_binary() instead')
