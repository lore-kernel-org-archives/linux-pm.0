From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 10/26] thermal: cpu_cooling: no need to set cpufreq_dev to NULL
Date: Thu,  4 Dec 2014 09:41:52 +0530
Message-ID: <21a29c0ebea4678b6922a237fd03b5cd2a55b5a5.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:54165 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbaLDENY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:24 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so1716317pdj.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:24 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

It will be overwritten soon with return value of kzalloc().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 30e2ecb..c144493 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -451,7 +451,7 @@ __cpufreq_cooling_register(struct device_node *np,
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

