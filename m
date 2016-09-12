From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 10/10] PM / Domains: Add support for removing nested PM domains by provider
Date: Mon, 12 Sep 2016 12:01:14 +0100
Message-ID: <1473678074-15126-11-git-send-email-jonathanh@nvidia.com>
References: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473678074-15126-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

If a device supports PM domains that are subdomains of another PM
domain, then the PM domains should be removed in reverse order to
ensure that the subdomains are removed first. Furthermore, if there is
more than one provider, then there needs to be a way to remove the
domains in reverse order for a specific provider.

Add the function of_genpd_remove_last() to remove the last PM domain
added by a given PM domain provider and return the generic_pm_domain
structure for the PM domain that was removed.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/base/power/domain.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7481e3e316a2..b0cf46dcae73 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1745,6 +1745,41 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
 EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
 
 /**
+ * of_genpd_remove_last - Remove the last PM domain registered for a provider
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
+struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
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
+			ret = genpd_remove(gpd);
+			genpd = ret ? ERR_PTR(ret) : gpd;
+			break;
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	return genpd;
+}
+EXPORT_SYMBOL_GPL(of_genpd_remove_last);
+
+/**
  * genpd_dev_pm_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
  * @power_off: Currently not used
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 85f7d53a9827..a09fe5c009c8 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -204,6 +204,7 @@ extern int of_genpd_add_device(struct of_phandle_args *args,
 			       struct device *dev);
 extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
 				  struct of_phandle_args *new_subdomain);
+extern struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
@@ -237,6 +238,12 @@ static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return -ENODEV;
 }
+
+static inline
+struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
-- 
2.1.4
