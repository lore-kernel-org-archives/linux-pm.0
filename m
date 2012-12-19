From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] thermal: db8500: Use of_match_ptr() macro in db8500_thermal.c
Date: Wed, 19 Dec 2012 14:20:58 +0530
Message-ID: <1355907059-28720-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60085 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab2LSJWL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Dec 2012 04:22:11 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so1174595pad.17
        for <linux-pm@vger.kernel.org>; Wed, 19 Dec 2012 01:22:10 -0800 (PST)
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
 drivers/thermal/db8500_thermal.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index ec71ade..61ce60a 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -508,15 +508,13 @@ static const struct of_device_id db8500_thermal_match[] = {
 	{ .compatible = "stericsson,db8500-thermal" },
 	{},
 };
-#else
-#define db8500_thermal_match NULL
 #endif
 
 static struct platform_driver db8500_thermal_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "db8500-thermal",
-		.of_match_table = db8500_thermal_match,
+		.of_match_table = of_match_ptr(db8500_thermal_match),
 	},
 	.probe = db8500_thermal_probe,
 	.suspend = db8500_thermal_suspend,
-- 
1.7.4.1

