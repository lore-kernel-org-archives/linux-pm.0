From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/6] [-mm]: ACPI: duplicate ACPI sleep "wakeup" attribute
	in sysfs
Date: Sat, 06 Jan 2007 19:35:26 +0800
Message-ID: <1168083326.5619.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Add "sleep_state" and "wakeup" attributes for devices that can wakeup a sleep system.
They are located under sysfs device tree, i.e. /sys/device/acpi_system/.../xxx/.
"sleep_state" indicates the lowest power system sleeping state that can be entered while still providing wake functionality.
#echo 1 or 0 >/sys/devices/acpi_system/.../xxx/wakeup can be used to enable/disable the device's ability to wake a sleeping system.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c         |   12 +++++
 drivers/acpi/sleep/proc.c   |   90 ++++++++++++++++++++++++++++++++++++++++++--
 include/acpi/acpi_drivers.h |    6 ++
 3 files changed, 105 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc2-mm1/drivers/acpi/sleep/proc.c
===================================================================
--- linux-2.6.20-rc2-mm1.orig/drivers/acpi/sleep/proc.c	2007-01-06 18:17:53.000000000 +0800
+++ linux-2.6.20-rc2-mm1/drivers/acpi/sleep/proc.c	2007-01-06 18:18:01.000000000 +0800
@@ -296,6 +296,93 @@ static int alarm_add_sysfs(void)
 	return sysfs_create_file(&power_subsys.kset.kobj, &alarm_attr.attr);
 }
 
+/*
+ * "sleep_state" and "wakeup" attributes are created when device is registered
+ */
+extern struct list_head acpi_wakeup_device_list;
+extern spinlock_t acpi_device_lock;
+
+static ssize_t
+acpi_sleep_state_show(struct device *dev, struct device_attribute *attr, char* buf){
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "%2d\n", (u32) acpi_dev->wakeup.sleep_state);
+}
+static DEVICE_ATTR(sleep_state, 0444, acpi_sleep_state_show, NULL);
+
+static ssize_t
+acpi_wakeup_show(struct device *dev, struct device_attribute *attr, char* buf){
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+
+	return sprintf(buf, "%2d\n", (u32) acpi_dev->wakeup.state.enabled);
+}
+
+static ssize_t
+acpi_wakeup_store(struct device *dev, struct device_attribute *attr, const char* buf, size_t count){
+	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_device *other_dev;
+	struct list_head *node, *next;
+	char *endp;
+	int state;
+
+	if (!acpi_dev)
+		return -EINVAL;
+
+	state = simple_strtol(buf, &endp, 0);
+	if (*endp == '\0')
+		return -EINVAL;
+
+	if(state != 0 && state != 1)
+		return -EINVAL;
+	acpi_dev->wakeup.state.enabled = state;
+
+	spin_lock(&acpi_device_lock);
+	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
+		other_dev = container_of(node, struct acpi_device, wakeup_list);
+		if ((other_dev != acpi_dev) &&
+		(other_dev->wakeup.gpe_number == acpi_dev->wakeup.gpe_number) &&
+		(other_dev->wakeup.gpe_device == acpi_dev->wakeup.gpe_device)) {
+			printk(KERN_WARNING "ACPI: '%s' and '%s' have the same GPE, "
+					"can't disable/enable one seperately\n",
+					other_dev->pnp.bus_id, acpi_dev->pnp.bus_id);
+			other_dev->wakeup.state.enabled = acpi_dev->wakeup.state.enabled;
+		}
+	}
+	spin_unlock(&acpi_device_lock);
+	return count;
+}
+
+#define DEVICE_ATTR_RO(_name, _mode, _show)	\
+struct device_attribute dev_attr_##_name##_ro = __ATTR(_name, _mode, _show, NULL)
+
+static DEVICE_ATTR(wakeup, 0644, acpi_wakeup_show, acpi_wakeup_store);
+static DEVICE_ATTR_RO(wakeup, 0444, acpi_wakeup_show);
+
+int acpi_add_wakeup_sysfs(struct acpi_device *dev) {
+	int result;
+
+	result = device_create_file(&dev->dev, &dev_attr_sleep_state);
+	if(result)
+		goto end;
+	if(dev->wakeup.flags.run_wake)
+		result = device_create_file(&dev->dev, &dev_attr_wakeup_ro);
+	else
+		result = device_create_file(&dev->dev, &dev_attr_wakeup);
+  end:
+  	return result;
+}
+EXPORT_SYMBOL(acpi_add_wakeup_sysfs);
+
+void acpi_remove_wakeup_sysfs(struct acpi_device *dev) {
+
+	if(dev->wakeup.flags.run_wake)
+		device_remove_file(&dev->dev, &dev_attr_wakeup_ro);
+	else
+		device_remove_file(&dev->dev, &dev_attr_wakeup);
+	device_remove_file(&dev->dev, &dev_attr_sleep_state);
+}
+EXPORT_SYMBOL(acpi_remove_wakeup_sysfs);
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -598,9 +685,6 @@ acpi_system_write_alarm(struct file *fil
 	return_VALUE(result ? result : count);
 }
 
-extern struct list_head acpi_wakeup_device_list;
-extern spinlock_t acpi_device_lock;
-
 static int
 acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 {
Index: linux-2.6.20-rc2-mm1/drivers/acpi/scan.c
===================================================================
--- linux-2.6.20-rc2-mm1.orig/drivers/acpi/scan.c	2007-01-06 17:54:31.000000000 +0800
+++ linux-2.6.20-rc2-mm1/drivers/acpi/scan.c	2007-01-06 18:18:01.000000000 +0800
@@ -155,6 +155,15 @@ static int acpi_device_setup_files(struc
 			goto end;
 	}
 
+	/*
+	 * add "wakeup" and "sleep_state" attributes for ACPI devices
+	 */
+	if(dev->wakeup.flags.valid) {
+		result = acpi_add_wakeup_sysfs(dev);
+		if(result)
+			goto end;
+	}
+
         /*
          * If device has _EJ0, 'eject' file is created that is used to trigger
          * hot-removal function from userland.
@@ -179,6 +188,9 @@ static void acpi_device_remove_files(str
 	if (ACPI_SUCCESS(status))
 		device_remove_file(&dev->dev, &dev_attr_eject);
 
+	if(dev->wakeup.flags.valid)
+		acpi_remove_wakeup_sysfs(dev);
+
 	if(dev->flags.hardware_id)
 		device_remove_file(&dev->dev, &dev_attr_hid);
 	if(dev->handle)
Index: linux-2.6.20-rc2-mm1/include/acpi/acpi_drivers.h
===================================================================
--- linux-2.6.20-rc2-mm1.orig/include/acpi/acpi_drivers.h	2007-01-06 17:54:31.000000000 +0800
+++ linux-2.6.20-rc2-mm1/include/acpi/acpi_drivers.h	2007-01-06 18:18:01.000000000 +0800
@@ -45,6 +45,12 @@
 
 #define ACPI_VIDEO_HID			"video"
 #define ACPI_BAY_HID			"bay"
+
+ /* --------------------------------------------------------------------------
+                                       Wakeup
+   -------------------------------------------------------------------------- */
+int acpi_add_wakeup_sysfs(struct acpi_device *dev);
+void acpi_remove_wakeup_sysfs(struct acpi_device *dev);
 /* --------------------------------------------------------------------------
                                        PCI
    -------------------------------------------------------------------------- */
