From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/7] PM / QOS: Keep common notifier list for genpd constraints
Date: Fri, 24 Feb 2017 14:36:35 +0530
Message-ID: <851a8ddd4b30e632f2491fc034c62a0b0ebcccfa.1487926924.git.viresh.kumar@linaro.org>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1487926924.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1487926924.git.viresh.kumar@linaro.org>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Only the resume_latency constraint uses the notifiers right now. In
order to prepare for adding new constraint types with notifiers, move to
a common notifier list.

Update pm_qos_update_target() to pass a pointer to the constraint
structure to the notifier callbacks. Also update the notifier callbacks
as well to error out for unexpected constraints.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/base/power/domain.c | 26 +++++++++++++++++++-------
 drivers/base/power/qos.c    | 15 ++++-----------
 include/linux/pm_qos.h      |  7 +++++++
 kernel/power/qos.c          |  2 +-
 4 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e697dec9d25b..303490ab5ffd 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -416,14 +416,10 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	return ret;
 }
 
-static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
-				     unsigned long val, void *ptr)
+static int __resume_latency_notifier(struct generic_pm_domain_data *gpd_data,
+				     unsigned long val)
 {
-	struct generic_pm_domain_data *gpd_data;
-	struct device *dev;
-
-	gpd_data = container_of(nb, struct generic_pm_domain_data, nb);
-	dev = gpd_data->base.dev;
+	struct device *dev = gpd_data->base.dev;
 
 	for (;;) {
 		struct generic_pm_domain *genpd;
@@ -456,6 +452,22 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
+				     unsigned long val, void *ptr)
+{
+	struct generic_pm_domain_data *gpd_data;
+	struct device *dev;
+
+	gpd_data = container_of(nb, struct generic_pm_domain_data, nb);
+	dev = gpd_data->base.dev;
+
+	if (dev_pm_qos_notifier_is_resume_latency(dev, ptr))
+		return __resume_latency_notifier(gpd_data, val);
+
+	dev_err(dev, "%s: Unexpected notifier call\n", __func__);
+	return NOTIFY_BAD;
+}
+
 /**
  * genpd_power_off_work_fn - Power off PM domain whose subdomain count is 0.
  * @work: Work structure used for scheduling the execution of this function.
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 271bec73185e..851fff60319c 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -173,18 +173,12 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 {
 	struct dev_pm_qos *qos;
 	struct pm_qos_constraints *c;
-	struct blocking_notifier_head *n;
 
 	qos = kzalloc(sizeof(*qos), GFP_KERNEL);
 	if (!qos)
 		return -ENOMEM;
 
-	n = kzalloc(sizeof(*n), GFP_KERNEL);
-	if (!n) {
-		kfree(qos);
-		return -ENOMEM;
-	}
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
+	BLOCKING_INIT_NOTIFIER_HEAD(&qos->notifiers);
 
 	c = &qos->resume_latency;
 	plist_head_init(&c->list);
@@ -192,7 +186,7 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->default_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
 	c->no_constraint_value = PM_QOS_RESUME_LATENCY_DEFAULT_VALUE;
 	c->type = PM_QOS_MIN;
-	c->notifiers = n;
+	c->notifiers = &qos->notifiers;
 
 	c = &qos->latency_tolerance;
 	plist_head_init(&c->list);
@@ -269,7 +263,6 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 	dev->power.qos = ERR_PTR(-ENODEV);
 	spin_unlock_irq(&dev->power.lock);
 
-	kfree(qos->resume_latency.notifiers);
 	kfree(qos);
 
  out:
@@ -488,7 +481,7 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
 		ret = dev_pm_qos_constraints_allocate(dev);
 
 	if (!ret)
-		ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
+		ret = blocking_notifier_chain_register(&dev->power.qos->notifiers,
 						       notifier);
 
 	mutex_unlock(&dev_pm_qos_mtx);
@@ -515,7 +508,7 @@ int dev_pm_qos_remove_notifier(struct device *dev,
 
 	/* Silently return if the constraints object is not present. */
 	if (!IS_ERR_OR_NULL(dev->power.qos))
-		retval = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
+		retval = blocking_notifier_chain_unregister(&dev->power.qos->notifiers,
 							    notifier);
 
 	mutex_unlock(&dev_pm_qos_mtx);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 3e2547d6e207..dd02020a02b6 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -100,6 +100,7 @@ struct dev_pm_qos {
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
 	struct dev_pm_qos_request *flags_req;
+	struct blocking_notifier_head notifiers; /* common for all constraints */
 };
 
 /* Action requested to pm_qos_update_target */
@@ -114,6 +115,12 @@ static inline int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
 	return req->dev != NULL;
 }
 
+static inline bool dev_pm_qos_notifier_is_resume_latency(struct device *dev,
+		struct pm_qos_constraints *c)
+{
+	return &dev->power.qos->resume_latency == c;
+}
+
 int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 			 enum pm_qos_req_action action, int value);
 bool pm_qos_update_flags(struct pm_qos_flags *pqf,
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 97b0df71303e..073324e0c3c8 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -315,7 +315,7 @@ int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 		if (c->notifiers)
 			blocking_notifier_call_chain(c->notifiers,
 						     (unsigned long)curr_value,
-						     NULL);
+						     c);
 	} else {
 		ret = 0;
 	}
-- 
2.7.1.410.g6faf27b
