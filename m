From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 02/10] pm: domains: factor out code to get the generic PM
 domain from a struct device
Date: Fri, 13 Mar 2015 16:23:25 +0000
Message-ID: <E1YWSMv-0006Fx-E6@rmk-PC.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43459 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbCMQXj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 12:23:39 -0400
In-Reply-To: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

The PM domain code contains two methods to get the generic PM domain
for a struct device.  One is dev_to_genpd() which is only safe when
we know for certain that the device has a generic PM domain attached.
The other is coded into genpd_dev_pm_detach() which ensures that the
PM domain in the struct device is a generic PM domain (and so is safer).

This commit factors out the safer version and documents it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b3fbc21da2dc..b9000b245e62 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -68,6 +68,31 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
 	return genpd;
 }
 
+/*
+ * Get the generic PM domain for a particular struct device.
+ * This validates the struct device pointer, the PM domain pointer,
+ * and checks that the PM domain pointer is a real generic PM domain.
+ * Any failure results in NULL being returned.
+ */
+static struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
+{
+	struct generic_pm_domain *genpd = NULL, *gpd;
+
+	if (IS_ERR_OR_NULL(dev) || IS_ERR_OR_NULL(dev->pm_domain))
+		return NULL;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+		if (&gpd->domain == dev->pm_domain) {
+			genpd = gpd;
+			break;
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	return genpd;
+}
+
 struct generic_pm_domain *dev_to_genpd(struct device *dev)
 {
 	if (IS_ERR_OR_NULL(dev->pm_domain))
@@ -2120,21 +2145,10 @@ EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
  */
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
-	struct generic_pm_domain *pd = NULL, *gpd;
+	struct generic_pm_domain *pd;
 	int ret = 0;
 
-	if (!dev->pm_domain)
-		return;
-
-	mutex_lock(&gpd_list_lock);
-	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
-		if (&gpd->domain == dev->pm_domain) {
-			pd = gpd;
-			break;
-		}
-	}
-	mutex_unlock(&gpd_list_lock);
-
+	pd = pm_genpd_lookup_dev(dev);
 	if (!pd)
 		return;
 
-- 
1.8.3.1

