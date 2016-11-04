From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 2/2] cpufreq: powernv: Use PMSR to verify global and local pstate
Date: Fri,  4 Nov 2016 10:57:35 +0530
Message-ID: <1478237255-4258-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

As fast_switch may get called in interrupt disable mode, it does not
update the global_pstate_info data structure. Hence the global_pstate_info
has stale data whenever pstate is updated through fast_swtich().

So the gpstate_timer can fire after a fast_switch() call has update
the pstates to a different value. Hence the timer handler cannot rely
on the cached values of local and global pstate and needs to read it
from the PMSR. 

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

---
 drivers/cpufreq/powernv-cpufreq.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 09a0496..57713b5 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -592,7 +592,8 @@ void gpstate_timer_handler(unsigned long data)
 {
 	struct cpufreq_policy *policy = (struct cpufreq_policy *)data;
 	struct global_pstate_info *gpstates = policy->driver_data;
-	int gpstate_idx;
+	int gpstate_idx, lpstate_idx;
+	unsigned long val;
 	unsigned int time_diff = jiffies_to_msecs(jiffies)
 					- gpstates->last_sampled_time;
 	struct powernv_smp_call_data freq_data;
@@ -600,21 +601,36 @@ void gpstate_timer_handler(unsigned long data)
 	if (!spin_trylock(&gpstates->gpstate_lock))
 		return;
 
+	/*
+	 * If PMCR was last updated was using fast_swtich then
+	 * We may have wrong in gpstate->last_lpstate_idx
+	 * value. Hence, read from PMCR to get correct data.
+	 */
+	val = get_pmspr(SPRN_PMCR);
+	freq_data.gpstate_id = (val >> (56)) & 0xFF;
+	freq_data.pstate_id = (val >> (48)) & 0xFF;
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
@@ -622,10 +638,6 @@ void gpstate_timer_handler(unsigned long data)
 	if (gpstate_idx != gpstates->last_lpstate_idx)
 		queue_gpstate_timer(gpstates);
 
-	freq_data.gpstate_id = idx_to_pstate(gpstate_idx);
-	gpstates->last_gpstate_idx = pstate_to_idx(freq_data.gpstate_id);
-	gpstates->last_lpstate_idx = pstate_to_idx(freq_data.pstate_id);
-
 	spin_unlock(&gpstates->gpstate_lock);
 
 	/* Timer may get migrated to a different cpu on cpu hot unplug */
-- 
2.7.4
