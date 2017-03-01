From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/44] tools/power turbostat: use wide columns to display large numbers
Date: Wed,  1 Mar 2017 00:27:39 -0500
Message-ID: <0de6c0df4ecc32ffaf064fea3a43846ba4474bd0.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35531 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdCAJar (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 04:30:47 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

When a counter overlfows 7 columns, it shifts the remaining
columns to the right, so they no longer line up under
their column header.

Update turbostat to dectect when it is handling large
numbers, and switch to wider columns where, necessary.

Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 68 ++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7b02fbb65893..cafc6bba6539 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -50,6 +50,7 @@ int *fd_percpu;
 struct timespec interval_ts = {5, 0};
 unsigned int debug;
 unsigned int quiet;
+unsigned int sums_need_wide_columns;
 unsigned int rapl_joules;
 unsigned int summary_only;
 unsigned int list_header_only;
@@ -154,7 +155,7 @@ struct thread_data {
 	unsigned long long aperf;
 	unsigned long long mperf;
 	unsigned long long c1;
-	unsigned int irq_count;
+	unsigned long long  irq_count;
 	unsigned int smi_count;
 	unsigned int cpu_id;
 	unsigned int flags;
@@ -489,8 +490,13 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_TSC_MHz))
 		outp += sprintf(outp, "%sTSC_MHz", delim);
 
-	if (DO_BIC(BIC_IRQ))
-		outp += sprintf(outp, "%sIRQ", delim);
+	if (DO_BIC(BIC_IRQ)) {
+		if (sums_need_wide_columns)
+			outp += sprintf(outp, "%s     IRQ", delim);
+		else
+			outp += sprintf(outp, "%sIRQ", delim);
+	}
+
 	if (DO_BIC(BIC_SMI))
 		outp += sprintf(outp, "%sSMI", delim);
 
@@ -501,7 +507,10 @@ void print_header(char *delim)
 			else
 				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
 		} else {
-			outp += sprintf(outp, "%s%s", delim, mp->name);
+			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "%s%8s", delim, mp->name);
+			else
+				outp += sprintf(outp, "%s%s", delim, mp->name);
 		}
 	}
 
@@ -527,7 +536,10 @@ void print_header(char *delim)
 			else
 				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
 		} else {
-			outp += sprintf(outp, "%s%s", delim, mp->name);
+			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "%s%8s", delim, mp->name);
+			else
+				outp += sprintf(outp, "%s%s", delim, mp->name);
 		}
 	}
 
@@ -596,7 +608,10 @@ void print_header(char *delim)
 			else
 				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
 		} else {
-			outp += sprintf(outp, "%s%s", delim, mp->name);
+			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "%s%8s", delim, mp->name);
+			else
+				outp += sprintf(outp, "%s%s", delim, mp->name);
 		}
 	}
 
@@ -620,7 +635,7 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "c1: %016llX\n", t->c1);
 
 		if (DO_BIC(BIC_IRQ))
-			outp += sprintf(outp, "IRQ: %d\n", t->irq_count);
+			outp += sprintf(outp, "IRQ: %lld\n", t->irq_count);
 		if (DO_BIC(BIC_SMI))
 			outp += sprintf(outp, "SMI: %d\n", t->smi_count);
 
@@ -755,8 +770,12 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "\t%.0f", 1.0 * t->tsc/units/interval_float);
 
 	/* IRQ */
-	if (DO_BIC(BIC_IRQ))
-		outp += sprintf(outp, "\t%d", t->irq_count);
+	if (DO_BIC(BIC_IRQ)) {
+		if (sums_need_wide_columns)
+			outp += sprintf(outp, "\t%8lld", t->irq_count);
+		else
+			outp += sprintf(outp, "\t%lld", t->irq_count);
+	}
 
 	/* SMI */
 	if (DO_BIC(BIC_SMI))
@@ -770,7 +789,10 @@ int format_counters(struct thread_data *t, struct core_data *c,
 			else
 				outp += sprintf(outp, "\t0x%016llx", t->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
-			outp += sprintf(outp, "\t%lld", t->counter[i]);
+			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "\t%8lld", t->counter[i]);
+			else
+				outp += sprintf(outp, "\t%lld", t->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
 			if (mp->type == COUNTER_USEC)
 				outp += sprintf(outp, "\t%.2f", t->counter[i]/interval_float/10000);
@@ -809,7 +831,10 @@ int format_counters(struct thread_data *t, struct core_data *c,
 			else
 				outp += sprintf(outp, "\t0x%016llx", c->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
-			outp += sprintf(outp, "\t%lld", c->counter[i]);
+			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "\t%8lld", c->counter[i]);
+			else
+				outp += sprintf(outp, "\t%lld", c->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
 			outp += sprintf(outp, "\t%.2f", 100.0 * c->counter[i]/tsc);
 		}
@@ -897,7 +922,10 @@ int format_counters(struct thread_data *t, struct core_data *c,
 			else
 				outp += sprintf(outp, "\t0x%016llx", p->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
-			outp += sprintf(outp, "\t%lld", p->counter[i]);
+			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
+				outp += sprintf(outp, "\t%8lld", p->counter[i]);
+			else
+				outp += sprintf(outp, "\t%lld", p->counter[i]);
 		} else if (mp->format == FORMAT_PERCENT) {
 			outp += sprintf(outp, "\t%.2f", 100.0 * p->counter[i]/tsc);
 		}
@@ -1272,6 +1300,9 @@ void compute_average(struct thread_data *t, struct core_data *c,
 	average.threads.mperf /= topo.num_cpus;
 	average.threads.c1 /= topo.num_cpus;
 
+	if (average.threads.irq_count > 9999999)
+		sums_need_wide_columns = 1;
+
 	average.cores.c3 /= topo.num_cores;
 	average.cores.c6 /= topo.num_cores;
 	average.cores.c7 /= topo.num_cores;
@@ -1299,18 +1330,29 @@ void compute_average(struct thread_data *t, struct core_data *c,
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
-		if (mp->flags & SYSFS_PERCPU && mp->type == COUNTER_ITEMS)
+		if (mp->type == COUNTER_ITEMS) {
+			if (average.threads.counter[i] > 9999999)
+				sums_need_wide_columns = 1;
 			continue;
+		}
 		average.threads.counter[i] /= topo.num_cpus;
 	}
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
+		if (mp->type == COUNTER_ITEMS) {
+			if (average.cores.counter[i] > 9999999)
+				sums_need_wide_columns = 1;
+		}
 		average.cores.counter[i] /= topo.num_cores;
 	}
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
+		if (mp->type == COUNTER_ITEMS) {
+			if (average.packages.counter[i] > 9999999)
+				sums_need_wide_columns = 1;
+		}
 		average.packages.counter[i] /= topo.num_packages;
 	}
 }
-- 
2.11.0.161.g6610af872
