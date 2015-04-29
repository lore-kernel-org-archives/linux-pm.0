From: ahaslam@baylibre.com
Subject: [PATCH/RFC v6 5/5] PM / Domains: remove old power on/off callbacks.
Date: Wed, 29 Apr 2015 21:10:15 +0200
Message-ID: <1430334615-1161-6-git-send-email-ahaslam@baylibre.com>
References: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35360 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbbD2TL0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 15:11:26 -0400
Received: by wgyo15 with SMTP id o15so38938220wgy.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2015 12:11:24 -0700 (PDT)
In-Reply-To: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Now that all known users have been converted to use the state
version of the callbacks, we can remove the default callbacks
without breaking compilation.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 drivers/base/power/domain.c | 15 ---------------
 include/linux/pm_domain.h   |  2 --
 2 files changed, 17 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4ea1365..30bff3f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1510,21 +1510,6 @@ static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
 			st[i].power_off_latency_ns;
 	}
 
-	/*
-	 * Copy the latency values To keep compatibility with
-	 * platfroms that are not converted to use the multiple states.
-	 * This will be removed once all platfroms are converted to use
-	 * multiple states. note that non converted platfroms will use the
-	 * default single off state.
-	 */
-	if (genpd->power_on_latency_ns != 0)
-		genpd->states[0].power_on_latency_ns =
-				genpd->power_on_latency_ns;
-
-	if (genpd->power_off_latency_ns != 0)
-		genpd->states[0].power_off_latency_ns =
-				genpd->power_off_latency_ns;
-
 	genpd->state_count = st_count;
 
 	/* to save memory, Name allocation will happen if debug is enabled */
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 8a3d43f..935984f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -73,9 +73,7 @@ struct generic_pm_domain {
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	bool suspend_power_off;	/* Power status before system suspend */
 	int (*power_off)(struct generic_pm_domain *domain);
-	s64 power_off_latency_ns;
 	int (*power_on)(struct generic_pm_domain *domain);
-	s64 power_on_latency_ns;
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
-- 
1.9.1

