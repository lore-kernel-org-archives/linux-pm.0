From: ahaslam@baylibre.com
Subject: [RFC v11 3/3] PM / Domains: remove old power on/off latencies.
Date: Tue,  9 Feb 2016 14:15:51 +0100
Message-ID: <1455023751-32521-4-git-send-email-ahaslam@baylibre.com>
References: <1455023751-32521-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33076 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbcBINQQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 08:16:16 -0500
Received: by mail-wm0-f53.google.com with SMTP id g62so174065162wme.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 05:16:15 -0800 (PST)
In-Reply-To: <1455023751-32521-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, lina.iyer@linaro.org
Cc: khilman@baylibre.com, linux-pm@vger.kernel.org, geert@linux-m68k.org, mtitinger@baylibre.com, rjw@rjwysocki.net, bcousson@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

Now that all known users have been converted to use state latencies,
we can remove the latency field in the generic_pm_domain structure.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 drivers/base/power/domain.c | 6 ------
 include/linux/pm_domain.h   | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7099eb3..c4b3e36 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1230,12 +1230,6 @@ static int genpd_alloc_default_state(struct generic_pm_domain *genpd)
 		goto err;
 	}
 
-	genpd->states[0].power_on_latency_ns =
-				genpd->power_on_latency_ns;
-
-	genpd->states[0].power_off_latency_ns =
-				genpd->power_off_latency_ns;
-
 	genpd->state_count = 1;
 	genpd->state_idx = 0;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a5c3b68..2cc75d8 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -59,9 +59,7 @@ struct generic_pm_domain {
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

