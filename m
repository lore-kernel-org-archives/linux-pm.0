From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/7] PM / Domain: Add struct device to genpd
Date: Fri, 22 Dec 2017 12:56:27 +0530
Message-ID: <a7867661e9bc6f5b1571f60398266ef678ccc1c0.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513926033.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The power-domain core would be using the OPP core going forward and the
OPP core has the basic requirement of a device structure for its working.

Add a struct device to the genpd structure and also add a genpd bus type
for the devices.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0c80bea05bcb..013c1e206167 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1630,6 +1630,10 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 	}
 }
 
+static struct bus_type genpd_bus_type = {
+	.name =		"genpd",
+};
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1687,6 +1691,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 			return ret;
 	}
 
+	genpd->dev.bus = &genpd_bus_type;
+	device_initialize(&genpd->dev);
+	dev_set_name(&genpd->dev, "%s", genpd->name);
+
+	ret = device_add(&genpd->dev);
+	if (ret) {
+		dev_err(&genpd->dev, "failed to add device: %d\n", ret);
+		put_device(&genpd->dev);
+		kfree(genpd->free);
+		return ret;
+	}
+
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
@@ -1724,6 +1740,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
+	device_del(&genpd->dev);
 	cancel_work_sync(&genpd->power_off_work);
 	kfree(genpd->free);
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
@@ -1888,6 +1905,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 		if (!ret) {
 			genpd->provider = &np->fwnode;
 			genpd->has_provider = true;
+			genpd->dev.of_node = np;
 		}
 	}
 
@@ -1924,6 +1942,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 		data->domains[i]->provider = &np->fwnode;
 		data->domains[i]->has_provider = true;
+		data->domains[i]->dev.of_node = np;
 	}
 
 	ret = genpd_add_provider(np, data->xlate, data);
@@ -2691,3 +2710,21 @@ static void __exit genpd_debug_exit(void)
 }
 __exitcall(genpd_debug_exit);
 #endif /* CONFIG_DEBUG_FS */
+
+static int __init pm_genpd_core_init(void)
+{
+	int ret;
+
+	ret = bus_register(&genpd_bus_type);
+	if (ret)
+		pr_err("bus_register failed (%d)\n", ret);
+
+	return ret;
+}
+pure_initcall(pm_genpd_core_init);
+
+static void __exit pm_genpd_core_exit(void)
+{
+	bus_unregister(&genpd_bus_type);
+}
+__exitcall(pm_genpd_core_exit);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 04dbef9847d3..aaacaa35005d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -49,6 +49,7 @@ struct genpd_power_state {
 struct genpd_lock_ops;
 
 struct generic_pm_domain {
+	struct device dev;
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
 	struct list_head master_links;	/* Links with PM domain as a master */
-- 
2.15.0.194.g9af6a3dea062
