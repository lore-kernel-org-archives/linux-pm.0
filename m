From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v3 2/2] cpufreq: powernv: Use PMCR to verify global and local pstate
Date: Tue,  8 Nov 2016 19:03:28 +0530
Message-ID: <1478612008-20703-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1478612008-20703-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35131 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751243AbcKHNd4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 08:33:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA8DXoIf000749
        for <linux-pm@vger.kernel.org>; Tue, 8 Nov 2016 08:33:55 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26keg967a0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 08 Nov 2016 08:33:54 -0500
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Tue, 8 Nov 2016 23:33:51 +1000
In-Reply-To: <1478612008-20703-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, shilpa.bhat@linux.vnet.ibm.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

As fast_switch() may get called with interrupt disable mode, we cannot
hold a mutex to update the global_pstate_info. So currently, fast_switch()
does not update the global_pstate_info and it will end up with stale data
whenever pstate is updated through fast_switch().

As the gpstate_timer can fire after fast_switch() has updated the pstates,
the timer handler cannot rely on the cached values of local and global
pstate and needs to read it from the PMCR.

Only gpstate_timer_handler() is affected by the stale cached pstate data
beacause either fast_switch() or target_index() routines will be called
for a given govenor, but gpstate_timer can fire after the governor has
changed to schedutil.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes from v2 :
- Added generic macros GET_LPSTATE and GET_GPSTATE
 instead of making it specific to PMCR.
Changes from v1 :
- Corrected Commit message
- Type cast pstate values read from PMCR to type s8
- Added Macros to get local and global pstates from PMCR

 drivers/cpufreq/powernv-cpufreq.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 4a4380d..c82304b 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -42,6 +42,10 @@
 #define PMSR_PSAFE_ENABLE	(1UL << 30)
 #define PMSR_SPR_EM_DISABLE	(1UL << 31)
 #define PMSR_MAX(x)		((x >> 32) & 0xFF)
+#define LPSTATE_SHIFT		48
+#define GPSTATE_SHIFT		56
+#define GET_LPSTATE(x)		(((x) >> LPSTATE_SHIFT) & 0xFF)
+#define GET_GPSTATE(x)		(((x) >> GPSTATE_SHIFT) & 0xFF)
 
 #define MAX_RAMP_DOWN_TIME				5120
 /*
@@ -592,7 +596,8 @@ void gpstate_timer_handler(unsigned long data)
 {
 	struct cpufreq_policy *policy = (struct cpufreq_policy *)data;
 	struct global_pstate_info *gpstates = policy->driver_data;
-	int gpstate_idx;
+	int gpstate_idx, lpstate_idx;
+	unsigned long val;
 	unsigned int time_diff = jiffies_to_msecs(jiffies)
 					- gpstates->last_sampled_time;
 	struct powernv_smp_call_data freq_data;
@@ -600,21 +605,36 @@ void gpstate_timer_handler(unsigned long data)
 	if (!spin_trylock(&gpstates->gpstate_lock))
 		return;
 
+	/*
+	 * If PMCR was last updated was using fast_swtich then
+	 * We may have wrong in gpstate->last_lpstate_idx
+	 * value. Hence, read from PMCR to get correct data.
+	 */
+	val = get_pmspr(SPRN_PMCR);
+	freq_data.gpstate_id = (s8)GET_GPSTATE(val);
+	freq_data.pstate_id = (s8)GET_LPSTATE(val);
+	if (freq_data.gpstate_id  == freq_data.pstate_id) {
+		reset_gpstates(policy);
+		spin_unlock(&gpstates->gpstate_lock);
+		return;
+	}
+
 	gpstates->last_sampled_time += time_diff;
 	gpstates->elapsed_time += time_diff;
-	freq_data.pstate_id = idx_to_pstate(gpstates->last_lpstate_idx);
 
-	if ((gpstates->last_gpstate_idx == gpstates->last_lpstate_idx) ||
-	    (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME)) {
+	if (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME) {
 		gpstate_idx = pstate_to_idx(freq_data.pstate_id);
 		reset_gpstates(policy);
 		gpstates->highest_lpstate_idx = gpstate_idx;
 	} else {
+		lpstate_idx = pstate_to_idx(freq_data.pstate_id);
 		gpstate_idx = calc_global_pstate(gpstates->elapsed_time,
 						 gpstates->highest_lpstate_idx,
-						 gpstates->last_lpstate_idx);
+						 lpstate_idx);
 	}
-
+	freq_data.gpstate_id = idx_to_pstate(gpstate_idx);
+	gpstates->last_gpstate_idx = gpstate_idx;
+	gpstates->last_lpstate_idx = lpstate_idx;
 	/*
 	 * If local pstate is equal to global pstate, rampdown is over
 	 * So timer is not required to be queued.
@@ -622,10 +642,6 @@ void gpstate_timer_handler(unsigned long data)
 	if (gpstate_idx != gpstates->last_lpstate_idx)
 		queue_gpstate_timer(gpstates);
 
-	freq_data.gpstate_id = idx_to_pstate(gpstate_idx);
-	gpstates->last_gpstate_idx = pstate_to_idx(freq_data.gpstate_id);
-	gpstates->last_lpstate_idx = pstate_to_idx(freq_data.pstate_id);
-
 	spin_unlock(&gpstates->gpstate_lock);
 
 	/* Timer may get migrated to a different cpu on cpu hot unplug */
-- 
2.5.5

