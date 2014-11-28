From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/26] cpu_cooling: no need to set cpufreq_state to zero
Date: Fri, 28 Nov 2014 15:14:03 +0530
Message-ID: <15ba799d1224df9e31165e6dfd8a8dc516232657.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:52637 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbaK1JpL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:11 -0500
Received: by mail-pd0-f182.google.com with SMTP id r10so6441151pdi.27
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:10 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

Its already zero, we allocated cpufreq_dev with kzalloc.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 59725d8..cf9d1de 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -491,7 +491,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		return cool_dev;
 	}
 	cpufreq_dev->cool_dev = cool_dev;
-	cpufreq_dev->cpufreq_state = 0;
+
 	mutex_lock(&cooling_cpufreq_lock);
 
 	/* Register the notifier for first cpufreq cooling device */
-- 
2.0.3.693.g996b0fd

