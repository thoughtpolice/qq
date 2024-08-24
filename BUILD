# SPDX-FileCopyrightText: © 2024 Austin Seipp
# SPDX-License-Identifier: Apache-2.0

TOOLS = {
    'qq-server': '//src/qq-server:qq-server',
    'qq-cli':    '//src/qq-cli:qq-cli',

    'buck2-logs-server': '//src/tools/buck2-logs:server',
    'buck2-logs-upload': '//src/tools/buck2-logs:upload',
}

filegroup(
    name = 'qq',
    srcs = {
        f'{name}.exe': tgt for name, tgt in TOOLS.items()
    },
)
