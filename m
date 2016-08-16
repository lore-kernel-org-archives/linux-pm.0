From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 10/10] PM / Domains: Add support for removing nested PM domains by provider
Date: Tue, 16 Aug 2016 10:49:36 +0100
Message-ID: <1471340976-5379-11-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11984 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbcHPJug (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 05:50:36 -0400
In-Reply-To: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

If a device supports PM domains that are subdomains of another PM
domain, then the PM domains should be removed in reverse order to
ensure that the subdomains are removed first. Furthermore, if there is
more than one provider, then there needs to be a way to remove the
domains in reverse order for a specific provider.

Add the function of_genpd_remove_tail() to remove the last PM domain
added by a given PM domain provider and return the generic_pm_domain
structure for the PM domain that was removed.

A PM domain should only be removed once the associated PM domain
provider has been removed from the list of providers. Otherwise, it
could be possible for a client to be associated with a PM domain that
could have been removed. Add a helper function to verify if the PM
domain provider is present and only allow a PM domain to be removed if
the provider has been removed.

The function of_genpd_remove_tail() must hold the gpd_list_lock while
finding and removing a PM domain. It is natural for
of_genpd_remove_tail() to call pm_genpd_remove() once the appropriate
PM domain is found to remove it. However, pm_genpd_remove(), also
acquires the gpd_list_lock. Therefore, move the core of the function
pm_genpd_remove() to a new function genpd_remove() which does not
acquire the gpd_list_lock so this can be used by both pm_genpd_remove()
and of_genpd_remove_tail().

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 87 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/pm_domain.h   |  7 ++++
 2 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0bc145e8e902..b6d1d0441a2d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1357,7 +1357,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
 /**
- * pm_genpd_remove - Remove a generic I/O PM domain
+ * genpd_remove - Remove a generic I/O PM domain
  * @genpd: Pointer to PM domain that is to be removed.
  *
  * To remove the PM domain, this function:
@@ -1366,9 +1366,10 @@ EXPORT_SYMBOL_GPL(pm_genpd_init);
  *  - Removes the PM domain from the list of registered PM domains.
  *
  * The PM domain will only be removed, if it is not a parent to any
- * other PM domain and has no devices associated with it.
+ * other PM domain and has no devices associated with it. Must be called
+ * with the gpd_list_lock held.
  */
-int pm_genpd_remove(struct generic_pm_domain *genpd)
+static int genpd_remove(struct generic_pm_domain *genpd)
 {
 	struct gpd_link *l, *link;
 	int ret = 0;
@@ -1376,12 +1377,10 @@ int pm_genpd_remove(struct generic_pm_domain *genpd)
 	if (IS_ERR_OR_NULL(genpd))
 		return -EINVAL;
 
-	mutex_lock(&gpd_list_lock);
 	mutex_lock(&genpd->lock);
 
 	if (!list_empty(&genpd->master_links) || genpd->device_count) {
 		mutex_unlock(&genpd->lock);
-		mutex_unlock(&gpd_list_lock);
 		pr_err("%s: unable to remove %s\n", __func__, genpd->name);
 		return -EBUSY;
 	}
@@ -1395,11 +1394,25 @@ int pm_genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	mutex_unlock(&genpd->lock);
 	cancel_work_sync(&genpd->power_off_work);
-	mutex_unlock(&gpd_list_lock);
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
 
 	return ret;
 }
+
+/**
+ * pm_genpd_remove - Remove a generic I/O PM domain
+ * @genpd: Pointer to PM domain that is to be removed.
+ */
+int pm_genpd_remove(struct generic_pm_domain *genpd)
+{
+	int ret;
+
+	mutex_lock(&gpd_list_lock);
+	ret = genpd_remove(genpd);
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(pm_genpd_remove);
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
@@ -1610,6 +1623,26 @@ void of_genpd_del_provider(struct device_node *np)
 EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 
 /**
+ * genpd_provider_present() - Verify if a PM domain provider is present
+ * @np: Device node pointer associated with the PM domain provider
+ */
+static bool genpd_provider_present(struct device_node *np)
+{
+	struct of_genpd_provider *cp;
+
+	mutex_lock(&of_genpd_mutex);
+	list_for_each_entry(cp, &of_genpd_providers, link) {
+		if (cp->node == np) {
+			mutex_unlock(&of_genpd_mutex);
+			return true;
+		}
+	}
+	mutex_unlock(&of_genpd_mutex);
+
+	return false;
+}
+
+/**
  * genpd_get_from_provider() - Look-up PM domain
  * @genpdspec: OF phandle args to use for look-up
  *
@@ -1713,6 +1746,48 @@ out:
 EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
 
 /**
+ * of_genpd_remove_tail - Remove the last PM domain registered for a provider
+ * @provider: Pointer to device structure associated with provider
+ *
+ * Find the last PM domain that was added by a particular provider and
+ * remove this PM domain from the list of PM domains. The provider is
+ * identified by the 'provider' device structure that is passed. The PM
+ * domain will only be removed, if the provider associated with domain
+ * has been removed.
+ *
+ * Returns a valid pointer to struct generic_pm_domain on success or
+ * ERR_PTR() on failure.
+ */
+struct generic_pm_domain *of_genpd_remove_tail(struct device_node *np)
+{
+	struct generic_pm_domain *gpd, *genpd = ERR_PTR(-ENOENT);
+	int ret;
+
+	if (IS_ERR_OR_NULL(np))
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+		if (gpd->provider == &np->fwnode) {
+			if (!genpd_provider_present(np)) {
+				ret = genpd_remove(gpd);
+				genpd = ret ? ERR_PTR(ret) : gpd;
+				break;
+			}
+
+			pr_warn("Provider maybe present, unable to remove %s\n",
+				genpd->name);
+			genpd = ERR_PTR(-EBUSY);
+			break;
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	return genpd;
+}
+EXPORT_SYMBOL_GPL(of_genpd_remove_tail);
+
+/**
  * genpd_dev_pm_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
  * @power_off: Currently not used
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 4aa285e44eb0..253f348b0ee9 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -203,6 +203,7 @@ extern int of_genpd_add_device(struct of_phandle_args *args,
 			       struct device *dev);
 extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
 				  struct of_phandle_args *new_subdomain);
+extern struct generic_pm_domain *of_genpd_remove_tail(struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
@@ -236,6 +237,12 @@ static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return -ENODEV;
 }
+
+static inline
+struct generic_pm_domain *of_genpd_remove_tail(struct device_node *np)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
-- 
2.1.4

