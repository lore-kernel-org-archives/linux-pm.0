From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/10] ACPI processor hotplug: Delay acpi_processor_start()
 call for hotplugged cores
Date: Mon, 23 Jan 2012 20:30:01 -0500
Message-ID: <99b725084450bbc6f8e1ab20a0df4cc291c342b5.1327368464.git.len.brown@intel.com>
References: <1327368609-28409-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1327368609-28409-1-git-send-email-lenb@kernel.org>
In-reply-to: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
References: <54d5dcc45af7adbb907072d042bbece4c2b4de6e.1327368464.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Renninger <trenn@suse.de>

Delay the setting up of features (cpuidle, throttling by calling
acpi_processor_start()) to the time when the hotplugged
core got onlined the first time and got fully
initialized.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_driver.c |   72 +++++++++++++++++++++++++++++++++++----
 drivers/idle/intel_idle.c       |    2 +-
 include/acpi/processor.h        |    1 +
 3 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bec5593..2b805d7 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -84,7 +84,7 @@ static int acpi_processor_remove(struct acpi_device *device, int type);
 static void acpi_processor_notify(struct acpi_device *device, u32 event);
 static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
-
+static int acpi_processor_start(struct acpi_processor *pr);
 
 static const struct acpi_device_id processor_device_ids[] = {
 	{ACPI_PROCESSOR_OBJECT_HID, 0},
@@ -423,10 +423,29 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
 	if (action == CPU_ONLINE && pr) {
-		acpi_processor_ppc_has_changed(pr, 0);
-		acpi_processor_hotplug(pr);
-		acpi_processor_reevaluate_tstate(pr, action);
-		acpi_processor_tstate_has_changed(pr);
+		/* CPU got physically hotplugged and onlined the first time:
+		 * Initialize missing things
+		 */
+		if (pr->flags.need_hotplug_init) {
+			struct cpuidle_driver *idle_driver =
+				cpuidle_get_driver();
+
+			printk(KERN_INFO "Will online and init hotplugged "
+			       "CPU: %d\n", pr->id);
+			WARN(acpi_processor_start(pr), "Failed to start CPU:"
+				" %d\n", pr->id);
+			pr->flags.need_hotplug_init = 0;
+			if (idle_driver && !strcmp(idle_driver->name,
+						   "intel_idle")) {
+				intel_idle_cpu_init(pr->id);
+			}
+		/* Normal CPU soft online event */
+		} else {
+			acpi_processor_ppc_has_changed(pr, 0);
+			acpi_processor_cst_has_changed(pr);
+			acpi_processor_reevaluate_tstate(pr, action);
+			acpi_processor_tstate_has_changed(pr);
+		}
 	}
 	if (action == CPU_DEAD && pr) {
 		/* invalidate the flag.throttling after one CPU is offline */
@@ -440,7 +459,15 @@ static struct notifier_block acpi_cpu_notifier =
 	    .notifier_call = acpi_cpu_soft_notify,
 };
 
-static int __cpuinit acpi_processor_start(struct acpi_processor *pr)
+/*
+ * acpi_processor_start() is called by the cpu_hotplug_notifier func:
+ * acpi_cpu_soft_notify(). Getting it __cpuinit{data} is difficult, the
+ * root cause seem to be that acpi_processor_uninstall_hotplug_notify()
+ * is in the module_exit (__exit) func. Allowing acpi_processor_start()
+ * to not be in __cpuinit section, but being called from __cpuinit funcs
+ * via __ref looks like the right thing to do here.
+ */
+static __ref int acpi_processor_start(struct acpi_processor *pr)
 {
 	struct acpi_device *device = per_cpu(processor_device_array, pr->id);
 	int result = 0;
@@ -491,7 +518,12 @@ err_power_exit:
 	return result;
 }
 
-
+/*
+ * Do not put anything in here which needs the core to be online.
+ * For example MSR access or setting up things which check for cpuinfo_x86
+ * (cpu_data(cpu)) values, like CPU feature flags, family, model, etc.
+ * Such things have to be put in and set up above in acpi_processor_start()
+ */
 static int __cpuinit acpi_processor_add(struct acpi_device *device)
 {
 	struct acpi_processor *pr = NULL;
@@ -546,6 +578,21 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 		result = -EFAULT;
 		goto err_free_cpumask;
 	}
+
+	/*
+	 * Do not start hotplugged CPUs now, but when they
+	 * are onlined the first time
+	 */
+	if (pr->flags.need_hotplug_init)
+		return 0;
+
+	/*
+	 * Do not start hotplugged CPUs now, but when they
+	 * are onlined the first time
+	 */
+	if (pr->flags.need_hotplug_init)
+		return 0;
+
 	result = acpi_processor_start(pr);
 	if (result)
 		goto err_remove_sysfs;
@@ -751,6 +798,17 @@ static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
 		return AE_ERROR;
 	}
 
+	/* CPU got hot-plugged, but cpu_data is not initialized yet
+	 * Set flag to delay cpu_idle/throttling initialization
+	 * in:
+	 * acpi_processor_add()
+	 *   acpi_processor_get_info()
+	 * and do it when the CPU gets online the first time
+	 * TBD: Cleanup above functions and try to do this more elegant.
+	 */
+	printk(KERN_INFO "CPU %d got hotplugged\n", pr->id);
+	pr->flags.need_hotplug_init = 1;
+
 	return AE_OK;
 }
 
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 20bce51..54ab97b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -527,7 +527,7 @@ int intel_idle_cpu_init(int cpu)
 
 	return 0;
 }
-
+EXPORT_SYMBOL_GPL(intel_idle_cpu_init);
 
 static int __init intel_idle_init(void)
 {
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 610f6fb..8cf7e98 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -195,6 +195,7 @@ struct acpi_processor_flags {
 	u8 has_cst:1;
 	u8 power_setup_done:1;
 	u8 bm_rld_set:1;
+	u8 need_hotplug_init:1;
 };
 
 struct acpi_processor {
-- 
1.7.9.rc2

