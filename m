From: ahaslam@baylibre.com
Subject: [PATCH v7 5/5] PM / Domains: remove old power on/off latencies.
Date: Thu, 30 Apr 2015 12:55:35 +0200
Message-ID: <1430391335-7588-6-git-send-email-ahaslam@baylibre.com>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37038 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbbD3K5I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2015 06:57:08 -0400
Received: by widdi4 with SMTP id di4so13157700wid.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2015 03:57:07 -0700 (PDT)
In-Reply-To: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Now that all known users have been converted to use state
latencies, we can remove the latency field in the generic_pm_domain
structure.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 drivers/base/power/domain.c | 15 ---------------
 include/linux/pm_domain.h   |  2 --
 2 files changed, 17 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 86f0c46..fa863c7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1510,21 +1510,6 @@ static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
 			st[i].power_off_latency_ns;
 	}
 
-	/*
-	 * Copy the latency values To keep compatibility with
-	 * platforms that are not converted to use the multiple states.
-	 * This will be removed once all platforms are converted to use
-	 * multiple states. note that non converted platforms will use the
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
index 581ae08..0248207 100644
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

