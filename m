From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC v4] ACPI throttling: Disable the MSR T-state if enabled after resumed
Date: Fri, 17 Feb 2017 16:27:30 +0800
Message-ID: <1487320050-22894-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Previously a bug was reported that on certain Broadwell
platform, after resumed from S3, the CPU is running at
an anomalously low speed, due to the BIOS has enabled the
MSR throttling across S3. The solution to this was to introduce
a quirk framework to save/restore tstate MSR register around
suspend/resume, in Commit 7a9c2dd08ead ("x86/pm:
Introduce quirk framework to save/restore extra MSR
registers around suspend/resume").

However there are still three problems left:
1. More and more reports show that other platforms also
   encountered the same issue, so the quirk list might
   be endless.
2. Each CPUs should take the save/restore operation into
   consideration, rather than the boot CPU alone.
3. Normally ACPI T-state re-evaluation is done on resume,
   however there is no _TSS on the bogus platform, thus
   above re-evaluation code does not run on that machine.

Solution:
This patch is based on the fact that, we generally should not
expect the system to come back from resume with throttling
enabled, but leverage the OS components to deal with it,
such as thermal event. So we simply clear the MSR T-state
and print the warning if it is found to be enabled after
resumed back. Besides, we can remove the quirk in previous patch
later.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=90041
Reported-and-tested-by: Kadir <kadir@colakoglu.nl>
Suggested-by: Len Brown <lenb@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/processor_throttling.c | 58 +++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index a12f96c..e121449 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/cpufreq.h>
 #include <linux/acpi.h>
+#include <linux/syscore_ops.h>
 #include <acpi/processor.h>
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -64,6 +65,7 @@ struct acpi_processor_throttling_arg {
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
 int acpi_processor_set_throttling(struct acpi_processor *pr,
 						int state, bool force);
+static void throttling_msr_reevaluate(int cpu);
 
 static int acpi_processor_update_tsd_coord(void)
 {
@@ -386,6 +388,15 @@ void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
 		pr->flags.throttling = 0;
 		return;
 	}
+	/*
+	 * It was found after resumed from suspend to ram, some BIOSes would
+	 * adjust the MSR tstate, however on these platforms no _PSS is provided
+	 * thus we never have a chance to adjust the MSR T-state anymore.
+	 * Thus force clearing it if MSR T-state is enabled, because generally
+	 * we never expect to come back from resume with throttling enabled.
+	 * Later let other components to adjust T-state if necessary.
+	 */
+	throttling_msr_reevaluate(pr->id);
 	/* the following is to recheck whether the T-state is valid for
 	 * the online CPU
 	 */
@@ -758,6 +769,24 @@ static int acpi_throttling_wrmsr(u64 value)
 	}
 	return ret;
 }
+
+static long msr_reevaluate_fn(void *data)
+{
+	u64 msr = 0;
+
+	acpi_throttling_rdmsr(&msr);
+	if (msr) {
+		printk_once(KERN_ERR "PM: The BIOS might have modified the MSR T-state, clear it for now.\n");
+		acpi_throttling_wrmsr(0);
+	}
+	return 0;
+}
+
+static void throttling_msr_reevaluate(int cpu)
+{
+	work_on_cpu(cpu, msr_reevaluate_fn, NULL);
+}
+
 #else
 static int acpi_throttling_rdmsr(u64 *value)
 {
@@ -772,8 +801,37 @@ static int acpi_throttling_wrmsr(u64 value)
 		"HARDWARE addr space,NOT supported yet\n");
 	return -1;
 }
+
+static long msr_reevaluate_fn(void *data)
+{
+	return 0;
+}
+
+static void throttling_msr_reevaluate(int cpu)
+{
+}
 #endif
 
+void acpi_throttling_resume(void)
+{
+	msr_reevaluate_fn(NULL);
+}
+
+static struct syscore_ops acpi_throttling_syscore_ops = {
+	.resume		= acpi_throttling_resume,
+};
+
+static int acpi_throttling_init_ops(void)
+{
+	/*
+	 * Reevaluate on boot CPU. Since it is not always CPU0,
+	 * we can not invoke throttling_msr_reevaluate(0) directly.
+	 */
+	register_syscore_ops(&acpi_throttling_syscore_ops);
+	return 0;
+}
+device_initcall(acpi_throttling_init_ops);
+
 static int acpi_read_throttling_status(struct acpi_processor *pr,
 					u64 *value)
 {
-- 
2.7.4
