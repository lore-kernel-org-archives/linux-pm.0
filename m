From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4] cpufreq: powernv: Report cpu frequency throttling
Date: Wed,  1 Apr 2015 15:16:34 +0530
Message-ID: <1427881594-13187-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

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
is unaware of throttling. So detect and report such a condition, so
the user can check the OCC status to reboot the system or check for
power supply or fan failures.

The current status of the core is read from Power Management Status
Register(PMSR) to check if any of the throttling condition is occurred
and the appropriate throttling message is reported.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Changes from V3:
-Added macros for shifting and reading bits from PMSR
-More verbose printk messages
-Modified the log level of printk messages to INFO and CRITICAL

Changes from V2:
-Changed commit log to add more details.
-Fixed multi-line comment to proper format

Changes from V1: Removed unused value of PMCR register

 drivers/cpufreq/powernv-cpufreq.c | 47 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 2dfd4fd..ebef0d8 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -34,9 +34,13 @@
 #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
 
 #define POWERNV_MAX_PSTATES	256
+#define PMSR_PSAFE_ENABLE	(1UL << 30)
+#define PMSR_SPR_EM_DISABLE	(1UL << 31)
+#define PMSR_MAX(x)		((x >> 32) & 0xFF)
+#define PMSR_LP(x)		((x >> 48) & 0xFF)
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
-static bool rebooting;
+static bool rebooting, throttled;
 
 /*
  * Note: The set of pstates consists of contiguous integers, the
@@ -294,6 +298,44 @@ static inline unsigned int get_nominal_index(void)
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
+	pmsr_pmax = (s8)PMSR_MAX(pmsr);
+	if (pmsr_pmax != powernv_pstate_info.max) {
+		throttled = true;
+		pr_info("CPU %d Pmax is reduced to %d\n", cpu, pmsr_pmax);
+		pr_info("Max allowed Pstate is capped\n");
+	}
+
+	/*
+	 * Check for Psafe by reading LocalPstate
+	 * or check if Psafe_mode_active is set in PMSR.
+	 */
+	pmsr_lp = (s8)PMSR_LP(pmsr);
+	if ((pmsr_lp < powernv_pstate_info.min) ||
+				(pmsr & PMSR_PSAFE_ENABLE)) {
+		throttled = true;
+		pr_info("Pstate set to safe frequency\n");
+	}
+
+	/* Check if SPR_EM_DISABLE is set in PMSR */
+	if (pmsr & PMSR_SPR_EM_DISABLE) {
+		throttled = true;
+		pr_info("Frequency Control disabled from OS\n");
+	}
+
+	if (throttled) {
+		pr_info("PMSR = %16lx\n", pmsr);
+		pr_crit("CPU Frequency could be throttled\n");
+	}
+}
+
 /*
  * powernv_cpufreq_target_index: Sets the frequency corresponding to
  * the cpufreq table entry indexed by new_index on the cpus in the
@@ -307,6 +349,9 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 	if (unlikely(rebooting) && new_index != get_nominal_index())
 		return 0;
 
+	if (!throttled)
+		powernv_cpufreq_throttle_check(smp_processor_id());
+
 	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
 	/*
-- 
1.9.3
