From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 1/3] cpufreq: tests: Cpufreq test to check if all declared
 freqs can be set
Date: Mon, 26 Jan 2015 11:41:22 +0100
Message-ID: <1422268884-26173-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57969 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbbAZKmA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jan 2015 05:42:00 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIS00I5N5PYNE50@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 26 Jan 2015 19:41:58 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, a.nitecki@samsung.com, Lukasz Majewski <l.majewski@samsung.com>

This test allows checking if all declared frequencies can be set on tested
board.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 tools/testing/cpufreq/cpufreq_freq_test.sh | 149 +++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100755 tools/testing/cpufreq/cpufreq_freq_test.sh

diff --git a/tools/testing/cpufreq/cpufreq_freq_test.sh b/tools/testing/cpufreq/cpufreq_freq_test.sh
new file mode 100755
index 0000000..6dfd08b
--- /dev/null
+++ b/tools/testing/cpufreq/cpufreq_freq_test.sh
@@ -0,0 +1,149 @@
+#!/bin/bash
+#
+# This file provides a simple mean to test if all declared freqs at
+# "scaling_available_frequencies" can be set and if "cpuinfo_cur_freq"
+# returns this value.
+#
+# Usage: ./cpufreq_freq_test.sh
+# Requisite: Compiled in "performance" governor
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, you can access it online at
+# http://www.gnu.org/licenses/gpl-2.0.html.
+#
+# Copyright (C) Samsung Electronics, 2014-2015
+#
+# Author: Lukasz Majewski <l.majewski@samsung.com>
+
+set +x
+
+COLOUR_RED="\33[31m"
+COLOUR_BLUE="\33[34m"
+COLOUR_GREEN="\33[32m"
+COLOUR_DEFAULT="\33[0m"
+
+T_PATH=/sys/devices/system/cpu/cpu0/cpufreq
+BOOST_PATH=/sys/devices/system/cpu/cpufreq
+
+if [ ! -d "$T_PATH" ]; then
+    printf "   $COLOUR_RED No path to CPUFREQ $COLOUR_DEFAULT\n"
+    exit 1
+fi
+
+ERRORS=0
+
+OLD_GOV=`cat $T_PATH/scaling_governor`
+echo "CURRENT GOVERNOR: $OLD_GOV"
+echo "SET GOVERNOR: performance"
+echo "performance" > $T_PATH/scaling_governor
+
+function test_freqs1 {
+    FREQS=`cat $1`
+    for I in $FREQS; do
+	cpufreq_set_freq $I
+	if [ "$2" ]; then
+	    printf "$COLOUR_BLUE BOOST $COLOUR_DEFAULT" $I
+	fi
+	cpufreq_test_freq $I
+    done
+}
+
+function test_freqs2 {
+    FREQ=`cat $1`
+    FREQS_ARRAY=($FREQ)
+
+    for freq in ${FREQS_ARRAY[@]}
+    do
+	echo "REFERENCE FREQ: $freq"
+	for f in ${FREQS_ARRAY[@]}
+	do
+	    cpufreq_set_freq $freq
+	    echo -n "----> "
+	    cpufreq_set_freq $f
+	    cpufreq_test_freq $f
+	done
+    done
+}
+
+function restore {
+    if [ -f $BOOST_PATH/boost ]; then
+	cpufreq_boost_state $BOOST_STATE
+    fi
+
+    echo "SET GOVERNOR: $OLD_GOV"
+    echo $OLD_GOV > $T_PATH/scaling_governor
+}
+
+function die {
+    printf "   $COLOUR_RED FAILED $COLOUR_DEFAULT\n"
+    restore_gov
+    exit 1
+}
+
+function cpufreq_test_freq {
+    gzip < /dev/urandom > /dev/null &
+    pid=$!
+    sleep 0.1
+    CURR_FREQ=`cat $T_PATH/cpuinfo_cur_freq`
+    if [ $1 -eq $CURR_FREQ ]; then
+	printf "\t$COLOUR_GREEN OK $COLOUR_DEFAULT\n"
+    else
+	printf "$COLOUR_RED CURRENT $CURR_FREQ $COLOUR_DEFAULT\n"
+	ERRORS=$(( $ERRORS + 1 ))
+	#die
+    fi
+    kill -9 $pid
+    wait $! 2>/dev/null
+}
+
+function cpufreq_set_freq {
+    echo $1 > $T_PATH/scaling_max_freq || die $?
+    printf "FREQ:$COLOUR_GREEN %s $COLOUR_DEFAULT" $1
+}
+
+function cpufreq_boost_state {
+   echo $1 > $BOOST_PATH/boost
+}
+
+function cpufreq_boost_status {
+   cat $BOOST_PATH/boost
+}
+
+if [ -f $BOOST_PATH/boost ]; then
+    echo "######################################"
+    echo "TEST BOOST OPERATION"
+    echo "######################################"
+
+    BOOST_STATE=$(cpufreq_boost_status)
+    if [ $BOOST_STATE -eq 0 ]; then
+	cpufreq_boost_state 1
+    fi
+    test_freqs1 $T_PATH/scaling_boost_frequencies 1
+fi
+
+echo "######################################"
+echo "TEST AVAILABLE FREQS"
+echo "######################################"
+test_freqs1 $T_PATH/scaling_available_frequencies
+
+echo "######################################"
+echo "TEST FREQS SWITCHING"
+echo "######################################"
+test_freqs2 $T_PATH/scaling_available_frequencies
+
+echo "######################################"
+echo "ERRORS: $ERRORS"
+echo "######################################"
+
+restore
+exit 0
-- 
2.0.0.rc2

