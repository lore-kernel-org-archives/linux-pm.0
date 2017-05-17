From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V7 1/2] PM / Domains: Add support to select performance-state of domains
Date: Wed, 17 May 2017 12:32:42 +0530
Message-ID: <4cc55fce0fd4199941f1d7b785e677255ff792d5.1495003720.git.viresh.kumar@linaro.org>
References: <cover.1495003720.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495003720.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1495003720.git.viresh.kumar@linaro.org>
References: <cover.1495003720.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Some platforms have the capability to configure the performance state of
their Power Domains. The performance levels are identified by positive
integer values, a lower value represents lower performance state.

This patch adds a new genpd API: pm_genpd_update_performance_state().
The caller passes the affected device and the frequency representing its
next DVFS state.

The power domains get two new callbacks:

- get_performance_state(): This is called by the genpd core to retrieve
  the performance state (integer value) corresponding to a target
  frequency for the device. This state is used by the genpd core to find
  the highest requested state by all the devices powered by a domain.

- set_performance_state(): The highest state retrieved from above
  interface is then passed to this callback to finally program the
  performance state of the power domain.

The power domains can avoid supplying these callbacks, if they don't
support setting performance-states.

A power domain may have only get_performance_state() callback, if it
doesn't have the capability of changing the performance state itself but
someone in its parent hierarchy has.

A power domain may have only set_performance_state(), it doesn't have
any direct devices below it and only subdomains. And so the
get_performance_state() will never get called.

The more common case would be to have both the callbacks set.

Another API, pm_genpd_has_performance_state(), is also added to let
other parts of the kernel check if the power domain of a device supports
performance-states or not.

Note that the same performance level as returned by the parent domain of
a device is used for every other domain in parent hierarchy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 172 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  19 +++++
 2 files changed, 191 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 71c95ad808d5..56b666eb1a71 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -466,6 +466,166 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+/*
+ * Returns true if anyone in genpd's parent hierarchy has
+ * set_performance_state() set.
+ */
+static bool genpd_has_set_performance_state(struct generic_pm_domain *genpd)
+{
+	struct gpd_link *link;
+
+	if (genpd->set_performance_state)
+		return true;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		if (genpd_has_set_performance_state(link->master))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * pm_genpd_has_performance_state - Checks if power domain does performance
+ * state management.
+ *
+ * @dev: Device whose power domain is getting inquired.
+ */
+bool pm_genpd_has_performance_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+
+	/* The parent domain must have set get_performance_state() */
+	if (!IS_ERR(genpd) && genpd->get_performance_state)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_has_performance_state);
+
+static int genpd_update_performance_state(struct generic_pm_domain *genpd,
+					  int depth)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct generic_pm_domain *subdomain;
+	struct pm_domain_data *pdd;
+	unsigned int state = 0, prev;
+	struct gpd_link *link;
+	int ret;
+
+	/* Traverse all devices within the domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		pd_data = to_gpd_data(pdd);
+
+		if (pd_data->performance_state > state)
+			state = pd_data->performance_state;
+	}
+
+	/* Traverse all subdomains within the domain */
+	list_for_each_entry(link, &genpd->master_links, master_node) {
+		subdomain = link->slave;
+
+		if (subdomain->performance_state > state)
+			state = subdomain->performance_state;
+	}
+
+	if (genpd->performance_state == state)
+		return 0;
+
+	/*
+	 * Not all domains support updating performance state. Move on to their
+	 * parent domains in that case.
+	 */
+	if (genpd->set_performance_state) {
+		ret = genpd->set_performance_state(genpd, state);
+		if (!ret)
+			genpd->performance_state = state;
+
+		return ret;
+	}
+
+	prev = genpd->performance_state;
+	genpd->performance_state = state;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		struct generic_pm_domain *master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		ret = genpd_update_performance_state(master, depth + 1);
+		genpd_unlock(master);
+
+		if (!ret)
+			continue;
+
+		/*
+		 * Preserve earlier state for all the power domains which have
+		 * been updated.
+		 */
+		genpd->performance_state = prev;
+
+		list_for_each_entry(link, &genpd->slave_links, slave_node) {
+			struct generic_pm_domain *nmaster = link->master;
+
+			if (nmaster == master)
+				break;
+
+			genpd_lock_nested(nmaster, depth + 1);
+			genpd_update_performance_state(master, depth + 1);
+			genpd_unlock(master);
+		}
+
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * pm_genpd_update_performance_state - Update performance state of parent power
+ * domain for the target frequency for the device.
+ *
+ * @dev: Device for which the performance-state needs to be adjusted.
+ * @rate: Device's next frequency.
+ */
+int pm_genpd_update_performance_state(struct device *dev, unsigned long rate)
+{
+	struct generic_pm_domain *genpd = ERR_PTR(-ENODATA);
+	struct generic_pm_domain_data *gpd_data;
+	int ret, prev;
+
+	spin_lock_irq(&dev->power.lock);
+	if (dev->power.subsys_data && dev->power.subsys_data->domain_data) {
+		gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+		genpd = dev_to_genpd(dev);
+	}
+	spin_unlock_irq(&dev->power.lock);
+
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	if (!genpd->get_performance_state) {
+		dev_err(dev, "Performance states aren't supported by power domain\n");
+		return -EINVAL;
+	}
+
+	genpd_lock(genpd);
+	ret = genpd->get_performance_state(dev, rate);
+	if (ret < 0)
+		goto unlock;
+
+	prev = gpd_data->performance_state;
+	gpd_data->performance_state = ret;
+	ret = genpd_update_performance_state(genpd, 0);
+	if (ret)
+		gpd_data->performance_state = prev;
+
+unlock:
+	genpd_unlock(genpd);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_update_performance_state);
+
 /**
  * genpd_power_off_work_fn - Power off PM domain whose subdomain count is 0.
  * @work: Work structure used for scheduling the execution of this function.
@@ -1156,6 +1316,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+	gpd_data->performance_state = 0;
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -1502,6 +1663,17 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.start = pm_clk_resume;
 	}
 
+	/*
+	 * If this genpd supports getting performance state, then someone in its
+	 * hierarchy must support setting it too.
+	 */
+	if (genpd->get_performance_state &&
+	    !genpd_has_set_performance_state(genpd)) {
+		pr_err("%s: genpd doesn't support updating performance state\n",
+		       genpd->name);
+		return -ENODEV;
+	}
+
 	/* Always-on domains must be powered on at initialization. */
 	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
 		return -EINVAL;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b7803a251044..74502664ea33 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -63,8 +63,12 @@ struct generic_pm_domain {
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
+	unsigned int performance_state;	/* Max requested performance state */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	int (*get_performance_state)(struct device *dev, unsigned long rate);
+	int (*set_performance_state)(struct generic_pm_domain *domain,
+				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
@@ -118,6 +122,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	unsigned int performance_state;
 	void *data;
 };
 
@@ -148,6 +153,9 @@ extern int pm_genpd_remove(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+extern bool pm_genpd_has_performance_state(struct device *dev);
+extern int pm_genpd_update_performance_state(struct device *dev,
+					     unsigned long rate);
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
@@ -185,6 +193,17 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -ENOTSUPP;
 }
 
+static inline bool pm_genpd_has_performance_state(struct device *dev)
+{
+	return false;
+}
+
+static inline int pm_genpd_update_performance_state(struct device *dev,
+						    unsigned long rate)
+{
+	return -ENOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.13.0.303.g4ebf3021692d
