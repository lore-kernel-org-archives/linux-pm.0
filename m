From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/6] PM / QOS: Add 'performance' request
Date: Thu,  9 Feb 2017 09:11:49 +0530
Message-ID: <9820795796278bc66baa3f41220f8524cbdda537.1486611268.git.viresh.kumar@linaro.org>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486611268.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1486611268.git.viresh.kumar@linaro.org>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add a new QOS request type: DEV_PM_QOS_PERFORMANCE.

This is required to support runtime performance constraints for the
devices. Also allow notifiers to be registered against it, which can be
used by frameworks like genpd.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/power/pm_qos_interface.txt |  2 +-
 drivers/base/power/qos.c                 | 69 +++++++++++++++++++++++++++-----
 include/linux/pm_qos.h                   |  4 ++
 3 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index c7989d140428..a0a45ecbc1a8 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -172,7 +172,7 @@ type.
 
 The callback is called when the aggregated value of the device constraints list
 is changed. Currently it only supports the notifier to be registered for resume
-latency device PM QoS.
+latency and performance device PM QoS.
 
 int dev_pm_qos_remove_notifier(device, notifier, type):
 Removes the notification callback function for the device.
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 9adc208cf1fc..cf070468a7ca 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -163,6 +163,10 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 			req->dev->power.set_latency_tolerance(req->dev, value);
 		}
 		break;
+	case DEV_PM_QOS_PERFORMANCE:
+		ret = pm_qos_update_target(&qos->performance, &req->data.pnode,
+					   action, value);
+		break;
 	case DEV_PM_QOS_FLAGS:
 		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
 					  action, value);
@@ -191,12 +195,13 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	if (!qos)
 		return -ENOMEM;
 
-	n = kzalloc(sizeof(*n), GFP_KERNEL);
+	n = kzalloc(2 * sizeof(*n), GFP_KERNEL);
 	if (!n) {
 		kfree(qos);
 		return -ENOMEM;
 	}
 	BLOCKING_INIT_NOTIFIER_HEAD(n);
+	BLOCKING_INIT_NOTIFIER_HEAD(n + 1);
 
 	c = &qos->resume_latency;
 	plist_head_init(&c->list);
@@ -213,6 +218,14 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 
+	c = &qos->performance;
+	plist_head_init(&c->list);
+	c->target_value = PM_QOS_PERFORMANCE_DEFAULT_VALUE;
+	c->default_value = PM_QOS_PERFORMANCE_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_PERFORMANCE_DEFAULT_VALUE;
+	c->type = PM_QOS_MAX;
+	c->notifiers = n + 1;
+
 	INIT_LIST_HEAD(&qos->flags.list);
 
 	spin_lock_irq(&dev->power.lock);
@@ -271,6 +284,11 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
+	c = &qos->performance;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
 	f = &qos->flags;
 	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
@@ -382,6 +400,7 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 	switch(req->type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 	case DEV_PM_QOS_LATENCY_TOLERANCE:
+	case DEV_PM_QOS_PERFORMANCE:
 		curr_value = req->data.pnode.prio;
 		break;
 	case DEV_PM_QOS_FLAGS:
@@ -492,11 +511,9 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
 int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 			    enum dev_pm_qos_req_type type)
 {
+	struct dev_pm_qos *qos;
 	int ret = 0;
 
-	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
-		return -EINVAL;
-
 	mutex_lock(&dev_pm_qos_mtx);
 
 	if (IS_ERR(dev->power.qos))
@@ -504,10 +521,26 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 	else if (!dev->power.qos)
 		ret = dev_pm_qos_constraints_allocate(dev);
 
-	if (!ret)
-		ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
+	if (ret)
+		goto unlock;
+
+	qos = dev->power.qos;
+
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		ret = blocking_notifier_chain_register(qos->resume_latency.notifiers,
+						       notifier);
+		break;
+	case DEV_PM_QOS_PERFORMANCE:
+		ret = blocking_notifier_chain_register(qos->performance.notifiers,
 						       notifier);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
 
+unlock:
 	mutex_unlock(&dev_pm_qos_mtx);
 	return ret;
 }
@@ -528,18 +561,32 @@ int dev_pm_qos_remove_notifier(struct device *dev,
 			       struct notifier_block *notifier,
 			       enum dev_pm_qos_req_type type)
 {
+	struct dev_pm_qos *qos;
 	int retval = 0;
 
-	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
-		return -EINVAL;
-
 	mutex_lock(&dev_pm_qos_mtx);
 
+	qos = dev->power.qos;
+
 	/* Silently return if the constraints object is not present. */
-	if (!IS_ERR_OR_NULL(dev->power.qos))
-		retval = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
+	if (IS_ERR_OR_NULL(qos))
+		goto unlock;
+
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		retval = blocking_notifier_chain_unregister(qos->resume_latency.notifiers,
+							    notifier);
+		break;
+	case DEV_PM_QOS_PERFORMANCE:
+		retval = blocking_notifier_chain_unregister(qos->performance.notifiers,
 							    notifier);
+		break;
+	default:
+		WARN_ON(1);
+		retval = -EINVAL;
+	}
 
+unlock:
 	mutex_unlock(&dev_pm_qos_mtx);
 	return retval;
 }
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 08cfaeb6c178..0e8386adb21c 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -36,6 +36,7 @@ enum pm_qos_flags_status {
 #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE	0
 #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
+#define PM_QOS_PERFORMANCE_DEFAULT_VALUE	0
 #define PM_QOS_LATENCY_ANY			((s32)(~(__u32)0 >> 1))
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
@@ -55,6 +56,7 @@ struct pm_qos_flags_request {
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
 	DEV_PM_QOS_LATENCY_TOLERANCE,
+	DEV_PM_QOS_PERFORMANCE,
 	DEV_PM_QOS_FLAGS,
 };
 
@@ -96,9 +98,11 @@ struct pm_qos_flags {
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
+	struct pm_qos_constraints performance;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
+	struct dev_pm_qos_request *performance_req;
 	struct dev_pm_qos_request *flags_req;
 };
 
-- 
2.7.1.410.g6faf27b
