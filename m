From: Erwan Velu <erwanaliasr1@gmail.com>
Subject: [PATCH v2] cpufreq: intel_pstate: Reporting reasons why driver prematurely exit
Date: Mon, 11 Feb 2019 10:28:26 +0100
Message-ID: <20190211092827.23188-1-e.velu@criteo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: e.velu@criteo.com, Liam.Howlett@oracle.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The init code path have several execeptions where the module can decide not to load.
As CONFIG_X86_INTEL_PSTATE is generally set to Y, the return code is not reachable.
The initialisation code is neither verbose of the reason why it did choose to prematurely exit.

This situation leads to situation where its difficult for a user to determine,
on a given platform, why the driver didn't loaded properly.

This patch is about reporting to the user the reason/context why the driver failed to load.
That is a precious hint when debugging a platform.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/cpufreq/intel_pstate.c | 39 ++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dd66decf2087..2b10f8864898 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2475,6 +2475,7 @@ static bool __init intel_pstate_no_acpi_pss(void)
 		kfree(pss);
 	}
 
+	pr_info("Cannot detect ACPI PSS");
 	return true;
 }
 
@@ -2484,10 +2485,16 @@ static bool __init intel_pstate_no_acpi_pcch(void)
 	acpi_handle handle;
 
 	status = acpi_get_handle(NULL, "\\_SB", &handle);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		pr_info("Cannot detect ACPI SB");
 		return true;
+	}
 
-	return !acpi_has_method(handle, "PCCH");
+	status = acpi_has_method(handle, "PCCH");
+	if (!status) {
+		pr_info("Cannot detect ACPI PCCH");
+	}
+	return !status;
 }
 
 static bool __init intel_pstate_has_acpi_ppc(void)
@@ -2499,9 +2506,11 @@ static bool __init intel_pstate_has_acpi_ppc(void)
 
 		if (!pr)
 			continue;
-		if (acpi_has_method(pr->handle, "_PPC"))
+		if (acpi_has_method(pr->handle, "_PPC")) {
 			return true;
+		}
 	}
+	pr_info("Cannot detect ACPI PPC");
 	return false;
 }
 
@@ -2592,8 +2601,10 @@ static int __init intel_pstate_init(void)
 	const struct x86_cpu_id *id;
 	int rc;
 
-	if (no_load)
+	if (no_load) {
+		pr_info("disabling as per user-request\n");
 		return -ENODEV;
+	}
 
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
@@ -2606,31 +2617,41 @@ static int __init intel_pstate_init(void)
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
 
-	if (!hwp_active && hwp_only)
+	if (!hwp_active && hwp_only) {
+		pr_warn("HWP not present\n");
 		return -ENOTSUPP;
+	}
 
 	pr_info("Intel P-state driver initializing\n");
 
 	all_cpu_data = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
-	if (!all_cpu_data)
+	if (!all_cpu_data) {
+		pr_warn("Cannot allocate memory\n");
 		return -ENOMEM;
+	}
 
 	intel_pstate_request_control_from_smm();
 
-- 
2.20.1
