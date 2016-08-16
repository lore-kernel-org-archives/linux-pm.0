From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 04/10] PM / Domains: Don't expose generic_pm_domain structure
 to clients
Date: Tue, 16 Aug 2016 10:49:30 +0100
Message-ID: <1471340976-5379-5-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

There should be no need to expose the generic_pm_domain structure to
clients and this eliminates the need to implement reference counting for
any external reference to a PM domain. Therefore, make the functions
pm_genpd_lookup_dev() and of_genpd_get_from_provider() private to the
PM domain core. The functions are renamed in accordance with the naming
conventions for genpd static functions.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 19 +++++++++----------
 include/linux/pm_domain.h   | 14 --------------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 43c2a959a7bf..7b0aecef2e51 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -45,7 +45,7 @@ static DEFINE_MUTEX(gpd_list_lock);
  * and checks that the PM domain pointer is a real generic PM domain.
  * Any failure results in NULL being returned.
  */
-struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
+static struct generic_pm_domain *genpd_lookup_dev(struct device *dev)
 {
 	struct generic_pm_domain *genpd = NULL, *gpd;
 
@@ -1119,7 +1119,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	if (!genpd || genpd != pm_genpd_lookup_dev(dev))
+	if (!genpd || genpd != genpd_lookup_dev(dev))
 		return -EINVAL;
 
 	/* The above validation also means we have existing domain_data. */
@@ -1466,7 +1466,7 @@ void of_genpd_del_provider(struct device_node *np)
 EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 
 /**
- * of_genpd_get_from_provider() - Look-up PM domain
+ * genpd_get_from_provider() - Look-up PM domain
  * @genpdspec: OF phandle args to use for look-up
  *
  * Looks for a PM domain provider under the node specified by @genpdspec and if
@@ -1476,7 +1476,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
  * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
  * on failure.
  */
-struct generic_pm_domain *of_genpd_get_from_provider(
+static struct generic_pm_domain *genpd_get_from_provider(
 					struct of_phandle_args *genpdspec)
 {
 	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
@@ -1499,7 +1499,6 @@ struct generic_pm_domain *of_genpd_get_from_provider(
 
 	return genpd;
 }
-EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 
 /**
  * of_genpd_add_device() - Add a device to an I/O PM domain
@@ -1513,7 +1512,7 @@ int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 
-	genpd = of_genpd_get_from_provider(genpdspec);
+	genpd = genpd_get_from_provider(genpdspec);
 	if (IS_ERR(genpd))
 		return PTR_ERR(genpd);
 
@@ -1535,11 +1534,11 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
 {
 	struct generic_pm_domain *parent, *subdomain;
 
-	parent = of_genpd_get_from_provider(parent_spec);
+	parent = genpd_get_from_provider(parent_spec);
 	if (IS_ERR(parent))
 		return PTR_ERR(parent);
 
-	subdomain = of_genpd_get_from_provider(subdomain_spec);
+	subdomain = genpd_get_from_provider(subdomain_spec);
 	if (IS_ERR(subdomain))
 		return PTR_ERR(subdomain);
 
@@ -1561,7 +1560,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	unsigned int i;
 	int ret = 0;
 
-	pd = pm_genpd_lookup_dev(dev);
+	pd = genpd_lookup_dev(dev);
 	if (!pd)
 		return;
 
@@ -1642,7 +1641,7 @@ int genpd_dev_pm_attach(struct device *dev)
 			return -ENOENT;
 	}
 
-	pd = of_genpd_get_from_provider(&pd_args);
+	pd = genpd_get_from_provider(&pd_args);
 	of_node_put(pd_args.np);
 	if (IS_ERR(pd)) {
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e1964a242389..bd411e754f4a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -116,7 +116,6 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 	return to_gpd_data(dev->power.subsys_data->domain_data);
 }
 
-extern struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev);
 extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
 				 struct gpd_timing_data *td);
@@ -138,10 +137,6 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 {
 	return ERR_PTR(-ENOSYS);
 }
-static inline struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
-{
-	return NULL;
-}
 static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 					struct device *dev,
 					struct gpd_timing_data *td)
@@ -199,9 +194,6 @@ typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
 int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 			void *data);
 void of_genpd_del_provider(struct device_node *np);
-struct generic_pm_domain *of_genpd_get_from_provider(
-			struct of_phandle_args *genpdspec);
-
 struct generic_pm_domain *__of_genpd_xlate_simple(
 					struct of_phandle_args *genpdspec,
 					void *data);
@@ -222,12 +214,6 @@ static inline int __of_genpd_add_provider(struct device_node *np,
 }
 static inline void of_genpd_del_provider(struct device_node *np) {}
 
-static inline struct generic_pm_domain *of_genpd_get_from_provider(
-			struct of_phandle_args *genpdspec)
-{
-	return NULL;
-}
-
 #define __of_genpd_xlate_simple		NULL
 #define __of_genpd_xlate_onecell	NULL
 
-- 
2.1.4
