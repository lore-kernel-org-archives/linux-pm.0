From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Expose lists of device wakeup power resources to user space
Date: Thu, 11 Apr 2013 00:40:53 +0200
Message-ID: <1425777.0jqdrENv3E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 18a3870 (ACPI / PM: Expose lists of device power resources
to user space) exposed the lists of ACPI power resources associated
with power states of ACPI devices, but it didn't expose the lists
of ACPI wakeup power resources, which also is necessary to get the
full picture of dependencies between ACPI devices and power
resources.

For this reason, for every ACPI device node having a list of ACPI
wakeup power resources associated with it, expose that list to user
space in analogy with commit 18a3870.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/ABI/testing/sysfs-devices-power_resources_wakeup |   13 ++
 drivers/acpi/power.c                                           |   58 ++++++----
 2 files changed, 52 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -459,57 +459,79 @@ static struct attribute_group attr_group
 	},
 };
 
-static void acpi_power_hide_list(struct acpi_device *adev, int state)
+static struct attribute_group wakeup_attr_group = {
+	.name = "power_resources_wakeup",
+	.attrs = attrs,
+};
+
+static void acpi_power_hide_list(struct acpi_device *adev,
+				 struct list_head *resources,
+				 struct attribute_group *attr_group)
 {
-	struct acpi_device_power_state *ps = &adev->power.states[state];
 	struct acpi_power_resource_entry *entry;
 
-	if (list_empty(&ps->resources))
+	if (list_empty(resources))
 		return;
 
-	list_for_each_entry_reverse(entry, &ps->resources, node) {
+	list_for_each_entry_reverse(entry, resources, node) {
 		struct acpi_device *res_dev = &entry->resource->device;
 
 		sysfs_remove_link_from_group(&adev->dev.kobj,
-					     attr_groups[state].name,
+					     attr_group->name,
 					     dev_name(&res_dev->dev));
 	}
-	sysfs_remove_group(&adev->dev.kobj, &attr_groups[state]);
+	sysfs_remove_group(&adev->dev.kobj, attr_group);
 }
 
-static void acpi_power_expose_list(struct acpi_device *adev, int state)
+static void acpi_power_expose_list(struct acpi_device *adev,
+				   struct list_head *resources,
+				   struct attribute_group *attr_group)
 {
-	struct acpi_device_power_state *ps = &adev->power.states[state];
 	struct acpi_power_resource_entry *entry;
 	int ret;
 
-	if (list_empty(&ps->resources))
+	if (list_empty(resources))
 		return;
 
-	ret = sysfs_create_group(&adev->dev.kobj, &attr_groups[state]);
+	ret = sysfs_create_group(&adev->dev.kobj, attr_group);
 	if (ret)
 		return;
 
-	list_for_each_entry(entry, &ps->resources, node) {
+	list_for_each_entry(entry, resources, node) {
 		struct acpi_device *res_dev = &entry->resource->device;
 
 		ret = sysfs_add_link_to_group(&adev->dev.kobj,
-					      attr_groups[state].name,
+					      attr_group->name,
 					      &res_dev->dev.kobj,
 					      dev_name(&res_dev->dev));
 		if (ret) {
-			acpi_power_hide_list(adev, state);
+			acpi_power_hide_list(adev, resources, attr_group);
 			break;
 		}
 	}
 }
 
+static void acpi_power_expose_hide(struct acpi_device *adev,
+				   struct list_head *resources,
+				   struct attribute_group *attr_group,
+				   bool expose)
+{
+	if (expose)
+		acpi_power_expose_list(adev, resources, attr_group);
+	else
+		acpi_power_hide_list(adev, resources, attr_group);
+}
+
 void acpi_power_add_remove_device(struct acpi_device *adev, bool add)
 {
 	struct acpi_device_power_state *ps;
 	struct acpi_power_resource_entry *entry;
 	int state;
 
+	if (adev->wakeup.flags.valid)
+		acpi_power_expose_hide(adev, &adev->wakeup.resources,
+				       &wakeup_attr_group, add);
+
 	if (!adev->power.flags.power_resources)
 		return;
 
@@ -523,12 +545,10 @@ void acpi_power_add_remove_device(struct
 			acpi_power_remove_dependent(resource, adev);
 	}
 
-	for (state = ACPI_STATE_D0; state <= ACPI_STATE_D3_HOT; state++) {
-		if (add)
-			acpi_power_expose_list(adev, state);
-		else
-			acpi_power_hide_list(adev, state);
-	}
+	for (state = ACPI_STATE_D0; state <= ACPI_STATE_D3_HOT; state++)
+		acpi_power_expose_hide(adev,
+				       &adev->power.states[state].resources,
+				       &attr_groups[state], add);
 }
 
 int acpi_power_wakeup_list_init(struct list_head *list, int *system_level_p)
Index: linux-pm/Documentation/ABI/testing/sysfs-devices-power_resources_wakeup
===================================================================
--- /dev/null
+++ linux-pm/Documentation/ABI/testing/sysfs-devices-power_resources_wakeup
@@ -0,0 +1,13 @@
+What:		/sys/devices/.../power_resources_wakeup/
+Date:		April 2013
+Contact:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+Description:
+		The /sys/devices/.../power_resources_wakeup/ directory is only
+		present for device objects representing ACPI device nodes that
+		require ACPI power resources for wakeup signaling.
+
+		If present, it contains symbolic links to device directories
+		representing ACPI power resources that need to be turned on for
+		the given device node to be able to signal wakeup.  The names of
+		the links are the same as the names of the directories they
+		point to.
\ No newline at end of file

