From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V11 1/7] PM / Domains: Add support to select performance-state of domains
Date: Wed, 11 Oct 2017 12:54:13 +0530
Message-ID: <431a7a5803b4a552dfe2a71700e19b904c6d16dc.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:55908 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756679AbdJKHYu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 03:24:50 -0400
Received: by mail-pg0-f46.google.com with SMTP id b11so554382pgn.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2017 00:24:50 -0700 (PDT)
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1507703370.git.viresh.kumar@linaro.org>
References: <cover.1507703370.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

Some platforms have the capability to configure the performance state of
PM domains. This patch enhances the genpd core to support such
platforms.

The performance levels (within the genpd core) are identified by
positive integer values, a lower value represents lower performance
state.

This patch adds a new genpd API, which is called by user drivers (like
OPP framework):

- int dev_pm_genpd_set_performance_state(struct device *dev,
					 unsigned int state);

  This updates the performance state constraint of the device on its PM
  domain. On success, the genpd will have its performance state set to a
  value which is >= "state" passed to this routine. The genpd core calls
  the genpd->genpd_set_performance_state() callback, if implemented,
  else -ENODEV is returned to the caller.

The PM domain drivers need to implement the following callback if they
want to support performance states.

- int (*genpd_set_performance_state)(struct generic_pm_domain *genpd,
				     unsigned int state);

  This is called internally by the genpd core on several occasions. The
  genpd core passes the genpd pointer and the aggregate of the
  performance states of the devices supported by that genpd to this
  callback. This callback must update the performance state of the genpd
  in a platform dependent way.

The power domains can avoid supplying above callback, if they don't
support setting performance-states.

A TODO comment is also added to _genpd_reeval_performance_state(). This
feature will be required once we have hardware that needs to propagate
the performance state changes to master domains.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 179 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   |  13 ++++
 2 files changed, 190 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a6e4c8d7d837..b8360bc6a8eb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -237,6 +237,169 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 #endif
 
+/* Returns negative errors or 0 on success */
+static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
+					int state)
+{
+	int ret;
+
+	ret = genpd->genpd_set_performance_state(genpd, state);
+	if (!ret)
+		genpd->performance_state = state;
+
+	return ret;
+}
+
+/*
+ * Re-evaluate performance state of a genpd. Finds the highest requested
+ * performance state by the devices within the genpd and then change genpd's
+ * performance state (if required).
+ *
+ * @genpd: PM domain whose state needs to be reevaluated.
+ * @state: Newly requested performance state of the device for which this
+ *	   routine is called.
+ *
+ * Returns negative errors or 0 on success.
+ */
+static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
+					   int state)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct pm_domain_data *pdd;
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
+	 * TODO: Traverse all subdomains of the genpd. This will be
+	 * required once we have hardware that needs to propagate the
+	 * performance state changes.
+	 */
+
+update_state:
+	return _genpd_set_performance_state(genpd, state);
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
+ * dev_pm_genpd_set_performance_state- Set performance state of device's power
+ * domain.
+ *
+ * @dev: Device for which the performance-state needs to be adjusted.
+ * @state: Target performance state of the device. This can be set as 0 when the
+ *	   device doesn't have any performance state constraints left (And so
+ *	   the device wouldn't participate anymore to find the target
+ *	   performance state of the genpd).
+ *
+ * It is assumed that the user driver guarantees that the genpd wouldn't be
+ * detached while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
+{
+	struct generic_pm_domain *genpd;
+	int ret;
+
+	genpd = dev_to_genpd(dev);
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	genpd_lock(genpd);
+
+	if (!genpd->genpd_set_performance_state) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	if (!genpd_status_on(genpd)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = _genpd_reeval_performance_state(genpd, state);
+	if (!ret) {
+		/*
+		 * Since we are passing "state" as well to
+		 * _genpd_reeval_performance_state(), we don't need to call
+		 * __genpd_dev_update_performance_state() before updating
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
+EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
+
+static int _genpd_on_update_performance_state(struct generic_pm_domain *genpd)
+{
+	int ret, prev = genpd->prev_performance_state;
+
+	if (likely(!prev))
+		return 0;
+
+	ret = _genpd_set_performance_state(genpd, prev);
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
+static void _genpd_off_update_performance_state(struct generic_pm_domain *genpd)
+{
+	int ret, state = genpd->performance_state;
+
+	if (likely(!state))
+		return;
+
+	ret = _genpd_set_performance_state(genpd, 0);
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
@@ -388,6 +551,8 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			return ret;
 	}
 
+	_genpd_off_update_performance_state(genpd);
+
 	genpd->status = GPD_STATE_POWER_OFF;
 	genpd_update_accounting(genpd);
 
@@ -437,15 +602,21 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 		}
 	}
 
-	ret = _genpd_power_on(genpd, true);
+	ret = _genpd_on_update_performance_state(genpd);
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
+	_genpd_off_update_performance_state(genpd);
  err:
 	list_for_each_entry_continue_reverse(link,
 					&genpd->slave_links,
@@ -803,6 +974,8 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 	if (_genpd_power_off(genpd, false))
 		return;
 
+	_genpd_off_update_performance_state(genpd);
+
 	genpd->status = GPD_STATE_POWER_OFF;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
@@ -848,7 +1021,9 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 			genpd_unlock(link->master);
 	}
 
-	_genpd_power_on(genpd, false);
+	if (!_genpd_on_update_performance_state(genpd))
+		if (_genpd_power_on(genpd, false))
+			_genpd_off_update_performance_state(genpd);
 
 	genpd->status = GPD_STATE_ACTIVE;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 84f423d5633e..81d923f058fd 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -64,8 +64,12 @@ struct generic_pm_domain {
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
+	unsigned int performance_state;	/* Max requested performance state */
+	unsigned int prev_performance_state;	/* Performance state before power off */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	int (*genpd_set_performance_state)(struct generic_pm_domain *genpd,
+					   unsigned int state);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
@@ -121,6 +125,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	unsigned int performance_state;
 	void *data;
 };
 
@@ -148,6 +153,8 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 extern int pm_genpd_init(struct generic_pm_domain *genpd,
 			 struct dev_power_governor *gov, bool is_off);
 extern int pm_genpd_remove(struct generic_pm_domain *genpd);
+extern int dev_pm_genpd_set_performance_state(struct device *dev,
+					      unsigned int state);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -188,6 +195,12 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_genpd_set_performance_state(struct device *dev,
+						     unsigned int state)
+{
+	return -ENOTSUPP;
+}
+
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.7.4
