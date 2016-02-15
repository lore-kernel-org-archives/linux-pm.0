From: ahaslam@baylibre.com
Subject: [PATCH v12 3/3] PM / Domains: remove old power on/off latencies.
Date: Mon, 15 Feb 2016 11:10:53 +0100
Message-ID: <1455531053-11291-4-git-send-email-ahaslam@baylibre.com>
References: <1455531053-11291-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35699 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbcBOKLJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 05:11:09 -0500
Received: by mail-wm0-f41.google.com with SMTP id c200so105143905wme.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 02:11:08 -0800 (PST)
In-Reply-To: <1455531053-11291-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, lina.iyer@linaro.org
Cc: khilman@baylibre.com, linux-pm@vger.kernel.org, geert@linux-m68k.org, mtitinger@baylibre.com, rjw@rjwysocki.net, bcousson@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Now that all known users have been converted to use state latencies,
we can remove the latency field in the generic_pm_domain structure.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 drivers/base/power/domain.c | 8 +-------
 include/linux/pm_domain.h   | 2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4c6f46b..e8ca290 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1523,14 +1523,8 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	}
 
 	/* Use only one "off" state if there were no states declared */
-	if (genpd->state_count == 0) {
-		genpd->states[0].power_on_latency_ns =
-					genpd->power_on_latency_ns;
-		genpd->states[0].power_off_latency_ns =
-					genpd->power_off_latency_ns;
-
+	if (genpd->state_count == 0)
 		genpd->state_count = 1;
-	}
 
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1726c4a..49cd8890 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -61,9 +61,7 @@ struct generic_pm_domain {
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
2.6.3

