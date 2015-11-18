From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] cpufreq, intel_pstate.c, Fix rounding errors
Date: Wed, 18 Nov 2015 10:55:44 -0500
Message-ID: <1447862144-7188-1-git-send-email-prarit@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

I have a Intel (6,63) processor with a "marketing" frequency (from
/proc/cpuinfo) of 2100MHz, and a max turbo frequency of 2600MHz.  I
can execute

cpupower frequency-set -g powersave --min 1200MHz --max 2100MHz

and the max_freq_pct is set to 80.  When adding load to the system I noticed
that the cpu frequency only reached 2000MHZ and not 2100MHz as expected.

I wrote a little test program to set the frequencies in decrements of
100MHz and compared the targeted frequency (the frequency set through
the cpupower command) and the actual frequency (from /proc/cpuinfo), as
well as dumping out the value of the MSR_IA32_PERF_CTL.

Target     Achieved     Difference     MSR(0x199)
 3300        2900          -400          0x1e00
 3200        2900          -300          0x1e00
 3100        2900          -200          0x1e00
 3000        2900          -100          0x1d00
 2900        2800          -100          0x1c00
 2800        2700          -100          0x1b00
 2700        2600          -100          0x1a00
 2600        2500          -100          0x1900
 2500        2400          -100          0x1800
 2400        2300          -100          0x1700
 2300        2200          -100          0x1600
 2200        2100          -100          0x1500
 2100        2000          -100          0x1400
 2000        1900          -100          0x1300
 1900        1800          -100          0x1200
 1800        1700          -100          0x1100
 1700        1600          -100          0x1000
 1600        1500          -100          0xf00
 1500        1400          -100          0xe00
 1400        1300          -100          0xd00
 1300        1200          -100          0xc00
 1200        1200             0          0xc00

As can be seen the frequencies are consistently off by 100MHz.  After
some examination I found a rounding error in intel_pstate_set_policy() for the
calculation of limits->max_policy_pct which needs to be rounded up to the
nearest percentage point.  For example, setting a frequency of 2100MHz on this
system results in limits->max_policy_pct = ((2100 * 100) / 2600) = 80.
However, ((2100 * 100) / 2600) is actually 80.7, or 81.   This is fixed
by expanding the calculation an extra decimal point and rounding to the
nearest percentage point.

A second rounding error was found in the calculation of limits->max_perf
in intel_pstate_set_policy(), which is used to calculate the max and min
pstate values in intel_pstate_get_min_max().  In this case, limits->max_perf
is truncated to 2 hex digits such that, for example, 0x169 was incorrectly
truncated to 0x16 instead of 0x17.  This resulted in the pstate being set
one level too low.

After applying these two fixes we consistently reach the targeted
frequency.

Target     Achieved     Difference     MSR(0x199)
 3300        2900          -400          0x1e00
 3200        2900          -300          0x1e00
 3100        2900          -200          0x1e00
 3000        2900          -100          0x1d00
 2900        2900             0          0x1d00
 2800        2800             0          0x1c00
 2700        2700             0          0x1b00
 2600        2600             0          0x1a00
 2500        2500             0          0x1900
 2400        2400             0          0x1800
 2300        2300             0          0x1700
 2200        2200             0          0x1600
 2100        2100             0          0x1500
 2000        2000             0          0x1400
 1900        1900             0          0x1300
 1800        1800             0          0x1200
 1700        1700             0          0x1100
 1600        1600             0          0x1000
 1500        1500             0          0xf00
 1400        1400             0          0xe00
 1300        1300             0          0xd00
 1200        1200             0          0xc00

Additional tests were run on a (6,78) with HWP enabled and a (6,79)
system.  Testing on both systems showed that the problem was resolved.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Alexandra Yates <alexandra.yates@intel.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/cpufreq/intel_pstate.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2e31d09..686f024 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1233,6 +1233,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	struct cpudata *cpu;
 	int i;
 #endif
+	int max_policy_calc;
+
 	pr_debug("intel_pstate: %s max %u policy->max %u\n", __func__,
 		 policy->cpuinfo.max_freq, policy->max);
 	if (!policy->cpuinfo.max_freq)
@@ -1249,7 +1251,10 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	limits = &powersave_limits;
 	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
 	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
-	limits->max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
+
+	max_policy_calc = (policy->max * 1000) / policy->cpuinfo.max_freq;
+	limits->max_policy_pct = DIV_ROUND_UP(max_policy_calc, 10);
+
 	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
 
 	/* Normalize user input to [min_policy_pct, max_policy_pct] */
@@ -1269,6 +1274,7 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 				  int_tofp(100));
 	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
 				  int_tofp(100));
+	limits->max_perf = round_up(limits->max_perf, 8);
 
 #if IS_ENABLED(CONFIG_ACPI)
 	cpu = all_cpu_data[policy->cpu];
-- 
1.7.9.3
