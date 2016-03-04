From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 7/8] PM / Domains: Prepare for adding support to remove PM domains
Date: Fri, 4 Mar 2016 11:23:53 +0000
Message-ID: <1457090634-14785-8-git-send-email-jonathanh@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457090634-14785-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

In order to remove PM domains safely from the list of PM domains,
it is necessary to adding locking for the PM domain list around any
places where devices or subdomains are added to a PM domain.

There are places where a reference to a PM domain is obtained via
calling of_genpd_get_from_provider() before adding the device or the
subdomain. In these cases a lock for the PM domain list needs to be
held around the call to of_genpd_get_from_provider() and the call to
add the device/subdomain. To avoid deadlocks by multiple attempts to
obtain the PM domain list lock, add functions genpd_add_device() and
genpd_add_subdomain() which require the user to hold the PM domain
list lock when calling.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/base/power/domain.c | 97 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 24 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 438885f2455f..9b33377bf01b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1214,14 +1214,8 @@ static void genpd_free_dev_data(struct device *dev,
 	dev_pm_put_subsys_data(dev);
 }
 
-/**
- * __pm_genpd_add_device - Add a device to an I/O PM domain.
- * @genpd: PM domain to add the device to.
- * @dev: Device to be added.
- * @td: Set of PM QoS timing parameters to attach to the device.
- */
-int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
-			  struct gpd_timing_data *td)
+static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
+			    struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data;
 	int ret = 0;
@@ -1261,6 +1255,24 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	return ret;
 }
+
+/**
+ * __pm_genpd_add_device - Add a device to an I/O PM domain.
+ * @genpd: PM domain to add the device to.
+ * @dev: Device to be added.
+ * @td: Set of PM QoS timing parameters to attach to the device.
+ */
+int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
+			  struct gpd_timing_data *td)
+{
+	int ret;
+
+	mutex_lock(&gpd_list_lock);
+	ret = genpd_add_device(genpd, dev, td);
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(__pm_genpd_add_device);
 
 /**
@@ -1314,13 +1326,8 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_remove_device);
 
-/**
- * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
- * @genpd: Master PM domain to add the subdomain to.
- * @subdomain: Subdomain to be added.
- */
-int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
-			   struct generic_pm_domain *subdomain)
+static int genpd_add_subdomain(struct generic_pm_domain *genpd,
+			       struct generic_pm_domain *subdomain)
 {
 	struct gpd_link *link, *itr;
 	int ret = 0;
@@ -1363,6 +1370,23 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 		kfree(link);
 	return ret;
 }
+
+/**
+ * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
+ * @genpd: Master PM domain to add the subdomain to.
+ * @subdomain: Subdomain to be added.
+ */
+int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
+			   struct generic_pm_domain *subdomain)
+{
+	int ret;
+
+	mutex_lock(&gpd_list_lock);
+	ret = genpd_add_subdomain(genpd, subdomain);
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
 
 /**
@@ -1807,12 +1831,22 @@ static struct generic_pm_domain *of_genpd_get_from_provider(
 int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret;
+
+	mutex_lock(&gpd_list_lock);
 
 	genpd = of_genpd_get_from_provider(genpdspec);
-	if (IS_ERR(genpd))
-		return PTR_ERR(genpd);
+	if (IS_ERR(genpd)) {
+		ret = PTR_ERR(genpd);
+		goto out;
+	}
 
-	return pm_genpd_add_device(genpd, dev);
+	ret = genpd_add_device(genpd, dev, NULL);
+
+out:
+	mutex_unlock(&gpd_list_lock);
+
+	return ret;
 }
 
 /**
@@ -1828,16 +1862,28 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
 			   struct of_phandle_args *subdomain_spec)
 {
 	struct generic_pm_domain *parent, *subdomain;
+	int ret;
+
+	mutex_lock(&gpd_list_lock);
 
 	parent = of_genpd_get_from_provider(parent_spec);
-	if (IS_ERR(parent))
-		return PTR_ERR(parent);
+	if (IS_ERR(parent)) {
+		ret = PTR_ERR(parent);
+		goto out;
+	}
 
 	subdomain = of_genpd_get_from_provider(subdomain_spec);
-	if (IS_ERR(subdomain))
-		return PTR_ERR(subdomain);
+	if (IS_ERR(subdomain)) {
+		ret = PTR_ERR(subdomain);
+		goto out;
+	}
+
+	ret = genpd_add_subdomain(parent, subdomain);
+
+out:
+	mutex_unlock(&gpd_list_lock);
 
-	return pm_genpd_add_subdomain(parent, subdomain);
+	return ret;
 }
 
 /**
@@ -1935,9 +1981,11 @@ int genpd_dev_pm_attach(struct device *dev)
 			return -ENOENT;
 	}
 
+	mutex_lock(&gpd_list_lock);
 	pd = of_genpd_get_from_provider(&pd_args);
 	of_node_put(pd_args.np);
 	if (IS_ERR(pd)) {
+		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
 		return -EPROBE_DEFER;
@@ -1946,13 +1994,14 @@ int genpd_dev_pm_attach(struct device *dev)
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
 	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
-		ret = pm_genpd_add_device(pd, dev);
+		ret = genpd_add_device(pd, dev, NULL);
 		if (ret != -EAGAIN)
 			break;
 
 		mdelay(i);
 		cond_resched();
 	}
+	mutex_unlock(&gpd_list_lock);
 
 	if (ret < 0) {
 		dev_err(dev, "failed to add to PM domain %s: %d",
-- 
2.1.4
