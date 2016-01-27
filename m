From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RESEND PATCH V2] PM / Domains: Fix potential deadlock while adding/removing subdomains
Date: Wed, 27 Jan 2016 09:10:37 +0100
Message-ID: <1453882237-2816-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34117 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbcA0IKp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2016 03:10:45 -0500
Received: by mail-lb0-f181.google.com with SMTP id cl12so715008lbc.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2016 00:10:45 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>

We must preserve the same order of how we acquire and release the lock for
genpd, as otherwise we may encounter deadlocks.

The power on phase of a genpd starts by acquiring its lock. Then it walks
the hierarchy of its parent domains to be able to power on these first, as
per design of genpd.

>From a locking perspective this means the locks of the parents becomes
acquired after the lock of the subdomain.

Let's fix pm_genpd_add|remove_subdomain() to maintain the same order of
acquiring/releasing the genpd lock as being applied in the power on/off
sequence.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Fix lockdep warning.

---
 drivers/base/power/domain.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6ac9a7f..676d762 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1339,8 +1339,8 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 	if (!link)
 		return -ENOMEM;
 
-	mutex_lock(&genpd->lock);
-	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
+	mutex_lock(&subdomain->lock);
+	mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
 
 	if (genpd->status == GPD_STATE_POWER_OFF
 	    &&  subdomain->status != GPD_STATE_POWER_OFF) {
@@ -1363,8 +1363,8 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 		genpd_sd_counter_inc(genpd);
 
  out:
-	mutex_unlock(&subdomain->lock);
 	mutex_unlock(&genpd->lock);
+	mutex_unlock(&subdomain->lock);
 	if (ret)
 		kfree(link);
 	return ret;
@@ -1385,7 +1385,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
 
-	mutex_lock(&genpd->lock);
+	mutex_lock(&subdomain->lock);
+	mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
 
 	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
@@ -1398,22 +1399,19 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		if (link->slave != subdomain)
 			continue;
 
-		mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
-
 		list_del(&link->master_node);
 		list_del(&link->slave_node);
 		kfree(link);
 		if (subdomain->status != GPD_STATE_POWER_OFF)
 			genpd_sd_counter_dec(genpd);
 
-		mutex_unlock(&subdomain->lock);
-
 		ret = 0;
 		break;
 	}
 
 out:
 	mutex_unlock(&genpd->lock);
+	mutex_unlock(&subdomain->lock);
 
 	return ret;
 }
-- 
1.9.1

