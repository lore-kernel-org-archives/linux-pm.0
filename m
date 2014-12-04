From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 08/26] thermal: cpu_cooling: Pass variable instead of its type to sizeof()
Date: Thu,  4 Dec 2014 09:41:50 +0530
Message-ID: <baf9a15535e8972fe23b78a64ca82bef7c15017a.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47808 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbaLDENR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:17 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so17071600pab.19
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:16 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Just following coding guidelines here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index a5a9317..5378561 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -476,8 +476,7 @@ __cpufreq_cooling_register(struct device_node *np,
 				return ERR_PTR(-EINVAL);
 		}
 	}
-	cpufreq_dev = kzalloc(sizeof(struct cpufreq_cooling_device),
-			      GFP_KERNEL);
+	cpufreq_dev = kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);
 	if (!cpufreq_dev)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.0.3.693.g996b0fd

