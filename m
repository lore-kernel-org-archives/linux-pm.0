From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V9 1/7] PM / Domains: Add support to select performance-state of domains
Date: Wed,  2 Aug 2017 15:42:32 +0530
Message-ID: <be580e89b254e3aa42e9784a8b73244e913c26e4.1501668354.git.viresh.kumar@linaro.org>
References: <cover.1501668354.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501668354.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1501668354.git.viresh.kumar@linaro.org>
References: <cover.1501668354.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

Some platforms have the capability to configure the performance state of
PM domains and this patch updates the genpd core to support them.

The performance levels (within the genpd core) are identified by
positive integer values, a lower value represents lower performance
state.

This patch adds two new genpd APIs:

- int dev_pm_genpd_has_performance_state(struct device *dev)

  This can be called (only once) by the device drivers to make sure all
  dependencies are met and the PM domain of the device supports
  performance states.

- int dev_pm_genpd_update_performance_state(struct device *dev,
  					    unsigned long rate);

  This can be called (any number of times) by the device drivers after
  they have called dev_pm_genpd_has_performance_state() once and it
  returned "true".

  This call will update the performance state of the PM domain of the
  device (for which this routine is called) and propagate it to the
  masters of the PM domain. This requires certain callbacks to be
  available for the genpd of the device, which are internally called by
  this routine in the order in which they are described below.

  - dev_get_performance_state()

    This shall return the performance state (integer value)
    corresponding to a target frequency for the device. This state is
    used by the genpd core as device's requested performance state and
    would be used while aggregating the requested states of all the
    devices and subdomains for a PM domain.

    Note that the same state value will be used by the device's PM
    domain and its masters hierarchy. We may want to implement master
    specific states later on once we have more complex cases available.

    Providing this callback is mandatory for any genpd which needs to
    manage performance states and is registered as master of one or more
    devices. Domains which only have sub domains and no devices, should
    not implement this callback.

  - genpd_set_performance_state()

    The aggregate of the performance states of the devices and
    subdomains of a PM genpd is then passed to this callback, which must
    change the performance state of the genpd. This callback of the
    masters of the genpd are also called to propagate the change.

  The power domains can avoid supplying these callbacks, if they don't
  support setting performance-states.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 284 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   |  23 ++++
 2 files changed, 305 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 43fd08e50ae9..5f50d5295cd4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -237,6 +237,274 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 #endif
 
+/**
+ * dev_pm_genpd_has_performance_state - Checks if power domain does performance
+ * state management.
+ *
+ * @dev: Device whose power domain is getting inquired.
+ *
+ * This can be called by the user drivers, before they start calling
+ * dev_pm_genpd_update_performance_state(), to guarantee that all dependencies
+ * are met and the device's genpd supports performance states.
+ *
+ * It is assumed that the user driver guarantees that the genpd wouldn't be
+ * detached while this routine is getting called.
+ *
+ * Returns "true" if device's genpd supports performance states, "false"
+ * otherwise.
+ */
+bool dev_pm_genpd_has_performance_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd = genpd_lookup_dev(dev);
+
+	return !IS_ERR(genpd) && genpd->dev_get_performance_state;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_has_performance_state);
+
+static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
+					   int state, int depth);
+
+/* Returns -ve errors or 0 on success */
+static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
+					int state, int depth)
+{
+	struct generic_pm_domain *master;
+	struct gpd_link *link;
+	int prev = genpd->performance_state, ret;
+
+	if (genpd->genpd_set_performance_state) {
+		ret = genpd->genpd_set_performance_state(genpd, state);
+		if (ret)
+			return ret;
+	}
+
+	/* Propagate to masters of genpd */
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+
+		link->performance_state = state;
+		ret = _genpd_reeval_performance_state(master, state, depth + 1);
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
+	 * The masters are updated now, lets get genpd performance_state in sync
+	 * with those.
+	 */
+	genpd->performance_state = state;
+	return 0;
+
+err:
+	/* Encountered an error, lets rollback */
+	list_for_each_entry_continue_reverse(link, &genpd->slave_links,
+					     slave_node) {
+		master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		link->performance_state = prev;
+		if (_genpd_reeval_performance_state(master, prev, depth + 1)) {
+			pr_err("%s: Failed to roll back to %d performance state\n",
+			       master->name, prev);
+		}
+		genpd_unlock(master);
+	}
+
+	if (genpd->genpd_set_performance_state) {
+		if (genpd->genpd_set_performance_state(genpd, prev)) {
+			pr_err("%s: Failed to roll back to %d performance state\n",
+			       genpd->name, prev);
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Re-evaluate performance state of a genpd. Finds the highest requested
+ * performance state by the devices and subdomains within the genpd and then
+ * change genpd's performance state (if required). The request is then
+ * propagated to the masters of the genpd.
+ *
+ * @genpd: PM domain whose state needs to be reevaluated.
+ * @state: Newly requested performance state of the device or subdomain for
+ * which this routine is called.
+ * @depth: nesting count for lockdep.
+ *
+ * Locking rules followed are:
+ *
+ * - Device's state (pd_data->performance_state) should be accessed from within
+ *   its master's lock protected section.
+ *
+ * - Subdomains have a separate state field (link->performance_state) per master
+ *   domain and is accessed only from within master's lock protected section.
+ *
+ * - Subdomain's state (genpd->performance_state) should be accessed from within
+ *   its own lock protected section.
+ *
+ * - The locks are always taken in bottom->up order, i.e. subdomain first,
+ *   followed by its masters.
+ *
+ * Returns -ve errors or 0 on success.
+ */
+static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
+					   int state, int depth)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct pm_domain_data *pdd;
+	struct gpd_link *link;
+
+	/* New requested state is same as Max requested state */
+	if (state == genpd->performance_state)
+		return 0;
+
+	/* New requested state is higher than Max requested state */
+	if (state > genpd->performance_state)
+		goto update_state;
+
+	/* Traverse all devices within the domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		pd_data = to_gpd_data(pdd);
+
+		if (pd_data->performance_state > state)
+			state = pd_data->performance_state;
+	}
+
+	/*
+	 * Traverse all subdomains within the domain. This can be done without
+	 * any additional locks as all link->performance_state fields are
+	 * protected by genpd->lock, which is already taken.
+	 */
+	list_for_each_entry(link, &genpd->master_links, master_node) {
+		if (link->performance_state > state)
+			state = link->performance_state;
+	}
+
+update_state:
+	return _genpd_set_performance_state(genpd, state, depth);
+}
+
+static void __genpd_dev_update_performance_state(struct device *dev, int state)
+{
+	struct generic_pm_domain_data *gpd_data;
+
+	spin_lock_irq(&dev->power.lock);
+
+	if (!dev->power.subsys_data || !dev->power.subsys_data->domain_data) {
+		WARN_ON(1);
+		goto unlock;
+	}
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+	gpd_data->performance_state = state;
+
+unlock:
+	spin_unlock_irq(&dev->power.lock);
+}
+
+/**
+ * dev_pm_genpd_update_performance_state - Update performance state of device's
+ * power domain for the target frequency for the device.
+ *
+ * @dev: Device for which the performance-state needs to be adjusted.
+ * @rate: Device's next frequency. This can be set as 0 when the device doesn't
+ * have any performance state constraints left (And so the device wouldn't
+ * participate anymore to find the target performance state of the genpd).
+ *
+ * The user drivers may want to call dev_pm_genpd_has_performance_state() (only
+ * once) before calling this routine (any number of times) to guarantee that all
+ * dependencies are met.
+ *
+ * It is assumed that the user driver guarantees that the genpd wouldn't be
+ * detached while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_update_performance_state(struct device *dev,
+					  unsigned long rate)
+{
+	struct generic_pm_domain *genpd;
+	int ret, state;
+
+	genpd = dev_to_genpd(dev);
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	genpd_lock(genpd);
+
+	if (!genpd_status_on(genpd)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	state = genpd->dev_get_performance_state(dev, rate);
+	if (state < 0) {
+		ret = state;
+		goto unlock;
+	}
+
+	ret = _genpd_reeval_performance_state(genpd, state, 0);
+	if (!ret) {
+		/*
+		 * Since we are passing "state" to
+		 * _genpd_reeval_performance_state() as well, we don't need to
+		 * call __genpd_dev_update_performance_state() before updating
+		 * genpd's state with the above call. Update it only after the
+		 * state of master domain is updated.
+		 */
+		__genpd_dev_update_performance_state(dev, state);
+	}
+
+unlock:
+	genpd_unlock(genpd);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_update_performance_state);
+
+static int _genpd_on_update_performance_state(struct generic_pm_domain *genpd,
+					      int depth)
+{
+	int ret, prev = genpd->prev_performance_state;
+
+	if (likely(!prev))
+		return 0;
+
+	ret = _genpd_set_performance_state(genpd, prev, depth);
+	if (ret) {
+		pr_err("%s: Failed to restore performance state to %d (%d)\n",
+		       genpd->name, prev, ret);
+	} else {
+		genpd->prev_performance_state = 0;
+	}
+
+	return ret;
+}
+
+static void _genpd_off_update_performance_state(struct generic_pm_domain *genpd,
+						int depth)
+{
+	int ret, state = genpd->performance_state;
+
+	if (likely(!state))
+		return;
+
+	ret = _genpd_set_performance_state(genpd, 0, depth);
+	if (ret) {
+		pr_err("%s: Failed to set performance state to 0 (%d)\n",
+		       genpd->name, ret);
+	} else {
+		genpd->prev_performance_state = state;
+	}
+}
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -388,6 +656,8 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			return ret;
 	}
 
+	_genpd_off_update_performance_state(genpd, depth);
+
 	genpd->status = GPD_STATE_POWER_OFF;
 	genpd_update_accounting(genpd);
 
@@ -437,15 +707,21 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 		}
 	}
 
-	ret = _genpd_power_on(genpd, true);
+	ret = _genpd_on_update_performance_state(genpd, depth);
 	if (ret)
 		goto err;
 
+	ret = _genpd_power_on(genpd, true);
+	if (ret)
+		goto err_power_on;
+
 	genpd->status = GPD_STATE_ACTIVE;
 	genpd_update_accounting(genpd);
 
 	return 0;
 
+ err_power_on:
+	_genpd_off_update_performance_state(genpd, depth);
  err:
 	list_for_each_entry_continue_reverse(link,
 					&genpd->slave_links,
@@ -807,6 +1083,8 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 	if (_genpd_power_off(genpd, false))
 		return;
 
+	_genpd_off_update_performance_state(genpd, depth);
+
 	genpd->status = GPD_STATE_POWER_OFF;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
@@ -852,7 +1130,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 			genpd_unlock(link->master);
 	}
 
-	_genpd_power_on(genpd, false);
+	if (!_genpd_on_update_performance_state(genpd, depth))
+		if (_genpd_power_on(genpd, false))
+			_genpd_off_update_performance_state(genpd, depth);
 
 	genpd->status = GPD_STATE_ACTIVE;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 84f423d5633e..715cca7ac399 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -64,8 +64,13 @@ struct generic_pm_domain {
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
+	unsigned int performance_state;	/* Max requested performance state */
+	unsigned int prev_performance_state;	/* Performance state before power off */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	int (*dev_get_performance_state)(struct device *dev, unsigned long rate);
+	int (*genpd_set_performance_state)(struct generic_pm_domain *genpd,
+					   unsigned int state);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
@@ -102,6 +107,9 @@ struct gpd_link {
 	struct list_head master_node;
 	struct generic_pm_domain *slave;
 	struct list_head slave_node;
+
+	/* Sub-domain's per-master domain performance state */
+	unsigned int performance_state;
 };
 
 struct gpd_timing_data {
@@ -121,6 +129,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	unsigned int performance_state;
 	void *data;
 };
 
@@ -148,6 +157,9 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 extern int pm_genpd_init(struct generic_pm_domain *genpd,
 			 struct dev_power_governor *gov, bool is_off);
 extern int pm_genpd_remove(struct generic_pm_domain *genpd);
+extern bool dev_pm_genpd_has_performance_state(struct device *dev);
+extern int dev_pm_genpd_update_performance_state(struct device *dev,
+						 unsigned long rate);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -188,6 +200,17 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -ENOTSUPP;
 }
 
+static inline bool dev_pm_genpd_has_performance_state(struct device *dev)
+{
+	return false;
+}
+
+static inline int dev_pm_genpd_update_performance_state(struct device *dev,
+							unsigned long rate)
+{
+	return -ENOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.13.0.71.gd7076ec9c9cb
