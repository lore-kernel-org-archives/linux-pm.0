From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/2] cpufreq: imx: fix regulator_get error handling
Date: Sun, 18 Oct 2015 13:01:48 +0200
Message-ID: <56237C1C.80109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37638 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbbJRL0r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2015 07:26:47 -0400
Received: by wicfv8 with SMTP id fv8so42523627wic.0
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2015 04:26:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

With CONFIG_DELAY_DEVICE_PROBES being set I get the following error:

cpu cpu0: failed to get regulators
imx6q-cpufreq: probe of imx6q-cpufreq.0 failed with error -2

Fix the error handling of regulator_get to properly deal
with -EPROBE_DEFER.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 380a90d..0bb33dc 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -187,11 +187,20 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	arm_reg = regulator_get(cpu_dev, "arm");
+	if (IS_ERR(arm_reg)) {
+		ret = PTR_ERR(arm_reg);
+		if (ret != -EPROBE_DEFER)
+			dev_err(cpu_dev, "failed to get regulator arm\n");
+		goto put_reg;
+	}
+
 	pu_reg = regulator_get_optional(cpu_dev, "pu");
+
 	soc_reg = regulator_get(cpu_dev, "soc");
-	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
-		dev_err(cpu_dev, "failed to get regulators\n");
-		ret = -ENOENT;
+	if (IS_ERR(soc_reg)) {
+		ret = PTR_ERR(soc_reg);
+		if (ret != -EPROBE_DEFER)
+			dev_err(cpu_dev, "failed to get regulator soc\n");
 		goto put_reg;
 	}
 
-- 
2.6.1

