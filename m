From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] PM / QoS: Drop PM_QOS_FLAG_REMOTE_WAKEUP
Date: Fri, 13 Oct 2017 15:27:24 +0200
Message-ID: <31420416.ycOlZLk83O@aspire.rjw.lan>
References: <1853660.GWc8KbUC1W@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1853660.GWc8KbUC1W@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PM QoS flag PM_QOS_FLAG_REMOTE_WAKEUP is not used consistently
and the vast majority of code simply assumes that remote wakeup
should be enabled for devices in runtime suspend if they can
generate wakeup signals, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---

-> v2: Drop it from documentation too and add tags from Ulf and Mika.

---
 Documentation/ABI/testing/sysfs-devices-power |   16 --------------
 Documentation/power/pm_qos_interface.txt      |   13 +++++-------
 drivers/acpi/device_pm.c                      |    6 +----
 drivers/base/power/domain.c                   |    4 ---
 drivers/base/power/sysfs.c                    |   28 --------------------------
 include/linux/pm_qos.h                        |    1 
 6 files changed, 9 insertions(+), 59 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -581,8 +581,7 @@ static int acpi_dev_pm_get_state(struct
 		d_min = ret;
 		wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
 			&& adev->wakeup.sleep_state >= target_state;
-	} else if (dev_pm_qos_flags(dev, PM_QOS_FLAG_REMOTE_WAKEUP) !=
-			PM_QOS_FLAGS_NONE) {
+	} else {
 		wakeup = adev->wakeup.flags.valid;
 	}
 
@@ -865,8 +864,7 @@ int acpi_dev_runtime_suspend(struct devi
 	if (!adev)
 		return 0;
 
-	remote_wakeup = dev_pm_qos_flags(dev, PM_QOS_FLAG_REMOTE_WAKEUP) >
-				PM_QOS_FLAGS_NONE;
+	remote_wakeup = acpi_device_can_wakeup(adev);
 	if (remote_wakeup) {
 		error = acpi_device_wakeup_enable(adev, ACPI_STATE_S0);
 		if (error)
Index: linux-pm/include/linux/pm_qos.h
===================================================================
--- linux-pm.orig/include/linux/pm_qos.h
+++ linux-pm/include/linux/pm_qos.h
@@ -39,7 +39,6 @@ enum pm_qos_flags_status {
 #define PM_QOS_LATENCY_ANY			((s32)(~(__u32)0 >> 1))
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
-#define PM_QOS_FLAG_REMOTE_WAKEUP	(1 << 1)
 
 struct pm_qos_request {
 	struct plist_node node;
Index: linux-pm/drivers/base/power/domain.c
===================================================================
--- linux-pm.orig/drivers/base/power/domain.c
+++ linux-pm/drivers/base/power/domain.c
@@ -346,9 +346,7 @@ static int genpd_power_off(struct generi
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
 		enum pm_qos_flags_status stat;
 
-		stat = dev_pm_qos_flags(pdd->dev,
-					PM_QOS_FLAG_NO_POWER_OFF
-						| PM_QOS_FLAG_REMOTE_WAKEUP);
+		stat = dev_pm_qos_flags(pdd->dev, PM_QOS_FLAG_NO_POWER_OFF);
 		if (stat > PM_QOS_FLAGS_NONE)
 			return -EBUSY;
 
Index: linux-pm/drivers/base/power/sysfs.c
===================================================================
--- linux-pm.orig/drivers/base/power/sysfs.c
+++ linux-pm/drivers/base/power/sysfs.c
@@ -309,33 +309,6 @@ static ssize_t pm_qos_no_power_off_store
 static DEVICE_ATTR(pm_qos_no_power_off, 0644,
 		   pm_qos_no_power_off_show, pm_qos_no_power_off_store);
 
-static ssize_t pm_qos_remote_wakeup_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	return sprintf(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
-					& PM_QOS_FLAG_REMOTE_WAKEUP));
-}
-
-static ssize_t pm_qos_remote_wakeup_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t n)
-{
-	int ret;
-
-	if (kstrtoint(buf, 0, &ret))
-		return -EINVAL;
-
-	if (ret != 0 && ret != 1)
-		return -EINVAL;
-
-	ret = dev_pm_qos_update_flags(dev, PM_QOS_FLAG_REMOTE_WAKEUP, ret);
-	return ret < 0 ? ret : n;
-}
-
-static DEVICE_ATTR(pm_qos_remote_wakeup, 0644,
-		   pm_qos_remote_wakeup_show, pm_qos_remote_wakeup_store);
-
 #ifdef CONFIG_PM_SLEEP
 static const char _enabled[] = "enabled";
 static const char _disabled[] = "disabled";
@@ -671,7 +644,6 @@ static const struct attribute_group pm_q
 
 static struct attribute *pm_qos_flags_attrs[] = {
 	&dev_attr_pm_qos_no_power_off.attr,
-	&dev_attr_pm_qos_remote_wakeup.attr,
 	NULL,
 };
 static const struct attribute_group pm_qos_flags_attr_group = {
Index: linux-pm/Documentation/ABI/testing/sysfs-devices-power
===================================================================
--- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-power
+++ linux-pm/Documentation/ABI/testing/sysfs-devices-power
@@ -258,19 +258,3 @@ Description:
 
 		This attribute has no effect on system-wide suspend/resume and
 		hibernation.
-
-What:		/sys/devices/.../power/pm_qos_remote_wakeup
-Date:		September 2012
-Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
-Description:
-		The /sys/devices/.../power/pm_qos_remote_wakeup attribute
-		is used for manipulating the PM QoS "remote wakeup required"
-		flag.  If set, this flag indicates to the kernel that the
-		device is a source of user events that have to be signaled from
-		its low-power states.
-
-		Not all drivers support this attribute.  If it isn't supported,
-		it is not present.
-
-		This attribute has no effect on system-wide suspend/resume and
-		hibernation.
Index: linux-pm/Documentation/power/pm_qos_interface.txt
===================================================================
--- linux-pm.orig/Documentation/power/pm_qos_interface.txt
+++ linux-pm/Documentation/power/pm_qos_interface.txt
@@ -98,8 +98,7 @@ Values are updated in response to change
 The target values of resume latency and active state latency tolerance are
 simply the minimum of the request values held in the parameter list elements.
 The PM QoS flags aggregate value is a gather (bitwise OR) of all list elements'
-values.  Two device PM QoS flags are defined currently: PM_QOS_FLAG_NO_POWER_OFF
-and PM_QOS_FLAG_REMOTE_WAKEUP.
+values.  One device PM QoS flag is defined currently: PM_QOS_FLAG_NO_POWER_OFF.
 
 Note: The aggregated target values are implemented in such a way that reading
 the aggregated value does not require any locking mechanism.
@@ -153,14 +152,14 @@ PM QoS list of resume latency constraint
 pm_qos_resume_latency_us from the device's power directory.
 
 int dev_pm_qos_expose_flags(device, value)
-Add a request to the device's PM QoS list of flags and create sysfs attributes
-pm_qos_no_power_off and pm_qos_remote_wakeup under the device's power directory
-allowing user space to change these flags' value.
+Add a request to the device's PM QoS list of flags and create sysfs attribute
+pm_qos_no_power_off under the device's power directory allowing user space to
+change the value of the PM_QOS_FLAG_NO_POWER_OFF flag.
 
 void dev_pm_qos_hide_flags(device)
 Drop the request added by dev_pm_qos_expose_flags() from the device's PM QoS list
-of flags and remove sysfs attributes pm_qos_no_power_off and pm_qos_remote_wakeup
-under the device's power directory.
+of flags and remove sysfs attribute pm_qos_no_power_off from the device's power
+directory.
 
 Notification mechanisms:
 The per-device PM QoS framework has a per-device notification tree.


