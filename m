From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 7/9] PM / domain: Register for PM QOS performance notifier
Date: Mon, 20 Mar 2017 15:02:19 +0530
Message-ID: <ffb55b31f92c7840dbb1a86288477ebf95a2ccbd.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Some platforms have the capability to configure the performance state of
their Power Domains. The performance levels are identified by positive
integer values, a lower value represents lower performance state. The
power domain driver should be able to retrieve all information required
to configure the performance state of the power domain, with the help of
the performance constraint's target value.

This patch implements performance state management in PM domain core.
The performance QOS uses the common QOS notifier list and we call
__performance_notifier() if the notifier is issued for performance
constraint.

This also allows the power domain drivers to implement a
->set_performance_state() callback, which will be called by the power
domain core from within the notifier routine. If a domain doesn't
implement ->set_performance_state() callback, then it is assumed that
its parents are responsible for performance state configuration. Both
devices and sub-domains are accounted for while finding the highest
performance state requested.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  4 +++
 2 files changed, 81 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6e4e22aa14a2..03dd7a61f08a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -452,6 +452,79 @@ static int __resume_latency_notifier(struct generic_pm_domain_data *gpd_data,
 	return NOTIFY_DONE;
 }
 
+static void __update_domain_performance_state(struct generic_pm_domain *genpd,
+					      int depth)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct generic_pm_domain *subdomain;
+	struct pm_domain_data *pdd;
+	unsigned int state = 0;
+	struct gpd_link *link;
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
+		return;
+
+	genpd->performance_state = state;
+
+	if (genpd->set_performance_state) {
+		genpd->set_performance_state(genpd, state);
+		return;
+	}
+
+	/* Propagate to parent power domains */
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		struct generic_pm_domain *master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		__update_domain_performance_state(master, depth + 1);
+		genpd_unlock(master);
+	}
+}
+
+static int __performance_notifier(struct generic_pm_domain_data *gpd_data,
+				  unsigned long val)
+{
+	struct generic_pm_domain *genpd = ERR_PTR(-ENODATA);
+	struct device *dev = gpd_data->base.dev;
+	struct pm_domain_data *pdd;
+
+	spin_lock_irq(&dev->power.lock);
+
+	pdd = dev->power.subsys_data ?
+		dev->power.subsys_data->domain_data : NULL;
+
+	if (pdd && pdd->dev)
+		genpd = dev_to_genpd(dev);
+
+	spin_unlock_irq(&dev->power.lock);
+
+	if (IS_ERR(genpd))
+		return NOTIFY_DONE;
+
+	genpd_lock(genpd);
+	gpd_data->performance_state = val;
+	__update_domain_performance_state(genpd, 0);
+	genpd_unlock(genpd);
+
+	return NOTIFY_DONE;
+}
+
 static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 				     unsigned long val, void *ptr)
 {
@@ -464,6 +537,9 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	if (dev_pm_qos_notifier_is_resume_latency(dev, ptr))
 		return __resume_latency_notifier(gpd_data, val);
 
+	if (dev_pm_qos_notifier_is_performance(dev, ptr))
+		return __performance_notifier(gpd_data, val);
+
 	dev_err(dev, "%s: Unexpected notifier call\n", __func__);
 	return NOTIFY_BAD;
 }
@@ -1157,6 +1233,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+	gpd_data->performance_state = 0;
 
 	spin_lock_irq(&dev->power.lock);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5339ed5bd6f9..83795935709e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -62,8 +62,11 @@ struct generic_pm_domain {
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
+	unsigned int performance_state;	/* Max requested performance state */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	int (*set_performance_state)(struct generic_pm_domain *domain,
+				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
@@ -117,6 +120,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	unsigned int performance_state;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
2.12.0.432.g71c3a4f4ba37
