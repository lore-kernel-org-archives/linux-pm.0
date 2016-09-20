From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH 1/3] PM / Domains: Add helper functions for finding and attaching PM domains
Date: Tue, 20 Sep 2016 11:28:05 +0100
Message-ID: <1474367287-10402-2-git-send-email-jonathanh@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

In preparation for supporting devices that require more than one PM
domain, move the code for finding and attaching PM domains into local
helper functions.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 121 ++++++++++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 48 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b0cf46dcae73..382735949591 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1779,6 +1779,41 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_genpd_remove_last);
 
+static struct generic_pm_domain *genpd_dev_pm_lookup(struct device *dev,
+						     unsigned int index)
+{
+	struct of_phandle_args pd_args;
+	struct generic_pm_domain *pd;
+	int ret;
+
+	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
+					 "#power-domain-cells", index, &pd_args);
+	if (ret < 0) {
+		if (ret != -ENOENT)
+			return ERR_PTR(ret);
+
+		/*
+		 * Try legacy Samsung-specific bindings
+		 * (for backwards compatibility of DT ABI)
+		 */
+		pd_args.args_count = 0;
+		pd_args.np = of_parse_phandle(dev->of_node,
+					      "samsung,power-domain", 0);
+		if (!pd_args.np)
+			return ERR_PTR(-ENOENT);
+	}
+
+	pd = genpd_get_from_provider(&pd_args);
+	of_node_put(pd_args.np);
+	if (IS_ERR(pd)) {
+		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
+			__func__, PTR_ERR(pd));
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return pd;
+}
+
 /**
  * genpd_dev_pm_detach - Detach a device from its PM domain.
  * @dev: Device to detach.
@@ -1829,6 +1864,40 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+static int genpd_dev_pm_attach_device(struct device *dev,
+				      struct generic_pm_domain *pd)
+{
+	unsigned int i;
+	int ret;
+
+	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
+
+	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
+		ret = genpd_add_device(pd, dev, NULL);
+		if (ret != -EAGAIN)
+			break;
+
+		mdelay(i);
+		cond_resched();
+	}
+
+	if (ret < 0) {
+		dev_err(dev, "failed to add to PM domain %s: %d",
+			pd->name, ret);
+		goto out;
+	}
+
+	dev->pm_domain->detach = genpd_dev_pm_detach;
+	dev->pm_domain->sync = genpd_dev_pm_sync;
+
+	mutex_lock(&pd->lock);
+	ret = genpd_poweron(pd, 0);
+	mutex_unlock(&pd->lock);
+out:
+	return ret ? -EPROBE_DEFER : 0;
+
+}
+
 /**
  * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
  * @dev: Device to attach.
@@ -1846,9 +1915,7 @@ static void genpd_dev_pm_sync(struct device *dev)
  */
 int genpd_dev_pm_attach(struct device *dev)
 {
-	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
-	unsigned int i;
 	int ret;
 
 	if (!dev->of_node)
@@ -1857,59 +1924,17 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (dev->pm_domain)
 		return -EEXIST;
 
-	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
-					"#power-domain-cells", 0, &pd_args);
-	if (ret < 0) {
-		if (ret != -ENOENT)
-			return ret;
-
-		/*
-		 * Try legacy Samsung-specific bindings
-		 * (for backwards compatibility of DT ABI)
-		 */
-		pd_args.args_count = 0;
-		pd_args.np = of_parse_phandle(dev->of_node,
-						"samsung,power-domain", 0);
-		if (!pd_args.np)
-			return -ENOENT;
-	}
-
 	mutex_lock(&gpd_list_lock);
-	pd = genpd_get_from_provider(&pd_args);
-	of_node_put(pd_args.np);
+	pd = genpd_dev_pm_lookup(dev, 0);
 	if (IS_ERR(pd)) {
 		mutex_unlock(&gpd_list_lock);
-		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
-			__func__, PTR_ERR(pd));
 		return -EPROBE_DEFER;
 	}
 
-	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
-
-	for (i = 1; i < GENPD_RETRY_MAX_MS; i <<= 1) {
-		ret = genpd_add_device(pd, dev, NULL);
-		if (ret != -EAGAIN)
-			break;
-
-		mdelay(i);
-		cond_resched();
-	}
-	mutex_unlock(&gpd_list_lock);
-
-	if (ret < 0) {
-		dev_err(dev, "failed to add to PM domain %s: %d",
-			pd->name, ret);
-		goto out;
-	}
-
-	dev->pm_domain->detach = genpd_dev_pm_detach;
-	dev->pm_domain->sync = genpd_dev_pm_sync;
+	ret = genpd_dev_pm_attach_device(dev, pd);
+	mutex_lock(&gpd_list_lock);
 
-	mutex_lock(&pd->lock);
-	ret = genpd_poweron(pd, 0);
-	mutex_unlock(&pd->lock);
-out:
-	return ret ? -EPROBE_DEFER : 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
-- 
2.1.4
