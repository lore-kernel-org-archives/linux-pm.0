From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/4] PM / Domains: Allow to attach a CPU via genpd_dev_pm_attach_by_id|name()
Date: Thu, 25 Apr 2019 11:04:13 +0200
Message-ID: <20190425090413.10700-5-ulf.hansson@linaro.org>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425090413.10700-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Attaching a device via genpd_dev_pm_attach_by_id|name() makes genpd to
allocate a virtual device that it attaches instead. This leads to a problem
in case the base device belongs to a CPU. More precisely, it means
genpd_get_cpu() compares against the virtual device, thus it fails to find
a matching CPU device.

Address this limitation, by passing the base device to genpd_get_cpu()
rather than the virtual device. Moreover, to deal with detach correctly
from genpd_remove_device(), let's store the CPU number in the struct
generic_pm_domain_data, as to be able to clear the corresponding bit in the
cpumask for the genpd.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 20 ++++++++++----------
 include/linux/pm_domain.h   |  1 +
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da1c99178943..3d899e8abd58 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1499,10 +1499,11 @@ static int genpd_get_cpu(struct generic_pm_domain *genpd, struct device *dev)
 	return -1;
 }
 
-static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
+static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
+			    struct device *base_dev)
 {
 	struct generic_pm_domain_data *gpd_data;
-	int ret, cpu;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1513,7 +1514,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-	cpu = genpd_get_cpu(genpd, dev);
+	gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
 
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
 	if (ret)
@@ -1521,7 +1522,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 
 	genpd_lock(genpd);
 
-	genpd_set_cpumask(genpd, cpu);
+	genpd_set_cpumask(genpd, gpd_data->cpu);
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
@@ -1549,7 +1550,7 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 	int ret;
 
 	mutex_lock(&gpd_list_lock);
-	ret = genpd_add_device(genpd, dev);
+	ret = genpd_add_device(genpd, dev, dev);
 	mutex_unlock(&gpd_list_lock);
 
 	return ret;
@@ -1561,14 +1562,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 {
 	struct generic_pm_domain_data *gpd_data;
 	struct pm_domain_data *pdd;
-	int cpu, ret = 0;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
 	pdd = dev->power.subsys_data->domain_data;
 	gpd_data = to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
-	cpu = genpd_get_cpu(genpd, dev);
 
 	genpd_lock(genpd);
 
@@ -1580,7 +1580,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd->device_count--;
 	genpd->max_off_time_changed = true;
 
-	genpd_clear_cpumask(genpd, cpu);
+	genpd_clear_cpumask(genpd, gpd_data->cpu);
 	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
@@ -2256,7 +2256,7 @@ int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
 		goto out;
 	}
 
-	ret = genpd_add_device(genpd, dev);
+	ret = genpd_add_device(genpd, dev, dev);
 
 out:
 	mutex_unlock(&gpd_list_lock);
@@ -2426,7 +2426,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
-	ret = genpd_add_device(pd, dev);
+	ret = genpd_add_device(pd, dev, base_dev);
 	mutex_unlock(&gpd_list_lock);
 
 	if (ret < 0) {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index bc82e74560ee..0e8e356bed6a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -175,6 +175,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	int cpu;
 	unsigned int performance_state;
 	void *data;
 };
-- 
2.17.1
