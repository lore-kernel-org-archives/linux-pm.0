From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 2/2] PM / Qos: Add notifier for pm qos flags
Date: Thu,  1 Nov 2012 18:47:26 +0800
Message-ID: <1351766846-24654-2-git-send-email-tianyu.lan@intel.com>
References: <1351766846-24654-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34362 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756297Ab2KAKvX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Nov 2012 06:51:23 -0400
In-Reply-To: <1351766846-24654-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, stern@rowland.harvard.edu
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

If pm qos flags was changed, device driver would take different
action according flags. E.g NO_POWER_OFF flag, if it was set when
a device had been power off, device driver should power on the device,
resume it and suspend it again without not power off. So device driver
should be notified. This patch is to add notifier for pm qos flags and
notify device when flags is changed.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/base/power/qos.c |   86 +++++++++++++++++++++++++++++++++++++---------
 include/linux/pm_qos.h   |    7 ++--
 2 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 31d3f48..c37f52f 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -149,6 +149,10 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 	case DEV_PM_QOS_FLAGS:
 		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
 					  action, value);
+		if (ret)
+			blocking_notifier_call_chain(qos->flags.notifiers,
+				(unsigned long)qos->flags.effective_flags,
+				req);
 		break;
 	default:
 		ret = -EINVAL;
@@ -168,26 +172,38 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 {
 	struct dev_pm_qos *qos;
 	struct pm_qos_constraints *c;
-	struct blocking_notifier_head *n;
+	struct pm_qos_flags	*flags;
+	struct blocking_notifier_head *constraints_notify;
+	struct blocking_notifier_head *flags_notify;
+	int ret = 0;
 
 	qos = kzalloc(sizeof(*qos), GFP_KERNEL);
 	if (!qos)
 		return -ENOMEM;
 
-	n = kzalloc(sizeof(*n), GFP_KERNEL);
-	if (!n) {
-		kfree(qos);
-		return -ENOMEM;
+	constraints_notify = kzalloc(sizeof(*constraints_notify), GFP_KERNEL);
+	if (!constraints_notify) {
+		ret = -ENOMEM;
+		goto alloc_constraints_fail;
+	}
+	BLOCKING_INIT_NOTIFIER_HEAD(constraints_notify);
+
+	flags_notify = kzalloc(sizeof(*flags_notify), GFP_KERNEL);
+	if (!flags_notify) {
+		ret = -ENOMEM;
+		goto alloc_flags_fail;
 	}
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
+	BLOCKING_INIT_NOTIFIER_HEAD(flags_notify);
 
 	c = &qos->latency;
 	plist_head_init(&c->list);
 	c->target_value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
 	c->default_value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
 	c->type = PM_QOS_MIN;
-	c->notifiers = n;
+	c->notifiers = constraints_notify;
 
+	flags = &qos->flags;
+	flags->notifiers = flags_notify;
 	INIT_LIST_HEAD(&qos->flags.list);
 
 	spin_lock_irq(&dev->power.lock);
@@ -195,6 +211,12 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	spin_unlock_irq(&dev->power.lock);
 
 	return 0;
+
+alloc_flags_fail:
+	kfree(constraints_notify);
+alloc_constraints_fail:
+	kfree(qos);
+	return ret;
 }
 
 /**
@@ -432,6 +454,7 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
  *
  * @dev: target device for the constraint
  * @notifier: notifier block managed by caller.
+ * @type: type of notifier
  *
  * Will register the notifier into a notification chain that gets called
  * upon changes to the target value for the device.
@@ -439,9 +462,11 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
  * If the device's constraints object doesn't exist when this routine is called,
  * it will be created (or error code will be returned if that fails).
  */
-int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
+int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
+		enum dev_pm_qos_req_type type)
 {
 	int ret = 0;
+	struct blocking_notifier_head *notifiers_head = NULL;
 
 	mutex_lock(&dev_pm_qos_mtx);
 
@@ -449,9 +474,22 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
 		ret = dev->power.power_state.event != PM_EVENT_INVALID ?
 			dev_pm_qos_constraints_allocate(dev) : -ENODEV;
 
-	if (!ret)
-		ret = blocking_notifier_chain_register(
-				dev->power.qos->latency.notifiers, notifier);
+	if (!ret) {
+		switch (type) {
+		case DEV_PM_QOS_LATENCY:
+			notifiers_head = dev->power.qos->latency.notifiers;
+			break;
+		case DEV_PM_QOS_FLAGS:
+			notifiers_head = dev->power.qos->flags.notifiers;
+			break;
+		default:
+			break;
+		}
+
+		if (notifiers_head)
+			ret = blocking_notifier_chain_register(
+					notifiers_head, notifier);
+	}
 
 	mutex_unlock(&dev_pm_qos_mtx);
 	return ret;
@@ -464,22 +502,38 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_notifier);
  *
  * @dev: target device for the constraint
  * @notifier: notifier block to be removed.
+ * @type: type of notifier
  *
  * Will remove the notifier from the notification chain that gets called
  * upon changes to the target value.
  */
 int dev_pm_qos_remove_notifier(struct device *dev,
-			       struct notifier_block *notifier)
+		struct notifier_block *notifier, enum dev_pm_qos_req_type type)
 {
 	int retval = 0;
+	struct blocking_notifier_head *notifiers_head = NULL;
+
 
 	mutex_lock(&dev_pm_qos_mtx);
 
 	/* Silently return if the constraints object is not present. */
-	if (dev->power.qos)
-		retval = blocking_notifier_chain_unregister(
-				dev->power.qos->latency.notifiers,
-				notifier);
+	if (dev->power.qos) {
+		switch (type) {
+		case DEV_PM_QOS_LATENCY:
+			notifiers_head = dev->power.qos->latency.notifiers;
+			break;
+		case DEV_PM_QOS_FLAGS:
+			notifiers_head = dev->power.qos->flags.notifiers;
+			break;
+		default:
+			break;
+		}
+
+		if (notifiers_head)
+			retval = blocking_notifier_chain_unregister(
+					notifiers_head,
+					notifier);
+	}
 
 	mutex_unlock(&dev_pm_qos_mtx);
 	return retval;
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 5a95013..479da6c 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -84,6 +84,7 @@ struct pm_qos_constraints {
 struct pm_qos_flags {
 	struct list_head list;
 	s32 effective_flags;	/* Do not change to 64 bit */
+	struct blocking_notifier_head *notifiers;
 };
 
 struct dev_pm_qos {
@@ -134,9 +135,11 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
 int dev_pm_qos_remove_request(struct dev_pm_qos_request *req);
 int dev_pm_qos_add_notifier(struct device *dev,
-			    struct notifier_block *notifier);
+			    struct notifier_block *notifier,
+			    enum dev_pm_qos_req_type type);
 int dev_pm_qos_remove_notifier(struct device *dev,
-			       struct notifier_block *notifier);
+				struct notifier_block *notifier,
+			    enum dev_pm_qos_req_type type);
 int dev_pm_qos_add_global_notifier(struct notifier_block *notifier);
 int dev_pm_qos_remove_global_notifier(struct notifier_block *notifier);
 void dev_pm_qos_constraints_init(struct device *dev);
-- 
1.7.9.5

