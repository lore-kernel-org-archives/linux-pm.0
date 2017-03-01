From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/44] tools/power turbostat: add --cpu parameter
Date: Wed,  1 Mar 2017 00:27:36 -0500
Message-ID: <1ef7d21afe2197013aefe0e93641aa2c5a9ac3db.1488345270.git.len.brown@intel.com>
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

With the --cpu parameter, turbostat prints only lines
for the specified set of CPUs:

sudo ./turbostat --quiet --show Core,CPU --cpu 0,1,3..5,6-7
	Core	CPU
	-	-
	0	0
	0	4
	1	1
	1	5
	2	6
	3	3
	3	7

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |  2 +
 tools/power/x86/turbostat/turbostat.c | 95 ++++++++++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index e31b7213fd45..efe6a7147ff2 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -47,6 +47,8 @@ name as necessary to disambiguate it from others is necessary.  Note that option
 		default: delta
 .fi
 .PP
+\fB--cpu cpu-set\fP limit output to system summary plus the specified cpu-set.  cpu-set is a comma delimited list of cpu ranges. cpu ranges can be individual cpu numbers or start and end numbers, separated by ".." or '-'.  eg. 1,2,8,14..17,21-44
+.PP
 \fB--hide column\fP do not show the specified columns.  May be invoked multiple times, or with a comma-separated list of column names.  Use "--hide sysfs" to hide the sysfs statistics columns as a group.
 .PP
 \fB--show column\fP show only the specified columns.  May be invoked multiple times, or with a comma-separated list of column names.  Use "--show sysfs" to show the sysfs statistics columns as a group.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index eb6cc8ccef06..8c965bb2f461 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -143,8 +143,9 @@ unsigned int has_misc_feature_control;
 int backwards_count;
 char *progname;
 
-cpu_set_t *cpu_present_set, *cpu_affinity_set;
-size_t cpu_present_setsize, cpu_affinity_setsize;
+#define CPU_SUBSET_MAXCPUS	1024	/* need to use before probe... */
+cpu_set_t *cpu_present_set, *cpu_affinity_set, *cpu_subset;
+size_t cpu_present_setsize, cpu_affinity_setsize, cpu_subset_size;
 #define MAX_ADDED_COUNTERS 16
 
 struct thread_data {
@@ -700,6 +701,11 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (show_pkg_only && !(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
 		return 0;
 
+	/*if not summary line and --cpu is used */
+	if ((t != &average.threads) &&
+		(cpu_subset && !CPU_ISSET_S(t->cpu_id, cpu_subset_size, cpu_subset)))
+		return 0;
+
 	interval_float = tv_delta.tv_sec + tv_delta.tv_usec/1000000.0;
 
 	tsc = t->tsc * tsc_tweak;
@@ -4096,6 +4102,7 @@ void help()
 	"to print statistics, until interrupted.\n"
 	"--add		add a counter\n"
 	"		eg. --add msr0x10,u64,cpu,delta,MY_TSC\n"
+	"--cpu	cpu-set	limit output to summary plus cpu-set cpu-set\n"
 	"--quiet	skip decoding system configuration header\n"
 	"--interval sec	Override default 5-second measurement interval\n"
 	"--help		print this help message\n"
@@ -4159,6 +4166,15 @@ void topology_probe()
 	for_all_proc_cpus(mark_cpu_present);
 
 	/*
+	 * Validate that all cpus in cpu_subset are also in cpu_present_set
+	 */
+	for (i = 0; i < CPU_SUBSET_MAXCPUS; ++i) {
+		if (CPU_ISSET_S(i, cpu_subset_size, cpu_subset))
+			if (!CPU_ISSET_S(i, cpu_present_setsize, cpu_present_set))
+				err(1, "cpu%d not present", i);
+	}
+
+	/*
 	 * Allocate and initialize cpu_affinity_set
 	 */
 	cpu_affinity_set = CPU_ALLOC((topo.max_cpu_num + 1));
@@ -4675,6 +4691,77 @@ void probe_sysfs(void)
 
 }
 
+
+/*
+ * parse cpuset with following syntax
+ * 1,2,4..6,8-10 and set bits in cpu_subset
+ */
+void parse_cpu_command(char *optarg)
+{
+	unsigned int start, end;
+	char *next;
+
+	cpu_subset = CPU_ALLOC(CPU_SUBSET_MAXCPUS);
+	if (cpu_subset == NULL)
+		err(3, "CPU_ALLOC");
+	cpu_subset_size = CPU_ALLOC_SIZE(CPU_SUBSET_MAXCPUS);
+
+	CPU_ZERO_S(cpu_subset_size, cpu_subset);
+
+	next = optarg;
+
+	while (next && *next) {
+
+		if (*next == '-')	/* no negative cpu numbers */
+			goto error;
+
+		start = strtoul(next, &next, 10);
+
+		if (start >= CPU_SUBSET_MAXCPUS)
+			goto error;
+		CPU_SET_S(start, cpu_subset_size, cpu_subset);
+
+		if (*next == '\0')
+			break;
+
+		if (*next == ',') {
+			next += 1;
+			continue;
+		}
+
+		if (*next == '-') {
+			next += 1;	/* start range */
+		} else if (*next == '.') {
+			next += 1;
+			if (*next == '.')
+				next += 1;	/* start range */
+			else
+				goto error;
+		}
+
+		end = strtoul(next, &next, 10);
+		if (end <= start)
+			goto error;
+
+		while (++start <= end) {
+			if (start >= CPU_SUBSET_MAXCPUS)
+				goto error;
+			CPU_SET_S(start, cpu_subset_size, cpu_subset);
+		}
+
+		if (*next == ',')
+			next += 1;
+		else if (*next != '\0')
+			goto error;
+	}
+
+	return;
+
+error:
+	fprintf(stderr, "'--cpu %s' malformed\n", optarg);
+	exit(-1);
+}
+
 /*
  * HIDE_LIST - hide this list of counters, show the rest [default]
  * SHOW_LIST - show this list of counters, hide the rest
@@ -4716,6 +4803,7 @@ void cmdline(int argc, char **argv)
 	int option_index = 0;
 	static struct option long_options[] = {
 		{"add",		required_argument,	0, 'a'},
+		{"cpu",		required_argument,	0, 'c'},
 		{"Dump",	no_argument,		0, 'D'},
 		{"debug",	no_argument,		0, 'd'},	/* internal, not documented */
 		{"interval",	required_argument,	0, 'i'},
@@ -4741,6 +4829,9 @@ void cmdline(int argc, char **argv)
 		case 'a':
 			parse_add_command(optarg);
 			break;
+		case 'c':
+			parse_cpu_command(optarg);
+			break;
 		case 'D':
 			dump_only++;
 			break;
-- 
2.11.0.161.g6610af872
