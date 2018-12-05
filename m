From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH] cpupower : Auto-completion for cpupower tool
Date: Wed,  5 Dec 2018 17:01:04 +0530
Message-ID: <20181205113104.71319-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.de, linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org
Cc: ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>, Bharath Thodla <bharath.thodla@in.ibm.com>
List-Id: linux-pm@vger.kernel.org

This script adds support for auto-completion for cpupower tool.
Added support for auto-completion of all the eight commands for
cpupower tool and their all subsequent sub-commands, wherever
possible.

A sample output after applying this script -

root@ubuntu:~# cpupower f<TAB>
root@ubuntu:~# cpupower frequency-<TAB>
frequency-info  frequency-set
root@ubuntu:~# cpupower frequency-set -
-d          --freq      --governor  --min       --related
-f          -g          --max       -r          -u
root@ubuntu:~# cpupower frequency-set -g <TAB>
conservative ondemand performance powersave schedutil userspace
root@ubuntu:~# cpupower frequency-set -f <TAB>
2061000  2194000  2327000  2460000  2593000  2726000  2859000
2094000  2227000  2360000  2493000  2626000  2759000  2892000
2128000  2261000  2394000  2527000  2660000  2793000  2926000
2161000  2294000  2427000  2560000  2693000  2826000  2959000
root@ubuntu:~# cpupower frequency-set -f 206<TAB>
root@ubuntu:~# cpupower frequency-set -f 2061000

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Signed-off-by: Bharath Thodla <bharath.thodla@in.ibm.com>
Tested-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/Makefile               |   6 +-
 tools/power/cpupower/cpupower-completion.sh | 128 ++++++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 tools/power/cpupower/cpupower-completion.sh

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 1dd5f4fcf..8c3adac6b 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -89,6 +89,7 @@ endif
 localedir ?=	/usr/share/locale
 docdir ?=       /usr/share/doc/packages/cpupower
 confdir ?=      /etc/
+bash_completion_dir ?= /usr/share/bash-completion/completions
 
 # Toolchain: what tools do we use, and what options do they need:
 
@@ -96,7 +97,8 @@ CP = cp -fpR
 INSTALL = /usr/bin/install -c
 INSTALL_PROGRAM = ${INSTALL}
 INSTALL_DATA  = ${INSTALL} -m 644
-INSTALL_SCRIPT = ${INSTALL_PROGRAM}
+#bash completion scripts get sourced and so they should be rw only.
+INSTALL_SCRIPT = ${INSTALL} -m 644
 
 # If you are running a cross compiler, you may want to set this
 # to something more interesting, like "arm-linux-".  If you want
@@ -288,6 +290,8 @@ install-lib:
 install-tools:
 	$(INSTALL) -d $(DESTDIR)${bindir}
 	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
+	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
+	$(INSTALL_SCRIPT) cpupower-completion.sh '$(DESTDIR)${bash_completion_dir}/cpupower'
 
 install-man:
 	$(INSTALL_DATA) -D man/cpupower.1 $(DESTDIR)${mandir}/man1/cpupower.1
diff --git a/tools/power/cpupower/cpupower-completion.sh b/tools/power/cpupower/cpupower-completion.sh
new file mode 100644
index 000000000..e10839cfc
--- /dev/null
+++ b/tools/power/cpupower/cpupower-completion.sh
@@ -0,0 +1,128 @@
+# -*- shell-script -*-
+# bash completion script for cpupower
+# Taken from git.git's completion script.
+
+_cpupower_commands="frequency-info frequency-set idle-info idle-set set info monitor"
+
+_frequency_info ()
+{
+	local flags="-f -w -l -d -p -g -a -s -y -o -m -n --freq --hwfreq --hwlimits --driver --policy --governors --related-cpus --affected-cpus --stats --latency --proc --human --no-rounding"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		frequency-info) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_frequency_set ()
+{
+	local flags="-f -g --freq --governor -d --min -u --max -r --related"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		-f| --freq | -d | --min | -u | --max)
+		if [ -d /sys/devices/system/cpu/cpufreq/ ] ; then
+			COMPREPLY=($(compgen -W '$(cat $(ls -d /sys/devices/system/cpu/cpufreq/policy* | head -1)/scaling_available_frequencies)' -- "$cur"))
+		fi ;;
+		-g| --governor)
+		if [ -d /sys/devices/system/cpu/cpufreq/ ] ; then
+			COMPREPLY=($(compgen -W '$(cat $(ls -d /sys/devices/system/cpu/cpufreq/policy* | head -1)/scaling_available_governors)' -- "$cur"))
+		fi;;
+		frequency-set) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_idle_info()
+{
+	local flags="-f --silent"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		idle-info) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_idle_set()
+{
+	local flags="-d --disable -e --enable -D --disable-by-latency -E --enable-all"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		idle-set) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_set()
+{
+	local flags="--perf-bias, -b"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		set) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_monitor()
+{
+	local flags="-l -m -i -c -v"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev" in
+		monitor) COMPREPLY=($(compgen -W "$flags" -- "$cur")) ;;
+	esac
+}
+
+_taskset()
+{
+	local prev_to_prev="${COMP_WORDS[COMP_CWORD-2]}"
+	local prev="${COMP_WORDS[COMP_CWORD-1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$prev_to_prev" in
+		-c|--cpu) COMPREPLY=($(compgen -W "$_cpupower_commands" -- "$cur")) ;;
+	esac
+	case "$prev" in
+		frequency-info) _frequency_info ;;
+		frequency-set) _frequency_set ;;
+		idle-info) _idle_info ;;
+		idle-set) _idle_set ;;
+		set) _set ;;
+		monitor) _monitor ;;
+	esac
+
+}
+
+_cpupower ()
+{
+	local i
+	local c=1
+	local command
+
+	while test $c -lt $COMP_CWORD; do
+		if test $c == 1; then
+			command="${COMP_WORDS[c]}"
+		fi
+		c=$((++c))
+	done
+
+	# Complete name of subcommand if the user has not finished typing it yet.
+	if test $c -eq $COMP_CWORD -a -z "$command"; then
+		COMPREPLY=($(compgen -W "help -v --version -c --cpu $_cpupower_commands" -- "${COMP_WORDS[COMP_CWORD]}"))
+		return
+	fi
+
+	# Complete arguments to subcommands.
+	case "$command" in
+		-v|--version) return ;;
+		-c|--cpu) _taskset ;;
+		help) COMPREPLY=($(compgen -W "$_cpupower_commands" -- "${COMP_WORDS[COMP_CWORD]}")) ;;
+		frequency-info) _frequency_info ;;
+		frequency-set) _frequency_set ;;
+		idle-info) _idle_info ;;
+		idle-set) _idle_set ;;
+		set) _set ;;
+		monitor) _monitor ;;
+	esac
+}
+
+complete -o bashdefault -o default -F _cpupower cpupower 2>/dev/null \
+    || complete -o default -F _cpupower cpupower
-- 
2.17.1
