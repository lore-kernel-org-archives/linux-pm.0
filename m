From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / QoS: Drop PM_QOS_FLAG_REMOTE_WAKEUP
Date: Fri, 13 Oct 2017 02:35:12 +0200
Message-ID: <1853660.GWc8KbUC1W@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PM QoS flag PM_QOS_FLAG_REMOTE_WAKEUP is not used consistently
and the vast majority of code simply assumes that remote wakeup
should be enabled for devices in runtime suspend if they can
generate wakeup signals, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c    |    6 ++----
 drivers/base/power/domain.c |    4 +---
 drivers/base/power/sysfs.c  |   28 ----------------------------
 include/linux/pm_qos.h      |    1 -
 4 files changed, 3 insertions(+), 36 deletions(-)

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

