From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 8/9] PM / Domain: Add struct device to genpd
Date: Wed, 26 Apr 2017 16:27:12 +0530
Message-ID: <695de87a5901febfbd15603fe9de7f32ff513fff.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33561 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2998904AbdDZK5x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 06:57:53 -0400
Received: by mail-pg0-f46.google.com with SMTP id 63so42917319pgh.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2017 03:57:53 -0700 (PDT)
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493203884.git.viresh.kumar@linaro.org>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

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
index 7d35dafe8c97..85365611b258 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1546,6 +1546,10 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 	}
 }
 
+static struct bus_type genpd_bus_type = {
+	.name =		"genpd",
+};
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1602,6 +1606,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
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
@@ -1639,6 +1655,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
+	device_del(&genpd->dev);
 	cancel_work_sync(&genpd->power_off_work);
 	kfree(genpd->free);
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
@@ -1806,6 +1823,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 		if (!ret) {
 			genpd->provider = &np->fwnode;
 			genpd->has_provider = true;
+			genpd->dev.of_node = np;
 		}
 	}
 
@@ -1839,6 +1857,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 		data->domains[i]->provider = &np->fwnode;
 		data->domains[i]->has_provider = true;
+		data->domains[i]->dev.of_node = np;
 	}
 
 	ret = genpd_add_provider(np, genpd_xlate_onecell, data);
@@ -2421,3 +2440,21 @@ static void __exit pm_genpd_debug_exit(void)
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
index 84ee474e66d0..c01f12b370d2 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -48,6 +48,7 @@ struct genpd_power_state {
 struct genpd_lock_ops;
 
 struct generic_pm_domain {
+	struct device dev;
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
 	struct list_head master_links;	/* Links with PM domain as a master */
-- 
2.12.0.432.g71c3a4f4ba37
