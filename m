From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V4 10/16] PM / Domains: Add function to remove a pm-domain
Date: Fri, 4 Dec 2015 14:57:11 +0000
Message-ID: <1449241037-22193-11-git-send-email-jonathanh@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
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

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 26 ++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e03b1ad25a90..137f29cde8a8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1509,6 +1509,32 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
+/**
+ * pm_genpd_remove - Remove a generic I/O PM domain object.
+ * @genpd: PM domain object to remove.
+ */
+int pm_genpd_remove(struct generic_pm_domain *genpd)
+{
+	if (IS_ERR_OR_NULL(genpd))
+		return -EINVAL;
+
+	mutex_lock(&genpd->lock);
+
+	if (!list_empty(&genpd->master_links)
+	    || !list_empty(&genpd->slave_links) || genpd->device_count) {
+		mutex_unlock(&genpd->lock);
+		return -EBUSY;
+	}
+
+	mutex_lock_nested(&gpd_list_lock, SINGLE_DEPTH_NESTING);
+	list_del(&genpd->gpd_list_node);
+	mutex_unlock(&gpd_list_lock);
+	mutex_unlock(&genpd->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm_genpd_remove);
+
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 /*
  * Device Tree based PM domain providers.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ba4ced38efae..637699ff5a23 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -123,6 +123,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
+extern int pm_genpd_remove(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -161,6 +162,10 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
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
