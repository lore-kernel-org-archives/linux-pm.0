From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM: Turn power resources on and off in the right order during resume
Date: Thu, 21 May 2015 04:19:49 +0200
Message-ID: <1692579.9Aunh5vn4X@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to Section 7.2 of ACPI 6.0, power resources should
always be enabled and disabled in order given by the "resourceorder"
field of the corresponding Power Resource objects: "Power Resource
levels are enabled from low values to high values and are disabled
from high values to low values."

However, this is not what happens during system resume, because
in that case the enabling/disabling is carried out in the power
resource registration order which may not reflect the ordering
required by the platform.

For this reason, make the ordering of the global list of all
power resources in the system (used by the system resume code)
reflect the one given by the "resourceorder" attributes of the
Power Resource objects in the ACPI namespace and modify
acpi_resume_power_resources() to walk the list in the reverse
order when turning off the power resources that had been off
before the system was suspended.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -760,6 +760,25 @@ static void acpi_power_sysfs_remove(stru
 	device_remove_file(&device->dev, &dev_attr_resource_in_use);
 }
 
+static void acpi_power_add_resource_to_list(struct acpi_power_resource *resource)
+{
+	mutex_lock(&power_resource_list_lock);
+
+	if (!list_empty(&acpi_power_resource_list)) {
+		struct acpi_power_resource *r;
+
+		list_for_each_entry(r, &acpi_power_resource_list, list_node)
+			if (r->order > resource->order) {
+				list_add_tail(&resource->list_node, &r->list_node);
+				goto out;
+			}
+	}
+	list_add_tail(&resource->list_node, &acpi_power_resource_list);
+
+ out:
+	mutex_unlock(&power_resource_list_lock);
+}
+
 int acpi_add_power_resource(acpi_handle handle)
 {
 	struct acpi_power_resource *resource;
@@ -810,9 +829,7 @@ int acpi_add_power_resource(acpi_handle
 	if (!device_create_file(&device->dev, &dev_attr_resource_in_use))
 		device->remove = acpi_power_sysfs_remove;
 
-	mutex_lock(&power_resource_list_lock);
-	list_add(&resource->list_node, &acpi_power_resource_list);
-	mutex_unlock(&power_resource_list_lock);
+	acpi_power_add_resource_to_list(resource);
 	acpi_device_add_finalize(device);
 	return 0;
 
@@ -843,7 +860,22 @@ void acpi_resume_power_resources(void)
 		    && resource->ref_count) {
 			dev_info(&resource->device.dev, "Turning ON\n");
 			__acpi_power_on(resource);
-		} else if (state == ACPI_POWER_RESOURCE_STATE_ON
+		}
+
+		mutex_unlock(&resource->resource_lock);
+	}
+	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
+		int result, state;
+
+		mutex_lock(&resource->resource_lock);
+
+		result = acpi_power_get_state(resource->device.handle, &state);
+		if (result) {
+			mutex_unlock(&resource->resource_lock);
+			continue;
+		}
+
+		if (state == ACPI_POWER_RESOURCE_STATE_ON
 		    && !resource->ref_count) {
 			dev_info(&resource->device.dev, "Turning OFF\n");
 			__acpi_power_off(resource);

