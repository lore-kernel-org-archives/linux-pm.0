From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/5] thermal: devfreq_cooling: Replace dev_warn with dev_err
Date: Mon, 13 Mar 2017 15:37:35 +0530
Message-ID: <3386850b3136e749e78aedaf689b9b0f20a67f3d.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36481 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdCMKIU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 06:08:20 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so44682142pge.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 03:08:19 -0700 (PDT)
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

There isn't much the user can do on seeing this warning, as the hardware
is actually okay. dev_err suits much better here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/devfreq_cooling.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 4793fc7b06dd..e99d0e026a53 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -193,9 +193,9 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
-		dev_warn_ratelimited(dev,
-				     "Failed to get voltage for frequency %lu: %ld\n",
-				     freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+		dev_err_ratelimited(dev,
+				    "Failed to get voltage for frequency %lu: %ld\n",
+				    freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
 		return 0;
 	}
 
-- 
2.7.1.410.g6faf27b
