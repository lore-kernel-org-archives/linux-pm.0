From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 12/26] thermal: cpu_cooling: propagate error returned by idr_alloc()
Date: Thu,  4 Dec 2014 09:41:54 +0530
Message-ID: <572e759226b469c45bdc9875bbd05ff6ebf921e1.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:64158 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbaLDENc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:32 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so16878504pdb.32
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:32 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

We aren't supposed to return our own error type here. Return what we got.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index d57b8bb..5c9a2ef 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -485,7 +485,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
 	if (ret) {
 		kfree(cpufreq_dev);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(ret);
 	}
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
-- 
2.0.3.693.g996b0fd

