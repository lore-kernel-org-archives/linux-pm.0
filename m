From: ahaslam@baylibre.com
Subject: [RFC v4 8/8] PM / Domains: remove old power on/off callbacks.
Date: Wed, 22 Apr 2015 11:45:35 +0200
Message-ID: <1429695935-15815-9-git-send-email-ahaslam@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38728 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019AbbDVJqk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 05:46:40 -0400
Received: by wiun10 with SMTP id n10so50550403wiu.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 02:46:39 -0700 (PDT)
In-Reply-To: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

Now that all known users have been converted to use the state
version of the callbacks, we can remove the default callbacks
without breaking compilation.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 include/linux/pm_domain.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f20c2c0..9bf9217 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -78,10 +78,6 @@ struct generic_pm_domain {
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	bool suspend_power_off;	/* Power status before system suspend */
-	int (*power_off)(struct generic_pm_domain *domain);
-	s64 power_off_latency_ns;
-	int (*power_on)(struct generic_pm_domain *domain);
-	s64 power_on_latency_ns;
 	struct gpd_dev_ops dev_ops;
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
-- 
1.9.1

