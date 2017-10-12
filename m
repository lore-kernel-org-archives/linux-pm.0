From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V12 1/7] PM / Domains: Add support to select performance-state of domains
Date: Thu, 12 Oct 2017 12:39:59 +0530
Message-ID: <0ffec4c9d7679be049cab74eebacb5ca248e903e.1507786342.git.viresh.kumar@linaro.org>
References: <431a7a5803b4a552dfe2a71700e19b904c6d16dc.1507703370.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <431a7a5803b4a552dfe2a71700e19b904c6d16dc.1507703370.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
  the genpd->set_performance_state() callback, if implemented,
  else -ENODEV is returned to the caller.

The PM domain drivers need to implement the following callback if they
want to support performance states.

- int (*set_performance_state)(struct generic_pm_domain *genpd,
			       unsigned int state);

  This is called internally by the genpd core on several occasions. The
  genpd core passes the genpd pointer and the aggregate of the
  performance states of the devices supported by that genpd to this
  callback. This callback must update the performance state of the genpd
  (in a platform dependent way).

The power domains can avoid supplying above callback, if they don't
support setting performance-states.

Currently we aren't propagating performance state changes of a subdomain
to its masters as we don't have hardware that needs it right now. Over
that, the performance states of subdomain and its masters may not have
one-to-one mapping and would require additional information. We can get
back to this once we have hardware that needs it.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Only the first patch has got updates (out of the first 3 patches, which
are going to get applied for now) and so I am resending only the first
one here.

V12:
- Always allow setting performance state, even if genpd is off. Don't
  call the callback in that case.
- Set performance state only when powering ON the genpd and not during
  power OFF. The driver can take care of it.
- Merge several routines and remove unnecessary locking.
- Update comments and log a bit.

 drivers/base/power/domain.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 12 ++++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a6e4c8d7d837..735850893882 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -237,6 +237,86 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 #endif
 
+/**
+ * dev_pm_genpd_set_performance_state- Set performance state of device's power
+ * domain.
+ *
+ * @dev: Device for which the performance-state needs to be set.
+ * @state: Target performance state of the device. This can be set as 0 when the
+ *	   device doesn't have any performance state constraints left (And so
+ *	   the device wouldn't participate anymore to find the target
+ *	   performance state of the genpd).
+ *
+ * It is assumed that the users guarantee that the genpd wouldn't be detached
+ * while this routine is getting called.
+ *
+ * Returns 0 on success and negative error values on failures.
+ */
+int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
+{
+	struct generic_pm_domain *genpd;
+	struct generic_pm_domain_data *pd_data;
+	struct pm_domain_data *pdd;
+	int ret = 0;
+
+	genpd = dev_to_genpd(dev);
+	if (IS_ERR(genpd))
+		return -ENODEV;
+
+	if (!genpd->set_performance_state)
+		return -EINVAL;
+
+	if (!dev->power.subsys_data || !dev->power.subsys_data->domain_data) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	genpd_lock(genpd);
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
+	 * We aren't propagating performance state changes of a subdomain to its
+	 * masters as we don't have hardware that needs it. Over that, the
+	 * performance states of subdomain and its masters may not have
+	 * one-to-one mapping and would require additional information. We can
+	 * get back to this once we have hardware that needs it. For that
+	 * reason, we don't have to consider performance state of the subdomains
+	 * of genpd here.
+	 */
+
+update_state:
+	if (genpd_status_on(genpd)) {
+		ret = genpd->set_performance_state(genpd, state);
+		if (ret)
+			goto unlock;
+	}
+
+	genpd->performance_state = state;
+	pd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+	pd_data->performance_state = state;
+
+unlock:
+	genpd_unlock(genpd);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -256,6 +336,15 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
+
+	if (unlikely(genpd->performance_state)) {
+		ret = genpd->set_performance_state(genpd, genpd->performance_state);
+		if (ret) {
+			pr_warn("%s: Failed to set performance state %d (%d)\n",
+				genpd->name, genpd->performance_state, ret);
+		}
+	}
+
 	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
 		return ret;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 84f423d5633e..3f8de25418a8 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -64,8 +64,11 @@ struct generic_pm_domain {
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
+	unsigned int performance_state;	/* Max requested performance state */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	int (*set_performance_state)(struct generic_pm_domain *genpd,
+				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
@@ -121,6 +124,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	unsigned int performance_state;
 	void *data;
 };
 
@@ -148,6 +152,8 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 extern int pm_genpd_init(struct generic_pm_domain *genpd,
 			 struct dev_power_governor *gov, bool is_off);
 extern int pm_genpd_remove(struct generic_pm_domain *genpd);
+extern int dev_pm_genpd_set_performance_state(struct device *dev,
+					      unsigned int state);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -188,6 +194,12 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
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
2.15.0.rc1.236.g92ea95045093
