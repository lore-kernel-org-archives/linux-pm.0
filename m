From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V5 08/14] PM / Domains: Add function to remove a pm-domain
Date: Thu, 28 Jan 2016 16:33:46 +0000
Message-ID: <1453998832-27383-9-git-send-email-jonathanh@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19870 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945947AbcA1Qei (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 11:34:38 -0500
In-Reply-To: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>

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
index 45e3641b427d..b4120121bcac 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1529,6 +1529,32 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
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
index db21d3995f7e..0d661998fa74 100644
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

