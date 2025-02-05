# SPDX-FileCopyrightText: © 2024-2025 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

load("@root//buck/shims/qq.bzl", "qq")
load("@root//buck/shims/package.bzl", "pkg")

VERSION = pkg.version().split('g', 1)[1]

http_archive(
    name = 'src',
    sha256 = 'de10623f0ab08ca0ccedc95d50f5e827b5f4680935024e6c5ebd7b2ef2129e5f',
    urls = [
        f'https://github.com/libssh2/libssh2/archive/{VERSION}.tar.gz',
    ],
    type = 'tar.gz',
    strip_prefix = f'libssh2-{VERSION}',
    sub_targets = [
        "include/libssh2.h",
        "src/agent.c",
        "src/bcrypt_pbkdf.c",
        "src/blowfish.c",
        "src/channel.c",
        "src/comp.c",
        "src/crypt.c",
        "src/global.c",
        "src/hostkey.c",
        "src/keepalive.c",
        "src/kex.c",
        "src/knownhost.c",
        "src/mac.c",
        "src/misc.c",
        "src/openssl.c",
        "src/packet.c",
        "src/pem.c",
        "src/publickey.c",
        "src/scp.c",
        "src/session.c",
        "src/sftp.c",
        "src/transport.c",
        "src/userauth.c",
        "src/userauth_kbd_packet.c",
        "src/agent_win.c",
    ],
)

qq.cxx_library(
    name = 'libssh2',
    srcs = [
        ":src[src/agent.c]",
        ":src[src/bcrypt_pbkdf.c]",
        ":src[src/blowfish.c]",
        ":src[src/channel.c]",
        ":src[src/comp.c]",
        ":src[src/crypt.c]",
        ":src[src/global.c]",
        ":src[src/hostkey.c]",
        ":src[src/keepalive.c]",
        ":src[src/kex.c]",
        ":src[src/knownhost.c]",
        ":src[src/mac.c]",
        ":src[src/misc.c]",
        ":src[src/openssl.c]",
        ":src[src/packet.c]",
        ":src[src/pem.c]",
        ":src[src/publickey.c]",
        ":src[src/scp.c]",
        ":src[src/session.c]",
        ":src[src/sftp.c]",
        ":src[src/transport.c]",
        ":src[src/userauth.c]",
        ":src[src/userauth_kbd_packet.c]",
    ] + select({
        'config//os:windows': [
            ':src[src/agent_win.c]',
        ],
        'DEFAULT': [],
    }),
    headers = ["include/libssh2_config.h"],
    header_namespace = "",
    exported_headers = {
        'libssh2.h': ':src[include/libssh2.h]',
    },
    include_directories = ["include"],
    compiler_flags = select({
        'config//os:windows': [],
        'DEFAULT': ["-fvisibility=hidden"],
    }),
    preferred_linkage = "static",
    preprocessor_flags = [
        "-I$(location :src)/src",
        "-I$(location :src)/include",
        "-DLIBSSH2_OPENSSL",
        "-DHAVE_EVP_AES_128_CTR",
        "-DLIBSSH2_DH_GEX_NEW",
        "-DLIBSSH2_HAVE_ZLIB",
    ] + select({
        'config//os:windows': [
            "-I$(location :src)/win32",
            "-DLIBSSH2_WIN32",
            "-DWIN32_LEAN_AND_MEAN",
            "-DNOMINMAX",
        ],
        'DEFAULT': [
            "-DHAVE_SNPRINTF",
            "-DHAVE_UNISTD_H",
            "-DHAVE_INTTYPES_H",
            "-DHAVE_SYS_SELECT_H",
            "-DHAVE_SYS_UIO",
            "-DHAVE_SYS_SOCKET_H",
            "-DHAVE_SYS_IOCTL_H",
            "-DHAVE_SYS_TIME_H",
            "-DHAVE_SYS_UN_H",
            "-DHAVE_O_NONBLOCK",
            "-DHAVE_LIBCRYPT32",
            "-DHAVE_POLL",
            "-DHAVE_GETTIMEOFDAY",
        ],
    }),

    deps = [
        "third-party//bssl:crypto",
        "third-party//bssl:ssl",
        "third-party//libz:libz",
    ],
)
