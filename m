From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 2/3] cpufreq: tests: Provide test to check if all supported
 governors are working
Date: Mon, 26 Jan 2015 11:41:23 +0100
Message-ID: <1422268884-26173-2-git-send-email-l.majewski@samsung.com>
References: <1422268884-26173-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58041 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbbAZKmL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jan 2015 05:42:11 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIS00KLB5QAEF30@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 26 Jan 2015 19:42:10 +0900 (KST)
In-reply-to: <1422268884-26173-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, a.nitecki@samsung.com, Lukasz Majewski <l.majewski@samsung.com>

This test checks if all compiled in cpufreq governors can be enabled.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 tools/testing/cpufreq/governors_switch.sh | 92 +++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100755 tools/testing/cpufreq/governors_switch.sh

diff --git a/tools/testing/cpufreq/governors_switch.sh b/tools/testing/cpufreq/governors_switch.sh
new file mode 100755
index 0000000..16bd88c
--- /dev/null
+++ b/tools/testing/cpufreq/governors_switch.sh
@@ -0,0 +1,92 @@
+#!/bin/bash
+#
+# This file provides a simple mean to test if all declared governors
+# at "scaling_available_governors" can be set and if "scaling_governor"
+# returns this value.
+#
+# Usage: ./governors_switch
+# Requisite: None
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
+# Copyright (C) Samsung Electronics, 2015
+#
+# Author: Lukasz Majewski <l.majewski@samsung.com>
+
+set +x
+T_PATCH=/sys/devices/system/cpu/cpu0/cpufreq
+
+ERRORS=0
+
+function restore_gov {
+    echo "SET GOVERNOR: $OLD_GOV"
+    echo $OLD_GOV > $T_PATCH/scaling_governor
+}
+
+function die {
+    printf "   \33[31m FAILED \33[0m \n"
+    restore_gov
+    exit $1
+}
+
+
+echo "######################################"
+printf "\33[35mGovernors permutation test\33[0m\n"
+echo "######################################"
+OLD_GOV=`cat $T_PATCH/scaling_governor`
+echo "CURRENT GOVERNOR: $OLD_GOV"
+
+GOVS=`cat $T_PATCH/scaling_available_governors`
+echo "Available governors: $GOVS"
+
+GOVS_ARRAY=($GOVS)
+GOVS_ARRAY_ELEM=${#GOVS_ARRAY[@]}
+echo "Number of elements: $GOVS_ARRAY_ELEM"
+
+if [ $GOVS_ARRAY_ELEM -le 1 ];
+then
+    echo "Only one governor present - NO testing"
+    exit 0
+fi
+
+TMP=$GOVS_ARRAY
+
+for gov in ${GOVS_ARRAY[@]}
+do
+    printf "\33[35mGOV:\t $gov\n\33[0m"
+
+    for f in ${GOVS_ARRAY[@]}
+    do
+	echo $gov > $T_PATCH/scaling_governor || die $?
+	printf "\t $f "
+	echo $f > $T_PATCH/scaling_governor || die $?
+
+	CURRENT_GOV=`cat $T_PATCH/scaling_governor`
+	if [ $CURRENT_GOV == $f ]; then
+	    printf "\t\33[32m OK \33[0m \n"
+	else
+	    printf "\t\33[31m CURRENT GOV: $CURRENT_GOV \33[0m \n"
+	    ERRORS=$(( $ERRORS + 1 ))
+	fi
+    done
+done
+
+echo "######################################"
+echo "ERRORS: $ERRORS"
+echo "######################################"
+
+restore_gov
+
+exit 0;
-- 
2.0.0.rc2

