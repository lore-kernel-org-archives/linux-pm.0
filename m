From: Erwan Velu <erwanaliasr1@gmail.com>
Subject: [PATCH v5] cpufreq: intel_pstate: Reporting reasons why driver prematurely exit
Date: Wed, 13 Feb 2019 09:58:35 +0100
Message-ID: <20190213085835.4705-1-e.velu@criteo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: rafael@kernel.org, Erwan Velu <e.velu@criteo.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The init code path has several exceptions where the module can decide not to load.
As CONFIG_X86_INTEL_PSTATE is generally set to Y, the return code is not reachable.
The initialization code is neither verbose of the reason why it did choose to prematurely exit.

This situation leads to a situation where its difficult for a user to determine,
on a given platform, why the driver didn't load properly.

This patch is about reporting to the user the reason/context of why the driver failed to load.
That is a precious hint when debugging a platform.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/cpufreq/intel_pstate.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd66decf2087..c6220261a87f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2475,6 +2475,7 @@ static bool __init intel_pstate_no_acpi_pss(void)
 		kfree(pss);
 	}
 
+	pr_debug("ACPI _PSS not found\n");
 	return true;
 }
 
@@ -2484,10 +2485,15 @@ static bool __init intel_pstate_no_acpi_pcch(void)
 	acpi_handle handle;
 
 	status = acpi_get_handle(NULL, "\\_SB", &handle);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		pr_debug("ACPI _SB not found\n");
 		return true;
+	}
 
-	return !acpi_has_method(handle, "PCCH");
+	status = acpi_has_method(handle, "PCCH");
+	if (!status)
+		pr_debug("ACPI PCCH not found\n");
+	return !status;
 }
 
 static bool __init intel_pstate_has_acpi_ppc(void)
@@ -2502,6 +2508,7 @@ static bool __init intel_pstate_has_acpi_ppc(void)
 		if (acpi_has_method(pr->handle, "_PPC"))
 			return true;
 	}
+	pr_debug("ACPI _PPC not found\n");
 	return false;
 }
 
@@ -2539,8 +2546,10 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
 	if (id) {
 		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
-		if ( misc_pwr & (1 << 8))
+		if (misc_pwr & (1 << 8)) {
+			pr_debug("MSR_MISC_PWR_MGMT enabled\n");
 			return true;
+		}
 	}
 
 	idx = acpi_match_platform_list(plat_info);
@@ -2606,22 +2615,28 @@ static int __init intel_pstate_init(void)
 		}
 	} else {
 		id = x86_match_cpu(intel_pstate_cpu_ids);
-		if (!id)
+		if (!id) {
+			pr_warn("CPU ID is not in the list of supported devices\n");
 			return -ENODEV;
+		}
 
 		copy_cpu_funcs((struct pstate_funcs *)id->driver_data);
 	}
 
-	if (intel_pstate_msrs_not_valid())
+	if (intel_pstate_msrs_not_valid()) {
+		pr_warn("Cannot enable driver as per invalid MSRs\n");
 		return -ENODEV;
+	}
 
 hwp_cpu_matched:
 	/*
 	 * The Intel pstate driver will be ignored if the platform
 	 * firmware has its own power management modes.
 	 */
-	if (intel_pstate_platform_pwr_mgmt_exists())
+	if (intel_pstate_platform_pwr_mgmt_exists()) {
+		pr_warn("Platform already taking care of power management\n");
 		return -ENODEV;
+	}
 
 	if (!hwp_active && hwp_only)
 		return -ENOTSUPP;
-- 
2.20.1
