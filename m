From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/4] selftest: cpufreq: Add support to test cpufreq modules
Date: Fri, 13 Jan 2017 12:06:47 +0530
Message-ID: <e0aa4179707614a6bae8802dd13fb8ba1f771e28.1484289212.git.viresh.kumar@linaro.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35341 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdAMGhP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 01:37:15 -0500
Received: by mail-pf0-f177.google.com with SMTP id f144so26332638pfa.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2017 22:37:15 -0800 (PST)
In-Reply-To: <cover.1484289212.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1484289212.git.viresh.kumar@linaro.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Shuah Khan <shuah@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

This patch adds support for cpufreq modules like cpufreq drivers and
cpufreq governors. The tests will insert the modules in different orders
and them perform basic cpufreq tests. The modules are then removed from
the kernel.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 tools/testing/selftests/cpufreq/Makefile  |   2 +-
 tools/testing/selftests/cpufreq/main.sh   |  45 +++++-
 tools/testing/selftests/cpufreq/module.sh | 243 ++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/cpufreq/module.sh

diff --git a/tools/testing/selftests/cpufreq/Makefile b/tools/testing/selftests/cpufreq/Makefile
index f5c6bb1965a1..80c8727dcec1 100644
--- a/tools/testing/selftests/cpufreq/Makefile
+++ b/tools/testing/selftests/cpufreq/Makefile
@@ -1,7 +1,7 @@
 all:
 
 TEST_PROGS := main.sh
-TEST_FILES := cpu.sh cpufreq.sh governor.sh
+TEST_FILES := cpu.sh cpufreq.sh governor.sh module.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index 9ff662f67ea4..2515867ac9de 100755
--- a/tools/testing/selftests/cpufreq/main.sh
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -3,6 +3,7 @@
 source cpu.sh
 source cpufreq.sh
 source governor.sh
+source module.sh
 
 FUNC=basic	# do basic tests by default
 OUTFILE=cpufreq_selftest
@@ -12,12 +13,15 @@ CPUFREQROOT=
 
 helpme()
 {
-	printf "Usage: $0 [-h] [-to args]
+	printf "Usage: $0 [-h] [-todg args]
 	[-h <help>]
 	[-o <output-file-for-dump>]
 	[-t <basic: Basic cpufreq testing
 	     suspend: suspend/resume,
-	     hibernate: hibernate/resume>]
+	     hibernate: hibernate/resume,
+	     modtest: test driver or governor modules. Only to be used with -d or -g options>]
+	[-d <driver's module name: only with \"-t modtest>\"]
+	[-g <governor's module name: only with \"-t modtest>\"]
 	\n"
 	exit 2
 }
@@ -56,14 +60,14 @@ prerequisite()
 
 parse_arguments()
 {
-	while getopts ht:o: arg
+	while getopts ht:o:d:g: arg
 	do
 		case $arg in
 			h) # --help
 				helpme
 				;;
 
-			t) # --func_type (Function to perform: basic, suspend, hibernate (default: basic))
+			t) # --func_type (Function to perform: basic, suspend, hibernate, modtest (default: basic))
 				FUNC=$OPTARG
 				;;
 
@@ -71,6 +75,14 @@ parse_arguments()
 				OUTFILE=$OPTARG
 				;;
 
+			d) # --driver-mod-name (Name of the driver module)
+				DRIVER_MOD=$OPTARG
+				;;
+
+			g) # --governor-mod-name (Name of the governor module)
+				GOVERNOR_MOD=$OPTARG
+				;;
+
 			\?)
 				helpme
 				;;
@@ -83,7 +95,7 @@ do_test()
 	# Check if CPUs are managed by cpufreq or not
 	count=$(count_cpufreq_managed_cpus)
 
-	if [ $count = 0 ]; then
+	if [ $count = 0 -a $FUNC != "modtest" ]; then
 		echo "No cpu is managed by cpufreq core, exiting"
 		exit 2;
 	fi
@@ -101,6 +113,29 @@ do_test()
 		do_suspend "hibernate" 1
 		;;
 
+		"modtest")
+		# Do we have modules in place?
+		if [ -z $DRIVER_MOD ] && [ -z $GOVERNOR_MOD ]; then
+			echo "No driver or governor module passed with -d or -g"
+			exit 2;
+		fi
+
+		if [ $DRIVER_MOD ]; then
+			if [ $GOVERNOR_MOD ]; then
+				module_test $DRIVER_MOD $GOVERNOR_MOD
+			else
+				module_driver_test $DRIVER_MOD
+			fi
+		else
+			if [ $count = 0 ]; then
+				echo "No cpu is managed by cpufreq core, exiting"
+				exit 2;
+			fi
+
+			module_governor_test $GOVERNOR_MOD
+		fi
+		;;
+
 		*)
 		echo "Invalid [-f] function type"
 		helpme
diff --git a/tools/testing/selftests/cpufreq/module.sh b/tools/testing/selftests/cpufreq/module.sh
new file mode 100755
index 000000000000..8ff2244a33a1
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/module.sh
@@ -0,0 +1,243 @@
+#!/bin/bash
+#
+# Modules specific tests cases
+
+# protect against multiple inclusion
+if [ $FILE_MODULE ]; then
+	return 0
+else
+	FILE_MODULE=DONE
+fi
+
+source cpu.sh
+source cpufreq.sh
+source governor.sh
+
+# Check basic insmod/rmmod
+# $1: module
+test_basic_insmod_rmmod()
+{
+	printf "** Test: Running ${FUNCNAME[0]} **\n\n"
+
+	printf "Inserting $1 module\n"
+	# insert module
+	insmod $1
+	if [ $? != 0 ]; then
+		printf "Insmod $1 failed\n"
+		exit;
+	fi
+
+	printf "Removing $1 module\n"
+	# remove module
+	rmmod $1
+	if [ $? != 0 ]; then
+		printf "rmmod $1 failed\n"
+		exit;
+	fi
+
+	printf "\n"
+}
+
+# Insert cpufreq driver module and perform basic tests
+# $1: cpufreq-driver module to insert
+# $2: If we want to play with CPUs (1) or not (0)
+module_driver_test_single()
+{
+	printf "** Test: Running ${FUNCNAME[0]} for driver $1 and cpus_hotplug=$2 **\n\n"
+
+	if [ $2 -eq 1 ]; then
+		# offline all non-boot CPUs
+		for_each_non_boot_cpu offline_cpu
+		printf "\n"
+	fi
+
+	# insert module
+	printf "Inserting $1 module\n\n"
+	insmod $1
+	if [ $? != 0 ]; then
+		printf "Insmod $1 failed\n"
+		return;
+	fi
+
+	if [ $2 -eq 1 ]; then
+		# online all non-boot CPUs
+		for_each_non_boot_cpu online_cpu
+		printf "\n"
+	fi
+
+	# run basic tests
+	cpufreq_basic_tests
+
+	# remove module
+	printf "Removing $1 module\n\n"
+	rmmod $1
+	if [ $? != 0 ]; then
+		printf "rmmod $1 failed\n"
+		return;
+	fi
+
+	# There shouldn't be any cpufreq directories now.
+	for_each_cpu cpu_should_not_have_cpufreq_directory
+	printf "\n"
+}
+
+# $1: cpufreq-driver module to insert
+module_driver_test()
+{
+	printf "** Test: Running ${FUNCNAME[0]} **\n\n"
+
+	# check if module is present or not
+	ls $1 > /dev/null
+	if [ $? != 0 ]; then
+		printf "$1: not present in `pwd` folder\n"
+		return;
+	fi
+
+	# test basic module tests
+	test_basic_insmod_rmmod $1
+
+	# Do simple module test
+	module_driver_test_single $1 0
+
+	# Remove CPUs before inserting module and then bring them back
+	module_driver_test_single $1 1
+	printf "\n"
+}
+
+# find governor name based on governor module name
+# $1: governor module name
+find_gov_name()
+{
+	if [ $1 = "cpufreq_ondemand.ko" ]; then
+		printf "ondemand"
+	elif [ $1 = "cpufreq_conservative.ko" ]; then
+		printf "conservative"
+	elif [ $1 = "cpufreq_userspace.ko" ]; then
+		printf "userspace"
+	elif [ $1 = "cpufreq_performance.ko" ]; then
+		printf "performance"
+	elif [ $1 = "cpufreq_powersave.ko" ]; then
+		printf "powersave"
+	elif [ $1 = "cpufreq_schedutil.ko" ]; then
+		printf "schedutil"
+	fi
+}
+
+# $1: governor string, $2: governor module, $3: policy
+# example: module_governor_test_single "ondemand" "cpufreq_ondemand.ko" 2
+module_governor_test_single()
+{
+	printf "** Test: Running ${FUNCNAME[0]} for $3 **\n\n"
+
+	backup_governor $3
+
+	# switch to new governor
+	printf "Switch from $CUR_GOV to $1\n"
+	switch_show_governor $3 $1
+
+	# try removing module, it should fail as governor is used
+	printf "Removing $2 module\n\n"
+	rmmod $2
+	if [ $? = 0 ]; then
+		printf "WARN: rmmod $2 succeeded even if governor is used\n"
+		insmod $2
+	else
+		printf "Pass: unable to remove $2 while it is being used\n\n"
+	fi
+
+	# switch back to old governor
+	printf "Switchback to $CUR_GOV from $1\n"
+	restore_governor $3
+	printf "\n"
+}
+
+# Insert cpufreq governor module and perform basic tests
+# $1: cpufreq-governor module to insert
+module_governor_test()
+{
+	printf "** Test: Running ${FUNCNAME[0]} **\n\n"
+
+	# check if module is present or not
+	ls $1 > /dev/null
+	if [ $? != 0 ]; then
+		printf "$1: not present in `pwd` folder\n"
+		return;
+	fi
+
+	# test basic module tests
+	test_basic_insmod_rmmod $1
+
+	# insert module
+	printf "Inserting $1 module\n\n"
+	insmod $1
+	if [ $? != 0 ]; then
+		printf "Insmod $1 failed\n"
+		return;
+	fi
+
+	# switch to new governor for each cpu
+	for_each_policy module_governor_test_single $(find_gov_name $1) $1
+
+	# remove module
+	printf "Removing $1 module\n\n"
+	rmmod $1
+	if [ $? != 0 ]; then
+		printf "rmmod $1 failed\n"
+		return;
+	fi
+	printf "\n"
+}
+
+# test modules: driver and governor
+# $1: driver module, $2: governor module
+module_test()
+{
+	printf "** Test: Running ${FUNCNAME[0]} **\n\n"
+
+	# check if modules are present or not
+	ls $1 $2 > /dev/null
+	if [ $? != 0 ]; then
+		printf "$1 or $2: is not present in `pwd` folder\n"
+		return;
+	fi
+
+	# TEST1: Insert gov after driver
+	# insert driver module
+	printf "Inserting $1 module\n\n"
+	insmod $1
+	if [ $? != 0 ]; then
+		printf "Insmod $1 failed\n"
+		return;
+	fi
+
+	# run governor tests
+	module_governor_test $2
+
+	# remove driver module
+	printf "Removing $1 module\n\n"
+	rmmod $1
+	if [ $? != 0 ]; then
+		printf "rmmod $1 failed\n"
+		return;
+	fi
+
+	# TEST2: Insert driver after governor
+	# insert governor module
+	printf "Inserting $2 module\n\n"
+	insmod $2
+	if [ $? != 0 ]; then
+		printf "Insmod $2 failed\n"
+		return;
+	fi
+
+	# run governor tests
+	module_driver_test $1
+
+	# remove driver module
+	printf "Removing $2 module\n\n"
+	rmmod $2
+	if [ $? != 0 ]; then
+		printf "rmmod $2 failed\n"
+		return;
+	fi
+}
-- 
2.7.1.410.g6faf27b

