From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Fix potential deadlock while adding/removing subdomains
Date: Fri, 15 Jan 2016 10:59:20 +0100
Message-ID: <1452851960-22555-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35408 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbcAOJ7a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2016 04:59:30 -0500
Received: by mail-lb0-f173.google.com with SMTP id bc4so311121812lbc.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2016 01:59:29 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>

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
 drivers/base/power/domain.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6ac9a7f..81332a4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1339,8 +1339,8 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 	if (!link)
 		return -ENOMEM;
 
+	mutex_lock(&subdomain->lock);
 	mutex_lock(&genpd->lock);
-	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
 
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
@@ -1385,6 +1385,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
 
+	mutex_lock(&subdomain->lock);
 	mutex_lock(&genpd->lock);
 
 	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
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

