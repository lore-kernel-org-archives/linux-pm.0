From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 4/9] PM / QOS: Add DEV_PM_QOS_PERFORMANCE request
Date: Wed, 26 Apr 2017 16:27:08 +0530
Message-ID: <166953ca65e499dfb42927c6c13734b513a2d29b.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Some platforms have the capability to configure the performance state of
their Power Domains. The performance levels are identified by positive
integer values, a lower value represents lower performance state. The
power domain driver should be able to retrieve all information required
to configure the performance state of the power domain, with the help of
the performance constraint's target value.

This patch adds a new QOS request type: DEV_PM_QOS_PERFORMANCE to
support runtime performance constraints for the devices. Also allow
notifiers to be registered against it, which will be used by frameworks
like genpd.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/power/pm_qos_interface.txt |  2 +-
 drivers/base/power/qos.c                 | 21 +++++++++++++++++++++
 include/linux/pm_qos.h                   |  9 +++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index 21d2d48f87a2..42870d28fc3c 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -168,7 +168,7 @@ The per-device PM QoS framework has a per-device notification tree.
 int dev_pm_qos_add_notifier(device, notifier):
 Adds a notification callback function for the device.
 The callback is called when the aggregated value of the device constraints list
-is changed (for resume latency device PM QoS only).
+is changed (for resume latency and performance device PM QoS).
 
 int dev_pm_qos_remove_notifier(device, notifier):
 Removes the notification callback function for the device.
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 654d8a12c2e7..084d26960dae 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -150,6 +150,10 @@ static int apply_constraint(struct dev_pm_qos_request *req,
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
@@ -194,6 +198,14 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 
+	c = &qos->performance;
+	plist_head_init(&c->list);
+	c->target_value = PM_QOS_PERFORMANCE_DEFAULT_VALUE;
+	c->default_value = PM_QOS_PERFORMANCE_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_PERFORMANCE_DEFAULT_VALUE;
+	c->type = PM_QOS_MAX;
+	c->notifiers = &qos->notifiers;
+
 	INIT_LIST_HEAD(&qos->flags.list);
 
 	spin_lock_irq(&dev->power.lock);
@@ -252,6 +264,11 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
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
@@ -362,6 +379,7 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 	switch(req->type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 	case DEV_PM_QOS_LATENCY_TOLERANCE:
+	case DEV_PM_QOS_PERFORMANCE:
 		curr_value = req->data.pnode.prio;
 		break;
 	case DEV_PM_QOS_FLAGS:
@@ -571,6 +589,9 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
 		req = dev->power.qos->flags_req;
 		dev->power.qos->flags_req = NULL;
 		break;
+	case DEV_PM_QOS_PERFORMANCE:
+		dev_err(dev, "Invalid user request (performance)\n");
+		return;
 	}
 	__dev_pm_qos_remove_request(req);
 	kfree(req);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index e546d1a2f237..665f90face40 100644
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
 
@@ -96,6 +98,7 @@ struct pm_qos_flags {
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
+	struct pm_qos_constraints performance;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
@@ -121,6 +124,12 @@ static inline bool dev_pm_qos_is_resume_latency(struct device *dev,
 	return &dev->power.qos->resume_latency == c;
 }
 
+static inline bool dev_pm_qos_is_performance(struct device *dev,
+					     struct pm_qos_constraints *c)
+{
+	return &dev->power.qos->performance == c;
+}
+
 int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 			 enum pm_qos_req_action action, int value);
 bool pm_qos_update_flags(struct pm_qos_flags *pqf,
-- 
2.12.0.432.g71c3a4f4ba37
