From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][RFC] ACPI / PM: Disable the MSR T-state during CPU online
Date: Sat, 26 Aug 2017 00:43:45 +0800
Message-ID: <169b775a81dcd3b8297b48f992ac7668257aca66.1503678995.git.yu.c.chen@intel.com>
References: <cover.1503678995.git.yu.c.chen@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1503678995.git.yu.c.chen@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In 2015 a bug was once reported that on a Broadwell
platform, after resumed from S3, the CPU was running at
an anomalously low speed, due to the BIOS has enabled the
MSR throttling across S3. This was a BIOS issue and the
solution to that was to introduce a quirk to save/restore
T-state MSR register around suspend/resume, in
Commit 7a9c2dd08ead ("x86/pm: Introduce quirk framework to
save/restore extra MSR registers around suspend/resume").

However there are still three problems left:
1. More and more reports show that other platforms also
   encountered the same issue, so the quirk list might
   be endless.
2. Each CPUs should take the save/restore operation into
   consideration, rather than the boot CPU alone.
3. Normally ACPI T-state re-evaluation should be taken care
   of during resume in the ACPI throttling driver, however
   there is no _TSS on that bogus platform, thus the
   re-evaluation code does not run on that machine.

Solution:
This patch is based on the fact that, we generally should not
expect the system to come back from resume(or event CPU been
brought online) with throttling enabled, but leverage the OS
components to deal with it, so we simply clear the MSR T-state
after that CPU has been brought online. In addition to that,
print the warning if the T-state is found to be enabled.

The side effect of this patch is that, we might lose the T-state
evaluation value in the ACPI throttling driver during CPU online
stage, because we can not guarantee that the clear action we
introduced is invoked strictly before the T-state evaluation in
the ACPI throttling driver. But anyway it is expected that there
should be an event later to adjust the T-state for us.

Besides, we can remove the quirk later.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=90041
Reported-by: Kadir <kadir@colakoglu.nl>
Reported-by: Victor Trac <victor.trac@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/sleep.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index cad1a0f..8802ffd 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -870,8 +870,51 @@ static int  acpi_syscore_suspend(void)
 	return acpi_save_bm_rld();
 }
 
+#ifdef CONFIG_X86
+static long msr_fix_fn(void *data)
+{
+	u64 msr;
+
+	if (this_cpu_read(cpu_info.x86_vendor) != X86_VENDOR_INTEL)
+		return 0;
+
+	/*
+	 * It was found after resumed from suspend to ram, some BIOSes would
+	 * adjust the MSR tstate, however on these platforms no _PSS is provided
+	 * thus we never have a chance to adjust the MSR T-state anymore.
+	 * Thus force clearing it if MSR T-state is enabled, because generally
+	 * we never expect to come back from resume(or CPU online) with
+	 * throttling enabled. Later let other components to adjust the
+	 * T-state if necessary.
+	 */
+	if (!rdmsrl_safe(MSR_IA32_THERM_CONTROL, &msr) && msr) {
+		pr_err("PM: The MSR T-state is enabled after CPU%d online, clear it.\n",
+				smp_processor_id());
+		wrmsrl_safe(MSR_IA32_THERM_CONTROL, 0);
+	}
+	return 0;
+}
+
+static int msr_fix_cpu_online(unsigned int cpu)
+{
+	work_on_cpu(cpu, msr_fix_fn, NULL);
+	return 0;
+}
+#else
+static long msr_fix_fn(void *data)
+{
+	return 0;
+}
+static int msr_fix_cpu_online(unsigned int cpu)
+{
+	return 0;
+}
+#endif
+
 static void  acpi_syscore_restore(void)
 {
+	/* Fix the boot CPU. */
+	msr_fix_fn(NULL);
 	acpi_restore_bm_rld();
 }
 
@@ -883,6 +926,9 @@ static struct syscore_ops acpi_sleep_syscore_ops = {
 void acpi_sleep_syscore_init(void)
 {
 	register_syscore_ops(&acpi_sleep_syscore_ops);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+				"msr_fix:online",
+				msr_fix_cpu_online, NULL);
 }
 #else
 static inline void acpi_sleep_syscore_init(void) {}
-- 
2.7.4

