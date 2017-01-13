From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/4] selftest: cpufreq: Add suspend/resume/hibernate support
Date: Fri, 13 Jan 2017 12:06:46 +0530
Message-ID: <11499360abc3e627800e286050d9388395a2d1ff.1484289212.git.viresh.kumar@linaro.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33997 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdAMGhO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 01:37:14 -0500
Received: by mail-pf0-f175.google.com with SMTP id 127so26093367pfg.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2017 22:37:14 -0800 (PST)
In-Reply-To: <cover.1484289212.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1484289212.git.viresh.kumar@linaro.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Shuah Khan <shuah@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

This patch adds support to test basic suspend/resume and hibernation to
the cpufreq selftests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 tools/testing/selftests/cpufreq/cpufreq.sh | 40 ++++++++++++++++++++++++++++++
 tools/testing/selftests/cpufreq/main.sh    | 14 +++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
index 2b8b05aaa874..1ed3832030b4 100755
--- a/tools/testing/selftests/cpufreq/cpufreq.sh
+++ b/tools/testing/selftests/cpufreq/cpufreq.sh
@@ -199,3 +199,43 @@ cpufreq_basic_tests()
 	# Test all governors
 	shuffle_governors_for_all_cpus 1
 }
+
+# Suspend/resume
+# $1: "suspend" or "hibernate", $2: loop count
+do_suspend()
+{
+	printf "** Test: Running ${FUNCNAME[0]}: Trying $1 for $2 loops **\n\n"
+
+	# Is the directory available
+	if [ ! -d $SYSFS/power/ -o ! -f $SYSFS/power/state ]; then
+		printf "$SYSFS/power/state not available\n"
+		return 1
+	fi
+
+	if [ $1 = "suspend" ]; then
+		filename="mem"
+	elif [ $1 = "hibernate" ]; then
+		filename="disk"
+	else
+		printf "$1 is not a valid option\n"
+		return 1
+	fi
+
+	if [ -n $filename ]; then
+		present=$(cat $SYSFS/power/state | grep $filename)
+
+		if [ -z "$present" ]; then
+			printf "Tried to $1 but $filename isn't present in $SYSFS/power/state\n"
+			return 1;
+		fi
+
+		for i in `seq 1 $2`; do
+			printf "Starting $1\n"
+			echo $filename > $SYSFS/power/state
+			printf "Came out of $1\n"
+
+			printf "Do basic tests after finishing $1 to verify cpufreq state\n\n"
+			cpufreq_basic_tests
+		done
+	fi
+}
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index 3224652ccbd4..9ff662f67ea4 100755
--- a/tools/testing/selftests/cpufreq/main.sh
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -15,7 +15,9 @@ helpme()
 	printf "Usage: $0 [-h] [-to args]
 	[-h <help>]
 	[-o <output-file-for-dump>]
-	[-t <basic: Basic cpufreq testing>]
+	[-t <basic: Basic cpufreq testing
+	     suspend: suspend/resume,
+	     hibernate: hibernate/resume>]
 	\n"
 	exit 2
 }
@@ -61,7 +63,7 @@ parse_arguments()
 				helpme
 				;;
 
-			t) # --func_type (Function to perform: basic (default: basic))
+			t) # --func_type (Function to perform: basic, suspend, hibernate (default: basic))
 				FUNC=$OPTARG
 				;;
 
@@ -91,6 +93,14 @@ do_test()
 		cpufreq_basic_tests
 		;;
 
+		"suspend")
+		do_suspend "suspend" 1
+		;;
+
+		"hibernate")
+		do_suspend "hibernate" 1
+		;;
+
 		*)
 		echo "Invalid [-f] function type"
 		helpme
-- 
2.7.1.410.g6faf27b

