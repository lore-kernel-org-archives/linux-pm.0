From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] thermal: imx: Do not print error message in the EPROBE_DEFER case
Date: Thu, 11 Dec 2014 19:11:40 -0200
Message-ID: <1418332300-7859-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:35963 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933335AbaLKVMg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Dec 2014 16:12:36 -0500
Received: by mail-qa0-f50.google.com with SMTP id w8so4180957qac.37
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2014 13:12:35 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

During imx_thermal probe we have the following log:

[    1.514819] imx_thermal 2000000.aips-bus:tempmon: failed to register cpufreq cooling device: -517
[    1.515064] platform 2000000.aips-bus:tempmon: Driver imx_thermal requests probe deferral

Avoid printing the error message in the EPROBE_DEFER case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/thermal/imx_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index bb08d6e..c1188ac 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -513,8 +513,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	data->cdev = cpufreq_cooling_register(cpu_present_mask);
 	if (IS_ERR(data->cdev)) {
 		ret = PTR_ERR(data->cdev);
-		dev_err(&pdev->dev,
-			"failed to register cpufreq cooling device: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to register cpufreq cooling device: %d\n",
+				ret);
 		return ret;
 	}
 
-- 
1.9.1

