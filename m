From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V6 03/10] PM / Domains: Add function to remove a pm-domain
Date: Fri, 26 Feb 2016 15:48:37 +0000
Message-ID: <1456501724-28477-4-git-send-email-jonathanh@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456501724-28477-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The genpd framework allows users to add power-domains via the
pm_genpd_init() function, however, there is no corresponding function
to remove a power-domain. For most devices this may be fine as the power
domains are never removed, however, for devices that wish to populate
the power-domains from within a driver, having the ability to remove a
power domain if the probing of the device fails or the driver is unloaded
is necessary. Therefore, add a function to remove a power-domain. Please
note that the power domain can only be removed if there are no devices
using the power-domain and it is not linked to another domain.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/base/power/domain.c | 31 +++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  5 +++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 608bc00655ee..22f6e9d738bf 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1557,6 +1557,37 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
+/**
+ * pm_genpd_remove - Remove a generic I/O PM domain object.
+ * @genpd: PM domain object to remove.
+ */
+int pm_genpd_remove(struct generic_pm_domain *genpd)
+{
+	int ret = 0;
+
+	if (IS_ERR_OR_NULL(genpd))
+		return -EINVAL;
+
+	mutex_lock(&gpd_list_lock);
+	mutex_lock(&genpd->lock);
+
+	if (!list_empty(&genpd->master_links)
+	    || !list_empty(&genpd->slave_links) || genpd->device_count) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	cancel_work_sync(&genpd->power_off_work);
+	list_del(&genpd->gpd_list_node);
+
+out:
+	mutex_unlock(&genpd->lock);
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_remove);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 /*
  * Device Tree based PM domain providers.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b38dd74dea9b..9ae9c42f807f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -134,6 +134,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
+extern int pm_genpd_remove(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -177,6 +178,10 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 				 struct dev_power_governor *gov, bool is_off)
 {
 }
+static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-- 
2.1.4
