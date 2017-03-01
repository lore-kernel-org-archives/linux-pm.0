From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/44] tools/power turbostat: print sysfs C-state stats
Date: Wed,  1 Mar 2017 00:27:35 -0500
Message-ID: <41618e63f2a869902f8534f0db337e85d6bd04c8.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

When turbostat shows % of time in a CPU idle power state,
it has always been showing information from underlying
hardware residency counters.

While this reflects what the hardware is doing, and is thus
useful for understanding the hardware,
it doesn't directly tell us what Linux requested --
which is useful for tuning Linux itself.

Here we add columns to turbostat to show the
Linux cpuidle sub-system statistics:
/sys/devices/system/cpu/cpu*/cpuidle/state*/*

The first group of columns are the "usage", which is the
number of times software requested that C-state in the
measurement interval. eg C1 below.

The second group of columns are the "time", which is the percentage
of the measurement interval time that software has requested
the specified C-state. eg C1% below.

These software counters can be compared to the underlying
hardware residency counters (eg CPU%c1	CPU%c3	CPU%c6	CPU%c7)
to compare what sofware requested to what the hardware delivered.

These sysfs attributes are discovered when turbostat starts,
rather than being "built in".  So the --show and --hide
parameters do not know about these dynamic column names.
However "--show sysfs" and "--hide sysfs" act on the
entire group of columns:

turbostat --show sysfs
...
cpu4: POLL: CPUIDLE CORE POLL IDLE
cpu4: C1: MWAIT 0x00
cpu4: C1E: MWAIT 0x01
cpu4: C3: MWAIT 0x10
cpu4: C6: MWAIT 0x20
cpu4: C7s: MWAIT 0x32
...
C1 	C1E	C3 	C6 	C7s	C1% 	C1E%	C3%	C6% 	C7s%
3	6	5	1	188	0.00	0.02	0.00	0.00	99.93
0	6	5	0	58	0.00	0.16	0.02	0.00	99.70
0	0	0	0	9	0.00	0.00	0.00	0.00	99.96
0	0	0	1	24	0.00	0.00	0.00	0.02	99.93
0	0	0	0	9	0.00	0.00	0.00	0.00	99.97
0	0	0	0	32	0.00	0.00	0.00	0.00	99.96
0	0	0	0	7	0.00	0.00	0.00	0.00	99.98
2	0	0	0	36	0.00	0.00	0.00	0.00	99.97
1	0	0	0	13	0.00	0.00	0.00	0.00	99.98

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |   4 +-
 tools/power/x86/turbostat/turbostat.c | 161 ++++++++++++++++++++++++++++++----
 2 files changed, 147 insertions(+), 18 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index a08de27713e0..e31b7213fd45 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -47,9 +47,9 @@ name as necessary to disambiguate it from others is necessary.  Note that option
 		default: delta
 .fi
 .PP
-\fB--hide column\fP do not show the specified columns.  May be invoked multiple times, or with a comma-separated list of column names.
+\fB--hide column\fP do not show the specified columns.  May be invoked multiple times, or with a comma-separated list of column names.  Use "--hide sysfs" to hide the sysfs statistics columns as a group.
 .PP
-\fB--show column\fP show only the specified columns.  May be invoked multiple times, or with a comma-separated list of column names.
+\fB--show column\fP show only the specified columns.  May be invoked multiple times, or with a comma-separated list of column names.  Use "--show sysfs" to show the sysfs statistics columns as a group.
 .PP
 \fB--Dump\fP displays the raw counter values.
 .PP
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 841f837e317f..eb6cc8ccef06 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -208,7 +208,7 @@ struct pkg_data {
 #define GET_PKG(pkg_base, pkg_no) (pkg_base + pkg_no)
 
 enum counter_scope {SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE};
-enum counter_type {COUNTER_CYCLES, COUNTER_SECONDS};
+enum counter_type {COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUNTER_USEC};
 enum counter_format {FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT};
 
 struct msr_counter {
@@ -222,6 +222,7 @@ struct msr_counter {
 	unsigned int flags;
 #define	FLAGS_HIDE	(1 << 0)
 #define	FLAGS_SHOW	(1 << 1)
+#define	SYSFS_PERCPU	(1 << 1)
 };
 
 struct sys_counters {
@@ -379,6 +380,7 @@ struct msr_counter bic[] = {
 	{ 0x0, "Core" },
 	{ 0x0, "CPU" },
 	{ 0x0, "Mod%c6" },
+	{ 0x0, "sysfs" },
 };
 
 #define MAX_BIC (sizeof(bic) / sizeof(struct msr_counter))
@@ -420,9 +422,10 @@ struct msr_counter bic[] = {
 #define	BIC_Core	(1ULL << 35)
 #define	BIC_CPU		(1ULL << 36)
 #define	BIC_Mod_c6	(1ULL << 37)
+#define	BIC_sysfs	(1ULL << 38)
 
 unsigned long long bic_enabled = 0xFFFFFFFFFFFFFFFFULL;
-unsigned long long bic_present;
+unsigned long long bic_present = BIC_sysfs;
 
 #define DO_BIC(COUNTER_NAME) (bic_enabled & bic_present & COUNTER_NAME)
 #define BIC_PRESENT(COUNTER_BIT) (bic_present |= COUNTER_BIT)
@@ -489,9 +492,6 @@ void print_header(void)
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "\tSMI");
 
-	if (DO_BIC(BIC_CPU_c1))
-		outp += sprintf(outp, "\tCPU%%c1");
-
 	for (mp = sys.tp; mp; mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
@@ -499,10 +499,12 @@ void print_header(void)
 			else
 				outp += sprintf(outp, "\t%10.10s", mp->name);
 		} else {
-			outp += sprintf(outp, "\t%-7.7s", mp->name);
+			outp += sprintf(outp, "\t%s", mp->name);
 		}
 	}
 
+	if (DO_BIC(BIC_CPU_c1))
+		outp += sprintf(outp, "\tCPU%%c1");
 	if (DO_BIC(BIC_CPU_c3) && !do_slm_cstates && !do_knl_cstates)
 		outp += sprintf(outp, "\tCPU%%c3");
 	if (DO_BIC(BIC_CPU_c6))
@@ -523,7 +525,7 @@ void print_header(void)
 			else
 				outp += sprintf(outp, "\t%10.10s", mp->name);
 		} else {
-			outp += sprintf(outp, "\t%-7.7s", mp->name);
+			outp += sprintf(outp, "\t%s", mp->name);
 		}
 	}
 
@@ -592,7 +594,7 @@ void print_header(void)
 			else
 				outp += sprintf(outp, "\t%10.10s", mp->name);
 		} else {
-			outp += sprintf(outp, "\t%-7.7s", mp->name);
+			outp += sprintf(outp, "\t%s", mp->name);
 		}
 	}
 
@@ -753,10 +755,6 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "\t%d", t->smi_count);
 
-	/* C1 */
-	if (DO_BIC(BIC_CPU_c1))
-		outp += sprintf(outp, "\t%.2f", 100.0 * t->c1/tsc);
-
 	/* Added counters */
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
@@ -767,10 +765,18 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		} else if (mp->format == FORMAT_DELTA) {
 			outp += sprintf(outp, "\t%lld", t->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
-			outp += sprintf(outp, "\t%.2f", 100.0 * t->counter[i]/tsc);
+			if (mp->type == COUNTER_USEC)
+				outp += sprintf(outp, "\t%.2f", t->counter[i]/interval_float/10000);
+			else
+				outp += sprintf(outp, "\t%.2f", 100.0 * t->counter[i]/tsc);
 		}
 	}
 
+	/* C1 */
+	if (DO_BIC(BIC_CPU_c1))
+		outp += sprintf(outp, "\t%.2f", 100.0 * t->c1/tsc);
+
+
 	/* print per-core data only for 1st thread in core */
 	if (!(t->flags & CPU_IS_FIRST_THREAD_IN_CORE))
 		goto done;
@@ -1286,6 +1292,8 @@ void compute_average(struct thread_data *t, struct core_data *c,
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
+		if (mp->flags & SYSFS_PERCPU && mp->type == COUNTER_ITEMS)
+			continue;
 		average.threads.counter[i] /= topo.num_cpus;
 	}
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
@@ -1348,7 +1356,16 @@ int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp)
 		if (get_msr(cpu, mp->msr_num, counterp))
 			return -1;
 	} else {
-		*counterp = snapshot_sysfs_counter(mp->path);
+		char path[128];
+
+		if (mp->flags & SYSFS_PERCPU) {
+			sprintf(path, "/sys/devices/system/cpu/cpu%d/%s",
+				 cpu, mp->path);
+
+			*counterp = snapshot_sysfs_counter(path);
+		} else {
+			*counterp = snapshot_sysfs_counter(mp->path);
+		}
 	}
 
 	return 0;
@@ -2822,6 +2839,48 @@ dump_cstate_pstate_config_info(unsigned int family, unsigned int model)
 	dump_nhm_cst_cfg();
 }
 
+static void
+dump_sysfs_cstate_config(void)
+{
+	char path[64];
+	char name_buf[16];
+	char desc[64];
+	FILE *input;
+	int state;
+	char *sp;
+
+	if (!DO_BIC(BIC_sysfs))
+		return;
+
+	for (state = 0; state < 10; ++state) {
+
+		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name",
+			base_cpu, state);
+		input = fopen(path, "r");
+		if (input == NULL)
+			continue;
+		fgets(name_buf, sizeof(name_buf), input);
+
+		 /* truncate "C1-HSW\n" to "C1", or truncate "C1\n" to "C1" */
+		sp = strchr(name_buf, '-');
+		if (!sp)
+			sp = strchrnul(name_buf, '\n');
+		*sp = '\0';
+
+		fclose(input);
+
+		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/desc",
+			base_cpu, state);
+		input = fopen(path, "r");
+		if (input == NULL)
+			continue;
+		fgets(desc, sizeof(desc), input);
+
+		fprintf(outf, "cpu%d: %s: %s", base_cpu, name_buf, desc);
+		fclose(input);
+	}
+}
+
 
 /*
  * print_epb()
@@ -4008,6 +4067,9 @@ void process_cpuid()
 	if (!quiet)
 		dump_cstate_pstate_config_info(family, model);
 
+	if (!quiet)
+		dump_sysfs_cstate_config();
+
 	if (has_skl_msrs(family, model))
 		calculate_tsc_tweak();
 
@@ -4380,7 +4442,7 @@ void print_version() {
 
 int add_counter(unsigned int msr_num, char *path, char *name,
 	unsigned int width, enum counter_scope scope,
-	enum counter_type type, enum counter_format format)
+	enum counter_type type, enum counter_format format, int flags)
 {
 	struct msr_counter *msrp;
 
@@ -4397,6 +4459,7 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 	msrp->width = width;
 	msrp->type = type;
 	msrp->format = format;
+	msrp->flags = flags;
 
 	switch (scope) {
 
@@ -4486,6 +4549,10 @@ void parse_add_command(char *add_command)
 			type = COUNTER_SECONDS;
 			goto next;
 		}
+		if (!strncmp(add_command, "usec", strlen("usec"))) {
+			type = COUNTER_USEC;
+			goto next;
+		}
 		if (!strncmp(add_command, "raw", strlen("raw"))) {
 			format = FORMAT_RAW;
 			goto next;
@@ -4541,7 +4608,7 @@ void parse_add_command(char *add_command)
 		}
 	}
 
-	if (add_counter(msr_num, path, name_buffer, width, scope, type, format))
+	if (add_counter(msr_num, path, name_buffer, width, scope, type, format, 0))
 		fail++;
 
 	if (fail) {
@@ -4549,6 +4616,65 @@ void parse_add_command(char *add_command)
 		exit(1);
 	}
 }
+
+void probe_sysfs(void)
+{
+	char path[64];
+	char name_buf[16];
+	FILE *input;
+	int state;
+	char *sp;
+
+	if (!DO_BIC(BIC_sysfs))
+		return;
+
+	for (state = 10; state > 0; --state) {
+
+		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name",
+			base_cpu, state);
+		input = fopen(path, "r");
+		if (input == NULL)
+			continue;
+		fgets(name_buf, sizeof(name_buf), input);
+
+		 /* truncate "C1-HSW\n" to "C1", or truncate "C1\n" to "C1" */
+		sp = strchr(name_buf, '-');
+		if (!sp)
+			sp = strchrnul(name_buf, '\n');
+		*sp = '%';
+		*(sp + 1) = '\0';
+
+		fclose(input);
+
+		sprintf(path, "cpuidle/state%d/time", state);
+
+		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_USEC,
+				FORMAT_PERCENT, SYSFS_PERCPU);
+	}
+
+	for (state = 10; state > 0; --state) {
+
+		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name",
+			base_cpu, state);
+		input = fopen(path, "r");
+		if (input == NULL)
+			continue;
+		fgets(name_buf, sizeof(name_buf), input);
+		 /* truncate "C1-HSW\n" to "C1", or truncate "C1\n" to "C1" */
+		sp = strchr(name_buf, '-');
+		if (!sp)
+			sp = strchrnul(name_buf, '\n');
+		*sp = '\0';
+		fclose(input);
+
+		sprintf(path, "cpuidle/state%d/usage", state);
+
+		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS,
+				FORMAT_DELTA, SYSFS_PERCPU);
+	}
+
+}
+
 /*
  * HIDE_LIST - hide this list of counters, show the rest [default]
  * SHOW_LIST - show this list of counters, hide the rest
@@ -4581,6 +4707,7 @@ void parse_show_hide(char *optarg, enum show_hide_mode new_mode)
 	 *  multiple invocations simply clear more bits in enabled mask
 	 */
 	bic_enabled &= ~bic_lookup(optarg);
+
 }
 
 void cmdline(int argc, char **argv)
@@ -4682,6 +4809,8 @@ int main(int argc, char **argv)
 	if (!quiet)
 		print_version();
 
+	probe_sysfs();
+
 	turbostat_init();
 
 	/* dump counters and exit */
-- 
2.11.0.161.g6610af872
