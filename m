From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 1/2] PM / Domains: Add support to select
 performance-state of domains
Date: Thu, 8 Jun 2017 15:12:51 +0530
Message-ID: <20170608094251.GC4634@vireshk-i7>
References: <cover.1495003720.git.viresh.kumar@linaro.org>
 <4cc55fce0fd4199941f1d7b785e677255ff792d5.1495003720.git.viresh.kumar@linaro.org>
 <CAPDyKFoWXPJx9pahzv6CkXosncODHSThYA9MoMVdruRtzHRyZg@mail.gmail.com>
 <20170608070505.GB4634@vireshk-i7>
 <CAPDyKFo1-BN2PqXZgKUCGee_QH1zevXFLFSO2+TaCpkWxd5r-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34903 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbdFHJmz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 05:42:55 -0400
Received: by mail-pf0-f177.google.com with SMTP id l89so15392506pfi.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2017 02:42:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFo1-BN2PqXZgKUCGee_QH1zevXFLFSO2+TaCpkWxd5r-g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>

On 08-06-17, 09:48, Ulf Hansson wrote:
> It's not a nightmare, just a tricky thing to solve. :-)

I may have just solved it actually :)

So the real locking problem was the case where a subdomain have multiple parent
domains and how do we access its performance_state field from all the paths that
originate from the parent's update and from the subdomains own path. And a
single performance_state field isn't going to help in that as multiple locks are
involved here. I have added another per parent-domain field and that will help
get the locking quite simple. Here is the new patch (compile tested):

---
 drivers/base/power/domain.c | 193 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  22 +++++
 2 files changed, 215 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 71c95ad808d5..40815974287f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -466,6 +466,187 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
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
+	 * All the parent domains are updated now, lets get genpd
+	 * performance_state in sync with those.
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
+
+	if (IS_ERR(genpd)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	if (!genpd->get_performance_state) {
+		dev_err(dev, "Performance states aren't supported by power domain\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	genpd_lock(genpd);
+	ret = genpd->get_performance_state(dev, rate);
+	if (ret < 0)
+		goto unlock_genpd;
+
+	prev = gpd_data->performance_state;
+	gpd_data->performance_state = ret;
+	ret = genpd_update_performance_state(genpd, 0);
+	if (ret)
+		gpd_data->performance_state = prev;
+
+unlock_genpd:
+	genpd_unlock(genpd);
+unlock:
+	spin_unlock_irq(&dev->power.lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_update_performance_state);
+
 /**
  * genpd_power_off_work_fn - Power off PM domain whose subdomain count is 0.
  * @work: Work structure used for scheduling the execution of this function.
@@ -1156,6 +1337,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+	gpd_data->performance_state = 0;
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -1502,6 +1684,17 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
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
