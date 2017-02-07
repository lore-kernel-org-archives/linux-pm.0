From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/5] thermal: devfreq: Check OPP for errors
Date: Tue,  7 Feb 2017 09:40:03 +0530
Message-ID: <06c4a7a43d537bf078f6ac72187853e11bd0384e.1486440448.git.viresh.kumar@linaro.org>
References: <79611a51240c83504c35a8739fe8e1837e903671.1486440448.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33822 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdBGEKR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 23:10:17 -0500
Received: by mail-pg0-f42.google.com with SMTP id 14so34617122pgg.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 20:10:17 -0800 (PST)
In-Reply-To: <79611a51240c83504c35a8739fe8e1837e903671.1486440448.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1486440448.git.viresh.kumar@linaro.org>
References: <cover.1486440448.git.viresh.kumar@linaro.org>
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
---
 drivers/thermal/devfreq_cooling.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 218ccc30c7ad..74d4846c66cd 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -225,13 +225,19 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
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

