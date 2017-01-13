From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/4] selftest: cpufreq: Add support for cpufreq tests
Date: Fri, 13 Jan 2017 12:06:45 +0530
Message-ID: <e8b0abde8fec4e92504b633dd3581026e189bca5.1484289212.git.viresh.kumar@linaro.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1484289212.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1484289212.git.viresh.kumar@linaro.org>
References: <cover.1484289212.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Shuah Khan <shuah@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch adds supports for basic cpufreq tests, which can be performed
independent of any platform.

It does basic tests for now, like
- reading all cpufreq files
- trying to update them
- switching frequencies
- switching governors

This can be extended to have more specific tests later on.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 tools/testing/selftests/Makefile            |   1 +
 tools/testing/selftests/cpufreq/Makefile    |   8 ++
 tools/testing/selftests/cpufreq/cpu.sh      |  84 ++++++++++++
 tools/testing/selftests/cpufreq/cpufreq.sh  | 201 ++++++++++++++++++++++++++++
 tools/testing/selftests/cpufreq/governor.sh | 146 ++++++++++++++++++++
 tools/testing/selftests/cpufreq/main.sh     | 128 ++++++++++++++++++
 6 files changed, 568 insertions(+)
 create mode 100644 tools/testing/selftests/cpufreq/Makefile
 create mode 100755 tools/testing/selftests/cpufreq/cpu.sh
 create mode 100755 tools/testing/selftests/cpufreq/cpufreq.sh
 create mode 100755 tools/testing/selftests/cpufreq/governor.sh
 create mode 100755 tools/testing/selftests/cpufreq/main.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 71b05891a6a1..a5a70e06b012 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,6 +1,7 @@
 TARGETS =  bpf
 TARGETS += breakpoints
 TARGETS += capabilities
+TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += efivarfs
 TARGETS += exec
diff --git a/tools/testing/selftests/cpufreq/Makefile b/tools/testing/selftests/cpufreq/Makefile
new file mode 100644
index 000000000000..f5c6bb1965a1
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/Makefile
@@ -0,0 +1,8 @@
+all:
+
+TEST_PROGS := main.sh
+TEST_FILES := cpu.sh cpufreq.sh governor.sh
+
+include ../lib.mk
+
+clean:
diff --git a/tools/testing/selftests/cpufreq/cpu.sh b/tools/testing/selftests/cpufreq/cpu.sh
new file mode 100755
index 000000000000..8e08a83d65f2
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/cpu.sh
@@ -0,0 +1,84 @@
+#!/bin/bash
+#
+# CPU helpers
+
+# protect against multiple inclusion
+if [ $FILE_CPU ]; then
+	return 0
+else
+	FILE_CPU=DONE
+fi
+
+source cpufreq.sh
+
+for_each_cpu()
+{
+	cpus=$(ls $CPUROOT | grep "cpu[0-9].*")
+	for cpu in $cpus; do
+		$@ $cpu
+	done
+}
+
+for_each_non_boot_cpu()
+{
+	cpus=$(ls $CPUROOT | grep "cpu[1-9].*")
+	for cpu in $cpus; do
+		$@ $cpu
+	done
+}
+
+#$1: cpu
+offline_cpu()
+{
+	printf "Offline $1\n"
+	echo 0 > $CPUROOT/$1/online
+}
+
+#$1: cpu
+online_cpu()
+{
+	printf "Online $1\n"
+	echo 1 > $CPUROOT/$1/online
+}
+
+#$1: cpu
+reboot_cpu()
+{
+	offline_cpu $1
+	online_cpu $1
+}
+
+# Reboot CPUs
+# param: number of times we want to run the loop
+reboot_cpus()
+{
+	printf "** Test: Running ${FUNCNAME[0]} for $1 loops **\n\n"
+
+	for i in `seq 1 $1`; do
+		for_each_non_boot_cpu offline_cpu
+		for_each_non_boot_cpu online_cpu
+		printf "\n"
+	done
+
+	printf "\n%s\n\n" "------------------------------------------------"
+}
+
+# Prints warning for all CPUs with missing cpufreq directory
+print_unmanaged_cpus()
+{
+	for_each_cpu cpu_should_have_cpufreq_directory
+}
+
+# Counts CPUs with cpufreq directories
+count_cpufreq_managed_cpus()
+{
+	count=0;
+
+	for cpu in `ls $CPUROOT | grep "cpu[0-9].*"`; do
+		if [ -d $CPUROOT/$cpu/cpufreq ]; then
+			let count=count+1;
+		fi
+	done
+
+	echo $count;
+}
diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
new file mode 100755
index 000000000000..2b8b05aaa874
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/cpufreq.sh
@@ -0,0 +1,201 @@
+#!/bin/bash
+
+# protect against multiple inclusion
+if [ $FILE_CPUFREQ ]; then
+	return 0
+else
+	FILE_CPUFREQ=DONE
+fi
+
+source cpu.sh
+
+
+# $1: cpu
+cpu_should_have_cpufreq_directory()
+{
+	if [ ! -d $CPUROOT/$1/cpufreq ]; then
+		printf "Warning: No cpufreq directory present for $1\n"
+	fi
+}
+
+cpu_should_not_have_cpufreq_directory()
+{
+	if [ -d $CPUROOT/$1/cpufreq ]; then
+		printf "Warning: cpufreq directory present for $1\n"
+	fi
+}
+
+for_each_policy()
+{
+	policies=$(ls $CPUFREQROOT| grep "policy[0-9].*")
+	for policy in $policies; do
+		$@ $policy
+	done
+}
+
+for_each_policy_concurrent()
+{
+	policies=$(ls $CPUFREQROOT| grep "policy[0-9].*")
+	for policy in $policies; do
+		$@ $policy &
+	done
+}
+
+# $1: Path
+read_cpufreq_files_in_dir()
+{
+	local files=`ls $1`
+
+	printf "Printing directory: $1\n\n"
+
+	for file in $files; do
+		if [ -f $1/$file ]; then
+			printf "$file:"
+			cat $1/$file
+		else
+			printf "\n"
+			read_cpufreq_files_in_dir "$1/$file"
+		fi
+	done
+	printf "\n"
+}
+
+
+read_all_cpufreq_files()
+{
+	printf "** Test: Running ${FUNCNAME[0]} **\n\n"
+
+	read_cpufreq_files_in_dir $CPUFREQROOT
+
+	printf "%s\n\n" "------------------------------------------------"
+}
+
+
+# UPDATE CPUFREQ FILES
+
+# $1: directory path
+update_cpufreq_files_in_dir()
+{
+	local files=`ls $1`
+
+	printf "Updating directory: $1\n\n"
+
+	for file in $files; do
+		if [ -f $1/$file ]; then
+			# file is writable ?
+			local wfile=$(ls -l $1/$file | awk '$1 ~ /^.*w.*/ { print $NF; }')
+
+			if [ ! -z $wfile ]; then
+				# scaling_setspeed is a special file and we
+				# should skip updating it
+				if [ $file != "scaling_setspeed" ]; then
+					local val=$(cat $1/$file)
+					printf "Writing $val to: $file\n"
+					echo $val > $1/$file
+				fi
+			fi
+		else
+			printf "\n"
+			update_cpufreq_files_in_dir "$1/$file"
+		fi
+	done
+
+	printf "\n"
+}
+
+# Update all writable files with their existing values
+update_all_cpufreq_files()
+{
+	printf "** Test: Running ${FUNCNAME[0]} **\n\n"
+
+	update_cpufreq_files_in_dir $CPUFREQROOT
+
+	printf "%s\n\n" "------------------------------------------------"
+}
+
+
+# CHANGE CPU FREQUENCIES
+
+# $1: policy
+find_current_freq()
+{
+	cat $CPUFREQROOT/$1/scaling_cur_freq
+}
+
+# $1: policy
+# $2: frequency
+set_cpu_frequency()
+{
+	printf "Change frequency for $1 to $2\n"
+	echo $2 > $CPUFREQROOT/$1/scaling_setspeed
+}
+
+# $1: policy
+test_all_frequencies()
+{
+	local filepath="$CPUFREQROOT/$1"
+
+	backup_governor $1
+
+	local found=$(switch_governor $1 "userspace")
+	if [ $found = 1 ]; then
+		printf "${FUNCNAME[0]}: userspace governor not available for: $1\n"
+		return;
+	fi
+
+	printf "Switched governor for $1 to userspace\n\n"
+
+	local freqs=$(cat $filepath/scaling_available_frequencies)
+	printf "Available frequencies for $1: $freqs\n\n"
+
+	# Set all frequencies one-by-one
+	for freq in $freqs; do
+		set_cpu_frequency $1 $freq
+	done
+
+	printf "\n"
+
+	restore_governor $1
+}
+
+# $1: loop count
+shuffle_frequency_for_all_cpus()
+{
+	printf "** Test: Running ${FUNCNAME[0]} for $1 loops **\n\n"
+
+	for i in `seq 1 $1`; do
+		for_each_policy test_all_frequencies
+	done
+	printf "\n%s\n\n" "------------------------------------------------"
+}
+
+# Basic cpufreq tests
+cpufreq_basic_tests()
+{
+	printf "*** RUNNING CPUFREQ SANITY TESTS ***\n"
+	printf "====================================\n\n"
+
+	count=$(count_cpufreq_managed_cpus)
+	if [ $count = 0 ]; then
+		printf "No cpu is managed by cpufreq core, exiting\n"
+		exit;
+	else
+		printf "CPUFreq manages: $count CPUs\n\n"
+	fi
+
+	# Detect & print which CPUs are not managed by cpufreq
+	print_unmanaged_cpus
+
+	# read/update all cpufreq files
+	read_all_cpufreq_files
+	update_all_cpufreq_files
+
+	# hotplug cpus
+	reboot_cpus 5
+
+	# Test all frequencies
+	shuffle_frequency_for_all_cpus 2
+
+	# Test all governors
+	shuffle_governors_for_all_cpus 1
+}
diff --git a/tools/testing/selftests/cpufreq/governor.sh b/tools/testing/selftests/cpufreq/governor.sh
new file mode 100755
index 000000000000..2e42432892ab
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/governor.sh
@@ -0,0 +1,146 @@
+#!/bin/bash
+#
+# Test governors
+
+# protect against multiple inclusion
+if [ $FILE_GOVERNOR ]; then
+	return 0
+else
+	FILE_GOVERNOR=DONE
+fi
+
+source cpu.sh
+source cpufreq.sh
+
+CUR_GOV=
+CUR_FREQ=
+
+# Find governor's directory path
+# $1: policy, $2: governor
+find_gov_directory()
+{
+	if [ -d $CPUFREQROOT/$2 ]; then
+		printf "$CPUFREQROOT/$2\n"
+	elif [ -d $CPUFREQROOT/$1/$2 ]; then
+		printf "$CPUFREQROOT/$1/$2\n"
+	else
+		printf "INVALID\n"
+	fi
+}
+
+# $1: policy
+find_current_governor()
+{
+	cat $CPUFREQROOT/$1/scaling_governor
+}
+
+# $1: policy
+backup_governor()
+{
+	CUR_GOV=$(find_current_governor $1)
+
+	printf "Governor backup done for $1: $CUR_GOV\n"
+
+	if [ $CUR_GOV == "userspace" ]; then
+		CUR_FREQ=$(find_current_freq $1)
+		printf "Governor frequency backup done for $1: $CUR_FREQ\n"
+	fi
+
+	printf "\n"
+}
+
+# $1: policy
+restore_governor()
+{
+	__switch_governor $1 $CUR_GOV
+
+	printf "Governor restored for $1 to $CUR_GOV\n"
+
+	if [ $CUR_GOV == "userspace" ]; then
+		set_cpu_frequency $1 $CUR_FREQ
+		printf "Governor frequency restored for $1: $CUR_FREQ\n"
+	fi
+
+	printf "\n"
+}
+
+# param:
+# $1: policy, $2: governor
+__switch_governor()
+{
+	echo $2 > $CPUFREQROOT/$1/scaling_governor
+}
+
+# SWITCH GOVERNORS
+
+# $1: cpu, $2: governor
+switch_governor()
+{
+	local filepath=$CPUFREQROOT/$1/scaling_available_governors
+
+	# check if governor is available
+	local found=$(cat $filepath | grep $2 | wc -l)
+	if [ $found = 0 ]; then
+		echo 1;
+		return
+	fi
+
+	__switch_governor $1 $2
+	echo 0;
+}
+
+# $1: policy, $2: governor
+switch_show_governor()
+{
+	cur_gov=find_current_governor
+	if [ $cur_gov == "userspace" ]; then
+		cur_freq=find_current_freq
+	fi
+
+	# switch governor
+	__switch_governor $1 $2
+
+	printf "\nSwitched governor for $1 to $2\n\n"
+
+	if [ $2 == "userspace" -o $2 == "powersave" -o $2 == "performance" ]; then
+		printf "No files to read for $2 governor\n\n"
+		return
+	fi
+
+	# show governor files
+	local govpath=$(find_gov_directory $1 $2)
+	read_cpufreq_files_in_dir $govpath
+}
+
+# $1: function to be called, $2: policy
+call_for_each_governor()
+{
+	local filepath=$CPUFREQROOT/$2/scaling_available_governors
+
+	# Exit if cpu isn't managed by cpufreq core
+	if [ ! -f $filepath ]; then
+		return;
+	fi
+
+	backup_governor $2
+
+	local governors=$(cat $filepath)
+	printf "Available governors for $2: $governors\n"
+
+	for governor in $governors; do
+		$1 $2 $governor
+	done
+
+	restore_governor $2
+}
+
+# $1: loop count
+shuffle_governors_for_all_cpus()
+{
+	printf "** Test: Running ${FUNCNAME[0]} for $1 loops **\n\n"
+
+	for i in `seq 1 $1`; do
+		for_each_policy call_for_each_governor switch_show_governor
+	done
+	printf "%s\n\n" "------------------------------------------------"
+}
diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
new file mode 100755
index 000000000000..3224652ccbd4
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/main.sh
@@ -0,0 +1,128 @@
+#!/bin/bash
+
+source cpu.sh
+source cpufreq.sh
+source governor.sh
+
+FUNC=basic	# do basic tests by default
+OUTFILE=cpufreq_selftest
+SYSFS=
+CPUROOT=
+CPUFREQROOT=
+
+helpme()
+{
+	printf "Usage: $0 [-h] [-to args]
+	[-h <help>]
+	[-o <output-file-for-dump>]
+	[-t <basic: Basic cpufreq testing>]
+	\n"
+	exit 2
+}
+
+prerequisite()
+{
+	msg="skip all tests:"
+
+	if [ $UID != 0 ]; then
+		echo $msg must be run as root >&2
+		exit 2
+	fi
+
+	taskset -p 01 $$
+
+	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
+
+	if [ ! -d "$SYSFS" ]; then
+		echo $msg sysfs is not mounted >&2
+		exit 2
+	fi
+
+	CPUROOT=$SYSFS/devices/system/cpu
+	CPUFREQROOT="$CPUROOT/cpufreq"
+
+	if ! ls $CPUROOT/cpu* > /dev/null 2>&1; then
+		echo $msg cpus not available in sysfs >&2
+		exit 2
+	fi
+
+	if ! ls $CPUROOT/cpufreq > /dev/null 2>&1; then
+		echo $msg cpufreq directory not available in sysfs >&2
+		exit 2
+	fi
+}
+
+parse_arguments()
+{
+	while getopts ht:o: arg
+	do
+		case $arg in
+			h) # --help
+				helpme
+				;;
+
+			t) # --func_type (Function to perform: basic (default: basic))
+				FUNC=$OPTARG
+				;;
+
+			o) # --output-file (Output file to store dumps)
+				OUTFILE=$OPTARG
+				;;
+
+			\?)
+				helpme
+				;;
+		esac
+	done
+}
+
+do_test()
+{
+	# Check if CPUs are managed by cpufreq or not
+	count=$(count_cpufreq_managed_cpus)
+
+	if [ $count = 0 ]; then
+		echo "No cpu is managed by cpufreq core, exiting"
+		exit 2;
+	fi
+
+	case "$FUNC" in
+		"basic")
+		cpufreq_basic_tests
+		;;
+
+		*)
+		echo "Invalid [-f] function type"
+		helpme
+		;;
+	esac
+}
+
+# clear dumps
+# $1: file name
+clear_dumps()
+{
+	echo "" > $1.txt
+	echo "" > $1.dmesg_cpufreq.txt
+	echo "" > $1.dmesg_full.txt
+}
+
+# $1: output file name
+dmesg_dumps()
+{
+	dmesg | grep cpufreq >> $1.dmesg_cpufreq.txt
+
+	# We may need the full logs as well
+	dmesg >> $1.dmesg_full.txt
+}
+
+# Parse arguments
+parse_arguments $@
+
+# Make sure all requirements are met
+prerequisite
+
+# Run requested functions
+clear_dumps $OUTFILE
+do_test >> $OUTFILE.txt
+dmesg_dumps $OUTFILE
-- 
2.7.1.410.g6faf27b
