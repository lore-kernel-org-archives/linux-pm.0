From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 01/10] PM / Domains: Add new helper functions for device-tree
Date: Mon, 12 Sep 2016 12:01:05 +0100
Message-ID: <1473678074-15126-2-git-send-email-jonathanh@nvidia.com>
References: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473678074-15126-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Ideally, if we are returning a reference to a PM domain via a call to
of_genpd_get_from_provider(), then we should keep track of such
references via a reference count. The reference count could then be used
to determine if a PM domain can be safely removed. Alternatively, it is
possible to avoid such external references by providing APIs to access
the PM domain and hence, eliminate any calls to
of_genpd_get_from_provider().

Add new helper functions for adding a device and a subdomain to a PM
domain when using device-tree, so that external calls to
of_genpd_get_from_provider() can be removed.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/base/power/domain.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 16 ++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 058c8b6d2871..e12d3a8a29a9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1502,6 +1502,52 @@ struct generic_pm_domain *of_genpd_get_from_provider(
 EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 
 /**
+ * of_genpd_add_device() - Add a device to an I/O PM domain
+ * @genpdspec: OF phandle args to use for look-up PM domain
+ * @dev: Device to be added.
+ *
+ * Looks-up an I/O PM domain based upon phandle args provided and adds
+ * the device to the PM domain. Returns a negative error code on failure.
+ */
+int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = of_genpd_get_from_provider(genpdspec);
+	if (IS_ERR(genpd))
+		return PTR_ERR(genpd);
+
+	return pm_genpd_add_device(genpd, dev);
+}
+EXPORT_SYMBOL_GPL(of_genpd_add_device);
+
+/**
+ * of_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
+ * @parent_spec: OF phandle args to use for parent PM domain look-up
+ * @subdomain_spec: OF phandle args to use for subdomain look-up
+ *
+ * Looks-up a parent PM domain and subdomain based upon phandle args
+ * provided and adds the subdomain to the parent PM domain. Returns a
+ * negative error code on failure.
+ */
+int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
+			   struct of_phandle_args *subdomain_spec)
+{
+	struct generic_pm_domain *parent, *subdomain;
+
+	parent = of_genpd_get_from_provider(parent_spec);
+	if (IS_ERR(parent))
+		return PTR_ERR(parent);
+
+	subdomain = of_genpd_get_from_provider(subdomain_spec);
+	if (IS_ERR(subdomain))
+		return PTR_ERR(subdomain);
+
+	return pm_genpd_add_subdomain(parent, subdomain);
+}
+EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
+
+/**
  * genpd_dev_pm_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
  * @power_off: Currently not used
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 31fec858088c..e1964a242389 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -208,6 +208,10 @@ struct generic_pm_domain *__of_genpd_xlate_simple(
 struct generic_pm_domain *__of_genpd_xlate_onecell(
 					struct of_phandle_args *genpdspec,
 					void *data);
+extern int of_genpd_add_device(struct of_phandle_args *args,
+			       struct device *dev);
+extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
+				  struct of_phandle_args *new_subdomain);
 
 int genpd_dev_pm_attach(struct device *dev);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
@@ -227,6 +231,18 @@ static inline struct generic_pm_domain *of_genpd_get_from_provider(
 #define __of_genpd_xlate_simple		NULL
 #define __of_genpd_xlate_onecell	NULL
 
+static inline int of_genpd_add_device(struct of_phandle_args *args,
+				      struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline int of_genpd_add_subdomain(struct of_phandle_args *parent,
+					 struct of_phandle_args *new_subdomain)
+{
+	return -ENODEV;
+}
+
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return -ENODEV;
-- 
2.1.4
