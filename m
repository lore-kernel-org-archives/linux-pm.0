From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/26] cpu_cooling: propagate error returned by idr_alloc()
Date: Fri, 28 Nov 2014 15:14:05 +0530
Message-ID: <1cfc99a9a641f2937a8ac95c6b784e3eee033b0c.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:58628 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaK1JpS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:18 -0500
Received: by mail-pd0-f175.google.com with SMTP id y10so6387329pdj.6
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:18 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

We aren't supposed to return our own error type here. Return what we got.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index bb11dd4..964586f 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -477,7 +477,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
 	if (ret) {
 		kfree(cpufreq_dev);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(cpufreq_dev->id);
 	}
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
-- 
2.0.3.693.g996b0fd

