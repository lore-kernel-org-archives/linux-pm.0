From: ahaslam@baylibre.com
Subject: [PATCH 2/2] PM / QoS: Introduce per device bandwidth request PM QoS type
Date: Tue, 23 Aug 2016 15:43:47 +0200
Message-ID: <1471959827-19837-2-git-send-email-ahaslam@baylibre.com>
References: <1471959827-19837-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34888 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbcHWNnz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 09:43:55 -0400
Received: by mail-wm0-f50.google.com with SMTP id f65so163530824wmi.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2016 06:43:54 -0700 (PDT)
In-Reply-To: <1471959827-19837-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

Some devices may have properties that affect how fast they react
(latency) but also what data rate they can handle (bandwidth).
These two properties may not be intertwined. For example, a device
may enter low power active modes if it detects no activity (generating
extra latency when work arrives), but it may also configure itself for
a slower speed limiting the data rate its able to process. The speed
setting is independant of the low power mode.

Similarly to latency tolerance, introduce a per-device bandwidth
constraint that will prevent the hardware form entering a low
power active state which is unable to support the bandwidth needed
from the device by the platform. The bandwidth constraint
is the SUM of all the bandwidth constraints against the device.

Similarly to latency tolerance, This feature will only be available
to devices who have .set_bandwidth() callback in dev_pm_info
populated.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 Documentation/ABI/testing/sysfs-devices-power |  24 +++++
 Documentation/power/pm_qos_interface.txt      |  68 +++++++------
 drivers/base/power/power.h                    |   2 +
 drivers/base/power/qos.c                      | 139 +++++++++++++++++++++++++-
 drivers/base/power/sysfs.c                    |  63 ++++++++++++
 include/linux/pm.h                            |   1 +
 include/linux/pm_qos.h                        |  17 ++++
 7 files changed, 281 insertions(+), 33 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 676fdf5..043fe33 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -244,6 +244,30 @@ Description:
 		This attribute has no effect on runtime suspend and resume of
 		devices and on system-wide suspend/resume and hibernation.
 
+What:		/sys/devices/.../power/pm_qos_bandwidth_kbps
+Date:		August 2016
+Contact:	Axel Haslam <ahaslam@bayliblre.com>
+Description:
+		The /sys/devices/.../power/pm_qos_bandwidth_kbps attribute
+		contains the PM QoS active state user space bandwidth request for
+		the given device in kilobits per second. It tells the data rate
+		the device should be able to accommodate for user space.
+		If that value is the string "any", the bandwidth does not matter
+		to user space at all, but hardware should not limit the available
+		bandwidth in any way.
+
+		Reading "auto" from this file means that the bandwidth
+		for the device may be determined automatically by the hardware as
+		needed. Writing "auto" to it allows the hardware to be switched
+		to this mode if there are no other bandwidth requirements from
+		the kernel side.
+
+		This attribute is only present if the feature controlled by it
+		is supported by the hardware.
+
+		This attribute has no effect on runtime suspend and resume of
+		devices and on system-wide suspend/resume and hibernation.
+
 What:		/sys/devices/.../power/pm_qos_no_power_off
 Date:		September 2012
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index 129f7c0..b76387a 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -88,15 +88,17 @@ To remove the user mode request for a target value simply close the device
 node.
 
 
-2. PM QoS per-device latency and flags framework
+2. PM QoS per-device latency, bandwidth and flags framework
 
-For each device, there are three lists of PM QoS requests. Two of them are
-maintained along with the aggregated targets of resume latency and active
-state latency tolerance (in microseconds) and the third one is for PM QoS flags.
-Values are updated in response to changes of the request list.
+For each device, there are four lists of PM QoS requests. Three of them are
+maintained along with the aggregated targets of resume latency, active
+state latency tolerance (in microseconds), and active state bandwidth (in kbps).
+The forth one is for PM QoS flags. Values are updated in response to changes
+of the request list.
 
 The target values of resume latency and active state latency tolerance are
 simply the minimum of the request values held in the parameter list elements.
+The target value of bandwidth is the total added value of all the request values.
 The PM QoS flags aggregate value is a gather (bitwise OR) of all list elements'
 values.  Two device PM QoS flags are defined currently: PM_QOS_FLAG_NO_POWER_OFF
 and PM_QOS_FLAG_REMOTE_WAKEUP.
@@ -140,7 +142,8 @@ int dev_pm_qos_add_ancestor_request(dev, handle, type, value)
 Add a PM QoS request for the first direct ancestor of the given device whose
 power.ignore_children flag is unset (for DEV_PM_QOS_RESUME_LATENCY requests)
 or whose power.set_latency_tolerance callback pointer is not NULL (for
-DEV_PM_QOS_LATENCY_TOLERANCE requests).
+DEV_PM_QOS_LATENCY_TOLERANCE requests) or whose power.set_bandwidth
+callback pointer is not NULL (for DEV_PM_QOS_BANDWIDTH requests).
 
 int dev_pm_qos_expose_latency_limit(device, value)
 Add a request to the device's PM QoS list of resume latency constraints and
@@ -185,9 +188,9 @@ Removes the notification callback function from the global notification tree
 of the framework.
 
 
-Active state latency tolerance
+Active state bandwidth and latency tolerance
 
-This device PM QoS type is used to support systems in which hardware may switch
+These device PM QoS types are used to support systems in which hardware may switch
 to energy-saving operation modes on the fly.  In those systems, if the operation
 mode chosen by the hardware attempts to save energy in an overly aggressive way,
 it may cause excess latencies to be visible to software, causing it to miss
@@ -195,30 +198,33 @@ certain protocol requirements or target frame or sample rates etc.
 
 If there is a latency tolerance control mechanism for a given device available
 to software, the .set_latency_tolerance callback in that device's dev_pm_info
-structure should be populated.  The routine pointed to by it is should implement
-whatever is necessary to transfer the effective requirement value to the
-hardware.
-
-Whenever the effective latency tolerance changes for the device, its
-.set_latency_tolerance() callback will be executed and the effective value will
-be passed to it.  If that value is negative, which means that the list of
-latency tolerance requirements for the device is empty, the callback is expected
-to switch the underlying hardware latency tolerance control mechanism to an
-autonomous mode if available.  If that value is PM_QOS_LATENCY_ANY, in turn, and
-the hardware supports a special "no requirement" setting, the callback is
-expected to use it.  That allows software to prevent the hardware from
-automatically updating the device's latency tolerance in response to its power
-state changes (e.g. during transitions from D3cold to D0), which generally may
-be done in the autonomous latency tolerance control mode.
-
-If .set_latency_tolerance() is present for the device, sysfs attribute
-pm_qos_latency_tolerance_us will be present in the devivce's power directory.
-Then, user space can use that attribute to specify its latency tolerance
-requirement for the device, if any.  Writing "any" to it means "no requirement,
-but do not let the hardware control latency tolerance" and writing "auto" to it
+structure should be populated. If there is a bandwidth control mechanism for a
+given device available to software, the .set_bandwidth callback in that device's
+dev_pm_info structure should be populated. The routines pointed to by these callbacks
+should implement whatever is necessary to transfer the effective requirement value
+to the hardware.
+
+Whenever the effective latency tolerance or the requested bandwidth changes for
+the device, the respective callback will be executed and the effective value will
+be passed to it. If that value is negative, which means that the list of
+requirements for the device is empty, the callback is expected to switch the
+underlying hardware control mechanism to an autonomous mode if available.  If that
+value is PM_QOS_LATENCY_ANY or PM_QOS_BANDWIDTH_ANY, and the hardware supports a
+special "no requirement" setting, the callback is expected to use it. That allows
+software to prevent the hardware from automatically updating the device's latency
+tolerance or available bandwidth in response to its power state changes (e.g. during
+transitions from D3cold to D0), which generally may be done in the autonomous
+control mode.
+
+If .set_latency_tolerance() is present for the device, the sysfs attribute
+pm_qos_latency_tolerance_us will be present in the devivce's power directory. If
+.set_bandwidth() is present for the device, the sysfs attribute pm_qos_bandwidth_kbps
+will be present in the devivce's power directory. User space can use those attributes
+to specify its requirements for the device, if any.  Writing "any" to it means
+"no requirement, but do not allow hardware control" and writing "auto" to it
 allows the hardware to be switched to the autonomous mode if there are no other
 requirements from the kernel side in the device's list.
 
 Kernel code can use the functions described above along with the
-DEV_PM_QOS_LATENCY_TOLERANCE device PM QoS type to add, remove and update
-latency tolerance requirements for devices.
+DEV_PM_QOS_LATENCY_TOLERANCE / DEV_PM_QOS_BANDWIDTH device PM QoS types to add,
+remove and update bandwidth requests and latency tolerance requirements for devices.
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 50e30e7..64203db 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -76,6 +76,8 @@ extern int pm_qos_sysfs_add_flags(struct device *dev);
 extern void pm_qos_sysfs_remove_flags(struct device *dev);
 extern int pm_qos_sysfs_add_latency_tolerance(struct device *dev);
 extern void pm_qos_sysfs_remove_latency_tolerance(struct device *dev);
+extern int pm_qos_sysfs_add_bandwidth(struct device *dev);
+extern void pm_qos_sysfs_remove_bandwidth(struct device *dev);
 
 #else /* CONFIG_PM */
 
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 0bd03e6..c6dd740 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -163,6 +163,14 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 			req->dev->power.set_latency_tolerance(req->dev, value);
 		}
 		break;
+	case DEV_PM_QOS_BANDWIDTH:
+		ret = pm_qos_update_target(&qos->bandwidth,
+					   &req->data.pnode, action, value);
+		if (ret) {
+			value = pm_qos_read_value(&qos->bandwidth);
+			req->dev->power.set_bandwidth(req->dev, value);
+		}
+		break;
 	case DEV_PM_QOS_FLAGS:
 		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
 					  action, value);
@@ -213,6 +221,13 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 
+	c = &qos->bandwidth;
+	plist_head_init(&c->list);
+	c->target_value = PM_QOS_BANDWIDTH_DEFAULT_VALUE;
+	c->default_value = PM_QOS_BANDWIDTH_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_BANDWIDTH_NO_CONSTRAINT;
+	c->type = PM_QOS_SUM;
+
 	INIT_LIST_HEAD(&qos->flags.list);
 
 	spin_lock_irq(&dev->power.lock);
@@ -271,6 +286,11 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
+	c = &qos->bandwidth;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
 	f = &qos->flags;
 	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
@@ -293,8 +313,15 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 static bool dev_pm_qos_invalid_request(struct device *dev,
 				       enum dev_pm_qos_req_type type)
 {
-	return (type == DEV_PM_QOS_LATENCY_TOLERANCE
-			&& !dev->power.set_latency_tolerance);
+	if (type == DEV_PM_QOS_LATENCY_TOLERANCE
+		&& !dev->power.set_latency_tolerance)
+		return true;
+
+	if (type == DEV_PM_QOS_BANDWIDTH
+		&& !dev->power.set_bandwidth)
+		return true;
+
+	return false;
 }
 
 static int __dev_pm_qos_add_request(struct device *dev,
@@ -382,6 +409,7 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 	switch(req->type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 	case DEV_PM_QOS_LATENCY_TOLERANCE:
+	case DEV_PM_QOS_BANDWIDTH:
 		curr_value = req->data.pnode.prio;
 		break;
 	case DEV_PM_QOS_FLAGS:
@@ -590,6 +618,11 @@ int dev_pm_qos_add_ancestor_request(struct device *dev,
 			ancestor = ancestor->parent;
 
 		break;
+	case DEV_PM_QOS_BANDWIDTH:
+		while (ancestor && !ancestor->power.set_bandwidth)
+			ancestor = ancestor->parent;
+
+		break;
 	default:
 		ancestor = NULL;
 	}
@@ -617,6 +650,10 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
 		req = dev->power.qos->latency_tolerance_req;
 		dev->power.qos->latency_tolerance_req = NULL;
 		break;
+	case DEV_PM_QOS_BANDWIDTH:
+		req = dev->power.qos->bandwidth_req;
+		dev->power.qos->bandwidth_req = NULL;
+		break;
 	case DEV_PM_QOS_FLAGS:
 		req = dev->power.qos->flags_req;
 		dev->power.qos->flags_req = NULL;
@@ -920,3 +957,101 @@ void dev_pm_qos_hide_latency_tolerance(struct device *dev)
 	pm_runtime_put(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
+
+/**
+ * dev_pm_qos_get_user_bandwidth - Get user space bandwidth request.
+ * @dev: Device to obtain the user space bandwidth request for.
+ */
+s32 dev_pm_qos_get_user_bandwidth(struct device *dev)
+{
+	s32 ret;
+
+	mutex_lock(&dev_pm_qos_mtx);
+	ret = IS_ERR_OR_NULL(dev->power.qos)
+		|| !dev->power.qos->bandwidth_req ?
+			PM_QOS_BANDWIDTH_NO_CONSTRAINT :
+			dev->power.qos->bandwidth_req->data.pnode.prio;
+	mutex_unlock(&dev_pm_qos_mtx);
+	return ret;
+}
+
+/**
+ * dev_pm_qos_update_user_bandwidth - Update user space bandwidth request.
+ * @dev: Device to obtain the user space bandwidth request for.
+ * @val: New user space bandwidth request for @dev (negative values disable).
+ */
+int dev_pm_qos_update_user_bandwidth(struct device *dev, s32 val)
+{
+	int ret;
+
+	mutex_lock(&dev_pm_qos_mtx);
+
+	if (IS_ERR_OR_NULL(dev->power.qos)
+	    || !dev->power.qos->bandwidth_req) {
+		struct dev_pm_qos_request *req;
+
+		if (val < 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+		req = kzalloc(sizeof(*req), GFP_KERNEL);
+		if (!req) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = __dev_pm_qos_add_request(dev, req, DEV_PM_QOS_BANDWIDTH, val);
+		if (ret < 0) {
+			kfree(req);
+			goto out;
+		}
+		dev->power.qos->bandwidth_req = req;
+	} else {
+		if (val < 0) {
+			__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_BANDWIDTH);
+			ret = 0;
+		} else {
+			ret = __dev_pm_qos_update_request(dev->power.qos->bandwidth_req, val);
+		}
+	}
+
+ out:
+	mutex_unlock(&dev_pm_qos_mtx);
+	return ret;
+}
+
+/**
+ * dev_pm_qos_expose_bandwidth - Expose bandwidth to userspace
+ * @dev: Device whose bandwidth to expose
+ */
+int dev_pm_qos_expose_bandwidth(struct device *dev)
+{
+	int ret;
+
+	if (!dev->power.set_bandwidth)
+		return -EINVAL;
+
+	mutex_lock(&dev_pm_qos_sysfs_mtx);
+	ret = pm_qos_sysfs_add_bandwidth(dev);
+	mutex_unlock(&dev_pm_qos_sysfs_mtx);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_expose_bandwidth);
+
+/**
+ * dev_pm_qos_hide_bandwidth - Hide bandwidth from userspace
+ * @dev: Device whose bandwidth to hide
+ */
+void dev_pm_qos_hide_bandwidth(struct device *dev)
+{
+	mutex_lock(&dev_pm_qos_sysfs_mtx);
+	pm_qos_sysfs_remove_bandwidth(dev);
+	mutex_unlock(&dev_pm_qos_sysfs_mtx);
+
+	/* Remove the request from user space now */
+	pm_runtime_get_sync(dev);
+	dev_pm_qos_update_user_bandwidth(dev,
+		PM_QOS_BANDWIDTH_NO_CONSTRAINT);
+	pm_runtime_put(dev);
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_hide_bandwidth);
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index a7b4679..de8e8b3 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -276,6 +276,40 @@ static ssize_t pm_qos_latency_tolerance_store(struct device *dev,
 static DEVICE_ATTR(pm_qos_latency_tolerance_us, 0644,
 		   pm_qos_latency_tolerance_show, pm_qos_latency_tolerance_store);
 
+static ssize_t pm_qos_bandwidth_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	s32 value = dev_pm_qos_get_user_bandwidth(dev);
+
+	if (value < 0)
+		return sprintf(buf, "auto\n");
+	else if (value == PM_QOS_BANDWIDTH_ANY)
+		return sprintf(buf, "any\n");
+
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t pm_qos_bandwidth_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t n)
+{
+	s32 value;
+	int ret;
+
+	if (kstrtos32(buf, 0, &value)) {
+		if (!strcmp(buf, "auto") || !strcmp(buf, "auto\n"))
+			value = PM_QOS_BANDWIDTH_NO_CONSTRAINT;
+		else if (!strcmp(buf, "any") || !strcmp(buf, "any\n"))
+			value = PM_QOS_BANDWIDTH_ANY;
+	}
+	ret = dev_pm_qos_update_user_bandwidth(dev, value);
+	return ret < 0 ? ret : n;
+}
+
+static DEVICE_ATTR(pm_qos_bandwidth_kbps, 0644,
+		   pm_qos_bandwidth_show, pm_qos_bandwidth_store);
+
 static ssize_t pm_qos_no_power_off_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -663,6 +697,15 @@ static struct attribute_group pm_qos_latency_tolerance_attr_group = {
 	.attrs	= pm_qos_latency_tolerance_attrs,
 };
 
+static struct attribute *pm_qos_bandwidth_attrs[] = {
+	&dev_attr_pm_qos_bandwidth_kbps.attr,
+	NULL,
+};
+static struct attribute_group pm_qos_bandwidth_attr_group = {
+	.name	= power_group_name,
+	.attrs	= pm_qos_bandwidth_attrs,
+};
+
 static struct attribute *pm_qos_flags_attrs[] = {
 	&dev_attr_pm_qos_no_power_off.attr,
 	&dev_attr_pm_qos_remote_wakeup.attr,
@@ -697,8 +740,16 @@ int dpm_sysfs_add(struct device *dev)
 		if (rc)
 			goto err_wakeup;
 	}
+	if (dev->power.set_bandwidth) {
+		rc = sysfs_merge_group(&dev->kobj,
+				       &pm_qos_bandwidth_attr_group);
+		if (rc)
+			goto err_latency_tolerance;
+	}
 	return 0;
 
+ err_latency_tolerance:
+	sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_group);
  err_wakeup:
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
  err_runtime:
@@ -749,6 +800,17 @@ void pm_qos_sysfs_remove_latency_tolerance(struct device *dev)
 	sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_group);
 }
 
+int pm_qos_sysfs_add_bandwidth(struct device *dev)
+{
+	return sysfs_merge_group(&dev->kobj,
+				 &pm_qos_bandwidth_attr_group);
+}
+
+void pm_qos_sysfs_remove_bandwidth(struct device *dev)
+{
+	sysfs_unmerge_group(&dev->kobj, &pm_qos_bandwidth_attr_group);
+}
+
 void rpm_sysfs_remove(struct device *dev)
 {
 	sysfs_unmerge_group(&dev->kobj, &pm_runtime_attr_group);
@@ -756,6 +818,7 @@ void rpm_sysfs_remove(struct device *dev)
 
 void dpm_sysfs_remove(struct device *dev)
 {
+	sysfs_unmerge_group(&dev->kobj, &pm_qos_bandwidth_attr_group);
 	sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_group);
 	dev_pm_qos_constraints_destroy(dev);
 	rpm_sysfs_remove(dev);
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 06eb353..ef2f5a8 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -607,6 +607,7 @@ struct dev_pm_info {
 #endif
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
+	void (*set_bandwidth)(struct device *, s32);
 	struct dev_pm_qos	*qos;
 };
 
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 0f65d36..54e4129 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -38,6 +38,9 @@ enum pm_qos_flags_status {
 #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 #define PM_QOS_LATENCY_ANY			((s32)(~(__u32)0 >> 1))
+#define PM_QOS_BANDWIDTH_DEFAULT_VALUE 0
+#define PM_QOS_BANDWIDTH_NO_CONSTRAINT (-1)
+#define PM_QOS_BANDWIDTH_ANY			((s32)(~(__u32)0 >> 1))
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
 #define PM_QOS_FLAG_REMOTE_WAKEUP	(1 << 1)
@@ -56,6 +59,7 @@ struct pm_qos_flags_request {
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
 	DEV_PM_QOS_LATENCY_TOLERANCE,
+	DEV_PM_QOS_BANDWIDTH,
 	DEV_PM_QOS_FLAGS,
 };
 
@@ -97,9 +101,11 @@ struct pm_qos_flags {
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
+	struct pm_qos_constraints bandwidth;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
+	struct dev_pm_qos_request *bandwidth_req;
 	struct dev_pm_qos_request *flags_req;
 };
 
@@ -163,6 +169,10 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev);
 int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val);
 int dev_pm_qos_expose_latency_tolerance(struct device *dev);
 void dev_pm_qos_hide_latency_tolerance(struct device *dev);
+s32 dev_pm_qos_get_user_bandwidth(struct device *dev);
+int dev_pm_qos_update_user_bandwidth(struct device *dev, s32 val);
+int dev_pm_qos_expose_bandwidth(struct device *dev);
+void dev_pm_qos_hide_bandwidth(struct device *dev);
 
 static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev)
 {
@@ -235,6 +245,13 @@ static inline int dev_pm_qos_expose_latency_tolerance(struct device *dev)
 			{ return 0; }
 static inline void dev_pm_qos_hide_latency_tolerance(struct device *dev) {}
 
+static inline s32 dev_pm_qos_get_user_bandwidth(struct device *dev)
+			{ return PM_QOS_BANDWIDTH_NO_CONSTRAINT; }
+static inline int dev_pm_qos_update_user_bandwidth(struct device *dev, s32 val)
+			{ return 0; }
+static inline int dev_pm_qos_expose_bandwidth(struct device *dev)
+			{ return 0; }
+static inline void dev_pm_qos_hide_bandwidth(struct device *dev) {}
 static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev) { return 0; }
 static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
 #endif
-- 
2.7.1

