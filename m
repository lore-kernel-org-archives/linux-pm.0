From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI / Sleep: Check low power idle constraints for debug only
Date: Mon,  7 Aug 2017 16:53:57 -0700
Message-ID: <1502150037-32786-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

For SoC to achieve its lowest power platform idle state a set of
hardware preconditions must be met. These preconditions or constraints
can be obtained by issuing a device specific method (_DSM) with
function "1".  Refer to the document provided in the link below.

Here during initialization (from attach() callback of LPS0 device, invoked
function 1 to get the device constraints. Each enabled constraint is
stored in a table. The devices in this table are used to check whether
they were in required minimum state, while entering suspend. This check
is done from platform freeze wake() callback. If any check fails then it
prints the failed device information in dmesg.

Also if debug is enabled in acpi/sleep.c, the constraint table and state
of each device on wake is dumped in dmesg.

Link: http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/sleep.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index fa8243c5c062..f23f0473f1d8 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -669,6 +669,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
 
 #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
 
+#define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
 #define ACPI_LPS0_SCREEN_OFF	3
 #define ACPI_LPS0_SCREEN_ON	4
 #define ACPI_LPS0_ENTRY		5
@@ -680,6 +681,169 @@ static acpi_handle lps0_device_handle;
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
+	char *name;
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
+	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid,
+				    1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
+				    NULL);
+
+	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
+			  out_obj ? "successful" : "failed");
+
+	if (!out_obj)
+		return;
+
+	if (out_obj->type != ACPI_TYPE_PACKAGE)
+		goto free_acpi_buffer;
+
+	lpi_constraints_table = kcalloc(out_obj->package.count,
+					sizeof(*lpi_constraints_table),
+					GFP_KERNEL);
+	if (!lpi_constraints_table)
+		goto free_acpi_buffer;
+
+	pr_debug("LPI: constraints dump begin\n");
+	for (i = 0; i < out_obj->package.count; i++) {
+		union acpi_object *package = &out_obj->package.elements[i];
+		struct lpi_device_info info;
+		int package_count = 0, j;
+
+		if (!package)
+			continue;
+
+		info.enabled = 0;
+		info.package = NULL;
+		info.name = NULL;
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
+		lpi_constraints_table[lpi_constraints_table_size].name =
+						kstrdup(info.name, GFP_KERNEL);
+		if (!lpi_constraints_table[lpi_constraints_table_size].name)
+			goto free_constraints;
+
+		pr_debug("index:%d Name:%s\n", i, info.name);
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
+				pr_debug("uid %d min_dstate %d\n",
+					 dev_info.uid,
+					 dev_info.min_dstate);
+				lpi_constraints_table[
+					lpi_constraints_table_size].min_dstate =
+						dev_info.min_dstate;
+				break;
+			}
+		}
+
+		lpi_constraints_table_size++;
+	}
+
+	pr_debug("LPI: constraints dump end\n");
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+	return;
+
+free_constraints:
+	ACPI_FREE(out_obj);
+	for (i = 0; i < lpi_constraints_table_size; ++i)
+		kfree(lpi_constraints_table[i].name);
+	kfree(lpi_constraints_table);
+	lpi_constraints_table_size = 0;
+}
+
+static void lpi_check_constraints(void)
+{
+	int i;
+
+	for (i = 0; i < lpi_constraints_table_size; ++i) {
+		acpi_handle handle;
+		struct acpi_device *adev;
+		int state, ret;
+
+		if (ACPI_FAILURE(acpi_get_handle(NULL,
+						 lpi_constraints_table[i].name,
+						 &handle)))
+			continue;
+
+		if (acpi_bus_get_device(handle, &adev))
+			continue;
+
+		ret = acpi_device_get_power(adev, &state);
+		if (!ret)
+			pr_debug("LPI: %s required min power state %d, current power state %d, real power state %d\n",
+				 lpi_constraints_table[i].name,
+				 lpi_constraints_table[i].min_dstate,
+				 adev->power.state, state);
+
+		if (adev->flags.power_manageable && adev->power.state <
+					lpi_constraints_table[i].min_dstate)
+			pr_info("LPI: Constraint [%s] not matched\n",
+				lpi_constraints_table[i].name);
+	}
+}
+
 static void acpi_sleep_run_lps0_dsm(unsigned int func)
 {
 	union acpi_object *out_obj;
@@ -723,6 +887,9 @@ static int lps0_device_attach(struct acpi_device *adev,
 				  "_DSM function 0 evaluation failed\n");
 	}
 	ACPI_FREE(out_obj);
+
+	lpi_device_get_constraints();
+
 	return 0;
 }
 
@@ -767,6 +934,7 @@ static void acpi_freeze_wake(void)
 	 */
 	if (acpi_sci_irq_valid() &&
 	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
+		lpi_check_constraints();
 		pm_system_cancel_wakeup();
 		s2idle_wakeup = true;
 	}
-- 
2.11.0

