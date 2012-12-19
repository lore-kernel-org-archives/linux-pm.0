From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] thermal: db8500: Use of_match_ptr() macro in db8500_cpufreq_cooling.c
Date: Wed, 19 Dec 2012 14:20:59 +0530
Message-ID: <1355907059-28720-2-git-send-email-sachin.kamat@linaro.org>
References: <1355907059-28720-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43051 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab2LSJzs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Dec 2012 04:55:48 -0500
Received: by mail-pb0-f48.google.com with SMTP id rq13so1088285pbb.35
        for <linux-pm@vger.kernel.org>; Wed, 19 Dec 2012 01:55:47 -0800 (PST)
In-Reply-To: <1355907059-28720-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, hongbo.zhang@linaro.org, sachin.kamat@linaro.org, patches@linaro.org, Hongbo Zhang <hongbo.zhang@stericsson.com>

This eliminates having an #ifdef returning NULL for the case
when OF is disabled.

Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Compile tested on linux-next.
---
 drivers/thermal/db8500_cpufreq_cooling.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/db8500_cpufreq_cooling.c b/drivers/thermal/db8500_cpufreq_cooling.c
index 4cf8e72..2141985 100644
--- a/drivers/thermal/db8500_cpufreq_cooling.c
+++ b/drivers/thermal/db8500_cpufreq_cooling.c
@@ -21,6 +21,7 @@
 #include <linux/cpufreq.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -73,15 +74,13 @@ static const struct of_device_id db8500_cpufreq_cooling_match[] = {
 	{ .compatible = "stericsson,db8500-cpufreq-cooling" },
 	{},
 };
-#else
-#define db8500_cpufreq_cooling_match NULL
 #endif
 
 static struct platform_driver db8500_cpufreq_cooling_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "db8500-cpufreq-cooling",
-		.of_match_table = db8500_cpufreq_cooling_match,
+		.of_match_table = of_match_ptr(db8500_cpufreq_cooling_match),
 	},
 	.probe = db8500_cpufreq_cooling_probe,
 	.suspend = db8500_cpufreq_cooling_suspend,
-- 
1.7.4.1

