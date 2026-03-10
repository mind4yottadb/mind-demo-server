#!/bin/bash
#################################################################
#                                                               #
# Copyright (c) 2026 DnaSoft BV and/or its subsidiaries.        #
# All rights reserved.                                          #
#                                                               #
#   This source code contains the intellectual property         #
#   of its copyright holder(s), and is made available           #
#   under a license.  If you do not know the terms of           #
#   the license, please stop and do not read further.           #
#                                                               #
#################################################################

if [ "$servermode" = "client-test" ]; then
  ../mind
elif [ "$servermode" = "server-test" ]; then
  ./mut-server.sh
elif [ "startupmode" = "direct" ]; then
  ../mind
else
  sleep infinity
fi