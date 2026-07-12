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
  #export ydb_routines="$ydb_dist/plugin/o/mind.so "
  /opt/mind/mind "$mind_args"
  echo "started..."

elif [ "$servermode" = "server-test" ]; then
  export ydb_routines='/opt/mind/o*(/opt/mind/m /opt/mind/test/m) '
  export ydb_chset="M"
  source /opt/yottadb/current/ydb_env_set
  /opt/mind/test/mut.sh $test_branch_server

elif [ "$startupmode" = "direct" ]; then
  ./mind "$mind_args"

else
  sleep infinity

fi