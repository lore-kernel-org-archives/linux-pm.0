From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/4] PM / Domains: Clean up code validating genpd's status
Date: Mon, 20 Mar 2017 11:19:20 +0100
Message-ID: <1490005163-28633-2-git-send-email-ulf.hansson@linaro.org>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35981 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbdCTKUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 06:20:23 -0400
Received: by mail-lf0-f45.google.com with SMTP id y193so53267568lfd.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 03:19:35 -0700 (PDT)
In-Reply-To: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

There exists several similar validations of the genpd->status, against
GPD_STATE_ACTIVE and GPD_STATE_POWER_OFF. Let's clean up this code by
converting to use a helper macro, genpd_status_on().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e697dec..7a8e70d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -121,6 +121,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
 #define genpd_unlock(p)			p->lock_ops->unlock(p)
 
+#define genpd_status_on(genpd)		(genpd->status == GPD_STATE_ACTIVE)
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
@@ -296,8 +297,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	 * (1) The domain is already in the "power off" state.
 	 * (2) System suspend is in progress.
 	 */
-	if (genpd->status == GPD_STATE_POWER_OFF
-	    || genpd->prepared_count > 0)
+	if (!genpd_status_on(genpd) || genpd->prepared_count > 0)
 		return 0;
 
 	if (atomic_read(&genpd->sd_count) > 0)
@@ -373,7 +373,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	struct gpd_link *link;
 	int ret = 0;
 
-	if (genpd->status == GPD_STATE_ACTIVE)
+	if (genpd_status_on(genpd))
 		return 0;
 
 	/*
@@ -752,7 +752,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
-	if (genpd->status == GPD_STATE_POWER_OFF)
+	if (!genpd_status_on(genpd))
 		return;
 
 	if (genpd->suspended_count != genpd->device_count
@@ -793,7 +793,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
-	if (genpd->status == GPD_STATE_ACTIVE)
+	if (genpd_status_on(genpd))
 		return;
 
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
@@ -1329,8 +1329,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	genpd_lock(subdomain);
 	genpd_lock_nested(genpd, SINGLE_DEPTH_NESTING);
 
-	if (genpd->status == GPD_STATE_POWER_OFF
-	    &&  subdomain->status != GPD_STATE_POWER_OFF) {
+	if (!genpd_status_on(genpd) && genpd_status_on(subdomain)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1346,7 +1345,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	list_add_tail(&link->master_node, &genpd->master_links);
 	link->slave = subdomain;
 	list_add_tail(&link->slave_node, &subdomain->slave_links);
-	if (subdomain->status != GPD_STATE_POWER_OFF)
+	if (genpd_status_on(subdomain))
 		genpd_sd_counter_inc(genpd);
 
  out:
@@ -1406,7 +1405,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 		list_del(&link->master_node);
 		list_del(&link->slave_node);
 		kfree(link);
-		if (subdomain->status != GPD_STATE_POWER_OFF)
+		if (genpd_status_on(subdomain))
 			genpd_sd_counter_dec(genpd);
 
 		ret = 0;
@@ -2221,7 +2220,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
 		goto exit;
-	if (genpd->status == GPD_STATE_POWER_OFF)
+	if (!genpd_status_on(genpd))
 		snprintf(state, sizeof(state), "%s-%u",
 			 status_lookup[genpd->status], genpd->state_idx);
 	else
-- 
2.7.4
