From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/6] PM / domain: Register for PM QOS performance notifier
Date: Thu,  9 Feb 2017 09:11:50 +0530
Message-ID: <a973289cb908a391533a4b940af671beb2e8ace4.1486611268.git.viresh.kumar@linaro.org>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486611268.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1486611268.git.viresh.kumar@linaro.org>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Some platforms have the capability to configure the performance state of
their Power Domains. The performance levels are represented by positive
integer values, a lower value represents lower performance state.

This patch registers the power domain framework for PM QOS performance
notifier in order to manage performance state of power domains.

This also allows the power domain drivers to implement a
->set_performance_state() callback, which will be called by the power
domain core from the notifier routine.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 98 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   |  5 +++
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a73d79670a64..1158a07f92de 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -367,6 +367,88 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static void update_domain_performance_state(struct generic_pm_domain *genpd,
+					    int depth)
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
+	/* Propagate only if this domain has a single parent */
+	if (list_is_singular(&genpd->slave_links)) {
+		/* Performance levels are managed by parent power domain */
+
+		struct generic_pm_domain *master;
+
+		link = list_first_entry(&genpd->slave_links, struct gpd_link, slave_node);
+		master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		update_domain_performance_state(master, depth + 1);
+		genpd_unlock(master);
+	}
+}
+
+static int genpd_dev_pm_qos_perf_notifier(struct notifier_block *nb,
+					  unsigned long val, void *ptr)
+{
+	struct generic_pm_domain_data *gpd_data;
+	struct generic_pm_domain *genpd = ERR_PTR(-ENODATA);
+	struct pm_domain_data *pdd;
+	struct device *dev;
+
+	gpd_data = container_of(nb, struct generic_pm_domain_data, perf_nb);
+	dev = gpd_data->base.dev;
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
+	update_domain_performance_state(genpd, 0);
+	genpd_unlock(genpd);
+
+	return NOTIFY_DONE;
+}
+
 /**
  * genpd_power_off - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
@@ -1137,6 +1219,9 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+	gpd_data->performance_state = 0;
+
+	gpd_data->perf_nb.notifier_call = genpd_dev_pm_qos_perf_notifier;
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -1210,12 +1295,16 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
  out:
 	genpd_unlock(genpd);
 
-	if (ret)
+	if (ret) {
 		genpd_free_dev_data(dev, gpd_data);
-	else
+	} else {
 		dev_pm_qos_add_notifier(dev, &gpd_data->nb,
 					DEV_PM_QOS_RESUME_LATENCY);
 
+		dev_pm_qos_add_notifier(dev, &gpd_data->perf_nb,
+					DEV_PM_QOS_PERFORMANCE);
+	}
+
 	return ret;
 }
 
@@ -1249,6 +1338,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
 	pdd = dev->power.subsys_data->domain_data;
 	gpd_data = to_gpd_data(pdd);
+	dev_pm_qos_remove_notifier(dev, &gpd_data->perf_nb,
+				   DEV_PM_QOS_PERFORMANCE);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb,
 				   DEV_PM_QOS_RESUME_LATENCY);
 
@@ -1277,6 +1368,9 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd_unlock(genpd);
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb, DEV_PM_QOS_RESUME_LATENCY);
 
+	dev_pm_qos_add_notifier(dev, &gpd_data->perf_nb,
+				DEV_PM_QOS_PERFORMANCE);
+
 	return ret;
 }
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 81ece61075df..d994ad5ba1c0 100644
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
@@ -117,6 +120,8 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	struct notifier_block perf_nb;
+	unsigned int performance_state;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
2.7.1.410.g6faf27b
