From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/26] cpu_cooling: no need to set cpufreq_dev to NULL
Date: Fri, 28 Nov 2014 15:14:04 +0530
Message-ID: <c2f2d850eab62ba05f5c5acc48df09e74e50d5cc.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61948 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaK1JpO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:14 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so6423159pdb.32
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:14 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

It will be overwritten soon with return value of kzalloc().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index cf9d1de..bb11dd4 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -448,7 +448,7 @@ __cpufreq_cooling_register(struct device_node *np,
 			   const struct cpumask *clip_cpus)
 {
 	struct thermal_cooling_device *cool_dev;
-	struct cpufreq_cooling_device *cpufreq_dev = NULL;
+	struct cpufreq_cooling_device *cpufreq_dev;
 	unsigned int min = 0, max = 0;
 	char dev_name[THERMAL_NAME_LENGTH];
 	int ret = 0, i;
-- 
2.0.3.693.g996b0fd

