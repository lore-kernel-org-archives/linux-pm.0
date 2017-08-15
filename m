From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4] ACPI / Sleep: Check low power idle constraints for debug only
Date: Mon, 14 Aug 2017 23:35:05 -0700
Message-ID: <1502778905-17817-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9154 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbdHOGfI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Aug 2017 02:35:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

For SoC to achieve its lowest power platform idle state a set of hardware
preconditions must be met. These preconditions or constraints can be
obtained by issuing a device specific method (_DSM) with function "1".
Refer to the document provided in the link below.

Here during initialization (from attach() callback of LPS0 device), invoke
function 1 to get the device constraints. Each enabled constraint is
stored in a table.

The devices in this table are used to check whether they were in required
minimum state, while entering suspend. This check is done from platform
freeze wake() callback, only when /sys/power/pm_debug_messages attribute
is non zero.

If any constraint is not met and device is ACPI power managed then it
prints the device information to kernel logs.

Also if debug is enabled in acpi/sleep.c, the constraint table and state
of each device on wake is dumped in kernel logs.

Since pm_debug_messages_on setting is used as condition to check
constraints outside kernel/power/main.c, pm_debug_messages_on is changed
to a global variable.

Link: http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

v4
- Storing handle in the lpi_constraints table.
- Print formatting
- Don't call acpi_device_get_power()
- use acpi_handle_info/debug

v3
- Removed the patch 0001 for exporting pm_debug_messages_on via a function.
As suggested by Rafael, made the pm_debug_messages_on a global variable instead.
- Moved the constraint check outside if() block and valid for all calls to
acpi_freeze_wakeup()
- Dumping irrespective of return value of acpi_device_get_power().
- Rebased to linux-next as of today

v2
- Changes as suggested by Lukas Wunner.
- Using pm_debug_messages_on attribute to prevent constraints check to
save some cycles on wake.


 drivers/acpi/sleep.c    | 168 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/suspend.h |   2 +
 kernel/power/main.c     |   2 +-
 3 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 0a16435..6f4d1e5 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -669,6 +669,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
 
 #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
 
+#define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
 #define ACPI_LPS0_SCREEN_OFF	3
 #define ACPI_LPS0_SCREEN_ON	4
 #define ACPI_LPS0_ENTRY		5
@@ -680,6 +681,166 @@ static acpi_handle lps0_device_handle;
 static guid_t lps0_dsm_guid;
 static char lps0_dsm_func_mask;
 
+/* Device constraint entry structure */
+struct lpi_device_info {
+	char *name;
+	int enabled;
+	union acpi_object *package;
+};
+
+/* Constraint package structure */
+struct lpi_device_constraint {
+	int uid;
+	int min_dstate;
+	int function_states;
+};
+
+struct lpi_constraints {
+	acpi_handle handle;
+	int min_dstate;
+};
+
+static struct lpi_constraints *lpi_constraints_table;
+static int lpi_constraints_table_size;
+
+static void lpi_device_get_constraints(void)
+{
+	union acpi_object *out_obj;
+	int i;
+
+	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
+					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
+					  NULL, ACPI_TYPE_PACKAGE);
+
+	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
+			  out_obj ? "successful" : "failed");
+
+	if (!out_obj)
+		return;
+
+	lpi_constraints_table = kcalloc(out_obj->package.count,
+					sizeof(*lpi_constraints_table),
+					GFP_KERNEL);
+	if (!lpi_constraints_table)
+		goto free_acpi_buffer;
+
+	acpi_handle_debug(lps0_device_handle, "LPI: constraints list begin:\n");
+
+	for (i = 0; i < out_obj->package.count; i++) {
+		struct lpi_constraints *constraint;
+		acpi_status status;
+		union acpi_object *package = &out_obj->package.elements[i];
+		struct lpi_device_info info = { };
+		int package_count = 0, j;
+
+		if (!package)
+			continue;
+
+		for (j = 0; j < package->package.count; ++j) {
+			union acpi_object *element =
+					&(package->package.elements[j]);
+
+			switch (element->type) {
+			case ACPI_TYPE_INTEGER:
+				info.enabled = element->integer.value;
+				break;
+			case ACPI_TYPE_STRING:
+				info.name = element->string.pointer;
+				break;
+			case ACPI_TYPE_PACKAGE:
+				package_count = element->package.count;
+				info.package = element->package.elements;
+				break;
+			}
+		}
+
+		if (!info.enabled || !info.package || !info.name)
+			continue;
+
+		constraint = &lpi_constraints_table[lpi_constraints_table_size];
+
+		status = acpi_get_handle(NULL, info.name, &constraint->handle);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		acpi_handle_debug(lps0_device_handle,
+				  "index:%d Name:%s\n", i, info.name);
+
+		constraint->min_dstate = -1;
+
+		for (j = 0; j < package_count; ++j) {
+			union acpi_object *info_obj = &info.package[j];
+			union acpi_object *cnstr_pkg;
+			union acpi_object *obj;
+			struct lpi_device_constraint dev_info;
+
+			switch (info_obj->type) {
+			case ACPI_TYPE_INTEGER:
+				/* version */
+				break;
+			case ACPI_TYPE_PACKAGE:
+				if (info_obj->package.count < 2)
+					break;
+
+				cnstr_pkg = info_obj->package.elements;
+				obj = &cnstr_pkg[0];
+				dev_info.uid = obj->integer.value;
+				obj = &cnstr_pkg[1];
+				dev_info.min_dstate = obj->integer.value;
+
+				acpi_handle_debug(lps0_device_handle,
+					"uid:%d min_dstate:%s\n",
+					dev_info.uid,
+					acpi_power_state_string(dev_info.min_dstate));
+
+				constraint->min_dstate = dev_info.min_dstate;
+				break;
+			}
+		}
+
+		if (constraint->min_dstate < 0) {
+			acpi_handle_debug(lps0_device_handle,
+					  "Incomplete constraint defined\n");
+			continue;
+		}
+
+		lpi_constraints_table_size++;
+	}
+
+	acpi_handle_debug(lps0_device_handle, "LPI: constraints list end\n");
+
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+}
+
+static void lpi_check_constraints(void)
+{
+	int i;
+
+	for (i = 0; i < lpi_constraints_table_size; ++i) {
+		struct acpi_device *adev;
+
+		if (acpi_bus_get_device(lpi_constraints_table[i].handle, &adev))
+			continue;
+
+		acpi_handle_debug(adev->handle,
+			"LPI: required min power state:%s current power state:%s\n",
+			acpi_power_state_string(lpi_constraints_table[i].min_dstate),
+			acpi_power_state_string(adev->power.state));
+
+		if (!adev->flags.power_manageable) {
+			acpi_handle_info(adev->handle, "LPI: Device not power manageble\n");
+			continue;
+		}
+
+		if (adev->power.state < lpi_constraints_table[i].min_dstate)
+			acpi_handle_info(adev->handle,
+				"LPI: Constraint not met; min power state:%s current power state:%s\n",
+				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
+				acpi_power_state_string(adev->power.state));
+	}
+}
+
 static void acpi_sleep_run_lps0_dsm(unsigned int func)
 {
 	union acpi_object *out_obj;
@@ -729,6 +890,9 @@ static int lps0_device_attach(struct acpi_device *adev,
 				  "_DSM function 0 evaluation failed\n");
 	}
 	ACPI_FREE(out_obj);
+
+	lpi_device_get_constraints();
+
 	return 0;
 }
 
@@ -766,6 +930,10 @@ static int acpi_freeze_prepare(void)
 
 static void acpi_freeze_wake(void)
 {
+
+	if (pm_debug_messages_on)
+		lpi_check_constraints();
+
 	/*
 	 * If IRQD_WAKEUP_ARMED is not set for the SCI at this point, it means
 	 * that the SCI has triggered while suspended, so cancel the wakeup in
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8c3b0b1..126adcb 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -495,9 +495,11 @@ static inline void unlock_system_sleep(void) {}
 
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
+extern bool pm_debug_messages_on;
 extern __printf(2, 3) void __pm_pr_dbg(bool defer, const char *fmt, ...);
 #else
 #define pm_print_times_enabled	(false)
+#define pm_debug_messages_on	(false)
 
 #include <linux/printk.h>
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3074ea4..3a2ca90 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -361,7 +361,7 @@ static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
 
 power_attr_ro(pm_wakeup_irq);
 
-static bool pm_debug_messages_on __read_mostly;
+bool pm_debug_messages_on __read_mostly;
 
 static ssize_t pm_debug_messages_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
-- 
2.7.5
