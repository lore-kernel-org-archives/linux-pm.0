From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Add io_boost trace
Date: Tue, 13 Sep 2016 17:41:33 -0700
Message-ID: <1473813693-193829-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:50697 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932484AbcINAlm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Sep 2016 20:41:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Add io_boost percent to current pstate_sample tracepoint.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c |  3 ++-
 include/trace/events/power.h   | 13 +++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 5bf7726..c877e70 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1316,7 +1316,8 @@ static inline void intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
 		sample->mperf,
 		sample->aperf,
 		sample->tsc,
-		get_avg_frequency(cpu));
+		get_avg_frequency(cpu),
+		fp_toint(cpu->iowait_boost * 100));
 }
 
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 19e5030..54e3aad 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -69,7 +69,8 @@ TRACE_EVENT(pstate_sample,
 		u64 mperf,
 		u64 aperf,
 		u64 tsc,
-		u32 freq
+		u32 freq,
+		u32 io_boost
 		),
 
 	TP_ARGS(core_busy,
@@ -79,7 +80,8 @@ TRACE_EVENT(pstate_sample,
 		mperf,
 		aperf,
 		tsc,
-		freq
+		freq,
+		io_boost
 		),
 
 	TP_STRUCT__entry(
@@ -91,6 +93,7 @@ TRACE_EVENT(pstate_sample,
 		__field(u64, aperf)
 		__field(u64, tsc)
 		__field(u32, freq)
+		__field(u32, io_boost)
 		),
 
 	TP_fast_assign(
@@ -102,9 +105,10 @@ TRACE_EVENT(pstate_sample,
 		__entry->aperf = aperf;
 		__entry->tsc = tsc;
 		__entry->freq = freq;
+		__entry->io_boost = io_boost;
 		),
 
-	TP_printk("core_busy=%lu scaled=%lu from=%lu to=%lu mperf=%llu aperf=%llu tsc=%llu freq=%lu ",
+	TP_printk("core_busy=%lu scaled=%lu from=%lu to=%lu mperf=%llu aperf=%llu tsc=%llu freq=%lu io_boost=%lu",
 		(unsigned long)__entry->core_busy,
 		(unsigned long)__entry->scaled_busy,
 		(unsigned long)__entry->from,
@@ -112,7 +116,8 @@ TRACE_EVENT(pstate_sample,
 		(unsigned long long)__entry->mperf,
 		(unsigned long long)__entry->aperf,
 		(unsigned long long)__entry->tsc,
-		(unsigned long)__entry->freq
+		(unsigned long)__entry->freq,
+		(unsigned long)__entry->io_boost
 		)
 
 );
-- 
2.7.4

