From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 06/10] PM / Domains: Verify the PM domain is present when adding a provider
Date: Tue, 16 Aug 2016 10:49:32 +0100
Message-ID: <1471340976-5379-7-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471340976-5379-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

When a PM domain provider is added, there is currently no way to tell if
any PM domains associated with the provider are present. Naturally, the
PM domain provider should not be registered if the PM domains have not
been added. Nonetheless, verify that the PM domain(s) associated with a
provider are present when registering the PM domain provider.

This change adds a dependency on the function pm_genpd_present() when
CONFIG_PM_GENERIC_DOMAINS_OF is enabled and so ensure this function is
available when CONFIG_PM_GENERIC_DOMAINS_OF selected.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/base/power/domain.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d09e45145a3d..50223ae0c9a7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -586,7 +586,7 @@ static int __init genpd_poweroff_unused(void)
 }
 late_initcall(genpd_poweroff_unused);
 
-#ifdef CONFIG_PM_SLEEP
+#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_GENERIC_DOMAINS_OF)
 
 /**
  * pm_genpd_present - Check if the given PM domain has been initialized.
@@ -606,6 +606,10 @@ static bool pm_genpd_present(const struct generic_pm_domain *genpd)
 	return false;
 }
 
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+
 static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
 				    struct device *dev)
 {
@@ -1453,7 +1457,23 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 int of_genpd_add_provider_simple(struct device_node *np,
 				 struct generic_pm_domain *genpd)
 {
-	return genpd_add_provider(np, genpd_xlate_simple, genpd);
+	int ret;
+
+	if (!np || !genpd)
+		return -EINVAL;
+
+	mutex_lock(&gpd_list_lock);
+
+	if (!pm_genpd_present(genpd)) {
+		mutex_unlock(&gpd_list_lock);
+		return -EINVAL;
+	}
+
+	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
+
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
 
@@ -1465,7 +1485,26 @@ EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
 int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data)
 {
-	return genpd_add_provider(np, genpd_xlate_onecell, data);
+	unsigned int i;
+	int ret;
+
+	if (!np || !data)
+		return -EINVAL;
+
+	mutex_lock(&gpd_list_lock);
+
+	for (i = 0; i < data->num_domains; i++) {
+		if (!pm_genpd_present(data->domains[i])) {
+			mutex_unlock(&gpd_list_lock);
+			return -EINVAL;
+		}
+	}
+
+	ret = genpd_add_provider(np, genpd_xlate_onecell, data);
+
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
 
-- 
2.1.4
