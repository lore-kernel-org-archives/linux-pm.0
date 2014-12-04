From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 11/26] thermal: cpu_cooling: no need to initialze 'ret'
Date: Thu,  4 Dec 2014 09:41:53 +0530
Message-ID: <484221f147f77526116e0d5b3c1f04679515bc7a.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62208 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbaLDEN2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:28 -0500
Received: by mail-pd0-f182.google.com with SMTP id r10so16895079pdi.13
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:28 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index c144493..d57b8bb 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -454,7 +454,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct cpufreq_cooling_device *cpufreq_dev;
 	unsigned int min = 0, max = 0;
 	char dev_name[THERMAL_NAME_LENGTH];
-	int ret = 0, i;
+	int ret, i;
 	struct cpufreq_policy policy;
 
 	if (!cpufreq_frequency_get_table(cpumask_first(clip_cpus))) {
-- 
2.0.3.693.g996b0fd

