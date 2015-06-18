From: Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC][PATCH] PM / Domains: Return -EPROBE_DEFER if we fail to init or turn-on domain
Date: Thu, 18 Jun 2015 18:52:47 +0100
Message-ID: <1434649967-21135-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8995 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbbFRRwx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 13:52:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

When a device is probed, the function dev_pm_domain_attach() is called
to see if there is a power-domain that is associated with the device and
needs to be turned on. If dev_pm_domain_attach() does not return
-EPROBE_DEFER then the device will be probed.

For devices using genpd, dev_pm_domain_attach() will call
genpd_dev_pm_attach(). If genpd_dev_pm_attach() does not find a power
domain associated with the device then it returns an error code not
equal to -EPROBE_DEFER to allow the device to be probed. However, if
genpd_dev_pm_attach() does find a power-domain that is associated with
the device, then it does not return -EPROBE_DEFER on failure and hence
the device will still be probed. Furthermore, genpd_dev_pm_attach() does
not check the error code returned by pm_genpd_poweron() to see if the
power-domain was turned on successfully.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
FWICT, it seems to me that we would not want to probe the device if
there is a power-domain associated but we fail to initialise it or
it fails to turn on. Of course I could be wrong here and so please
let me know if my interpretation is utterly flawed in someway ;-)

 drivers/base/power/domain.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cdd547bd67df..c69e87ccb150 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2177,7 +2177,10 @@ static void genpd_dev_pm_sync(struct device *dev)
  * Both generic and legacy Samsung-specific DT bindings are supported to keep
  * backwards compatibility with existing DTBs.
  *
- * Returns 0 on successfully attached PM domain or negative error code.
+ * Returns 0 on successfully attached PM domain or negative error code. Note
+ * that if a power-domain exists for the device, but it cannot be found or
+ * turned on, then return -EPROBE_DEFER to ensure that the device is not
+ * probed and to re-try again later.
  */
 int genpd_dev_pm_attach(struct device *dev)
 {
@@ -2213,7 +2216,7 @@ int genpd_dev_pm_attach(struct device *dev)
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
 		of_node_put(dev->of_node);
-		return PTR_ERR(pd);
+		return -EPROBE_DEFER;
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
@@ -2229,14 +2232,15 @@ int genpd_dev_pm_attach(struct device *dev)
 		dev_err(dev, "failed to add to PM domain %s: %d",
 			pd->name, ret);
 		of_node_put(dev->of_node);
-		return ret;
+		goto out;
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
-	pm_genpd_poweron(pd);
+	ret = pm_genpd_poweron(pd);
 
-	return 0;
+out:
+	return ret ? -EPROBE_DEFER : 0;
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
-- 
2.1.4

