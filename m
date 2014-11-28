From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/26] cpu_cooling: Pass variable instead of its type to sizeof()
Date: Fri, 28 Nov 2014 15:14:02 +0530
Message-ID: <1a0d2430eb52b55fdb8f82c4cbbb8b4038a105ec.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:39790 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaK1JpH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:07 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so6523209pab.7
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:06 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

Just following coding guidelines here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index def0f21..59725d8 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -468,8 +468,7 @@ __cpufreq_cooling_register(struct device_node *np,
 				return ERR_PTR(-EINVAL);
 		}
 	}
-	cpufreq_dev = kzalloc(sizeof(struct cpufreq_cooling_device),
-			      GFP_KERNEL);
+	cpufreq_dev = kzalloc(sizeof(*cool_dev), GFP_KERNEL);
 	if (!cpufreq_dev)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.0.3.693.g996b0fd

