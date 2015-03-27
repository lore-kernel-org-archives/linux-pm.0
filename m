From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3] cpufreq: powernv: Report cpu frequency throttling
Date: Fri, 27 Mar 2015 13:02:03 +0530
Message-ID: <1427441523-5189-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:51560 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbbC0HcP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2015 03:32:15 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Fri, 27 Mar 2015 13:02:12 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

The power and thermal safety of the system is taken care by an
On-Chip-Controller (OCC) which is real-time subsystem embedded within
the POWER8 processor. OCC continuously monitors the memory and core
temperature, the total system power, state of power supply and fan.

The cpu frequency can be throttled by OCC for the following reasons:
1)If a processor crosses its power and temperature limit then OCC will
  lower its Pmax to reduce the frequency and voltage.
2)If OCC crashes then the system is forced to Psafe frequency.
3)If OCC fails to recover then the kernel is not allowed to do any
  further frequency changes and the chip will remain in Psafe.

The user can see a drop in performance when frequency is throttled and
is unaware of throttling. So detect and report such a condition so
that user can check the OCC status to reboot the system or check for
power supply or fan failures.

The current status of the core is read from Power Management Status
Register(PMSR) to check if any of the throttling condition is occurred
and the appropriate throttling message is reported.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V2:
-Changed commit log to add more details.
-Fixed multi-line comment to proper format

Changes from V1: Removed unused value of PMCR register

 drivers/cpufreq/powernv-cpufreq.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 2dfd4fd..0eb89a9 100644
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
+	unsigned long pmsr;
+	int pmsr_pmax, pmsr_lp;
+
+	pmsr = get_pmspr(SPRN_PMSR);
+
+	/* Check for Pmax Capping */
+	pmsr_pmax = (s8)((pmsr >> 32) & 0xFF);
+	if (pmsr_pmax != powernv_pstate_info.max) {
+		throttled = true;
+		pr_warn("Cpu %d Pmax is reduced to %d\n", cpu, pmsr_pmax);
+	}
+
+	/*
+	 * Check for Psafe by reading LocalPstate
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

