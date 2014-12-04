From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 09/26] thermal: cpu_cooling: no need to set cpufreq_state to zero
Date: Thu,  4 Dec 2014 09:41:51 +0530
Message-ID: <013ea5e93099865298d229e7a9906c85289d7e07.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37575 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbaLDENV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:21 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so16878209pdb.32
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:20 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Its already zero, we allocated cpufreq_dev with kzalloc.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 5378561..30e2ecb 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -499,7 +499,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		return cool_dev;
 	}
 	cpufreq_dev->cool_dev = cool_dev;
-	cpufreq_dev->cpufreq_state = 0;
+
 	mutex_lock(&cooling_cpufreq_lock);
 
 	/* Register the notifier for first cpufreq cooling device */
-- 
2.0.3.693.g996b0fd

