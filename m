From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Add checks to report cpu frequency throttling conditions
Date: Thu, 26 Mar 2015 23:49:37 +0530
Message-ID: <1427393977-31663-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:49623 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbbCZSUP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 14:20:15 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Thu, 26 Mar 2015 23:50:12 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Cpu frequency can be throttled due to failures of components like OCC,
power supply and fan. It can also be throttled due to temperature and
power limit. We can detect the throttling by checking 1)if max frequency
is reduced, 2)if the core is put to safe frequency 3)if the SPR based
frequency management is disabled.

The current status of the core is read from Power Management Status
Register(PMSR) to check if any of the throttling condition is
occurred and the appropriate throttling message is reported.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 2dfd4fd..40fa1d3 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -36,7 +36,7 @@
 #define POWERNV_MAX_PSTATES	256
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
-static bool rebooting;
+static bool rebooting, throttled;
 
 /*
  * Note: The set of pstates consists of contiguous integers, the
@@ -294,6 +294,41 @@ static inline unsigned int get_nominal_index(void)
 	return powernv_pstate_info.max - powernv_pstate_info.nominal;
 }
 
+static void powernv_cpufreq_throttle_check(unsigned int cpu)
+{
+	unsigned long pmsr, pmcr;
+	int pmsr_pmax, pmsr_lp;
+
+	pmcr = get_pmspr(SPRN_PMCR);
+	pmsr = get_pmspr(SPRN_PMSR);
+
+	/* Check for Pmax Capping */
+	pmsr_pmax = (s8)((pmsr >> 32) & 0xFF);
+	if (pmsr_pmax != powernv_pstate_info.max) {
+		throttled = true;
+		pr_warn("Cpu %d Pmax is reduced to %d\n", cpu, pmsr_pmax);
+	}
+
+	/* Check for Psafe by reading LocalPstate
+	 * or check if Psafe_mode_active- 34th bit is set in PMSR.
+	 */
+	pmsr_lp = (s8)((pmsr >> 48) & 0xFF);
+	if ((pmsr_lp < powernv_pstate_info.min) || ((pmsr >> 30) & 1)) {
+		throttled = true;
+		pr_warn("Cpu %d in Psafe %d PMSR[34]=%lx\n", cpu,
+				pmsr_lp, ((pmsr >> 30) & 1));
+	}
+
+	/* Check if SPR_EM_DISABLED- 33rd bit is set in PMSR */
+	if ((pmsr >> 31) & 1) {
+		throttled = true;
+		pr_warn("Frequency management disabled cpu %d PMSR[33]=%lx\n",
+				cpu, ((pmsr >> 31) & 1));
+	}
+	if (throttled)
+		pr_warn("Cpu Frequency is throttled\n");
+}
+
 /*
  * powernv_cpufreq_target_index: Sets the frequency corresponding to
  * the cpufreq table entry indexed by new_index on the cpus in the
@@ -307,6 +342,9 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	if (unlikely(rebooting) && new_index != get_nominal_index())
 		return 0;
 
+	if (!throttled)
+		powernv_cpufreq_throttle_check(smp_processor_id());
+
 	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
 	/*
-- 
1.9.3

