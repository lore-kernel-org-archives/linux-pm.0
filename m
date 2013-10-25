From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] thermal: cpu_cooling: fix return value check in cpufreq_cooling_register()
Date: Fri, 25 Oct 2013 21:55:42 +0800
Message-ID: <CAPgLHd8_-oLvW7ps5way80S10asaN6uy8imjtUaqysQNNTXb7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:33432 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab3JYNzo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2013 09:55:44 -0400
Received: by mail-ea0-f175.google.com with SMTP id l15so519818eak.6
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2013 06:55:42 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function thermal_cooling_device_register() returns
ERR_PTR() and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/thermal/cpu_cooling.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index d179028..02a46f2 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -469,10 +469,10 @@ cpufreq_cooling_register(const struct cpumask *clip_cpus)
 
 	cool_dev = thermal_cooling_device_register(dev_name, cpufreq_dev,
 						   &cpufreq_cooling_ops);
-	if (!cool_dev) {
+	if (IS_ERR(cool_dev)) {
 		release_idr(&cpufreq_idr, cpufreq_dev->id);
 		kfree(cpufreq_dev);
-		return ERR_PTR(-EINVAL);
+		return cool_dev;
 	}
 	cpufreq_dev->cool_dev = cool_dev;
 	cpufreq_dev->cpufreq_state = 0;

