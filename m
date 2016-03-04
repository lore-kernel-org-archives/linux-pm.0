From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 5/8] PM / Domains: Verify the PM domain is present when adding a provider
Date: Fri, 4 Mar 2016 11:23:51 +0000
Message-ID: <1457090634-14785-6-git-send-email-jonathanh@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457090634-14785-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

When a PM domain provider is added, there is currently no way to tell if
the PM domain is actually present in the system. Naturally, the PM domain
provider should not be registered if the PM domain has not been added.
Nonetheless, to verify that the PM domain associated with a provider is
present, store the 'provider_data' in the PM domain structure when adding
the provider and make sure that the PM domain is found the list of PM
domains registered.

The of_genpd_add_provider_simple() and of_genpd_add_provider_onecell()
functions have been updated to store the 'provider_data' by default to
avoid having to modify all the current PM domain provider
implementations.

By doing this, we can also verify that the provider has been removed
from the list of providers before removing a PM domain.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/base/power/domain.c | 74 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   | 13 +++++---
 2 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c2ba1d6dbad3..72055fef6256 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1570,6 +1570,24 @@ static LIST_HEAD(of_genpd_providers);
 static DEFINE_MUTEX(of_genpd_mutex);
 
 /**
+ * pm_genpd_provider_present - Check if the provider's PM domain is present.
+ * @data: Provider data associated with the PM domain.
+ */
+static bool pm_genpd_provider_present(void *data)
+{
+	struct generic_pm_domain *gpd;
+
+	if (!data)
+		return false;
+
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node)
+		if (gpd->provider_data == data)
+			return true;
+
+	return false;
+}
+
+/**
  * __of_genpd_xlate_simple() - Xlate function for direct node-domain mapping
  * @genpdspec: OF phandle args to map into a PM domain
  * @data: xlate function private data - pointer to struct generic_pm_domain
@@ -1625,9 +1643,15 @@ EXPORT_SYMBOL_GPL(__of_genpd_xlate_onecell);
  * @np: Device node pointer associated with the PM domain provider.
  * @xlate: Callback for decoding PM domain from phandle arguments.
  * @data: Context pointer for @xlate callback.
+ *
+ * The PM domain assocaited with the provider must have the
+ * 'provider_data' member of the PM domain structure populated with the
+ * same data pointer passed to this function. This is used to verify
+ * that the PM domain associated with the provider is present in the
+ * list of registered PM domains.
  */
-int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
-			void *data)
+static int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
+				   void *data)
 {
 	struct of_genpd_provider *cp;
 
@@ -1635,6 +1659,13 @@ int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 	if (!cp)
 		return -ENOMEM;
 
+	mutex_lock(&gpd_list_lock);
+
+	if (!pm_genpd_provider_present(data)) {
+		mutex_unlock(&gpd_list_lock);
+		return -EINVAL;
+	}
+
 	cp->node = of_node_get(np);
 	cp->data = data;
 	cp->xlate = xlate;
@@ -1642,11 +1673,48 @@ int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 	mutex_lock(&of_genpd_mutex);
 	list_add(&cp->link, &of_genpd_providers);
 	mutex_unlock(&of_genpd_mutex);
+	mutex_unlock(&gpd_list_lock);
 	pr_debug("Added domain provider from %s\n", np->full_name);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(__of_genpd_add_provider);
+
+/**
+ * of_genpd_add_provider_simple() - Register a simple PM domain provider
+ * @np: Device node pointer associated with the PM domain provider.
+ * @genpd: Pointer to PM domain associated with the PM domain provider.
+ */
+int of_genpd_add_provider_simple(struct device_node *np,
+				 struct generic_pm_domain *genpd)
+{
+	if (!np || !genpd)
+		return -EINVAL;
+
+	genpd->provider_data = genpd;
+
+	return __of_genpd_add_provider(np, __of_genpd_xlate_simple, genpd);
+}
+EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
+
+/**
+ * of_genpd_add_provider_onecell() - Register a onecell PM domain provider
+ * @np: Device node pointer associated with the PM domain provider.
+ * @data: Pointer to the data associated with the PM domain provider.
+ */
+int of_genpd_add_provider_onecell(struct device_node *np,
+				  struct genpd_onecell_data *data)
+{
+	unsigned int i;
+
+	if (!np || !data)
+		return -EINVAL;
+
+	for (i = 0; i < data->num_domains; i++)
+		data->domains[i]->provider_data = data;
+
+	return __of_genpd_add_provider(np, __of_genpd_xlate_onecell, data);
+}
+EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
 
 /**
  * of_genpd_del_provider() - Remove a previously registered PM domain provider
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 510512d5390e..bed84413546f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -53,6 +53,7 @@ struct generic_pm_domain {
 	struct mutex lock;
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
+	void *provider_data;
 	const char *name;
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
@@ -193,8 +194,10 @@ typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
 						void *data);
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
-int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
-			void *data);
+int of_genpd_add_provider_simple(struct device_node *np,
+				 struct generic_pm_domain *genpd);
+int of_genpd_add_provider_onecell(struct device_node *np,
+				  struct genpd_onecell_data *data);
 void of_genpd_del_provider(struct device_node *np);
 struct generic_pm_domain *__of_genpd_xlate_simple(
 					struct of_phandle_args *genpdspec,
@@ -235,18 +238,18 @@ static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return -ENODEV;
 }
-#endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
 {
-	return __of_genpd_add_provider(np, __of_genpd_xlate_simple, genpd);
+	return -ENOTSUPP;
 }
 static inline int of_genpd_add_provider_onecell(struct device_node *np,
 					struct genpd_onecell_data *data)
 {
-	return __of_genpd_add_provider(np, __of_genpd_xlate_onecell, data);
+	return -ENOTSUPP;
 }
+#endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
 extern int dev_pm_domain_attach(struct device *dev, bool power_on);
-- 
2.1.4
