From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 8/9] PM / Domain: Add struct device to genpd
Date: Mon, 20 Mar 2017 15:02:20 +0530
Message-ID: <d5a9bf0beebda881d04ee7ffc2b9d94887db65dd.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1490001099.git.viresh.kumar@linaro.org>
References: <cover.1490001099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The power-domain core would be using the OPP core going forward and the
OPP core has a basic requirement of a device structure for its working.

Add a struct device to the genpd structure and also add a genpd bus type
for the devices.

Note that the of_node field of the device is only set when separate DT
node is present for the power-domain, otherwise the of node is common
across multiple genpd devices and filling the of_node field with it
doesn't sound right.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 03dd7a61f08a..51d3afc0476d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1536,6 +1536,10 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 	}
 }
 
+static struct bus_type genpd_bus_type = {
+	.name =		"genpd",
+};
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1588,6 +1592,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
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
@@ -1625,6 +1641,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
+	device_del(&genpd->dev);
 	cancel_work_sync(&genpd->power_off_work);
 	kfree(genpd->free);
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
@@ -1794,6 +1811,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 		if (!ret) {
 			genpd->provider = &np->fwnode;
 			genpd->has_provider = true;
+			genpd->dev->of_node = np;
 		}
 	}
 
@@ -2407,3 +2425,21 @@ static void __exit pm_genpd_debug_exit(void)
 }
 __exitcall(pm_genpd_debug_exit);
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
index 83795935709e..d55c0112dcde 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -47,6 +47,7 @@ struct genpd_power_state {
 struct genpd_lock_ops;
 
 struct generic_pm_domain {
+	struct device dev;
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
 	struct list_head master_links;	/* Links with PM domain as a master */
-- 
2.12.0.432.g71c3a4f4ba37
