From: Adrian Huang <adrian.huang@hp.com>
Subject: [PATCH 1/1] Skip the driver if ACPI has power mgmt option
Date: Thu, 16 Aug 2012 20:12:04 +0800
Message-ID: <1345119124-32673-1-git-send-email-adrian.huang@hp.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:21039 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab3IRBOt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2013 21:14:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linda.knippers@hp.com, Adrian Huang <adrian.huang@hp.com>

Do not load the Intel pstate driver if the platform firmware
(ACPI BIOS) supports the power management alternative.
The ACPI BIOS indicates that the OS control mode can be used
if the _PSS (Performance Supported States) is defined in ACPI
table. For the OS control mode, the Intel pstate driver will be
loaded.

Signed-off-by: Adrian Huang <adrian.huang@hp.com>
---
 drivers/cpufreq/intel_pstate.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6efd96c..c181109 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -25,6 +25,9 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/debugfs.h>
+#include <linux/acpi.h>
+#include <acpi/processor.h>
+
 #include <trace/events/power.h>
 
 #include <asm/div64.h>
@@ -129,6 +132,18 @@ static struct perf_limits limits = {
 	.max_sysfs_pct = 100,
 };
 
+struct hw_vendor_info {
+	u16  valid;
+	char oem_id[ACPI_OEM_ID_SIZE];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
+};
+
+/* Hardware vendor-specific info that has its own power management modes */
+static struct hw_vendor_info vendor_info[] = {
+	{1, "HP    ", "ProLiant"},
+	{0, "", ""},
+};
+
 static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
 			int deadband, int integral) {
 	pid->setpoint = setpoint;
@@ -692,6 +707,66 @@ static int intel_pstate_msrs_not_valid(void)
 
 	return 0;
 }
+
+static bool intel_pstate_no_acpi_pss(void)
+{
+	struct acpi_processor *pr;
+	acpi_status status = AE_OK;
+	union acpi_object *pss = NULL;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	int i;
+
+	for_each_possible_cpu(i) {
+		pr = per_cpu(processors, i);
+
+		if (pr) {
+			status = acpi_evaluate_object(pr->handle, "_PSS",
+						      NULL, &buffer);
+
+			pss = buffer.pointer;
+
+			if (ACPI_SUCCESS(status) && pss) {
+				/* Found _PSS */
+				if (pss->type == ACPI_TYPE_PACKAGE)
+					return false;
+			}
+		}
+	}
+
+	/* No _PSS */
+	return true;
+}
+
+static bool intel_pstate_check_platform_pwr_mgmt(void)
+{
+	struct acpi_table_header hdr;
+	struct hw_vendor_info *v_info;
+
+	if (acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr) == AE_OK) {
+		for (v_info = vendor_info; v_info->valid; v_info++) {
+			/*
+			 * Check if the hardware/platform is in the
+			 * predefined vendor data.
+			 */
+			if (!strncmp(hdr.oem_id, v_info->oem_id,
+				     ACPI_OEM_ID_SIZE) &&
+			    !strncmp(hdr.oem_table_id, v_info->oem_table_id,
+				     ACPI_OEM_TABLE_ID_SIZE)) {
+
+				/*
+				 * No _PSS defintion in ACPI BIOS means that
+				 * the platform firmware has its own power
+				 * management modes.
+				 */
+				if (intel_pstate_no_acpi_pss())
+					return true;
+			}
+		}
+	}
+
+	return false;
+}
+
 static int __init intel_pstate_init(void)
 {
 	int cpu, rc = 0;
@@ -700,6 +775,15 @@ static int __init intel_pstate_init(void)
 	if (no_load)
 		return -ENODEV;
 
+	if (!acpi_disabled) {
+		/*
+		 * Check if the platform has its own power management modes.
+		 * If so, the pstate cpufreq driver will be ignored.
+		 */
+		if (intel_pstate_check_platform_pwr_mgmt())
+			return 0;
+	}
+
 	id = x86_match_cpu(intel_pstate_cpu_ids);
 	if (!id)
 		return -ENODEV;
-- 
1.8.1.2

