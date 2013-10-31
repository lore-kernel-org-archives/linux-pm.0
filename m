From: Adrian Huang <adrian.huang@hp.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: skip the driver if ACPI has
 power mgmt option
Date: Thu, 31 Oct 2013 15:29:59 +0800
Message-ID: <1383204599.2487.12.camel@adrian-F6S>
References: <1382952130.4419.10.camel@adrian-F6S>
	 <2180132.nWVXASx7r4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2180132.nWVXASx7r4@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linda.knippers@hp.com
List-Id: linux-pm@vger.kernel.org

Do not load the Intel pstate driver if the platform firmware
(ACPI BIOS) supports the power management alternatives.
The ACPI BIOS indicates that the OS control mode can be used
if the _PSS (Performance Supported States) object is defined
in ACPI table. For the OS control mode, the Intel pstate
driver will be loaded.

Signed-off-by: Adrian Huang <adrian.huang@hp.com>
---
Changes since v1:
 * Minimize indentation levels (Commented by Rafael)
 * Re-define some local variables (Commented by Rafael)
 * Return -ENODEV if platform FW has power management modes (Commented by Dirk)

 drivers/cpufreq/intel_pstate.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index eb3fdc7..8770d67 100644
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
@@ -698,6 +712,55 @@ static int intel_pstate_msrs_not_valid(void)
 
 	return 0;
 }
+
+static bool intel_pstate_no_acpi_pss(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		acpi_status status = AE_OK;
+		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+		struct acpi_processor *pr = per_cpu(processors, i);
+		union acpi_object *pss = NULL;
+
+		if (!pr)
+			continue;
+
+		status = acpi_evaluate_object(pr->handle, "_PSS",
+					      NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		pss = buffer.pointer;
+		if (pss && (pss->type == ACPI_TYPE_PACKAGE)) {
+			kfree(buffer.pointer);
+			return false;
+		}
+
+		kfree(buffer.pointer);
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
+	if (ACPI_FAILURE(acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr)))
+		return false;
+
+	for (v_info = vendor_info; v_info->valid; v_info++) {
+		if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZE)
+		    && !strncmp(hdr.oem_table_id, v_info->oem_table_id, ACPI_OEM_TABLE_ID_SIZE)
+		    && intel_pstate_no_acpi_pss())
+			return true;
+	}
+
+	return false;
+}
+
 static int __init intel_pstate_init(void)
 {
 	int cpu, rc = 0;
@@ -706,6 +769,13 @@ static int __init intel_pstate_init(void)
 	if (no_load)
 		return -ENODEV;
 
+	/*
+	 * The Intel pstate driver will be ignored if the platform
+	 * firmware has its own power management modes.
+	 */
+	if (!acpi_disabled && intel_pstate_platform_pwr_mgmt_exists())
+		return -ENODEV;
+
 	id = x86_match_cpu(intel_pstate_cpu_ids);
 	if (!id)
 		return -ENODEV;
-- 
1.8.1.2



