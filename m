From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Revert "cpufreq: intel_pstate: Enable PPC enforcement for servers"
Date: Wed,  1 Jun 2016 17:41:57 -0700
Message-ID: <1464828117-6534-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:34679 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbcFBAkn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jun 2016 20:40:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This change reverts
'commit 2b3ec7650584 ("cpufreq: intel_pstate: Enable PPC enforcement for
servers")'

Intel P State uses max P-State as the max turbo P-State. This max P-State
can be limited by ACPI _PSS table entry 0. After
'commit 9522a2ff9cde ("cpufreq: intel_pstate: Enforce _PPC limits")''
the _PSS table entry[0] will be used to cap max performance for
enterprise and performance server by default.

Even though this is correct processing, but when the performance results
are compared with the version before the above commit, then obviously the
results will be worse, if the _PSS table entry 0 is not the max turbo
P-State.

So to minimize impact on performance, this revert will disable the default
enforcement of ACPI _PSS and ACPI _PPC. So this feature can only only be
explicitly activated by kernel command line
intel_pstate=support_acpi_ppc

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/kernel-parameters.txt |  5 +----
 drivers/cpufreq/intel_pstate.c      | 15 +--------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 82b42c9..b7c3a56 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1683,10 +1683,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Only load intel_pstate on systems which support
 			hardware P state control (HWP) if available.
 		support_acpi_ppc
-			Enforce ACPI _PPC performance limits. If the Fixed ACPI
-			Description Table, specifies preferred power management
-			profile as "Enterprise Server" or "Performance Server",
-			then this feature is turned on by default.
+			Enforce ACPI _PPC performance limits.
 
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3a9c432..518537c 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -362,16 +362,6 @@ static struct perf_limits *limits = &powersave_limits;
 #endif
 
 #ifdef CONFIG_ACPI
-
-static bool intel_pstate_get_ppc_enable_status(void)
-{
-	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
-	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
-		return true;
-
-	return acpi_ppc;
-}
-
 /*
  * The max target pstate ratio is a 8 bit value in both PLATFORM_INFO MSR and
  * in TURBO_RATIO_LIMIT MSR, which pstate driver stores in max_pstate and
@@ -395,10 +385,7 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 	int ret;
 	int i;
 
-	if (hwp_active)
-		return;
-
-	if (!intel_pstate_get_ppc_enable_status())
+	if (!acpi_ppc || hwp_active)
 		return;
 
 	cpu = all_cpu_data[policy->cpu];
-- 
2.5.5

