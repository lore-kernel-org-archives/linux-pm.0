From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 3/3] cpufreq: intel_pstate: Enable PPC enforcement for servers
Date: Wed, 27 Apr 2016 15:48:08 -0700
Message-ID: <1461797288-31573-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1461797288-31573-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52033 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbcD0WsE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Apr 2016 18:48:04 -0400
In-Reply-To: <1461797288-31573-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: khlebnikov@yandex-team.ru, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

For platforms which are controlled via remove node manager, enable _PPC by
default. These platforms are mostly categorized as enterprise server or
performance servers. These platforms needs to go through some
certifications tests, which tests control via _PPC.
The relative risk of enabling by default is  low as this is is less likely
that these systems have broken _PSS table.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/kernel-parameters.txt |  5 ++++-
 drivers/cpufreq/intel_pstate.c      | 12 +++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4199a1b..52292b2 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1662,7 +1662,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Only load intel_pstate on systems which support
 			hardware P state control (HWP) if available.
 		support_acpi_ppc
-			Enforce ACPI _PPC performance limits.
+			Enforce ACPI _PPC performance limits. If the Fixed ACPI
+			Description Table, specifies preferred power management
+			profile as "Enterprise Server" or "Performance Server",
+			then this feature is turned on by default.
 
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c4894ff..7da7672 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -345,6 +345,16 @@ static struct perf_limits *limits = &powersave_limits;
 #endif
 
 #ifdef CONFIG_ACPI
+
+static bool intel_pstate_get_ppc_enable_status(void)
+{
+	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
+	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
+		return true;
+
+	return acpi_ppc;
+}
+
 /*
  * The max target pstate ratio is a 8 bit value in both PLATFORM_INFO MSR and
  * in TURBO_RATIO_LIMIT MSR, which pstate driver stores in max_pstate and
@@ -368,7 +378,7 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 	int ret;
 	int i;
 
-	if (!acpi_ppc)
+	if (!intel_pstate_get_ppc_enable_status())
 		return;
 
 	cpu = all_cpu_data[policy->cpu];
-- 
2.5.5

