From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 01/13] PM / Domains: Add genpd attach/detach callbacks
Date: Thu, 25 Sep 2014 18:28:28 +0200
Message-ID: <1411662520-22795-2-git-send-email-geert+renesas@glider.be>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411662520-22795-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

While a PM domain can enable PM runtime management of its devices' module
clocks by setting

	genpd->dev_ops.stop = pm_clk_suspend;
	genpd->dev_ops.start = pm_clk_resume;

this also requires registering the clocks with the pm_clk subsystem.
In the legacy case, this is handled by the platform code, after
attaching the device to its PM domain.

When the devices are instantiated from DT, devices are attached to their
PM domains by generic code, leaving no method for the platform-specific
PM domain code to register their clocks.

Add two callbacks, allowing a PM domain to perform platform-specific
tasks when a device is attached to or detached from a PM domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
v3:
  - Add Reviewed-by (Ulf: are you still OK with the changes in v3?)
  - Move calling of the callbacks to a point where dev->pm_domain is
    valid, so the domain parameter is no longer needed,
  - Make callbacks return void.
v2:
  - New

 drivers/base/power/domain.c | 6 ++++++
 include/linux/pm_domain.h   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cd400575ee0ee89c..6e36bb09e7d9c144 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1436,6 +1436,9 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	spin_unlock_irq(&dev->power.lock);
 
+	if (genpd->attach_dev)
+		genpd->attach_dev(dev);
+
 	mutex_lock(&gpd_data->lock);
 	gpd_data->base.dev = dev;
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
@@ -1528,6 +1531,9 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd->device_count--;
 	genpd->max_off_time_changed = true;
 
+	if (genpd->detach_dev)
+		genpd->detach_dev(dev);
+
 	spin_lock_irq(&dev->power.lock);
 
 	dev->pm_domain = NULL;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 292079d8da6b8a78..9a93e622bdea3f79 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -73,6 +73,8 @@ struct generic_pm_domain {
 	bool cached_power_down_ok;
 	struct device_node *of_node; /* Node in device tree */
 	struct gpd_cpu_data *cpu_data;
+	void (*attach_dev)(struct device *dev);
+	void (*detach_dev)(struct device *dev);
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
