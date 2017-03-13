From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/5] thermal: devfreq: Check OPP for errors
Date: Mon, 13 Mar 2017 15:37:36 +0530
Message-ID: <bd7ef529482524d6b963b43066f331417bae906c.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36493 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdCMKIX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 06:08:23 -0400
Received: by mail-pg0-f48.google.com with SMTP id g2so44682644pge.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 03:08:22 -0700 (PDT)
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489399567.git.viresh.kumar@linaro.org>
References: <cover.1489399567.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dan.carpenter@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

It is possible for dev_pm_opp_find_freq_exact() to return errors. It was
all fine earlier as dev_pm_opp_get_voltage() had a check within it to
check for invalid OPPs, but dev_pm_opp_put() doesn't have any similar
checks and the callers need to make sure OPP is valid before calling
them.

Also update the later dev_warn_ratelimited() to not print the error
message as the OPP is guaranteed to be valid now.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/devfreq_cooling.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index e99d0e026a53..4bf4ad58cffd 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -189,13 +189,19 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 	if (PTR_ERR(opp) == -ERANGE)
 		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
 
+	if (IS_ERR(opp)) {
+		dev_err_ratelimited(dev, "Failed to find OPP for frequency %lu: %ld\n",
+				    freq, PTR_ERR(opp));
+		return 0;
+	}
+
 	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
 		dev_err_ratelimited(dev,
-				    "Failed to get voltage for frequency %lu: %ld\n",
-				    freq, IS_ERR(opp) ? PTR_ERR(opp) : 0);
+				    "Failed to get voltage for frequency %lu\n",
+				    freq);
 		return 0;
 	}
 
-- 
2.7.1.410.g6faf27b
