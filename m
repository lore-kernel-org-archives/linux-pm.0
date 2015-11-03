From: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFCv2 1/2] power: domain: add pm_genpd_uninit
Date: Tue,  3 Nov 2015 23:45:10 +0100
Message-ID: <1446590711-18928-2-git-send-email-alex.aring@gmail.com>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446590711-18928-1-git-send-email-alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds function pm_genpd_uninit for undo a pm_genpd_init. This
is useful for multiple power domains while probing. If the probing fails
after one pm_genpd_init was called we need to undo all previous
registrations of generic pm domains inside the gpd_list list.

There is a check on IS_ERR_OR_NULL(genpd) which is useful to check again
registered power domains and not registered domains, the driver can use
this mechanism to have an array with registered and non-registered power
domains, where non-registered power domains are NULL.

Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Signed-off-by: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/base/power/domain.c | 15 +++++++++++++++
 include/linux/pm_domain.h   |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 16550c6..65b9d1a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1730,6 +1730,21 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
+/**
+ * pm_genpd_uninit - Uninitialize a generic I/O PM domain object.
+ * @genpd: PM domain object to initialize.
+ */
+void pm_genpd_uninit(struct generic_pm_domain *genpd)
+{
+	if (IS_ERR_OR_NULL(genpd))
+		return;
+
+	mutex_lock(&gpd_list_lock);
+	list_del(&genpd->gpd_list_node);
+	mutex_unlock(&gpd_list_lock);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_uninit);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 /*
  * Device Tree based PM domain providers.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b1cf7e7..45d4f7a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -143,6 +143,7 @@ extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_detach_cpuidle(const char *name);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
+extern void pm_genpd_uninit(struct generic_pm_domain *genpd);
 
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_poweron(const char *domain_name);
@@ -212,6 +213,9 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 				 struct dev_power_governor *gov, bool is_off)
 {
 }
+static inline void pm_genpd_uninit(struct generic_pm_domain *genpd)
+{
+}
 static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
 {
 	return -ENOSYS;
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
