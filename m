From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] tools/power turbostat: if  --debug, print sampling overhead
Date: Sat, 24 Jun 2017 20:12:58 -0700
Message-ID: <f4fdf2b474606580b95eed95d06c762d4fd3f57b.1498359826.git.len.brown@intel.com>
References: <1498360381-10293-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33119 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFYDNK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 23:13:10 -0400
Received: by mail-qk0-f193.google.com with SMTP id p21so10962844qke.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2017 20:13:09 -0700 (PDT)
In-Reply-To: <1498360381-10293-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a99d87306f83d2a97c8c7e854b6583c4037ecf75.1498359826.git.len.brown@intel.com>
References: <a99d87306f83d2a97c8c7e854b6583c4037ecf75.1498359826.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The --debug option now pre-pends each row with
the number  of micro-seconds [usec] to collect
the finishing snapshot for that row.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2b25727..6f7c64a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -150,6 +150,8 @@ size_t cpu_present_setsize, cpu_affinity_setsize, cpu_subset_size;
 #define MAX_ADDED_COUNTERS 16
 
 struct thread_data {
+	struct timeval tv_begin;
+	struct timeval tv_end;
 	unsigned long long tsc;
 	unsigned long long aperf;
 	unsigned long long mperf;
@@ -530,6 +532,8 @@ void print_header(char *delim)
 	struct msr_counter *mp;
 	int printed = 0;
 
+	if (debug)
+		outp += sprintf(outp, "usec %s", delim);
 	if (DO_BIC(BIC_Package))
 		outp += sprintf(outp, "%sPackage", (printed++ ? delim : ""));
 	if (DO_BIC(BIC_Core))
@@ -782,6 +786,14 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		(cpu_subset && !CPU_ISSET_S(t->cpu_id, cpu_subset_size, cpu_subset)))
 		return 0;
 
+	if (debug) {
+		/* on each row, print how many usec each timestamp took to gather */
+		struct timeval tv;
+
+		timersub(&t->tv_end, &t->tv_begin, &tv);
+		outp += sprintf(outp, "%5ld\t", tv.tv_sec * 1000000 + tv.tv_usec);
+	}
+
 	interval_float = tv_delta.tv_sec + tv_delta.tv_usec/1000000.0;
 
 	tsc = t->tsc * tsc_tweak;
@@ -1503,6 +1515,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	struct msr_counter *mp;
 	int i;
 
+
+	gettimeofday(&t->tv_begin, (struct timezone *)NULL);
+
 	if (cpu_migrate(cpu)) {
 		fprintf(outf, "Could not migrate to CPU %d\n", cpu);
 		return -1;
@@ -1586,7 +1601,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	/* collect core counters only for 1st thread in core */
 	if (!(t->flags & CPU_IS_FIRST_THREAD_IN_CORE))
-		return 0;
+		goto done;
 
 	if (DO_BIC(BIC_CPU_c3) && !do_slm_cstates && !do_knl_cstates) {
 		if (get_msr(cpu, MSR_CORE_C3_RESIDENCY, &c->c3))
@@ -1622,7 +1637,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	/* collect package counters only for 1st core in package */
 	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
-		return 0;
+		goto done;
 
 	if (DO_BIC(BIC_Totl_c0)) {
 		if (get_msr(cpu, MSR_PKG_WEIGHTED_CORE_C0_RES, &p->pkg_wtd_core_c0))
@@ -1715,6 +1730,8 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		if (get_mp(cpu, mp, &p->counter[i]))
 			return -10;
 	}
+done:
+	gettimeofday(&t->tv_end, (struct timezone *)NULL);
 
 	return 0;
 }
-- 
2.7.4
