From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpufreq: intel_pstate: skip the driver if ACPI has power mgmt option
Date: Sat, 02 Nov 2013 13:58:48 +0100
Message-ID: <2574312.RODqt35jkY@vostro.rjw.lan>
References: <1383233045.2462.7.camel@adrian-F6S> <24720758.HRzPDnyMM4@vostro.rjw.lan> <CAHKZfL2_ahVjaPCiMa14uHFNuwOKnPhAUr-Vn3QcqDHod_f8vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58977 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752065Ab3KBMqg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Nov 2013 08:46:36 -0400
In-Reply-To: <CAHKZfL2_ahVjaPCiMa14uHFNuwOKnPhAUr-Vn3QcqDHod_f8vg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huang Adrian <adrianhuang0701@gmail.com>, Adrian Huang <adrian.huang@hp.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linda.knippers@hp.com

On Friday, November 01, 2013 09:29:48 AM Huang Adrian wrote:
> Yes. HP BIOS has several power management modes (firmware, OS-control and
> so on). For the OS control mode in HP BIOS, the Intel p-state driver will
> be loaded. When the customer chooses the firmware power management in HP
> BIOS, the Intel p-state driver will be ignored.
> 
> I put hw_vendor_info vendor_info in case other vendors (Dell, Lenovo...)
> have their firmware power management. Vendors should make sure their
> firmware power management works properly, and they can go for adding their
> vendor info to the variable.
> 
> And, I have verified the patch on HP ProLiant servers.  The patch worked
> correctly.

OK.  I've added the above information to the patch changelog and fixed it up
so that the driver builds for CONFIG_ACPI unset.  The result is below, please
retest.

Thanks,
Rafael


---
From: Adrian Huang <adrian.huang@hp.com>
Subject: intel_pstate: skip the driver if ACPI has power mgmt option

Do not load the Intel pstate driver if the platform firmware
(ACPI BIOS) supports the power management alternatives.
The ACPI BIOS indicates that the OS control mode can be used
if the _PSS (Performance Supported States) is defined in ACPI
table. For the OS control mode, the Intel pstate driver will be
loaded.

HP BIOS has several power management modes (firmware, OS-control and
so on). For the OS control mode in HP BIOS, the Intel p-state driver
will be loaded. When the customer chooses the firmware power
management in HP BIOS, the Intel p-state driver will be ignored.

I put hw_vendor_info vendor_info in case other vendors (Dell, Lenovo...)
have their firmware power management. Vendors should make sure their
firmware power management works properly, and they can go for adding
their vendor info to the variable.

I have verified the patch on HP ProLiant servers.  The patch worked
correctly.

[rjw: Fixed up !CONFIG_ACPI build]
Signed-off-by: Adrian Huang <adrian.huang@hp.com>
---

 drivers/cpufreq/intel_pstate.c |   74 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/debugfs.h>
+#include <linux/acpi.h>
 #include <trace/events/power.h>
 
 #include <asm/div64.h>
@@ -777,6 +778,72 @@ static void copy_cpu_funcs(struct pstate
 	pstate_funcs.set       = funcs->set;
 }
 
+#if IS_ENABLED(CONFIG_ACPI)
+#include <acpi/processor.h>
+
+static bool intel_pstate_no_acpi_pss(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		acpi_status status;
+		union acpi_object *pss;
+		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+		struct acpi_processor *pr = per_cpu(processors, i);
+
+		if (!pr)
+			continue;
+
+		status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		pss = buffer.pointer;
+		if (pss && pss->type == ACPI_TYPE_PACKAGE) {
+			kfree(pss);
+			return false;
+		}
+
+		kfree(pss);
+	}
+
+	return true;
+}
+
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
+static bool intel_pstate_platform_pwr_mgmt_exists(void)
+{
+	struct acpi_table_header hdr;
+	struct hw_vendor_info *v_info;
+
+	if (acpi_disabled
+	    || ACPI_FAILURE(acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr)))
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
+#else /* CONFIG_ACPI not enabled */
+static inline bool intel_pstate_platform_pwr_mgmt_exists(void) { return false; }
+#endif /* CONFIG_ACPI */
+
 static int __init intel_pstate_init(void)
 {
 	int cpu, rc = 0;
@@ -790,6 +857,13 @@ static int __init intel_pstate_init(void
 	if (!id)
 		return -ENODEV;
 
+	/*
+	 * The Intel pstate driver will be ignored if the platform
+	 * firmware has its own power management modes.
+	 */
+	if (intel_pstate_platform_pwr_mgmt_exists())
+		return -ENODEV;
+
 	cpu_info = (struct cpu_defaults *)id->driver_data;
 
 	copy_pid_params(&cpu_info->pid_policy);

