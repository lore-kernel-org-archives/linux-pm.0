From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/4] selftest: cpufreq: Add special tests
Date: Fri, 13 Jan 2017 12:06:48 +0530
Message-ID: <618cbb8e2bc2d17bacc3c1989823e6815888eafb.1484289212.git.viresh.kumar@linaro.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1484289212.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1484289212.git.viresh.kumar@linaro.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Shuah Khan <shuah@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch adds support for special tests which were reported on the PM
list over the years, which helped catching core bugs by several
developers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 tools/testing/selftests/cpufreq/Makefile         |   2 +-
 tools/testing/selftests/cpufreq/governor.sh      |   7 ++
 tools/testing/selftests/cpufreq/main.sh          |  25 ++++-
 tools/testing/selftests/cpufreq/special-tests.sh | 115 +++++++++++++++++++++++
 4 files changed, 146 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/cpufreq/special-tests.sh

diff --git a/tools/testing/selftests/cpufreq/Makefile b/tools/testing/selftests/cpufreq/Makefile
index 80c8727dcec1..3955cd96f3a2 100644
--- a/tools/testing/selftests/cpufreq/Makefile
+++ b/tools/testing/selftests/cpufreq/Makefile
@@ -1,7 +1,7 @@
 all:
 
 TEST_PROGS := main.sh
-TEST_FILES := cpu.sh cpufreq.sh governor.sh module.sh
+TEST_FILES := cpu.sh cpufreq.sh governor.sh module.sh special-tests.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/cpufreq/governor.sh b/tools/testing/selftests/cpufreq/governor.sh
index 2e42432892ab..def645103555 100755
--- a/tools/testing/selftests/cpufreq/governor.sh
+++ b/tools/testing/selftests/cpufreq/governor.sh
@@ -71,6 +71,13 @@ __switch_governor()
 	echo $2 > $CPUFREQROOT/$1/scaling_governor
 }
 
+# param:
+# $1: cpu, $2: governor
+__switch_governor_for_cpu()
+{
+	echo $2 > $CPUROOT/$1/cpufreq/scaling_governor
+}
+
 # SWITCH GOVERNORS
 
 # $1: cpu, $2: governor
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
index 2515867ac9de..01bac76ac0ec 100755
--- a/tools/testing/selftests/cpufreq/main.sh
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -4,6 +4,7 @@ source cpu.sh
 source cpufreq.sh
 source governor.sh
 source module.sh
+source special-tests.sh
 
 FUNC=basic	# do basic tests by default
 OUTFILE=cpufreq_selftest
@@ -19,7 +20,11 @@ helpme()
 	[-t <basic: Basic cpufreq testing
 	     suspend: suspend/resume,
 	     hibernate: hibernate/resume,
-	     modtest: test driver or governor modules. Only to be used with -d or -g options>]
+	     modtest: test driver or governor modules. Only to be used with -d or -g options,
+	     sptest1: Simple governor switch to produce lockdep.
+	     sptest2: Concurrent governor switch to produce lockdep.
+	     sptest3: Governor races, shuffle between governors quickly.
+	     sptest4: CPU hotplugs with updates to cpufreq files.>]
 	[-d <driver's module name: only with \"-t modtest>\"]
 	[-g <governor's module name: only with \"-t modtest>\"]
 	\n"
@@ -67,7 +72,7 @@ parse_arguments()
 				helpme
 				;;
 
-			t) # --func_type (Function to perform: basic, suspend, hibernate, modtest (default: basic))
+			t) # --func_type (Function to perform: basic, suspend, hibernate, modtest, sptest1/2/3/4 (default: basic))
 				FUNC=$OPTARG
 				;;
 
@@ -136,6 +141,22 @@ do_test()
 		fi
 		;;
 
+		"sptest1")
+		simple_lockdep
+		;;
+
+		"sptest2")
+		concurrent_lockdep
+		;;
+
+		"sptest3")
+		governor_race
+		;;
+
+		"sptest4")
+		hotplug_with_updates
+		;;
+
 		*)
 		echo "Invalid [-f] function type"
 		helpme
diff --git a/tools/testing/selftests/cpufreq/special-tests.sh b/tools/testing/selftests/cpufreq/special-tests.sh
new file mode 100755
index 000000000000..58b730f23ef7
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/special-tests.sh
@@ -0,0 +1,115 @@
+#!/bin/bash
+#
+# Special test cases reported by people
+
+# Testcase 1: Reported here: http://marc.info/?l=linux-pm&m=140618592709858&w=2
+
+# protect against multiple inclusion
+if [ $FILE_SPECIAL ]; then
+	return 0
+else
+	FILE_SPECIAL=DONE
+fi
+
+source cpu.sh
+source cpufreq.sh
+source governor.sh
+
+# Test 1
+# $1: policy
+__simple_lockdep()
+{
+	# switch to ondemand
+	__switch_governor $1 "ondemand"
+
+	# cat ondemand files
+	local ondir=$(find_gov_directory $1 "ondemand")
+	if [ -z $ondir ]; then
+		printf "${FUNCNAME[0]}Ondemand directory not created, quit"
+		return
+	fi
+
+	cat $ondir/*
+
+	# switch to conservative
+	__switch_governor $1 "conservative"
+}
+
+simple_lockdep()
+{
+	printf "** Test: Running ${FUNCNAME[0]} **\n"
+
+	for_each_policy __simple_lockdep
+}
+
+# Test 2
+# $1: policy
+__concurrent_lockdep()
+{
+	for i in `seq 0 100`; do
+		__simple_lockdep $1
+	done
+}
+
+concurrent_lockdep()
+{
+	printf "** Test: Running ${FUNCNAME[0]} **\n"
+
+	for_each_policy_concurrent __concurrent_lockdep
+}
+
+# Test 3
+quick_shuffle()
+{
+	# this is called concurrently from governor_race
+	for I in `seq 1000`
+	do
+		echo ondemand | sudo tee $CPUFREQROOT/policy*/scaling_governor &
+		echo userspace | sudo tee $CPUFREQROOT/policy*/scaling_governor &
+	done
+}
+
+governor_race()
+{
+	printf "** Test: Running ${FUNCNAME[0]} **\n"
+
+	# run 8 concurrent instances
+	for I in `seq 8`
+	do
+		quick_shuffle &
+	done
+}
+
+# Test 4
+# $1: cpu
+hotplug_with_updates_cpu()
+{
+	local filepath="$CPUROOT/$1/cpufreq"
+
+	# switch to ondemand
+	__switch_governor_for_cpu $1 "ondemand"
+
+	for i in `seq 1 5000`
+	do
+		reboot_cpu $1
+	done &
+
+	local freqs=$(cat $filepath/scaling_available_frequencies)
+	local oldfreq=$(cat $filepath/scaling_min_freq)
+
+	for j in `seq 1 5000`
+	do
+		# Set all frequencies one-by-one
+		for freq in $freqs; do
+			echo $freq > $filepath/scaling_min_freq
+		done
+	done
+
+	# restore old freq
+	echo $oldfreq > $filepath/scaling_min_freq
+}
+
+hotplug_with_updates()
+{
+	for_each_non_boot_cpu hotplug_with_updates_cpu
+}
-- 
2.7.1.410.g6faf27b
