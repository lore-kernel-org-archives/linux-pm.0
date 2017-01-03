From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/6] PM / domain: Register for PM QOS performance notifier
Date: Tue,  3 Jan 2017 16:36:10 +0530
Message-ID: <9e3e66a8f7392c7baa57a16325724f4a20584e3e.1483439894.git.viresh.kumar@linaro.org>
References: <cover.1483439894.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32968 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934849AbdACLG4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2017 06:06:56 -0500
Received: by mail-pg0-f48.google.com with SMTP id g1so174778470pgn.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2017 03:06:51 -0800 (PST)
In-Reply-To: <cover.1483439894.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1483439894.git.viresh.kumar@linaro.org>
References: <cover.1483439894.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

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
 drivers/base/power/domain.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   |  5 +++
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 12f16d9b6b55..f460be4ca5f7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -367,6 +367,61 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static void update_domain_performance_state(struct generic_pm_domain *genpd)
+{
+	struct generic_pm_domain_data *pd_data;
+	struct pm_domain_data *pdd;
+	unsigned int state = 0;
+
+	if (!genpd->set_performance_state)
+		return;
+
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		pd_data = to_gpd_data(pdd);
+
+		if (pd_data->performance_state > state)
+			state = pd_data->performance_state;
+	}
+
+	if (genpd->performance_state == state)
+		return;
+
+	genpd->performance_state = state;
+	genpd->set_performance_state(genpd, state);
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
+	update_domain_performance_state(genpd);
+	genpd_unlock(genpd);
+
+	return NOTIFY_DONE;
+}
+
 /**
  * genpd_poweroff - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
@@ -1127,6 +1182,10 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+	gpd_data->performance_state = 0;
+
+	if (genpd->set_performance_state)
+		gpd_data->perf_nb.notifier_call = genpd_dev_pm_qos_perf_notifier;
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -1200,12 +1259,17 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
  out:
 	genpd_unlock(genpd);
 
-	if (ret)
+	if (ret) {
 		genpd_free_dev_data(dev, gpd_data);
-	else
+	} else {
 		dev_pm_qos_add_notifier(dev, &gpd_data->nb,
 					DEV_PM_QOS_RESUME_LATENCY);
 
+		if (genpd->set_performance_state)
+			dev_pm_qos_add_notifier(dev, &gpd_data->perf_nb,
+						DEV_PM_QOS_PERFORMANCE);
+	}
+
 	return ret;
 }
 
@@ -1239,6 +1303,9 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
 	pdd = dev->power.subsys_data->domain_data;
 	gpd_data = to_gpd_data(pdd);
+	if (genpd->set_performance_state)
+		dev_pm_qos_remove_notifier(dev, &gpd_data->perf_nb,
+					   DEV_PM_QOS_PERFORMANCE);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb,
 				   DEV_PM_QOS_RESUME_LATENCY);
 
@@ -1267,6 +1334,10 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd_unlock(genpd);
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb, DEV_PM_QOS_RESUME_LATENCY);
 
+	if (genpd->set_performance_state)
+		dev_pm_qos_add_notifier(dev, &gpd_data->perf_nb,
+					DEV_PM_QOS_PERFORMANCE);
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

