From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/1] cpupower: Add cpuidle parts into library
Date: Mon, 25 Apr 2016 16:34:02 +0200
Message-ID: <3109572.conPodfd62@skinner>
References: <1685056.NeGEfvDZMv@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46363 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754896AbcDYOeF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Apr 2016 10:34:05 -0400
In-Reply-To: <1685056.NeGEfvDZMv@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

This more or less is a renaming and moving of functions and should not
introduce any functional change.

cpupower was built from cpufrequtils (which had a C library providing easy
access to cpu frequency platform info). In the meantime it got enhanced
by quite some neat cpuidle userspace tools.

Now the cpu idle functions have been separated and added to the cpupower.so
library.
So beside an already existing public header file:
cpufreq.h
cpupower now also exports these cpu idle functions in:
cpuidle.h 

Here again pasted for better review of the interfaces: 

======================================
int cpuidle_is_state_disabled(unsigned int cpu,
                                       unsigned int idlestate);
int cpuidle_state_disable(unsigned int cpu, unsigned int idlestate,
                                   unsigned int disable);
unsigned long cpuidle_state_latency(unsigned int cpu,
                                                unsigned int idlestate);
unsigned long cpuidle_state_usage(unsigned int cpu,
                                        unsigned int idlestate);
unsigned long long cpuidle_state_time(unsigned int cpu,
                                                unsigned int idlestate);
char *cpuidle_state_name(unsigned int cpu,
                                unsigned int idlestate);
char *cpuidle_state_desc(unsigned int cpu,
                                unsigned int idlestate);
unsigned int cpuidle_state_count(unsigned int cpu);

char *cpuidle_get_governor(void);
char *cpuidle_get_driver(void);

======================================


Signed-off-by: Thomas Renninger <trenn@suse.com>

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 2e2ba2e..1ca525d 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -58,7 +58,7 @@ DESTDIR ?=
 # and _should_ modify the PACKAGE_BUGREPORT definition
 
 VERSION=			$(shell ./utils/version-gen.sh)
-LIB_MAJ=			0.0.0
+LIB_MAJ=			0.0.1
 LIB_MIN=			0
 
 PACKAGE =			cpupower
@@ -124,7 +124,7 @@ WARNINGS += -Wshadow
 CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
 		-DPACKAGE_BUGREPORT=\"$(PACKAGE_BUGREPORT)\" -D_GNU_SOURCE
 
-UTIL_OBJS =  utils/helpers/amd.o utils/helpers/topology.o utils/helpers/msr.o \
+UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
 	utils/helpers/sysfs.o utils/helpers/misc.o utils/helpers/cpuid.o \
 	utils/helpers/pci.o utils/helpers/bitmask.o \
 	utils/idle_monitor/nhm_idle.o utils/idle_monitor/snb_idle.o \
@@ -143,9 +143,9 @@ UTIL_HEADERS = utils/helpers/helpers.h utils/idle_monitor/cpupower-monitor.h \
 	utils/helpers/bitmask.h \
 	utils/idle_monitor/idle_monitors.h utils/idle_monitor/idle_monitors.def
 
-LIB_HEADERS = 	lib/cpufreq.h lib/sysfs.h
-LIB_SRC = 	lib/cpufreq.c lib/sysfs.c
-LIB_OBJS = 	lib/cpufreq.o lib/sysfs.o
+LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h
+LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c
+LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o
 LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
 
 CFLAGS +=	-pipe
@@ -265,6 +265,7 @@ install-lib:
 	$(CP) $(OUTPUT)libcpupower.so* $(DESTDIR)${libdir}/
 	$(INSTALL) -d $(DESTDIR)${includedir}
 	$(INSTALL_DATA) lib/cpufreq.h $(DESTDIR)${includedir}/cpufreq.h
+	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
 
 install-tools:
 	$(INSTALL) -d $(DESTDIR)${bindir}
@@ -296,6 +297,7 @@ install: all install-lib install-tools install-man $(INSTALL_NLS) $(INSTALL_BENC
 uninstall:
 	- rm -f $(DESTDIR)${libdir}/libcpupower.*
 	- rm -f $(DESTDIR)${includedir}/cpufreq.h
+	- rm -f $(DESTDIR)${includedir}/cpuidle.h
 	- rm -f $(DESTDIR)${bindir}/utils/cpupower
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
index f01e3f4..c25a74a 100644
--- a/tools/power/cpupower/bench/system.c
+++ b/tools/power/cpupower/bench/system.c
@@ -26,6 +26,7 @@
 #include <sched.h>
 
 #include <cpufreq.h>
+#include <cpupower.h>
 
 #include "config.h"
 #include "system.h"
@@ -60,7 +61,7 @@ int set_cpufreq_governor(char *governor, unsigned int cpu)
 
 	dprintf("set %s as cpufreq governor\n", governor);
 
-	if (cpufreq_cpu_exists(cpu) != 0) {
+	if (cpupower_is_cpu_online(cpu) != 0) {
 		perror("cpufreq_cpu_exists");
 		fprintf(stderr, "error: cpu %u does not exist\n", cpu);
 		return -1;
diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index d961101..1b993fe 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -9,28 +9,190 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #include "cpufreq.h"
-#include "sysfs.h"
+#include "cpupower_intern.h"
 
-int cpufreq_cpu_exists(unsigned int cpu)
+/* CPUFREQ sysfs access **************************************************/
+
+/* helper function to read file from /sys into given buffer */
+/* fname is a relative path under "cpuX/cpufreq" dir */
+static unsigned int sysfs_cpufreq_read_file(unsigned int cpu, const char *fname,
+					    char *buf, size_t buflen)
 {
-	return sysfs_cpu_exists(cpu);
+	char path[SYSFS_PATH_MAX];
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpufreq/%s",
+			 cpu, fname);
+	return sysfs_read_file(path, buf, buflen);
 }
 
+/* helper function to write a new value to a /sys file */
+/* fname is a relative path under "cpuX/cpufreq" dir */
+static unsigned int sysfs_cpufreq_write_file(unsigned int cpu,
+					     const char *fname,
+					     const char *value, size_t len)
+{
+	char path[SYSFS_PATH_MAX];
+	int fd;
+	ssize_t numwrite;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpufreq/%s",
+			 cpu, fname);
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		return 0;
+
+	numwrite = write(fd, value, len);
+	if (numwrite < 1) {
+		close(fd);
+		return 0;
+	}
+
+	close(fd);
+
+	return (unsigned int) numwrite;
+}
+
+/* read access to files which contain one numeric value */
+
+enum cpufreq_value {
+	CPUINFO_CUR_FREQ,
+	CPUINFO_MIN_FREQ,
+	CPUINFO_MAX_FREQ,
+	CPUINFO_LATENCY,
+	SCALING_CUR_FREQ,
+	SCALING_MIN_FREQ,
+	SCALING_MAX_FREQ,
+	STATS_NUM_TRANSITIONS,
+	MAX_CPUFREQ_VALUE_READ_FILES
+};
+
+static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
+	[CPUINFO_CUR_FREQ] = "cpuinfo_cur_freq",
+	[CPUINFO_MIN_FREQ] = "cpuinfo_min_freq",
+	[CPUINFO_MAX_FREQ] = "cpuinfo_max_freq",
+	[CPUINFO_LATENCY]  = "cpuinfo_transition_latency",
+	[SCALING_CUR_FREQ] = "scaling_cur_freq",
+	[SCALING_MIN_FREQ] = "scaling_min_freq",
+	[SCALING_MAX_FREQ] = "scaling_max_freq",
+	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
+};
+
+
+static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
+						 enum cpufreq_value which)
+{
+	unsigned long value;
+	unsigned int len;
+	char linebuf[MAX_LINE_LEN];
+	char *endp;
+
+	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
+		return 0;
+
+	len = sysfs_cpufreq_read_file(cpu, cpufreq_value_files[which],
+				linebuf, sizeof(linebuf));
+
+	if (len == 0)
+		return 0;
+
+	value = strtoul(linebuf, &endp, 0);
+
+	if (endp == linebuf || errno == ERANGE)
+		return 0;
+
+	return value;
+}
+
+/* read access to files which contain one string */
+
+enum cpufreq_string {
+	SCALING_DRIVER,
+	SCALING_GOVERNOR,
+	MAX_CPUFREQ_STRING_FILES
+};
+
+static const char *cpufreq_string_files[MAX_CPUFREQ_STRING_FILES] = {
+	[SCALING_DRIVER] = "scaling_driver",
+	[SCALING_GOVERNOR] = "scaling_governor",
+};
+
+
+static char *sysfs_cpufreq_get_one_string(unsigned int cpu,
+					   enum cpufreq_string which)
+{
+	char linebuf[MAX_LINE_LEN];
+	char *result;
+	unsigned int len;
+
+	if (which >= MAX_CPUFREQ_STRING_FILES)
+		return NULL;
+
+	len = sysfs_cpufreq_read_file(cpu, cpufreq_string_files[which],
+				linebuf, sizeof(linebuf));
+	if (len == 0)
+		return NULL;
+
+	result = strdup(linebuf);
+	if (result == NULL)
+		return NULL;
+
+	if (result[strlen(result) - 1] == '\n')
+		result[strlen(result) - 1] = '\0';
+
+	return result;
+}
+
+/* write access */
+
+enum cpufreq_write {
+	WRITE_SCALING_MIN_FREQ,
+	WRITE_SCALING_MAX_FREQ,
+	WRITE_SCALING_GOVERNOR,
+	WRITE_SCALING_SET_SPEED,
+	MAX_CPUFREQ_WRITE_FILES
+};
+
+static const char *cpufreq_write_files[MAX_CPUFREQ_WRITE_FILES] = {
+	[WRITE_SCALING_MIN_FREQ] = "scaling_min_freq",
+	[WRITE_SCALING_MAX_FREQ] = "scaling_max_freq",
+	[WRITE_SCALING_GOVERNOR] = "scaling_governor",
+	[WRITE_SCALING_SET_SPEED] = "scaling_setspeed",
+};
+
+static int sysfs_cpufreq_write_one_value(unsigned int cpu,
+					 enum cpufreq_write which,
+					 const char *new_value, size_t len)
+{
+	if (which >= MAX_CPUFREQ_WRITE_FILES)
+		return 0;
+
+	if (sysfs_cpufreq_write_file(cpu, cpufreq_write_files[which],
+					new_value, len) != len)
+		return -ENODEV;
+
+	return 0;
+};
+
 unsigned long cpufreq_get_freq_kernel(unsigned int cpu)
 {
-	return sysfs_get_freq_kernel(cpu);
+	return sysfs_cpufreq_get_one_value(cpu, SCALING_CUR_FREQ);
 }
 
 unsigned long cpufreq_get_freq_hardware(unsigned int cpu)
 {
-	return sysfs_get_freq_hardware(cpu);
+	return sysfs_cpufreq_get_one_value(cpu, CPUINFO_CUR_FREQ);
 }
 
 unsigned long cpufreq_get_transition_latency(unsigned int cpu)
 {
-	return sysfs_get_freq_transition_latency(cpu);
+	return sysfs_cpufreq_get_one_value(cpu, CPUINFO_LATENCY);
 }
 
 int cpufreq_get_hardware_limits(unsigned int cpu,
@@ -39,12 +201,21 @@ int cpufreq_get_hardware_limits(unsigned int cpu,
 {
 	if ((!min) || (!max))
 		return -EINVAL;
-	return sysfs_get_freq_hardware_limits(cpu, min, max);
+
+	*min = sysfs_cpufreq_get_one_value(cpu, CPUINFO_MIN_FREQ);
+	if (!*min)
+		return -ENODEV;
+
+	*max = sysfs_cpufreq_get_one_value(cpu, CPUINFO_MAX_FREQ);
+	if (!*max)
+		return -ENODEV;
+
+	return 0;
 }
 
 char *cpufreq_get_driver(unsigned int cpu)
 {
-	return sysfs_get_freq_driver(cpu);
+	return sysfs_cpufreq_get_one_string(cpu, SCALING_DRIVER);
 }
 
 void cpufreq_put_driver(char *ptr)
@@ -56,7 +227,26 @@ void cpufreq_put_driver(char *ptr)
 
 struct cpufreq_policy *cpufreq_get_policy(unsigned int cpu)
 {
-	return sysfs_get_freq_policy(cpu);
+	struct cpufreq_policy *policy;
+
+	policy = malloc(sizeof(struct cpufreq_policy));
+	if (!policy)
+		return NULL;
+
+	policy->governor = sysfs_cpufreq_get_one_string(cpu, SCALING_GOVERNOR);
+	if (!policy->governor) {
+		free(policy);
+		return NULL;
+	}
+	policy->min = sysfs_cpufreq_get_one_value(cpu, SCALING_MIN_FREQ);
+	policy->max = sysfs_cpufreq_get_one_value(cpu, SCALING_MAX_FREQ);
+	if ((!policy->min) || (!policy->max)) {
+		free(policy->governor);
+		free(policy);
+		return NULL;
+	}
+
+	return policy;
 }
 
 void cpufreq_put_policy(struct cpufreq_policy *policy)
@@ -72,7 +262,57 @@ void cpufreq_put_policy(struct cpufreq_policy *policy)
 struct cpufreq_available_governors *cpufreq_get_available_governors(unsigned
 								int cpu)
 {
-	return sysfs_get_freq_available_governors(cpu);
+	struct cpufreq_available_governors *first = NULL;
+	struct cpufreq_available_governors *current = NULL;
+	char linebuf[MAX_LINE_LEN];
+	unsigned int pos, i;
+	unsigned int len;
+
+	len = sysfs_cpufreq_read_file(cpu, "scaling_available_governors",
+				linebuf, sizeof(linebuf));
+	if (len == 0)
+		return NULL;
+
+	pos = 0;
+	for (i = 0; i < len; i++) {
+		if (linebuf[i] == ' ' || linebuf[i] == '\n') {
+			if (i - pos < 2)
+				continue;
+			if (current) {
+				current->next = malloc(sizeof(*current));
+				if (!current->next)
+					goto error_out;
+				current = current->next;
+			} else {
+				first = malloc(sizeof(*first));
+				if (!first)
+					goto error_out;
+				current = first;
+			}
+			current->first = first;
+			current->next = NULL;
+
+			current->governor = malloc(i - pos + 1);
+			if (!current->governor)
+				goto error_out;
+
+			memcpy(current->governor, linebuf + pos, i - pos);
+			current->governor[i - pos] = '\0';
+			pos = i + 1;
+		}
+	}
+
+	return first;
+
+ error_out:
+	while (first) {
+		current = first->next;
+		if (first->governor)
+			free(first->governor);
+		free(first);
+		first = current;
+	}
+	return NULL;
 }
 
 void cpufreq_put_available_governors(struct cpufreq_available_governors *any)
@@ -96,7 +336,57 @@ void cpufreq_put_available_governors(struct cpufreq_available_governors *any)
 struct cpufreq_available_frequencies
 *cpufreq_get_available_frequencies(unsigned int cpu)
 {
-	return sysfs_get_available_frequencies(cpu);
+	struct cpufreq_available_frequencies *first = NULL;
+	struct cpufreq_available_frequencies *current = NULL;
+	char one_value[SYSFS_PATH_MAX];
+	char linebuf[MAX_LINE_LEN];
+	unsigned int pos, i;
+	unsigned int len;
+
+	len = sysfs_cpufreq_read_file(cpu, "scaling_available_frequencies",
+				linebuf, sizeof(linebuf));
+	if (len == 0)
+		return NULL;
+
+	pos = 0;
+	for (i = 0; i < len; i++) {
+		if (linebuf[i] == ' ' || linebuf[i] == '\n') {
+			if (i - pos < 2)
+				continue;
+			if (i - pos >= SYSFS_PATH_MAX)
+				goto error_out;
+			if (current) {
+				current->next = malloc(sizeof(*current));
+				if (!current->next)
+					goto error_out;
+				current = current->next;
+			} else {
+				first = malloc(sizeof(*first));
+				if (!first)
+					goto error_out;
+				current = first;
+			}
+			current->first = first;
+			current->next = NULL;
+
+			memcpy(one_value, linebuf + pos, i - pos);
+			one_value[i - pos] = '\0';
+			if (sscanf(one_value, "%lu", &current->frequency) != 1)
+				goto error_out;
+
+			pos = i + 1;
+		}
+	}
+
+	return first;
+
+ error_out:
+	while (first) {
+		current = first->next;
+		free(first);
+		first = current;
+	}
+	return NULL;
 }
 
 void cpufreq_put_available_frequencies(struct cpufreq_available_frequencies
@@ -114,10 +404,65 @@ void cpufreq_put_available_frequencies(struct cpufreq_available_frequencies
 	}
 }
 
+static struct cpufreq_affected_cpus *sysfs_get_cpu_list(unsigned int cpu,
+							const char *file)
+{
+	struct cpufreq_affected_cpus *first = NULL;
+	struct cpufreq_affected_cpus *current = NULL;
+	char one_value[SYSFS_PATH_MAX];
+	char linebuf[MAX_LINE_LEN];
+	unsigned int pos, i;
+	unsigned int len;
+
+	len = sysfs_cpufreq_read_file(cpu, file, linebuf, sizeof(linebuf));
+	if (len == 0)
+		return NULL;
+
+	pos = 0;
+	for (i = 0; i < len; i++) {
+		if (i == len || linebuf[i] == ' ' || linebuf[i] == '\n') {
+			if (i - pos  < 1)
+				continue;
+			if (i - pos >= SYSFS_PATH_MAX)
+				goto error_out;
+			if (current) {
+				current->next = malloc(sizeof(*current));
+				if (!current->next)
+					goto error_out;
+				current = current->next;
+			} else {
+				first = malloc(sizeof(*first));
+				if (!first)
+					goto error_out;
+				current = first;
+			}
+			current->first = first;
+			current->next = NULL;
+
+			memcpy(one_value, linebuf + pos, i - pos);
+			one_value[i - pos] = '\0';
+
+			if (sscanf(one_value, "%u", &current->cpu) != 1)
+				goto error_out;
+
+			pos = i + 1;
+		}
+	}
+
+	return first;
+
+ error_out:
+	while (first) {
+		current = first->next;
+		free(first);
+		first = current;
+	}
+	return NULL;
+}
 
 struct cpufreq_affected_cpus *cpufreq_get_affected_cpus(unsigned int cpu)
 {
-	return sysfs_get_freq_affected_cpus(cpu);
+	return sysfs_get_cpu_list(cpu, "affected_cpus");
 }
 
 void cpufreq_put_affected_cpus(struct cpufreq_affected_cpus *any)
@@ -138,7 +483,7 @@ void cpufreq_put_affected_cpus(struct cpufreq_affected_cpus *any)
 
 struct cpufreq_affected_cpus *cpufreq_get_related_cpus(unsigned int cpu)
 {
-	return sysfs_get_freq_related_cpus(cpu);
+	return sysfs_get_cpu_list(cpu, "related_cpus");
 }
 
 void cpufreq_put_related_cpus(struct cpufreq_affected_cpus *any)
@@ -146,45 +491,208 @@ void cpufreq_put_related_cpus(struct cpufreq_affected_cpus *any)
 	cpufreq_put_affected_cpus(any);
 }
 
+static int verify_gov(char *new_gov, char *passed_gov)
+{
+	unsigned int i, j = 0;
+
+	if (!passed_gov || (strlen(passed_gov) > 19))
+		return -EINVAL;
+
+	strncpy(new_gov, passed_gov, 20);
+	for (i = 0; i < 20; i++) {
+		if (j) {
+			new_gov[i] = '\0';
+			continue;
+		}
+		if ((new_gov[i] >= 'a') && (new_gov[i] <= 'z'))
+			continue;
+
+		if ((new_gov[i] >= 'A') && (new_gov[i] <= 'Z'))
+			continue;
+
+		if (new_gov[i] == '-')
+			continue;
+
+		if (new_gov[i] == '_')
+			continue;
+
+		if (new_gov[i] == '\0') {
+			j = 1;
+			continue;
+		}
+		return -EINVAL;
+	}
+	new_gov[19] = '\0';
+	return 0;
+}
 
 int cpufreq_set_policy(unsigned int cpu, struct cpufreq_policy *policy)
 {
+	char min[SYSFS_PATH_MAX];
+	char max[SYSFS_PATH_MAX];
+	char gov[SYSFS_PATH_MAX];
+	int ret;
+	unsigned long old_min;
+	int write_max_first;
+
 	if (!policy || !(policy->governor))
 		return -EINVAL;
 
-	return sysfs_set_freq_policy(cpu, policy);
+	if (policy->max < policy->min)
+		return -EINVAL;
+
+	if (verify_gov(gov, policy->governor))
+		return -EINVAL;
+
+	snprintf(min, SYSFS_PATH_MAX, "%lu", policy->min);
+	snprintf(max, SYSFS_PATH_MAX, "%lu", policy->max);
+
+	old_min = sysfs_cpufreq_get_one_value(cpu, SCALING_MIN_FREQ);
+	write_max_first = (old_min && (policy->max < old_min) ? 0 : 1);
+
+	if (write_max_first) {
+		ret = sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MAX_FREQ,
+						    max, strlen(max));
+		if (ret)
+			return ret;
+	}
+
+	ret = sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MIN_FREQ, min,
+					    strlen(min));
+	if (ret)
+		return ret;
+
+	if (!write_max_first) {
+		ret = sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MAX_FREQ,
+						    max, strlen(max));
+		if (ret)
+			return ret;
+	}
+
+	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_GOVERNOR,
+					     gov, strlen(gov));
 }
 
 
 int cpufreq_modify_policy_min(unsigned int cpu, unsigned long min_freq)
 {
-	return sysfs_modify_freq_policy_min(cpu, min_freq);
+	char value[SYSFS_PATH_MAX];
+
+	snprintf(value, SYSFS_PATH_MAX, "%lu", min_freq);
+
+	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MIN_FREQ,
+					     value, strlen(value));
 }
 
 
 int cpufreq_modify_policy_max(unsigned int cpu, unsigned long max_freq)
 {
-	return sysfs_modify_freq_policy_max(cpu, max_freq);
-}
+	char value[SYSFS_PATH_MAX];
+
+	snprintf(value, SYSFS_PATH_MAX, "%lu", max_freq);
 
+	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MAX_FREQ,
+					     value, strlen(value));
+}
 
 int cpufreq_modify_policy_governor(unsigned int cpu, char *governor)
 {
+	char new_gov[SYSFS_PATH_MAX];
+
 	if ((!governor) || (strlen(governor) > 19))
 		return -EINVAL;
 
-	return sysfs_modify_freq_policy_governor(cpu, governor);
+	if (verify_gov(new_gov, governor))
+		return -EINVAL;
+
+	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_GOVERNOR,
+					     new_gov, strlen(new_gov));
 }
 
 int cpufreq_set_frequency(unsigned int cpu, unsigned long target_frequency)
 {
-	return sysfs_set_frequency(cpu, target_frequency);
+	struct cpufreq_policy *pol = cpufreq_get_policy(cpu);
+	char userspace_gov[] = "userspace";
+	char freq[SYSFS_PATH_MAX];
+	int ret;
+
+	if (!pol)
+		return -ENODEV;
+
+	if (strncmp(pol->governor, userspace_gov, 9) != 0) {
+		ret = cpufreq_modify_policy_governor(cpu, userspace_gov);
+		if (ret) {
+			cpufreq_put_policy(pol);
+			return ret;
+		}
+	}
+
+	cpufreq_put_policy(pol);
+
+	snprintf(freq, SYSFS_PATH_MAX, "%lu", target_frequency);
+
+	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_SET_SPEED,
+					     freq, strlen(freq));
 }
 
 struct cpufreq_stats *cpufreq_get_stats(unsigned int cpu,
 					unsigned long long *total_time)
 {
-	return sysfs_get_freq_stats(cpu, total_time);
+	struct cpufreq_stats *first = NULL;
+	struct cpufreq_stats *current = NULL;
+	char one_value[SYSFS_PATH_MAX];
+	char linebuf[MAX_LINE_LEN];
+	unsigned int pos, i;
+	unsigned int len;
+
+	len = sysfs_cpufreq_read_file(cpu, "stats/time_in_state",
+				linebuf, sizeof(linebuf));
+	if (len == 0)
+		return NULL;
+
+	*total_time = 0;
+	pos = 0;
+	for (i = 0; i < len; i++) {
+		if (i == strlen(linebuf) || linebuf[i] == '\n')	{
+			if (i - pos < 2)
+				continue;
+			if ((i - pos) >= SYSFS_PATH_MAX)
+				goto error_out;
+			if (current) {
+				current->next = malloc(sizeof(*current));
+				if (!current->next)
+					goto error_out;
+				current = current->next;
+			} else {
+				first = malloc(sizeof(*first));
+				if (!first)
+					goto error_out;
+				current = first;
+			}
+			current->first = first;
+			current->next = NULL;
+
+			memcpy(one_value, linebuf + pos, i - pos);
+			one_value[i - pos] = '\0';
+			if (sscanf(one_value, "%lu %llu",
+					&current->frequency,
+					&current->time_in_state) != 2)
+				goto error_out;
+
+			*total_time = *total_time + current->time_in_state;
+			pos = i + 1;
+		}
+	}
+
+	return first;
+
+ error_out:
+	while (first) {
+		current = first->next;
+		free(first);
+		first = current;
+	}
+	return NULL;
 }
 
 void cpufreq_put_stats(struct cpufreq_stats *any)
@@ -204,5 +712,5 @@ void cpufreq_put_stats(struct cpufreq_stats *any)
 
 unsigned long cpufreq_get_transitions(unsigned int cpu)
 {
-	return sysfs_get_freq_transitions(cpu);
+	return sysfs_cpufreq_get_one_value(cpu, STATS_NUM_TRANSITIONS);
 }
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 3aae8e7..3b005c3 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -17,8 +17,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#ifndef _CPUFREQ_H
-#define _CPUFREQ_H 1
+#ifndef __CPUPOWER_CPUFREQ_H__
+#define __CPUPOWER_CPUFREQ_H__
 
 struct cpufreq_policy {
 	unsigned long min;
@@ -58,13 +58,6 @@ struct cpufreq_stats {
 extern "C" {
 #endif
 
-/*
- * returns 0 if the specified CPU is present (it doesn't say
- * whether it is online!), and an error value if not.
- */
-
-extern int cpufreq_cpu_exists(unsigned int cpu);
-
 /* determine current CPU frequency
  * - _kernel variant means kernel's opinion of CPU frequency
  * - _hardware variant means actual hardware CPU frequency,
@@ -73,9 +66,9 @@ extern int cpufreq_cpu_exists(unsigned int cpu);
  * returns 0 on failure, else frequency in kHz.
  */
 
-extern unsigned long cpufreq_get_freq_kernel(unsigned int cpu);
+unsigned long cpufreq_get_freq_kernel(unsigned int cpu);
 
-extern unsigned long cpufreq_get_freq_hardware(unsigned int cpu);
+unsigned long cpufreq_get_freq_hardware(unsigned int cpu);
 
 #define cpufreq_get(cpu) cpufreq_get_freq_kernel(cpu);
 
@@ -84,7 +77,7 @@ extern unsigned long cpufreq_get_freq_hardware(unsigned int cpu);
  *
  * returns 0 on failure, else transition latency in 10^(-9) s = nanoseconds
  */
-extern unsigned long cpufreq_get_transition_latency(unsigned int cpu);
+unsigned long cpufreq_get_transition_latency(unsigned int cpu);
 
 
 /* determine hardware CPU frequency limits
@@ -93,7 +86,7 @@ extern unsigned long cpufreq_get_transition_latency(unsigned int cpu);
  * considerations by cpufreq policy notifiers in the kernel.
  */
 
-extern int cpufreq_get_hardware_limits(unsigned int cpu,
+int cpufreq_get_hardware_limits(unsigned int cpu,
 				unsigned long *min,
 				unsigned long *max);
 
@@ -104,9 +97,9 @@ extern int cpufreq_get_hardware_limits(unsigned int cpu,
  * to avoid memory leakage, please.
  */
 
-extern char *cpufreq_get_driver(unsigned int cpu);
+char *cpufreq_get_driver(unsigned int cpu);
 
-extern void cpufreq_put_driver(char *ptr);
+void cpufreq_put_driver(char *ptr);
 
 
 /* determine CPUfreq policy currently used
@@ -116,9 +109,9 @@ extern void cpufreq_put_driver(char *ptr);
  */
 
 
-extern struct cpufreq_policy *cpufreq_get_policy(unsigned int cpu);
+struct cpufreq_policy *cpufreq_get_policy(unsigned int cpu);
 
-extern void cpufreq_put_policy(struct cpufreq_policy *policy);
+void cpufreq_put_policy(struct cpufreq_policy *policy);
 
 
 /* determine CPUfreq governors currently available
@@ -129,10 +122,10 @@ extern void cpufreq_put_policy(struct cpufreq_policy *policy);
  */
 
 
-extern struct cpufreq_available_governors
+struct cpufreq_available_governors
 *cpufreq_get_available_governors(unsigned int cpu);
 
-extern void cpufreq_put_available_governors(
+void cpufreq_put_available_governors(
 	struct cpufreq_available_governors *first);
 
 
@@ -143,10 +136,10 @@ extern void cpufreq_put_available_governors(
  * cpufreq_put_available_frequencies after use.
  */
 
-extern struct cpufreq_available_frequencies
+struct cpufreq_available_frequencies
 *cpufreq_get_available_frequencies(unsigned int cpu);
 
-extern void cpufreq_put_available_frequencies(
+void cpufreq_put_available_frequencies(
 		struct cpufreq_available_frequencies *first);
 
 
@@ -156,10 +149,10 @@ extern void cpufreq_put_available_frequencies(
  * to avoid memory leakage, please.
  */
 
-extern struct cpufreq_affected_cpus *cpufreq_get_affected_cpus(unsigned
+struct cpufreq_affected_cpus *cpufreq_get_affected_cpus(unsigned
 							int cpu);
 
-extern void cpufreq_put_affected_cpus(struct cpufreq_affected_cpus *first);
+void cpufreq_put_affected_cpus(struct cpufreq_affected_cpus *first);
 
 
 /* determine related CPUs
@@ -168,10 +161,10 @@ extern void cpufreq_put_affected_cpus(struct cpufreq_affected_cpus *first);
  * to avoid memory leakage, please.
  */
 
-extern struct cpufreq_affected_cpus *cpufreq_get_related_cpus(unsigned
+struct cpufreq_affected_cpus *cpufreq_get_related_cpus(unsigned
 							int cpu);
 
-extern void cpufreq_put_related_cpus(struct cpufreq_affected_cpus *first);
+void cpufreq_put_related_cpus(struct cpufreq_affected_cpus *first);
 
 
 /* determine stats for cpufreq subsystem
@@ -179,12 +172,12 @@ extern void cpufreq_put_related_cpus(struct cpufreq_affected_cpus *first);
  * This is not available in all kernel versions or configurations.
  */
 
-extern struct cpufreq_stats *cpufreq_get_stats(unsigned int cpu,
+struct cpufreq_stats *cpufreq_get_stats(unsigned int cpu,
 					unsigned long long *total_time);
 
-extern void cpufreq_put_stats(struct cpufreq_stats *stats);
+void cpufreq_put_stats(struct cpufreq_stats *stats);
 
-extern unsigned long cpufreq_get_transitions(unsigned int cpu);
+unsigned long cpufreq_get_transitions(unsigned int cpu);
 
 
 /* set new cpufreq policy
@@ -193,7 +186,7 @@ extern unsigned long cpufreq_get_transitions(unsigned int cpu);
  * but results may differ depending e.g. on governors being available.
  */
 
-extern int cpufreq_set_policy(unsigned int cpu, struct cpufreq_policy *policy);
+int cpufreq_set_policy(unsigned int cpu, struct cpufreq_policy *policy);
 
 
 /* modify a policy by only changing min/max freq or governor
@@ -201,9 +194,9 @@ extern int cpufreq_set_policy(unsigned int cpu, struct cpufreq_policy *policy);
  * Does not check whether result is what was intended.
  */
 
-extern int cpufreq_modify_policy_min(unsigned int cpu, unsigned long min_freq);
-extern int cpufreq_modify_policy_max(unsigned int cpu, unsigned long max_freq);
-extern int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
+int cpufreq_modify_policy_min(unsigned int cpu, unsigned long min_freq);
+int cpufreq_modify_policy_max(unsigned int cpu, unsigned long max_freq);
+int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
 
 
 /* set a specific frequency
@@ -213,7 +206,7 @@ extern int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
  * occurs. Also does not work on ->range() cpufreq drivers.
  */
 
-extern int cpufreq_set_frequency(unsigned int cpu,
+int cpufreq_set_frequency(unsigned int cpu,
 				unsigned long target_frequency);
 
 #ifdef __cplusplus
diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
new file mode 100644
index 0000000..5b1928a
--- /dev/null
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -0,0 +1,380 @@
+/*
+ *  (C) 2004-2009  Dominik Brodowski <linux@dominikbrodowski.de>
+ *  (C) 2011       Thomas Renninger <trenn@novell.com> Novell Inc.
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "cpuidle.h"
+#include "cpupower_intern.h"
+
+/*
+ * helper function to check whether a file under "../cpuX/cpuidle/stateX/" dir
+ * exists.
+ * For example the functionality to disable c-states was introduced in later
+ * kernel versions, this function can be used to explicitly check for this
+ * feature.
+ *
+ * returns 1 if the file exists, 0 otherwise.
+ */
+static
+unsigned int cpuidle_state_file_exists(unsigned int cpu,
+				       unsigned int idlestate,
+				       const char *fname)
+{
+	char path[SYSFS_PATH_MAX];
+	struct stat statbuf;
+
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpuidle/state%u/%s",
+		 cpu, idlestate, fname);
+	if (stat(path, &statbuf) != 0)
+		return 0;
+	return 1;
+}
+
+/*
+ * helper function to read file from /sys into given buffer
+ * fname is a relative path under "cpuX/cpuidle/stateX/" dir
+ * cstates starting with 0, C0 is not counted as cstate.
+ * This means if you want C1 info, pass 0 as idlestate param
+ */
+static
+unsigned int cpuidle_state_read_file(unsigned int cpu,
+					    unsigned int idlestate,
+					    const char *fname, char *buf,
+					    size_t buflen)
+{
+	char path[SYSFS_PATH_MAX];
+	int fd;
+	ssize_t numread;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpuidle/state%u/%s",
+		 cpu, idlestate, fname);
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return 0;
+
+	numread = read(fd, buf, buflen - 1);
+	if (numread < 1) {
+		close(fd);
+		return 0;
+	}
+
+	buf[numread] = '\0';
+	close(fd);
+
+	return (unsigned int) numread;
+}
+
+/* 
+ * helper function to write a new value to a /sys file
+ * fname is a relative path under "../cpuX/cpuidle/cstateY/" dir
+ *
+ * Returns the number of bytes written or 0 on error
+ */
+static
+unsigned int cpuidle_state_write_file(unsigned int cpu,
+				      unsigned int idlestate,
+				      const char *fname,
+				      const char *value, size_t len)
+{
+	char path[SYSFS_PATH_MAX];
+	int fd;
+	ssize_t numwrite;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpuidle/state%u/%s",
+		 cpu, idlestate, fname);
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		return 0;
+
+	numwrite = write(fd, value, len);
+	if (numwrite < 1) {
+		close(fd);
+		return 0;
+	}
+
+	close(fd);
+
+	return (unsigned int) numwrite;
+}
+
+/* read access to files which contain one numeric value */
+
+enum idlestate_value {
+	IDLESTATE_USAGE,
+	IDLESTATE_POWER,
+	IDLESTATE_LATENCY,
+	IDLESTATE_TIME,
+	IDLESTATE_DISABLE,
+	MAX_IDLESTATE_VALUE_FILES
+};
+
+static const char *idlestate_value_files[MAX_IDLESTATE_VALUE_FILES] = {
+	[IDLESTATE_USAGE] = "usage",
+	[IDLESTATE_POWER] = "power",
+	[IDLESTATE_LATENCY] = "latency",
+	[IDLESTATE_TIME]  = "time",
+	[IDLESTATE_DISABLE]  = "disable",
+};
+
+static
+unsigned long long cpuidle_state_get_one_value(unsigned int cpu,
+					       unsigned int idlestate,
+					       enum idlestate_value which)
+{
+	unsigned long long value;
+	unsigned int len;
+	char linebuf[MAX_LINE_LEN];
+	char *endp;
+
+	if (which >= MAX_IDLESTATE_VALUE_FILES)
+		return 0;
+
+	len = cpuidle_state_read_file(cpu, idlestate,
+				      idlestate_value_files[which],
+				      linebuf, sizeof(linebuf));
+	if (len == 0)
+		return 0;
+
+	value = strtoull(linebuf, &endp, 0);
+
+	if (endp == linebuf || errno == ERANGE)
+		return 0;
+
+	return value;
+}
+
+/* read access to files which contain one string */
+
+enum idlestate_string {
+	IDLESTATE_DESC,
+	IDLESTATE_NAME,
+	MAX_IDLESTATE_STRING_FILES
+};
+
+static const char *idlestate_string_files[MAX_IDLESTATE_STRING_FILES] = {
+	[IDLESTATE_DESC] = "desc",
+	[IDLESTATE_NAME] = "name",
+};
+
+
+static char *cpuidle_state_get_one_string(unsigned int cpu,
+					unsigned int idlestate,
+					enum idlestate_string which)
+{
+	char linebuf[MAX_LINE_LEN];
+	char *result;
+	unsigned int len;
+
+	if (which >= MAX_IDLESTATE_STRING_FILES)
+		return NULL;
+
+	len = cpuidle_state_read_file(cpu, idlestate,
+				      idlestate_string_files[which],
+				      linebuf, sizeof(linebuf));
+	if (len == 0)
+		return NULL;
+
+	result = strdup(linebuf);
+	if (result == NULL)
+		return NULL;
+
+	if (result[strlen(result) - 1] == '\n')
+		result[strlen(result) - 1] = '\0';
+
+	return result;
+}
+
+/*
+ * Returns:
+ *    1  if disabled
+ *    0  if enabled
+ *    -1 if idlestate is not available
+ *    -2 if disabling is not supported by the kernel
+ */
+int cpuidle_is_state_disabled(unsigned int cpu,
+				unsigned int idlestate)
+{
+	if (cpuidle_state_count(cpu) <= idlestate)
+		return -1;
+
+	if (!cpuidle_state_file_exists(cpu, idlestate,
+				 idlestate_value_files[IDLESTATE_DISABLE]))
+		return -2;
+	return cpuidle_state_get_one_value(cpu, idlestate, IDLESTATE_DISABLE);
+}
+
+/*
+ * Pass 1 as last argument to disable or 0 to enable the state
+ * Returns:
+ *    0  on success
+ *    negative values on error, for example:
+ *      -1 if idlestate is not available
+ *      -2 if disabling is not supported by the kernel
+ *      -3 No write access to disable/enable C-states
+ */
+int cpuidle_state_disable(unsigned int cpu,
+			    unsigned int idlestate,
+			    unsigned int disable)
+{
+	char value[SYSFS_PATH_MAX];
+	int bytes_written;
+
+	if (cpuidle_state_count(cpu) <= idlestate)
+		return -1;
+
+	if (!cpuidle_state_file_exists(cpu, idlestate,
+				 idlestate_value_files[IDLESTATE_DISABLE]))
+		return -2;
+
+	snprintf(value, SYSFS_PATH_MAX, "%u", disable);
+
+	bytes_written = cpuidle_state_write_file(cpu, idlestate, "disable",
+						   value, sizeof(disable));
+	if (bytes_written)
+		return 0;
+	return -3;
+}
+
+unsigned long cpuidle_state_latency(unsigned int cpu,
+					  unsigned int idlestate)
+{
+	return cpuidle_state_get_one_value(cpu, idlestate, IDLESTATE_LATENCY);
+}
+
+unsigned long cpuidle_state_usage(unsigned int cpu,
+					unsigned int idlestate)
+{
+	return cpuidle_state_get_one_value(cpu, idlestate, IDLESTATE_USAGE);
+}
+
+unsigned long long cpuidle_state_time(unsigned int cpu,
+					unsigned int idlestate)
+{
+	return cpuidle_state_get_one_value(cpu, idlestate, IDLESTATE_TIME);
+}
+
+char *cpuidle_state_name(unsigned int cpu, unsigned int idlestate)
+{
+	return cpuidle_state_get_one_string(cpu, idlestate, IDLESTATE_NAME);
+}
+
+char *cpuidle_state_desc(unsigned int cpu, unsigned int idlestate)
+{
+	return cpuidle_state_get_one_string(cpu, idlestate, IDLESTATE_DESC);
+}
+
+/*
+ * Returns number of supported C-states of CPU core cpu
+ * Negativ in error case
+ * Zero if cpuidle does not export any C-states
+ */
+unsigned int cpuidle_state_count(unsigned int cpu)
+{
+	char file[SYSFS_PATH_MAX];
+	struct stat statbuf;
+	int idlestates = 1;
+
+
+	snprintf(file, SYSFS_PATH_MAX, PATH_TO_CPU "cpuidle");
+	if (stat(file, &statbuf) != 0 || !S_ISDIR(statbuf.st_mode))
+		return 0;
+
+	snprintf(file, SYSFS_PATH_MAX, PATH_TO_CPU "cpu%u/cpuidle/state0", cpu);
+	if (stat(file, &statbuf) != 0 || !S_ISDIR(statbuf.st_mode))
+		return 0;
+
+	while (stat(file, &statbuf) == 0 && S_ISDIR(statbuf.st_mode)) {
+		snprintf(file, SYSFS_PATH_MAX, PATH_TO_CPU
+			 "cpu%u/cpuidle/state%d", cpu, idlestates);
+		idlestates++;
+	}
+	idlestates--;
+	return idlestates;
+}
+
+/* CPUidle general /sys/devices/system/cpu/cpuidle/ sysfs access ********/
+
+/*
+ * helper function to read file from /sys into given buffer
+ * fname is a relative path under "cpu/cpuidle/" dir
+ */
+static unsigned int sysfs_cpuidle_read_file(const char *fname, char *buf,
+					    size_t buflen)
+{
+	char path[SYSFS_PATH_MAX];
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpuidle/%s", fname);
+
+	return sysfs_read_file(path, buf, buflen);
+}
+
+
+
+/* read access to files which contain one string */
+
+enum cpuidle_string {
+	CPUIDLE_GOVERNOR,
+	CPUIDLE_GOVERNOR_RO,
+	CPUIDLE_DRIVER,
+	MAX_CPUIDLE_STRING_FILES
+};
+
+static const char *cpuidle_string_files[MAX_CPUIDLE_STRING_FILES] = {
+	[CPUIDLE_GOVERNOR]	= "current_governor",
+	[CPUIDLE_GOVERNOR_RO]	= "current_governor_ro",
+	[CPUIDLE_DRIVER]	= "current_driver",
+};
+
+
+static char *sysfs_cpuidle_get_one_string(enum cpuidle_string which)
+{
+	char linebuf[MAX_LINE_LEN];
+	char *result;
+	unsigned int len;
+
+	if (which >= MAX_CPUIDLE_STRING_FILES)
+		return NULL;
+
+	len = sysfs_cpuidle_read_file(cpuidle_string_files[which],
+				linebuf, sizeof(linebuf));
+	if (len == 0)
+		return NULL;
+
+	result = strdup(linebuf);
+	if (result == NULL)
+		return NULL;
+
+	if (result[strlen(result) - 1] == '\n')
+		result[strlen(result) - 1] = '\0';
+
+	return result;
+}
+
+char *cpuidle_get_governor(void)
+{
+	char *tmp = sysfs_cpuidle_get_one_string(CPUIDLE_GOVERNOR_RO);
+	if (!tmp)
+		return sysfs_cpuidle_get_one_string(CPUIDLE_GOVERNOR);
+	else
+		return tmp;
+}
+
+char *cpuidle_get_driver(void)
+{
+	return sysfs_cpuidle_get_one_string(CPUIDLE_DRIVER);
+}
+/* CPUidle idlestate specific /sys/devices/system/cpu/cpuX/cpuidle/ access */
diff --git a/tools/power/cpupower/lib/cpuidle.h b/tools/power/cpupower/lib/cpuidle.h
new file mode 100644
index 0000000..04eb3cf
--- /dev/null
+++ b/tools/power/cpupower/lib/cpuidle.h
@@ -0,0 +1,23 @@
+#ifndef __CPUPOWER_CPUIDLE_H__
+#define __CPUPOWER_CPUIDLE_H__
+
+int cpuidle_is_state_disabled(unsigned int cpu,
+				       unsigned int idlestate);
+int cpuidle_state_disable(unsigned int cpu, unsigned int idlestate,
+				   unsigned int disable);
+unsigned long cpuidle_state_latency(unsigned int cpu,
+						unsigned int idlestate);
+unsigned long cpuidle_state_usage(unsigned int cpu,
+					unsigned int idlestate);
+unsigned long long cpuidle_state_time(unsigned int cpu,
+						unsigned int idlestate);
+char *cpuidle_state_name(unsigned int cpu,
+				unsigned int idlestate);
+char *cpuidle_state_desc(unsigned int cpu,
+				unsigned int idlestate);
+unsigned int cpuidle_state_count(unsigned int cpu);
+
+char *cpuidle_get_governor(void);
+char *cpuidle_get_driver(void);
+
+#endif /* __CPUPOWER_HELPERS_SYSFS_H__ */
diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
new file mode 100644
index 0000000..9c395ec9
--- /dev/null
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -0,0 +1,192 @@
+/*
+ *  (C) 2004-2009  Dominik Brodowski <linux@dominikbrodowski.de>
+ *
+ *  Licensed under the terms of the GNU GPL License version 2.
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+
+#include "cpupower.h"
+#include "cpupower_intern.h"
+
+unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen)
+{
+	int fd;
+	ssize_t numread;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return 0;
+
+	numread = read(fd, buf, buflen - 1);
+	if (numread < 1) {
+		close(fd);
+		return 0;
+	}
+
+	buf[numread] = '\0';
+	close(fd);
+
+	return (unsigned int) numread;
+}
+
+/*
+ * Detect whether a CPU is online
+ *
+ * Returns:
+ *     1 -> if CPU is online
+ *     0 -> if CPU is offline
+ *     negative errno values in error case
+ */
+int cpupower_is_cpu_online(unsigned int cpu)
+{
+	char path[SYSFS_PATH_MAX];
+	int fd;
+	ssize_t numread;
+	unsigned long long value;
+	char linebuf[MAX_LINE_LEN];
+	char *endp;
+	struct stat statbuf;
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u", cpu);
+
+	if (stat(path, &statbuf) != 0)
+		return 0;
+
+	/*
+	 * kernel without CONFIG_HOTPLUG_CPU
+	 * -> cpuX directory exists, but not cpuX/online file
+	 */
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/online", cpu);
+	if (stat(path, &statbuf) != 0)
+		return 1;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return -errno;
+
+	numread = read(fd, linebuf, MAX_LINE_LEN - 1);
+	if (numread < 1) {
+		close(fd);
+		return -EIO;
+	}
+	linebuf[numread] = '\0';
+	close(fd);
+
+	value = strtoull(linebuf, &endp, 0);
+	if (value > 1)
+		return -EINVAL;
+
+	return value;
+}
+
+/* returns -1 on failure, 0 on success */
+static int sysfs_topology_read_file(unsigned int cpu, const char *fname, int *result)
+{
+	char linebuf[MAX_LINE_LEN];
+	char *endp;
+	char path[SYSFS_PATH_MAX];
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/topology/%s",
+			 cpu, fname);
+	if (sysfs_read_file(path, linebuf, MAX_LINE_LEN) == 0)
+		return -1;
+	*result = strtol(linebuf, &endp, 0);
+	if (endp == linebuf || errno == ERANGE)
+		return -1;
+	return 0;
+}
+
+static int __compare(const void *t1, const void *t2)
+{
+	struct cpuid_core_info *top1 = (struct cpuid_core_info *)t1;
+	struct cpuid_core_info *top2 = (struct cpuid_core_info *)t2;
+	if (top1->pkg < top2->pkg)
+		return -1;
+	else if (top1->pkg > top2->pkg)
+		return 1;
+	else if (top1->core < top2->core)
+		return -1;
+	else if (top1->core > top2->core)
+		return 1;
+	else if (top1->cpu < top2->cpu)
+		return -1;
+	else if (top1->cpu > top2->cpu)
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * Returns amount of cpus, negative on error, cpu_top must be
+ * passed to cpu_topology_release to free resources
+ *
+ * Array is sorted after ->pkg, ->core, then ->cpu
+ */
+int get_cpu_topology(struct cpupower_topology *cpu_top)
+{
+	int cpu, last_pkg, cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	cpu_top->core_info = malloc(sizeof(struct cpuid_core_info) * cpus);
+	if (cpu_top->core_info == NULL)
+		return -ENOMEM;
+	cpu_top->pkgs = cpu_top->cores = 0;
+	for (cpu = 0; cpu < cpus; cpu++) {
+		cpu_top->core_info[cpu].cpu = cpu;
+		cpu_top->core_info[cpu].is_online = cpupower_is_cpu_online(cpu);
+		if(sysfs_topology_read_file(
+			cpu,
+			"physical_package_id",
+			&(cpu_top->core_info[cpu].pkg)) < 0) {
+			cpu_top->core_info[cpu].pkg = -1;
+			cpu_top->core_info[cpu].core = -1;
+			continue;
+		}
+		if(sysfs_topology_read_file(
+			cpu,
+			"core_id",
+			&(cpu_top->core_info[cpu].core)) < 0) {
+			cpu_top->core_info[cpu].pkg = -1;
+			cpu_top->core_info[cpu].core = -1;
+			continue;
+		}
+	}
+
+	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
+	      __compare);
+
+	/* Count the number of distinct pkgs values. This works
+	   because the primary sort of the core_info struct was just
+	   done by pkg value. */
+	last_pkg = cpu_top->core_info[0].pkg;
+	for(cpu = 1; cpu < cpus; cpu++) {
+		if (cpu_top->core_info[cpu].pkg != last_pkg &&
+				cpu_top->core_info[cpu].pkg != -1) {
+
+			last_pkg = cpu_top->core_info[cpu].pkg;
+			cpu_top->pkgs++;
+		}
+	}
+	if (!(cpu_top->core_info[0].pkg == -1))
+		cpu_top->pkgs++;
+
+	/* Intel's cores count is not consecutively numbered, there may
+	 * be a core_id of 3, but none of 2. Assume there always is 0
+	 * Get amount of cores by counting duplicates in a package
+	for (cpu = 0; cpu_top->core_info[cpu].pkg = 0 && cpu < cpus; cpu++) {
+		if (cpu_top->core_info[cpu].core == 0)
+	cpu_top->cores++;
+	*/
+	return cpus;
+}
+
+void cpu_topology_release(struct cpupower_topology cpu_top)
+{
+	free(cpu_top.core_info);
+}
diff --git a/tools/power/cpupower/lib/cpupower.h b/tools/power/cpupower/lib/cpupower.h
new file mode 100644
index 0000000..fa031fc
--- /dev/null
+++ b/tools/power/cpupower/lib/cpupower.h
@@ -0,0 +1,35 @@
+#ifndef __CPUPOWER_CPUPOWER_H__
+#define __CPUPOWER_CPUPOWER_H__
+
+struct cpupower_topology {
+	/* Amount of CPU cores, packages and threads per core in the system */
+	unsigned int cores;
+	unsigned int pkgs;
+	unsigned int threads; /* per core */
+
+	/* Array gets mallocated with cores entries, holding per core info */
+	struct cpuid_core_info *core_info;
+};
+
+struct cpuid_core_info {
+	int pkg;
+	int core;
+	int cpu;
+
+	/* flags */
+	unsigned int is_online:1;
+};
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+int get_cpu_topology(struct cpupower_topology *cpu_top);
+void cpu_topology_release(struct cpupower_topology cpu_top);
+int cpupower_is_cpu_online(unsigned int cpu);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/tools/power/cpupower/lib/cpupower_intern.h b/tools/power/cpupower/lib/cpupower_intern.h
new file mode 100644
index 0000000..f8ec400
--- /dev/null
+++ b/tools/power/cpupower/lib/cpupower_intern.h
@@ -0,0 +1,5 @@
+#define PATH_TO_CPU "/sys/devices/system/cpu/"
+#define MAX_LINE_LEN 4096
+#define SYSFS_PATH_MAX 255
+
+unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen);
diff --git a/tools/power/cpupower/lib/sysfs.c b/tools/power/cpupower/lib/sysfs.c
deleted file mode 100644
index 870713a..0000000
--- a/tools/power/cpupower/lib/sysfs.c
+++ /dev/null
@@ -1,672 +0,0 @@
-/*
- *  (C) 2004-2009  Dominik Brodowski <linux@dominikbrodowski.de>
- *
- *  Licensed under the terms of the GNU GPL License version 2.
- */
-
-#include <stdio.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <string.h>
-#include <limits.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
-
-#include "cpufreq.h"
-
-#define PATH_TO_CPU "/sys/devices/system/cpu/"
-#define MAX_LINE_LEN 4096
-#define SYSFS_PATH_MAX 255
-
-
-static unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen)
-{
-	int fd;
-	ssize_t numread;
-
-	fd = open(path, O_RDONLY);
-	if (fd == -1)
-		return 0;
-
-	numread = read(fd, buf, buflen - 1);
-	if (numread < 1) {
-		close(fd);
-		return 0;
-	}
-
-	buf[numread] = '\0';
-	close(fd);
-
-	return (unsigned int) numread;
-}
-
-
-/* CPUFREQ sysfs access **************************************************/
-
-/* helper function to read file from /sys into given buffer */
-/* fname is a relative path under "cpuX/cpufreq" dir */
-static unsigned int sysfs_cpufreq_read_file(unsigned int cpu, const char *fname,
-					    char *buf, size_t buflen)
-{
-	char path[SYSFS_PATH_MAX];
-
-	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpufreq/%s",
-			 cpu, fname);
-	return sysfs_read_file(path, buf, buflen);
-}
-
-/* helper function to write a new value to a /sys file */
-/* fname is a relative path under "cpuX/cpufreq" dir */
-static unsigned int sysfs_cpufreq_write_file(unsigned int cpu,
-					     const char *fname,
-					     const char *value, size_t len)
-{
-	char path[SYSFS_PATH_MAX];
-	int fd;
-	ssize_t numwrite;
-
-	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/cpufreq/%s",
-			 cpu, fname);
-
-	fd = open(path, O_WRONLY);
-	if (fd == -1)
-		return 0;
-
-	numwrite = write(fd, value, len);
-	if (numwrite < 1) {
-		close(fd);
-		return 0;
-	}
-
-	close(fd);
-
-	return (unsigned int) numwrite;
-}
-
-/* read access to files which contain one numeric value */
-
-enum cpufreq_value {
-	CPUINFO_CUR_FREQ,
-	CPUINFO_MIN_FREQ,
-	CPUINFO_MAX_FREQ,
-	CPUINFO_LATENCY,
-	SCALING_CUR_FREQ,
-	SCALING_MIN_FREQ,
-	SCALING_MAX_FREQ,
-	STATS_NUM_TRANSITIONS,
-	MAX_CPUFREQ_VALUE_READ_FILES
-};
-
-static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
-	[CPUINFO_CUR_FREQ] = "cpuinfo_cur_freq",
-	[CPUINFO_MIN_FREQ] = "cpuinfo_min_freq",
-	[CPUINFO_MAX_FREQ] = "cpuinfo_max_freq",
-	[CPUINFO_LATENCY]  = "cpuinfo_transition_latency",
-	[SCALING_CUR_FREQ] = "scaling_cur_freq",
-	[SCALING_MIN_FREQ] = "scaling_min_freq",
-	[SCALING_MAX_FREQ] = "scaling_max_freq",
-	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
-};
-
-
-static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
-						 enum cpufreq_value which)
-{
-	unsigned long value;
-	unsigned int len;
-	char linebuf[MAX_LINE_LEN];
-	char *endp;
-
-	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
-		return 0;
-
-	len = sysfs_cpufreq_read_file(cpu, cpufreq_value_files[which],
-				linebuf, sizeof(linebuf));
-
-	if (len == 0)
-		return 0;
-
-	value = strtoul(linebuf, &endp, 0);
-
-	if (endp == linebuf || errno == ERANGE)
-		return 0;
-
-	return value;
-}
-
-/* read access to files which contain one string */
-
-enum cpufreq_string {
-	SCALING_DRIVER,
-	SCALING_GOVERNOR,
-	MAX_CPUFREQ_STRING_FILES
-};
-
-static const char *cpufreq_string_files[MAX_CPUFREQ_STRING_FILES] = {
-	[SCALING_DRIVER] = "scaling_driver",
-	[SCALING_GOVERNOR] = "scaling_governor",
-};
-
-
-static char *sysfs_cpufreq_get_one_string(unsigned int cpu,
-					   enum cpufreq_string which)
-{
-	char linebuf[MAX_LINE_LEN];
-	char *result;
-	unsigned int len;
-
-	if (which >= MAX_CPUFREQ_STRING_FILES)
-		return NULL;
-
-	len = sysfs_cpufreq_read_file(cpu, cpufreq_string_files[which],
-				linebuf, sizeof(linebuf));
-	if (len == 0)
-		return NULL;
-
-	result = strdup(linebuf);
-	if (result == NULL)
-		return NULL;
-
-	if (result[strlen(result) - 1] == '\n')
-		result[strlen(result) - 1] = '\0';
-
-	return result;
-}
-
-/* write access */
-
-enum cpufreq_write {
-	WRITE_SCALING_MIN_FREQ,
-	WRITE_SCALING_MAX_FREQ,
-	WRITE_SCALING_GOVERNOR,
-	WRITE_SCALING_SET_SPEED,
-	MAX_CPUFREQ_WRITE_FILES
-};
-
-static const char *cpufreq_write_files[MAX_CPUFREQ_WRITE_FILES] = {
-	[WRITE_SCALING_MIN_FREQ] = "scaling_min_freq",
-	[WRITE_SCALING_MAX_FREQ] = "scaling_max_freq",
-	[WRITE_SCALING_GOVERNOR] = "scaling_governor",
-	[WRITE_SCALING_SET_SPEED] = "scaling_setspeed",
-};
-
-static int sysfs_cpufreq_write_one_value(unsigned int cpu,
-					 enum cpufreq_write which,
-					 const char *new_value, size_t len)
-{
-	if (which >= MAX_CPUFREQ_WRITE_FILES)
-		return 0;
-
-	if (sysfs_cpufreq_write_file(cpu, cpufreq_write_files[which],
-					new_value, len) != len)
-		return -ENODEV;
-
-	return 0;
-};
-
-unsigned long sysfs_get_freq_kernel(unsigned int cpu)
-{
-	return sysfs_cpufreq_get_one_value(cpu, SCALING_CUR_FREQ);
-}
-
-unsigned long sysfs_get_freq_hardware(unsigned int cpu)
-{
-	return sysfs_cpufreq_get_one_value(cpu, CPUINFO_CUR_FREQ);
-}
-
-unsigned long sysfs_get_freq_transition_latency(unsigned int cpu)
-{
-	return sysfs_cpufreq_get_one_value(cpu, CPUINFO_LATENCY);
-}
-
-int sysfs_get_freq_hardware_limits(unsigned int cpu,
-			      unsigned long *min,
-			      unsigned long *max)
-{
-	if ((!min) || (!max))
-		return -EINVAL;
-
-	*min = sysfs_cpufreq_get_one_value(cpu, CPUINFO_MIN_FREQ);
-	if (!*min)
-		return -ENODEV;
-
-	*max = sysfs_cpufreq_get_one_value(cpu, CPUINFO_MAX_FREQ);
-	if (!*max)
-		return -ENODEV;
-
-	return 0;
-}
-
-char *sysfs_get_freq_driver(unsigned int cpu)
-{
-	return sysfs_cpufreq_get_one_string(cpu, SCALING_DRIVER);
-}
-
-struct cpufreq_policy *sysfs_get_freq_policy(unsigned int cpu)
-{
-	struct cpufreq_policy *policy;
-
-	policy = malloc(sizeof(struct cpufreq_policy));
-	if (!policy)
-		return NULL;
-
-	policy->governor = sysfs_cpufreq_get_one_string(cpu, SCALING_GOVERNOR);
-	if (!policy->governor) {
-		free(policy);
-		return NULL;
-	}
-	policy->min = sysfs_cpufreq_get_one_value(cpu, SCALING_MIN_FREQ);
-	policy->max = sysfs_cpufreq_get_one_value(cpu, SCALING_MAX_FREQ);
-	if ((!policy->min) || (!policy->max)) {
-		free(policy->governor);
-		free(policy);
-		return NULL;
-	}
-
-	return policy;
-}
-
-struct cpufreq_available_governors *
-sysfs_get_freq_available_governors(unsigned int cpu) {
-	struct cpufreq_available_governors *first = NULL;
-	struct cpufreq_available_governors *current = NULL;
-	char linebuf[MAX_LINE_LEN];
-	unsigned int pos, i;
-	unsigned int len;
-
-	len = sysfs_cpufreq_read_file(cpu, "scaling_available_governors",
-				linebuf, sizeof(linebuf));
-	if (len == 0)
-		return NULL;
-
-	pos = 0;
-	for (i = 0; i < len; i++) {
-		if (linebuf[i] == ' ' || linebuf[i] == '\n') {
-			if (i - pos < 2)
-				continue;
-			if (current) {
-				current->next = malloc(sizeof(*current));
-				if (!current->next)
-					goto error_out;
-				current = current->next;
-			} else {
-				first = malloc(sizeof(*first));
-				if (!first)
-					goto error_out;
-				current = first;
-			}
-			current->first = first;
-			current->next = NULL;
-
-			current->governor = malloc(i - pos + 1);
-			if (!current->governor)
-				goto error_out;
-
-			memcpy(current->governor, linebuf + pos, i - pos);
-			current->governor[i - pos] = '\0';
-			pos = i + 1;
-		}
-	}
-
-	return first;
-
- error_out:
-	while (first) {
-		current = first->next;
-		if (first->governor)
-			free(first->governor);
-		free(first);
-		first = current;
-	}
-	return NULL;
-}
-
-
-struct cpufreq_available_frequencies *
-sysfs_get_available_frequencies(unsigned int cpu) {
-	struct cpufreq_available_frequencies *first = NULL;
-	struct cpufreq_available_frequencies *current = NULL;
-	char one_value[SYSFS_PATH_MAX];
-	char linebuf[MAX_LINE_LEN];
-	unsigned int pos, i;
-	unsigned int len;
-
-	len = sysfs_cpufreq_read_file(cpu, "scaling_available_frequencies",
-				linebuf, sizeof(linebuf));
-	if (len == 0)
-		return NULL;
-
-	pos = 0;
-	for (i = 0; i < len; i++) {
-		if (linebuf[i] == ' ' || linebuf[i] == '\n') {
-			if (i - pos < 2)
-				continue;
-			if (i - pos >= SYSFS_PATH_MAX)
-				goto error_out;
-			if (current) {
-				current->next = malloc(sizeof(*current));
-				if (!current->next)
-					goto error_out;
-				current = current->next;
-			} else {
-				first = malloc(sizeof(*first));
-				if (!first)
-					goto error_out;
-				current = first;
-			}
-			current->first = first;
-			current->next = NULL;
-
-			memcpy(one_value, linebuf + pos, i - pos);
-			one_value[i - pos] = '\0';
-			if (sscanf(one_value, "%lu", &current->frequency) != 1)
-				goto error_out;
-
-			pos = i + 1;
-		}
-	}
-
-	return first;
-
- error_out:
-	while (first) {
-		current = first->next;
-		free(first);
-		first = current;
-	}
-	return NULL;
-}
-
-static struct cpufreq_affected_cpus *sysfs_get_cpu_list(unsigned int cpu,
-							const char *file)
-{
-	struct cpufreq_affected_cpus *first = NULL;
-	struct cpufreq_affected_cpus *current = NULL;
-	char one_value[SYSFS_PATH_MAX];
-	char linebuf[MAX_LINE_LEN];
-	unsigned int pos, i;
-	unsigned int len;
-
-	len = sysfs_cpufreq_read_file(cpu, file, linebuf, sizeof(linebuf));
-	if (len == 0)
-		return NULL;
-
-	pos = 0;
-	for (i = 0; i < len; i++) {
-		if (i == len || linebuf[i] == ' ' || linebuf[i] == '\n') {
-			if (i - pos  < 1)
-				continue;
-			if (i - pos >= SYSFS_PATH_MAX)
-				goto error_out;
-			if (current) {
-				current->next = malloc(sizeof(*current));
-				if (!current->next)
-					goto error_out;
-				current = current->next;
-			} else {
-				first = malloc(sizeof(*first));
-				if (!first)
-					goto error_out;
-				current = first;
-			}
-			current->first = first;
-			current->next = NULL;
-
-			memcpy(one_value, linebuf + pos, i - pos);
-			one_value[i - pos] = '\0';
-
-			if (sscanf(one_value, "%u", &current->cpu) != 1)
-				goto error_out;
-
-			pos = i + 1;
-		}
-	}
-
-	return first;
-
- error_out:
-	while (first) {
-		current = first->next;
-		free(first);
-		first = current;
-	}
-	return NULL;
-}
-
-struct cpufreq_affected_cpus *sysfs_get_freq_affected_cpus(unsigned int cpu)
-{
-	return sysfs_get_cpu_list(cpu, "affected_cpus");
-}
-
-struct cpufreq_affected_cpus *sysfs_get_freq_related_cpus(unsigned int cpu)
-{
-	return sysfs_get_cpu_list(cpu, "related_cpus");
-}
-
-struct cpufreq_stats *sysfs_get_freq_stats(unsigned int cpu,
-					unsigned long long *total_time) {
-	struct cpufreq_stats *first = NULL;
-	struct cpufreq_stats *current = NULL;
-	char one_value[SYSFS_PATH_MAX];
-	char linebuf[MAX_LINE_LEN];
-	unsigned int pos, i;
-	unsigned int len;
-
-	len = sysfs_cpufreq_read_file(cpu, "stats/time_in_state",
-				linebuf, sizeof(linebuf));
-	if (len == 0)
-		return NULL;
-
-	*total_time = 0;
-	pos = 0;
-	for (i = 0; i < len; i++) {
-		if (i == strlen(linebuf) || linebuf[i] == '\n')	{
-			if (i - pos < 2)
-				continue;
-			if ((i - pos) >= SYSFS_PATH_MAX)
-				goto error_out;
-			if (current) {
-				current->next = malloc(sizeof(*current));
-				if (!current->next)
-					goto error_out;
-				current = current->next;
-			} else {
-				first = malloc(sizeof(*first));
-				if (!first)
-					goto error_out;
-				current = first;
-			}
-			current->first = first;
-			current->next = NULL;
-
-			memcpy(one_value, linebuf + pos, i - pos);
-			one_value[i - pos] = '\0';
-			if (sscanf(one_value, "%lu %llu",
-					&current->frequency,
-					&current->time_in_state) != 2)
-				goto error_out;
-
-			*total_time = *total_time + current->time_in_state;
-			pos = i + 1;
-		}
-	}
-
-	return first;
-
- error_out:
-	while (first) {
-		current = first->next;
-		free(first);
-		first = current;
-	}
-	return NULL;
-}
-
-unsigned long sysfs_get_freq_transitions(unsigned int cpu)
-{
-	return sysfs_cpufreq_get_one_value(cpu, STATS_NUM_TRANSITIONS);
-}
-
-static int verify_gov(char *new_gov, char *passed_gov)
-{
-	unsigned int i, j = 0;
-
-	if (!passed_gov || (strlen(passed_gov) > 19))
-		return -EINVAL;
-
-	strncpy(new_gov, passed_gov, 20);
-	for (i = 0; i < 20; i++) {
-		if (j) {
-			new_gov[i] = '\0';
-			continue;
-		}
-		if ((new_gov[i] >= 'a') && (new_gov[i] <= 'z'))
-			continue;
-
-		if ((new_gov[i] >= 'A') && (new_gov[i] <= 'Z'))
-			continue;
-
-		if (new_gov[i] == '-')
-			continue;
-
-		if (new_gov[i] == '_')
-			continue;
-
-		if (new_gov[i] == '\0') {
-			j = 1;
-			continue;
-		}
-		return -EINVAL;
-	}
-	new_gov[19] = '\0';
-	return 0;
-}
-
-int sysfs_modify_freq_policy_governor(unsigned int cpu, char *governor)
-{
-	char new_gov[SYSFS_PATH_MAX];
-
-	if (!governor)
-		return -EINVAL;
-
-	if (verify_gov(new_gov, governor))
-		return -EINVAL;
-
-	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_GOVERNOR,
-					     new_gov, strlen(new_gov));
-};
-
-int sysfs_modify_freq_policy_max(unsigned int cpu, unsigned long max_freq)
-{
-	char value[SYSFS_PATH_MAX];
-
-	snprintf(value, SYSFS_PATH_MAX, "%lu", max_freq);
-
-	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MAX_FREQ,
-					     value, strlen(value));
-};
-
-
-int sysfs_modify_freq_policy_min(unsigned int cpu, unsigned long min_freq)
-{
-	char value[SYSFS_PATH_MAX];
-
-	snprintf(value, SYSFS_PATH_MAX, "%lu", min_freq);
-
-	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MIN_FREQ,
-					     value, strlen(value));
-};
-
-
-int sysfs_set_freq_policy(unsigned int cpu, struct cpufreq_policy *policy)
-{
-	char min[SYSFS_PATH_MAX];
-	char max[SYSFS_PATH_MAX];
-	char gov[SYSFS_PATH_MAX];
-	int ret;
-	unsigned long old_min;
-	int write_max_first;
-
-	if (!policy || !(policy->governor))
-		return -EINVAL;
-
-	if (policy->max < policy->min)
-		return -EINVAL;
-
-	if (verify_gov(gov, policy->governor))
-		return -EINVAL;
-
-	snprintf(min, SYSFS_PATH_MAX, "%lu", policy->min);
-	snprintf(max, SYSFS_PATH_MAX, "%lu", policy->max);
-
-	old_min = sysfs_cpufreq_get_one_value(cpu, SCALING_MIN_FREQ);
-	write_max_first = (old_min && (policy->max < old_min) ? 0 : 1);
-
-	if (write_max_first) {
-		ret = sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MAX_FREQ,
-						    max, strlen(max));
-		if (ret)
-			return ret;
-	}
-
-	ret = sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MIN_FREQ, min,
-					    strlen(min));
-	if (ret)
-		return ret;
-
-	if (!write_max_first) {
-		ret = sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_MAX_FREQ,
-						    max, strlen(max));
-		if (ret)
-			return ret;
-	}
-
-	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_GOVERNOR,
-					     gov, strlen(gov));
-}
-
-int sysfs_set_frequency(unsigned int cpu, unsigned long target_frequency)
-{
-	struct cpufreq_policy *pol = sysfs_get_freq_policy(cpu);
-	char userspace_gov[] = "userspace";
-	char freq[SYSFS_PATH_MAX];
-	int ret;
-
-	if (!pol)
-		return -ENODEV;
-
-	if (strncmp(pol->governor, userspace_gov, 9) != 0) {
-		ret = sysfs_modify_freq_policy_governor(cpu, userspace_gov);
-		if (ret) {
-			cpufreq_put_policy(pol);
-			return ret;
-		}
-	}
-
-	cpufreq_put_policy(pol);
-
-	snprintf(freq, SYSFS_PATH_MAX, "%lu", target_frequency);
-
-	return sysfs_cpufreq_write_one_value(cpu, WRITE_SCALING_SET_SPEED,
-					     freq, strlen(freq));
-}
-
-/* CPUFREQ sysfs access **************************************************/
-
-/* General sysfs access **************************************************/
-int sysfs_cpu_exists(unsigned int cpu)
-{
-	char file[SYSFS_PATH_MAX];
-	struct stat statbuf;
-
-	snprintf(file, SYSFS_PATH_MAX, PATH_TO_CPU "cpu%u/", cpu);
-
-	if (stat(file, &statbuf) != 0)
-		return -ENOSYS;
-
-	return S_ISDIR(statbuf.st_mode) ? 0 : -ENOSYS;
-}
-
-/* General sysfs access **************************************************/
diff --git a/tools/power/cpupower/lib/sysfs.h b/tools/power/cpupower/lib/sysfs.h
deleted file mode 100644
index c76a5e0..0000000
--- a/tools/power/cpupower/lib/sysfs.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* General */
-extern unsigned int sysfs_cpu_exists(unsigned int cpu);
-
-/* CPUfreq */
-extern unsigned long sysfs_get_freq_kernel(unsigned int cpu);
-extern unsigned long sysfs_get_freq_hardware(unsigned int cpu);
-extern unsigned long sysfs_get_freq_transition_latency(unsigned int cpu);
-extern int sysfs_get_freq_hardware_limits(unsigned int cpu,
-					unsigned long *min, unsigned long *max);
-extern char *sysfs_get_freq_driver(unsigned int cpu);
-extern struct cpufreq_policy *sysfs_get_freq_policy(unsigned int cpu);
-extern struct cpufreq_available_governors *sysfs_get_freq_available_governors(
-	unsigned int cpu);
-extern struct cpufreq_available_frequencies *sysfs_get_available_frequencies(
-	unsigned int cpu);
-extern struct cpufreq_affected_cpus *sysfs_get_freq_affected_cpus(
-	unsigned int cpu);
-extern struct cpufreq_affected_cpus *sysfs_get_freq_related_cpus(
-	unsigned int cpu);
-extern struct cpufreq_stats *sysfs_get_freq_stats(unsigned int cpu,
-						unsigned long long *total_time);
-extern unsigned long sysfs_get_freq_transitions(unsigned int cpu);
-extern int sysfs_set_freq_policy(unsigned int cpu,
-				struct cpufreq_policy *policy);
-extern int sysfs_modify_freq_policy_min(unsigned int cpu,
-					unsigned long min_freq);
-extern int sysfs_modify_freq_policy_max(unsigned int cpu,
-					unsigned long max_freq);
-extern int sysfs_modify_freq_policy_governor(unsigned int cpu, char *governor);
-extern int sysfs_set_frequency(unsigned int cpu,
-			unsigned long target_frequency);
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 0e67643..e9679f4 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -256,7 +256,7 @@ static void debug_output_one(unsigned int cpu)
 	struct cpufreq_available_governors *governors;
 	struct cpufreq_stats *stats;
 
-	if (cpufreq_cpu_exists(cpu))
+	if (cpupower_is_cpu_online(cpu))
 		return;
 
 	freq_kernel = cpufreq_get_freq_kernel(cpu);
@@ -647,7 +647,7 @@ int cmd_freq_info(int argc, char **argv)
 
 		if (!bitmask_isbitset(cpus_chosen, cpu))
 			continue;
-		if (cpufreq_cpu_exists(cpu)) {
+		if (cpupower_is_cpu_online(cpu)) {
 			printf(_("couldn't analyze CPU %d as it doesn't seem to be present\n"), cpu);
 			continue;
 		}
diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 0fbd1a2..b4bf769 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -16,8 +16,8 @@
 #include <getopt.h>
 
 #include "cpufreq.h"
+#include "cpuidle.h"
 #include "helpers/helpers.h"
-#include "helpers/sysfs.h"
 
 #define NORM_FREQ_LEN 32
 
@@ -296,7 +296,7 @@ int cmd_freq_set(int argc, char **argv)
 			struct cpufreq_affected_cpus *cpus;
 
 			if (!bitmask_isbitset(cpus_chosen, cpu) ||
-			    cpufreq_cpu_exists(cpu))
+			    cpupower_is_cpu_online(cpu))
 				continue;
 
 			cpus = cpufreq_get_related_cpus(cpu);
@@ -316,10 +316,10 @@ int cmd_freq_set(int argc, char **argv)
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
 		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpufreq_cpu_exists(cpu))
+		    cpupower_is_cpu_online(cpu))
 			continue;
 
-		if (sysfs_is_cpu_online(cpu) != 1)
+		if (cpupower_is_cpu_online(cpu) != 1)
 			continue;
 
 		printf(_("Setting cpu: %d\n"), cpu);
diff --git a/tools/power/cpupower/utils/cpuidle-info.c b/tools/power/cpupower/utils/cpuidle-info.c
index 750c1d8..8473ec4 100644
--- a/tools/power/cpupower/utils/cpuidle-info.c
+++ b/tools/power/cpupower/utils/cpuidle-info.c
@@ -13,9 +13,9 @@
 #include <string.h>
 #include <getopt.h>
 #include <cpufreq.h>
+#include <cpuidle.h>
 
 #include "helpers/helpers.h"
-#include "helpers/sysfs.h"
 #include "helpers/bitmask.h"
 
 #define LINE_LEN 10
@@ -27,7 +27,7 @@ static void cpuidle_cpu_output(unsigned int cpu, int verbose)
 
 	printf(_ ("Analyzing CPU %d:\n"), cpu);
 
-	idlestates = sysfs_get_idlestate_count(cpu);
+	idlestates = cpuidle_state_count(cpu);
 	if (idlestates == 0) {
 		printf(_("CPU %u: No idle states\n"), cpu);
 		return;
@@ -36,7 +36,7 @@ static void cpuidle_cpu_output(unsigned int cpu, int verbose)
 	printf(_("Number of idle states: %d\n"), idlestates);
 	printf(_("Available idle states:"));
 	for (idlestate = 0; idlestate < idlestates; idlestate++) {
-		tmp = sysfs_get_idlestate_name(cpu, idlestate);
+		tmp = cpuidle_state_name(cpu, idlestate);
 		if (!tmp)
 			continue;
 		printf(" %s", tmp);
@@ -48,28 +48,28 @@ static void cpuidle_cpu_output(unsigned int cpu, int verbose)
 		return;
 
 	for (idlestate = 0; idlestate < idlestates; idlestate++) {
-		int disabled = sysfs_is_idlestate_disabled(cpu, idlestate);
+		int disabled = cpuidle_is_state_disabled(cpu, idlestate);
 		/* Disabled interface not supported on older kernels */
 		if (disabled < 0)
 			disabled = 0;
-		tmp = sysfs_get_idlestate_name(cpu, idlestate);
+		tmp = cpuidle_state_name(cpu, idlestate);
 		if (!tmp)
 			continue;
 		printf("%s%s:\n", tmp, (disabled) ? " (DISABLED) " : "");
 		free(tmp);
 
-		tmp = sysfs_get_idlestate_desc(cpu, idlestate);
+		tmp = cpuidle_state_desc(cpu, idlestate);
 		if (!tmp)
 			continue;
 		printf(_("Flags/Description: %s\n"), tmp);
 		free(tmp);
 
 		printf(_("Latency: %lu\n"),
-		       sysfs_get_idlestate_latency(cpu, idlestate));
+		       cpuidle_state_latency(cpu, idlestate));
 		printf(_("Usage: %lu\n"),
-		       sysfs_get_idlestate_usage(cpu, idlestate));
+		       cpuidle_state_usage(cpu, idlestate));
 		printf(_("Duration: %llu\n"),
-		       sysfs_get_idlestate_time(cpu, idlestate));
+		       cpuidle_state_time(cpu, idlestate));
 	}
 	printf("\n");
 }
@@ -78,7 +78,7 @@ static void cpuidle_general_output(void)
 {
 	char *tmp;
 
-	tmp = sysfs_get_cpuidle_driver();
+	tmp = cpuidle_get_driver();
 	if (!tmp) {
 		printf(_("Could not determine cpuidle driver\n"));
 		return;
@@ -87,7 +87,7 @@ static void cpuidle_general_output(void)
 	printf(_("CPUidle driver: %s\n"), tmp);
 	free(tmp);
 
-	tmp = sysfs_get_cpuidle_governor();
+	tmp = cpuidle_get_governor();
 	if (!tmp) {
 		printf(_("Could not determine cpuidle governor\n"));
 		return;
@@ -102,7 +102,7 @@ static void proc_cpuidle_cpu_output(unsigned int cpu)
 	long max_allowed_cstate = 2000000000;
 	unsigned int cstate, cstates;
 
-	cstates = sysfs_get_idlestate_count(cpu);
+	cstates = cpuidle_state_count(cpu);
 	if (cstates == 0) {
 		printf(_("CPU %u: No C-states info\n"), cpu);
 		return;
@@ -117,11 +117,11 @@ static void proc_cpuidle_cpu_output(unsigned int cpu)
 			 "type[C%d] "), cstate, cstate);
 		printf(_("promotion[--] demotion[--] "));
 		printf(_("latency[%03lu] "),
-		       sysfs_get_idlestate_latency(cpu, cstate));
+		       cpuidle_state_latency(cpu, cstate));
 		printf(_("usage[%08lu] "),
-		       sysfs_get_idlestate_usage(cpu, cstate));
+		       cpuidle_state_usage(cpu, cstate));
 		printf(_("duration[%020Lu] \n"),
-		       sysfs_get_idlestate_time(cpu, cstate));
+		       cpuidle_state_time(cpu, cstate));
 	}
 }
 
@@ -190,7 +190,7 @@ int cmd_idle_info(int argc, char **argv)
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
 		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpufreq_cpu_exists(cpu))
+		    cpupower_is_cpu_online(cpu))
 			continue;
 
 		switch (output_param) {
diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index d6b6ae4..691c24d 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -5,12 +5,12 @@
 #include <limits.h>
 #include <string.h>
 #include <ctype.h>
-
 #include <getopt.h>
 
-#include "cpufreq.h"
+#include <cpufreq.h>
+#include <cpuidle.h>
+
 #include "helpers/helpers.h"
-#include "helpers/sysfs.h"
 
 static struct option info_opts[] = {
      {"disable",	required_argument,		NULL, 'd'},
@@ -104,16 +104,16 @@ int cmd_idle_set(int argc, char **argv)
 		if (!bitmask_isbitset(cpus_chosen, cpu))
 			continue;
 
-		if (sysfs_is_cpu_online(cpu) != 1)
+		if (cpupower_is_cpu_online(cpu) != 1)
 			continue;
 
-		idlestates = sysfs_get_idlestate_count(cpu);
+		idlestates = cpuidle_state_count(cpu);
 		if (idlestates <= 0)
 			continue;
 
 		switch (param) {
 		case 'd':
-			ret = sysfs_idlestate_disable(cpu, idlestate, 1);
+			ret = cpuidle_state_disable(cpu, idlestate, 1);
 			if (ret == 0)
 		printf(_("Idlestate %u disabled on CPU %u\n"),  idlestate, cpu);
 			else if (ret == -1)
@@ -126,7 +126,7 @@ int cmd_idle_set(int argc, char **argv)
 		       idlestate, cpu);
 			break;
 		case 'e':
-			ret = sysfs_idlestate_disable(cpu, idlestate, 0);
+			ret = cpuidle_state_disable(cpu, idlestate, 0);
 			if (ret == 0)
 		printf(_("Idlestate %u enabled on CPU %u\n"),  idlestate, cpu);
 			else if (ret == -1)
@@ -140,13 +140,13 @@ int cmd_idle_set(int argc, char **argv)
 			break;
 		case 'D':
 			for (idlestate = 0; idlestate < idlestates; idlestate++) {
-				disabled = sysfs_is_idlestate_disabled
+				disabled = cpuidle_is_state_disabled
 					(cpu, idlestate);
-				state_latency = sysfs_get_idlestate_latency
+				state_latency = cpuidle_state_latency
 					(cpu, idlestate);
 				if (disabled == 1) {
 					if (latency > state_latency){
-						ret = sysfs_idlestate_disable
+						ret = cpuidle_state_disable
 							(cpu, idlestate, 0);
 						if (ret == 0)
 		printf(_("Idlestate %u enabled on CPU %u\n"),  idlestate, cpu);
@@ -154,7 +154,7 @@ int cmd_idle_set(int argc, char **argv)
 					continue;
 				}
 				if (latency <= state_latency){
-					ret = sysfs_idlestate_disable
+					ret = cpuidle_state_disable
 						(cpu, idlestate, 1);
 					if (ret == 0)
 		printf(_("Idlestate %u disabled on CPU %u\n"), idlestate, cpu);
@@ -163,10 +163,10 @@ int cmd_idle_set(int argc, char **argv)
 			break;
 		case 'E':
 			for (idlestate = 0; idlestate < idlestates; idlestate++) {
-				disabled = sysfs_is_idlestate_disabled
+				disabled = cpuidle_is_state_disabled
 					(cpu, idlestate);
 				if (disabled == 1) {
-					ret = sysfs_idlestate_disable
+					ret = cpuidle_state_disable
 						(cpu, idlestate, 0);
 					if (ret == 0)
 		printf(_("Idlestate %u enabled on CPU %u\n"), idlestate, cpu);
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 10299f2..0a02485 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -13,8 +13,9 @@
 #include <getopt.h>
 
 #include <cpufreq.h>
+#include <cpuidle.h>
+
 #include "helpers/helpers.h"
-#include "helpers/sysfs.h"
 
 static struct option set_opts[] = {
      {"perf-bias", optional_argument, NULL, 'b'},
@@ -84,7 +85,7 @@ int cmd_info(int argc, char **argv)
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
 		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpufreq_cpu_exists(cpu))
+		    cpupower_is_cpu_online(cpu))
 			continue;
 
 		printf(_("analyzing CPU %d:\n"), cpu);
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 3e6f374..cf24c09 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -12,9 +12,9 @@
 #include <string.h>
 #include <getopt.h>
 
-#include <cpufreq.h>
+#include <cpuidle.h>
+
 #include "helpers/helpers.h"
-#include "helpers/sysfs.h"
 #include "helpers/bitmask.h"
 
 static struct option set_opts[] = {
@@ -79,7 +79,7 @@ int cmd_set(int argc, char **argv)
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
 		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpufreq_cpu_exists(cpu))
+		    cpupower_is_cpu_online(cpu))
 			continue;
 
 		if (params.perf_bias) {
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index aa9e954..afb66f8 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -14,6 +14,7 @@
 #include <locale.h>
 
 #include "helpers/bitmask.h"
+#include <cpupower.h>
 
 /* Internationalization ****************************/
 #ifdef NLS
@@ -92,31 +93,6 @@ extern int get_cpu_info(unsigned int cpu, struct cpupower_cpu_info *cpu_info);
 extern struct cpupower_cpu_info cpupower_cpu_info;
 /* cpuid and cpuinfo helpers  **************************/
 
-struct cpuid_core_info {
-	int pkg;
-	int core;
-	int cpu;
-
-	/* flags */
-	unsigned int is_online:1;
-};
-
-/* CPU topology/hierarchy parsing ******************/
-struct cpupower_topology {
-	/* Amount of CPU cores, packages and threads per core in the system */
-	unsigned int cores;
-	unsigned int pkgs;
-	unsigned int threads; /* per core */
-
-	/* Array gets mallocated with cores entries, holding per core info */
-	struct cpuid_core_info *core_info;
-};
-
-extern int get_cpu_topology(struct cpupower_topology *cpu_top);
-extern void cpu_topology_release(struct cpupower_topology cpu_top);
-
-/* CPU topology/hierarchy parsing ******************/
-
 /* X86 ONLY ****************************************/
 #if defined(__i386__) || defined(__x86_64__)
 
diff --git a/tools/power/cpupower/utils/helpers/topology.c b/tools/power/cpupower/utils/helpers/topology.c
index 5f9c908..a1a6c60 100644
--- a/tools/power/cpupower/utils/helpers/topology.c
+++ b/tools/power/cpupower/utils/helpers/topology.c
@@ -16,110 +16,7 @@
 #include <errno.h>
 #include <fcntl.h>
 
-#include <helpers/helpers.h>
-#include <helpers/sysfs.h>
+#include <cpuidle.h>
 
-/* returns -1 on failure, 0 on success */
-static int sysfs_topology_read_file(unsigned int cpu, const char *fname, int *result)
-{
-	char linebuf[MAX_LINE_LEN];
-	char *endp;
-	char path[SYSFS_PATH_MAX];
+/* CPU topology/hierarchy parsing ******************/
 
-	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/topology/%s",
-			 cpu, fname);
-	if (sysfs_read_file(path, linebuf, MAX_LINE_LEN) == 0)
-		return -1;
-	*result = strtol(linebuf, &endp, 0);
-	if (endp == linebuf || errno == ERANGE)
-		return -1;
-	return 0;
-}
-
-static int __compare(const void *t1, const void *t2)
-{
-	struct cpuid_core_info *top1 = (struct cpuid_core_info *)t1;
-	struct cpuid_core_info *top2 = (struct cpuid_core_info *)t2;
-	if (top1->pkg < top2->pkg)
-		return -1;
-	else if (top1->pkg > top2->pkg)
-		return 1;
-	else if (top1->core < top2->core)
-		return -1;
-	else if (top1->core > top2->core)
-		return 1;
-	else if (top1->cpu < top2->cpu)
-		return -1;
-	else if (top1->cpu > top2->cpu)
-		return 1;
-	else
-		return 0;
-}
-
-/*
- * Returns amount of cpus, negative on error, cpu_top must be
- * passed to cpu_topology_release to free resources
- *
- * Array is sorted after ->pkg, ->core, then ->cpu
- */
-int get_cpu_topology(struct cpupower_topology *cpu_top)
-{
-	int cpu, last_pkg, cpus = sysconf(_SC_NPROCESSORS_CONF);
-
-	cpu_top->core_info = malloc(sizeof(struct cpuid_core_info) * cpus);
-	if (cpu_top->core_info == NULL)
-		return -ENOMEM;
-	cpu_top->pkgs = cpu_top->cores = 0;
-	for (cpu = 0; cpu < cpus; cpu++) {
-		cpu_top->core_info[cpu].cpu = cpu;
-		cpu_top->core_info[cpu].is_online = sysfs_is_cpu_online(cpu);
-		if(sysfs_topology_read_file(
-			cpu,
-			"physical_package_id",
-			&(cpu_top->core_info[cpu].pkg)) < 0) {
-			cpu_top->core_info[cpu].pkg = -1;
-			cpu_top->core_info[cpu].core = -1;
-			continue;
-		}
-		if(sysfs_topology_read_file(
-			cpu,
-			"core_id",
-			&(cpu_top->core_info[cpu].core)) < 0) {
-			cpu_top->core_info[cpu].pkg = -1;
-			cpu_top->core_info[cpu].core = -1;
-			continue;
-		}
-	}
-
-	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
-	      __compare);
-
-	/* Count the number of distinct pkgs values. This works
-	   because the primary sort of the core_info struct was just
-	   done by pkg value. */
-	last_pkg = cpu_top->core_info[0].pkg;
-	for(cpu = 1; cpu < cpus; cpu++) {
-		if (cpu_top->core_info[cpu].pkg != last_pkg &&
-				cpu_top->core_info[cpu].pkg != -1) {
-
-			last_pkg = cpu_top->core_info[cpu].pkg;
-			cpu_top->pkgs++;
-		}
-	}
-	if (!(cpu_top->core_info[0].pkg == -1))
-		cpu_top->pkgs++;
-
-	/* Intel's cores count is not consecutively numbered, there may
-	 * be a core_id of 3, but none of 2. Assume there always is 0
-	 * Get amount of cores by counting duplicates in a package
-	for (cpu = 0; cpu_top->core_info[cpu].pkg = 0 && cpu < cpus; cpu++) {
-		if (cpu_top->core_info[cpu].core == 0)
-	cpu_top->cores++;
-	*/
-	return cpus;
-}
-
-void cpu_topology_release(struct cpupower_topology cpu_top)
-{
-	free(cpu_top.core_info);
-}
diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index bcd22a1..1b5da00 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -10,8 +10,8 @@
 #include <stdint.h>
 #include <string.h>
 #include <limits.h>
+#include <cpuidle.h>
 
-#include "helpers/sysfs.h"
 #include "helpers/helpers.h"
 #include "idle_monitor/cpupower-monitor.h"
 
@@ -51,7 +51,7 @@ static int cpuidle_start(void)
 		for (state = 0; state < cpuidle_sysfs_monitor.hw_states_num;
 		     state++) {
 			previous_count[cpu][state] =
-				sysfs_get_idlestate_time(cpu, state);
+				cpuidle_state_time(cpu, state);
 			dprint("CPU %d - State: %d - Val: %llu\n",
 			       cpu, state, previous_count[cpu][state]);
 		}
@@ -70,7 +70,7 @@ static int cpuidle_stop(void)
 		for (state = 0; state < cpuidle_sysfs_monitor.hw_states_num;
 		     state++) {
 			current_count[cpu][state] =
-				sysfs_get_idlestate_time(cpu, state);
+				cpuidle_state_time(cpu, state);
 			dprint("CPU %d - State: %d - Val: %llu\n",
 			       cpu, state, previous_count[cpu][state]);
 		}
@@ -132,13 +132,13 @@ static struct cpuidle_monitor *cpuidle_register(void)
 	char *tmp;
 
 	/* Assume idle state count is the same for all CPUs */
-	cpuidle_sysfs_monitor.hw_states_num = sysfs_get_idlestate_count(0);
+	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(0);
 
 	if (cpuidle_sysfs_monitor.hw_states_num <= 0)
 		return NULL;
 
 	for (num = 0; num < cpuidle_sysfs_monitor.hw_states_num; num++) {
-		tmp = sysfs_get_idlestate_name(0, num);
+		tmp = cpuidle_state_name(0, num);
 		if (tmp == NULL)
 			continue;
 
@@ -146,7 +146,7 @@ static struct cpuidle_monitor *cpuidle_register(void)
 		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
 		free(tmp);
 
-		tmp = sysfs_get_idlestate_desc(0, num);
+		tmp = cpuidle_state_desc(0, num);
 		if (tmp == NULL)
 			continue;
 		strncpy(cpuidle_cstates[num].desc, tmp,	CSTATE_DESC_LEN - 1);

