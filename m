From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V8 1/6] PM / Domains: Add support to select performance-state of domains
Date: Wed, 21 Jun 2017 12:40:48 +0530
Message-ID: <52daf22d2c9d92b0e61c8c5c5a88516d7a08a31a.1498026827.git.viresh.kumar@linaro.org>
References: <cover.1498026827.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1498026827.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498026827.git.viresh.kumar@linaro.org>
References: <cover.1498026827.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
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

A power domain may have only set_performance_state(), if it doesn't have
any direct devices below it but subdomains. And so the
get_performance_state() will never get called from the core.

The more common case would be to have both the callbacks set.

Another API, pm_genpd_has_performance_state(), is also added to let
other parts of the kernel check if the power domain of a device supports
performance-states or not. This could have been done from
pm_genpd_update_performance_state() as well, but that routine gets
called every time we do DVFS for the device and it wouldn't be optimal
in that case.

Note that, the performance level as returned by
->get_performance_state() for the parent domain of a device is used for
all domains in parent hierarchy.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 223 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  22 +++++
 2 files changed, 245 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 71c95ad808d5..d506be9ff1f7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -466,6 +466,229 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
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
+ *
+ * This must be called by the user drivers, before they start calling
+ * pm_genpd_update_performance_state(), to guarantee that all dependencies are
+ * met and the device's genpd supports performance states.
+ *
+ * It is assumed that the user driver guarantees that the genpd wouldn't be
+ * detached while this routine is getting called.
+ *
+ * Returns "true" if device's genpd supports performance states, "false"
+ * otherwise.
+ */
+bool pm_genpd_has_performance_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd = genpd_lookup_dev(dev);
+
+	/* The parent domain must have set get_performance_state() */
+	if (!IS_ERR(genpd) && genpd->get_performance_state) {
+		if (genpd_has_set_performance_state(genpd))
+			return true;
+
+		/*
+		 * A genpd with ->get_performance_state() callback must also
+		 * allow setting performance state.
+		 */
+		dev_err(dev, "genpd doesn't support setting performance state\n");
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_has_performance_state);
+
+/*
+ * Re-evaluate performance state of a power domain. Finds the highest requested
+ * performance state by the devices and subdomains within the power domain and
+ * then tries to change its performance state. If the power domain doesn't have
+ * a set_performance_state() callback, then we move the request to its parent
+ * power domain.
+ *
+ * Locking: Access (or update) to device's "pd_data->performance_state" field
+ * happens only with parent domain's lock held. Subdomains have their
+ * "genpd->performance_state" protected with their own lock (and they are the
+ * only user of this field) and their per-parent-domain
+ * "link->performance_state" field is protected with individual parent power
+ * domain's lock and is only accessed/updated with that lock held.
+ */
+static int genpd_update_performance_state(struct generic_pm_domain *genpd,
+					  int depth)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct generic_pm_domain *master;
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
+		if (link->performance_state > state)
+			state = link->performance_state;
+	}
+
+	if (genpd->performance_state == state)
+		return 0;
+
+	if (genpd->set_performance_state) {
+		ret = genpd->set_performance_state(genpd, state);
+		if (!ret)
+			genpd->performance_state = state;
+
+		return ret;
+	}
+
+	/*
+	 * Not all domains support updating performance state. Move on to their
+	 * parent domains in that case.
+	 */
+	prev = genpd->performance_state;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+
+		link->performance_state = state;
+		ret = genpd_update_performance_state(master, depth + 1);
+		if (ret)
+			link->performance_state = prev;
+
+		genpd_unlock(master);
+
+		if (ret)
+			goto err;
+	}
+
+	/*
+	 * The parent domains are updated now, lets get genpd performance_state
+	 * in sync with those.
+	 */
+	genpd->performance_state = state;
+	return 0;
+
+err:
+	list_for_each_entry_continue_reverse(link, &genpd->slave_links,
+					     slave_node) {
+		master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		link->performance_state = prev;
+		if (genpd_update_performance_state(master, depth + 1))
+			pr_err("%s: Failed to roll back to %d performance state\n",
+			       genpd->name, prev);
+		genpd_unlock(master);
+	}
+
+	return ret;
+}
+
+static int __dev_update_performance_state(struct device *dev, int state)
+{
+	struct generic_pm_domain_data *gpd_data;
+	int ret;
+
+	spin_lock_irq(&dev->power.lock);
+
+	if (!dev->power.subsys_data || !dev->power.subsys_data->domain_data) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+
+	ret = gpd_data->performance_state;
+	gpd_data->performance_state = state;
+
+unlock:
+	spin_unlock_irq(&dev->power.lock);
+
+	return ret;
+}
+
+/**
+ * pm_genpd_update_performance_state - Update performance state of device's
+ * parent power domain for the target frequency for the device.
+ *
+ * @dev: Device for which the performance-state needs to be adjusted.
+ * @rate: Device's next frequency. This can be set as 0 when the device doesn't
+ * have any performance state constraints left (And so the device wouldn't
+ * participate anymore to find the target performance state of the genpd).
+ *
+ * This must be called by the user drivers (as many times as they want) only
+ * after pm_genpd_has_performance_state() is called (only once) and that
+ * returned "true".
+ *
+ * It is assumed that the user driver guarantees that the genpd wouldn't be
+ * detached while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int pm_genpd_update_performance_state(struct device *dev, unsigned long rate)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	int ret, state;
+
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	genpd_lock(genpd);
+
+	state = genpd->get_performance_state(dev, rate);
+	if (state < 0) {
+		ret = state;
+		goto unlock;
+	}
+
+	state = __dev_update_performance_state(dev, state);
+	if (state < 0) {
+		ret = state;
+		goto unlock;
+	}
+
+	ret = genpd_update_performance_state(genpd, 0);
+	if (ret)
+		__dev_update_performance_state(dev, state);
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
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b7803a251044..bf90177208a2 100644
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
@@ -99,6 +103,9 @@ struct gpd_link {
 	struct list_head master_node;
 	struct generic_pm_domain *slave;
 	struct list_head slave_node;
+
+	/* Sub-domain's per-parent domain performance state */
+	unsigned int performance_state;
 };
 
 struct gpd_timing_data {
@@ -118,6 +125,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	unsigned int performance_state;
 	void *data;
 };
 
@@ -148,6 +156,9 @@ extern int pm_genpd_remove(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+extern bool pm_genpd_has_performance_state(struct device *dev);
+extern int pm_genpd_update_performance_state(struct device *dev,
+					     unsigned long rate);
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
@@ -185,6 +196,17 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
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
2.13.0.71.gd7076ec9c9cb
