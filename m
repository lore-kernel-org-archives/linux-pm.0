From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/6] PM / domain: Register for PM QOS performance notifier
Date: Thu, 19 Jan 2017 10:06:16 +0530
Message-ID: <20170119043616.GG11478@vireshk-i7>
References: <cover.1483439894.git.viresh.kumar@linaro.org>
 <9e3e66a8f7392c7baa57a16325724f4a20584e3e.1483439894.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e3e66a8f7392c7baa57a16325724f4a20584e3e.1483439894.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, lina.iyer@linaro.org, rnayak@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 03-01-17, 16:36, Viresh Kumar wrote:
> Some platforms have the capability to configure the performance state of
> their Power Domains. The performance levels are represented by positive
> integer values, a lower value represents lower performance state.
> 
> This patch registers the power domain framework for PM QOS performance
> notifier in order to manage performance state of power domains.
> 
> This also allows the power domain drivers to implement a
> ->set_performance_state() callback, which will be called by the power
> domain core from the notifier routine.

Rajendra helped me testing this stuff on his Qualcomm board and this patch has
received some updates to support the hierarchy of power domains, i.e. subdomains
withing power domains. Below is the new patch which worked for him.

-- 
viresh

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 23 Nov 2016 11:00:41 +0530
Subject: [PATCH] PM / domain: Register for PM QOS performance notifier

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
 drivers/base/power/domain.c | 99 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   |  5 +++
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 12f16d9b6b55..12ec1f8c42ed 100644
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
  * genpd_poweroff - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
@@ -578,6 +660,7 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
+
 	genpd_poweroff(genpd, false);
 	genpd_unlock(genpd);
 
@@ -1127,6 +1210,9 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+	gpd_data->performance_state = 0;
+
+	gpd_data->perf_nb.notifier_call = genpd_dev_pm_qos_perf_notifier;
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -1200,12 +1286,16 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
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
 
@@ -1239,6 +1329,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
 	pdd = dev->power.subsys_data->domain_data;
 	gpd_data = to_gpd_data(pdd);
+	dev_pm_qos_remove_notifier(dev, &gpd_data->perf_nb,
+				   DEV_PM_QOS_PERFORMANCE);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb,
 				   DEV_PM_QOS_RESUME_LATENCY);
 
@@ -1267,6 +1359,9 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
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
