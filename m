From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: adjust _PSS[0] freqeuency
Date: Tue, 14 Jun 2016 23:12:59 -0700
Message-ID: <1465971179-7832-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33738 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbcFNXOS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jun 2016 19:14:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Intel P State uses max P-State as the max turbo P-State. This max P-State
can be limited by ACPI _PSS table entry 0. After
'commit 9522a2ff9cde ("cpufreq: intel_pstate: Enforce _PPC limits")''
the _PSS table entry[0] will be used to cap max performance for
enterprise and performance server by default.

Even though this is correct processing, but when the performance results
are compared with the version before the above commit, then obviously the
results will be worse, if the _PSS table entry 0 is not the max turbo
P-State.

This change will change the _PSS table entry 0 to the max turbo frequency
if turbo is enabled in the BIOS. In this way, the performance will be
comparable to the version without _PSS/_PPC support.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ee367e9..fe9dc17 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -372,26 +372,9 @@ static bool intel_pstate_get_ppc_enable_status(void)
 	return acpi_ppc;
 }
 
-/*
- * The max target pstate ratio is a 8 bit value in both PLATFORM_INFO MSR and
- * in TURBO_RATIO_LIMIT MSR, which pstate driver stores in max_pstate and
- * max_turbo_pstate fields. The PERF_CTL MSR contains 16 bit value for P state
- * ratio, out of it only high 8 bits are used. For example 0x1700 is setting
- * target ratio 0x17. The _PSS control value stores in a format which can be
- * directly written to PERF_CTL MSR. But in intel_pstate driver this shift
- * occurs during write to PERF_CTL (E.g. for cores core_set_pstate()).
- * This function converts the _PSS control value to intel pstate driver format
- * for comparison and assignment.
- */
-static int convert_to_native_pstate_format(struct cpudata *cpu, int index)
-{
-	return cpu->acpi_perf_data.states[index].control >> 8;
-}
-
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
-	int turbo_pss_ctl;
 	int ret;
 	int i;
 
@@ -441,11 +424,10 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 	 * max frequency, which will cause a reduced performance as
 	 * this driver uses real max turbo frequency as the max
 	 * frequency. So correct this frequency in _PSS table to
-	 * correct max turbo frequency based on the turbo ratio.
+	 * correct max turbo frequency based on the turbo state.
 	 * Also need to convert to MHz as _PSS freq is in MHz.
 	 */
-	turbo_pss_ctl = convert_to_native_pstate_format(cpu, 0);
-	if (turbo_pss_ctl > cpu->pstate.max_pstate)
+	if (!limits->turbo_disabled)
 		cpu->acpi_perf_data.states[0].core_frequency =
 					policy->cpuinfo.max_freq / 1000;
 	cpu->valid_pss_table = true;
-- 
2.5.0

