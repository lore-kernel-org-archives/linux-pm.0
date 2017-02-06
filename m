From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] thermal: devfreq: Simplify expression
Date: Mon,  6 Feb 2017 15:56:27 +0530
Message-ID: <232171cd9d89c2179e10e1f2aed71ad7fc1f7872.1486376756.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34841 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdBFK0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 05:26:46 -0500
Received: by mail-pf0-f172.google.com with SMTP id f144so23244648pfa.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2017 02:26:45 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>

There is no need to check for IS_ERR() as we are looking for a very
particular error value here. Drop the first check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ba7a5cd994dc..cf71550b9d00 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -222,7 +222,7 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 		return 0;
 
 	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
-	if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))
+	if (PTR_ERR(opp) == -ERANGE)
 		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
 
 	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
-- 
2.7.1.410.g6faf27b

