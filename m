From: ahaslam@baylibre.com
Subject: [PATCH v10 5/6] PM / Domains: remove old power on/off latencies.
Date: Tue, 20 Oct 2015 15:26:28 +0200
Message-ID: <1445347589-5626-6-git-send-email-ahaslam@baylibre.com>
References: <1445347589-5626-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36071 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbbJTN0u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 09:26:50 -0400
Received: by wicfx6 with SMTP id fx6so45650358wic.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2015 06:26:49 -0700 (PDT)
In-Reply-To: <1445347589-5626-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@linaro.org, ulf.hansson@linaro.org, lina.iyer@linaro.org, geert@glider.be, k.kozlowski.k@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bcousson@baylibre.com, mturquette@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Now that all known users have been converted to use state latencies,
we can remove the latency field in the generic_pm_domain structure.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 drivers/base/power/domain.c | 15 ---------------
 include/linux/pm_domain.h   |  2 --
 2 files changed, 17 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2ffee65..dbab367 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1239,21 +1239,6 @@ static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
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
index 3129f85..ff576e4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -65,9 +65,7 @@ struct generic_pm_domain {
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
2.4.5

