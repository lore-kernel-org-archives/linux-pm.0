From: Adrian Huang <adrian.huang@hp.com>
Subject: [PATCH 1/1] cpufreq: intel_pstate: skip the driver if ACPI has power mgmt option
Date: Mon, 21 Oct 2013 13:27:07 +0800
Message-ID: <1382333227-28231-1-git-send-email-adrian.huang@hp.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linda.knippers@hp.com, Adrian Huang <adrian.huang@hp.com>
List-Id: linux-pm@vger.kernel.org

Do not load the Intel pstate driver if the platform firmware
(ACPI BIOS) supports the power management alternatives.
The ACPI BIOS indicates that the OS control mode can be used
if the _PSS (Performance Supported States) object is defined
in ACPI table. For the OS control mode, the Intel pstate
driver will be loaded.

Signed-off-by: Adrian Huang <adrian.huang@hp.com>
---
 drivers/cpufreq/intel_pstate.c | 80 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index badf620..c03915e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -26,6 +26,8 @@
 #include <linux/fs.h>
 #include <linux/debugfs.h>
 #include <trace/events/power.h>
+#include <linux/acpi.h>
+#include <acpi/processor.h>
 
 #include <asm/div64.h>
 #include <asm/msr.h>
@@ -129,6 +131,18 @@ static struct perf_limits limits = {
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
@@ -700,6 +714,63 @@ static int intel_pstate_msrs_not_valid(void)
 
 	return 0;
 }
+
+static bool intel_pstate_no_acpi_pss(void)
+{
+	struct acpi_processor *pr;
+	union acpi_object *pss = NULL;
+	int i;
+
+	for_each_possible_cpu(i) {
+
+		pr = per_cpu(processors, i);
+
+		if (pr) {
+			struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER,
+							NULL };
+
+			if (ACPI_SUCCESS(acpi_evaluate_object(pr->handle,
+						"_PSS", NULL, &buffer))) {
+
+				pss = buffer.pointer;
+
+				if (pss && pss->type == ACPI_TYPE_PACKAGE) {
+					kfree(buffer.pointer);
+					return false;
+				}
+
+				kfree(buffer.pointer);
+			}
+		}
+	}
+
+	return true;
+}
+
+static bool intel_pstate_platform_pwr_mgmt_exists(void)
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
@@ -708,6 +779,15 @@ static int __init intel_pstate_init(void)
 	if (no_load)
 		return -ENODEV;
 
+	if (!acpi_disabled) {
+		/*
+		 * Check if the platform has its own power management modes.
+		 * If so, the pstate cpufreq driver will be ignored.
+		 */
+		if (intel_pstate_platform_pwr_mgmt_exists())
+			return 0;
+	}
+
 	id = x86_match_cpu(intel_pstate_cpu_ids);
 	if (!id)
 		return -ENODEV;
-- 
1.8.1.2

