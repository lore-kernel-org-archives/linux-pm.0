From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] PM / devfreq: rk3399_dmc: Remove explictly regulator_put call in .remove
Date: Sun, 18 Sep 2016 10:41:05 +0800
Message-ID: <1474166465-18736-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33950 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755391AbcIRClW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Sep 2016 22:41:22 -0400
Received: by mail-pa0-f65.google.com with SMTP id vz6so5206099pab.1
        for <linux-pm@vger.kernel.org>; Sat, 17 Sep 2016 19:41:22 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Lin Huang <hl@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

Current code uses devm_regulator_get() in .probe so a regulator_put() will
be automatically called when unload the module. Remove the explictly
regulator_put() call and then we can also remove rk3399_dmcfreq_remove().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/devfreq/rk3399_dmc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 54d65f2..e24b73d 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -450,15 +450,6 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rk3399_dmcfreq_remove(struct platform_device *pdev)
-{
-	struct rk3399_dmcfreq *dmcfreq = platform_get_drvdata(pdev);
-
-	regulator_put(dmcfreq->vdd_center);
-
-	return 0;
-}
-
 static const struct of_device_id rk3399dmc_devfreq_of_match[] = {
 	{ .compatible = "rockchip,rk3399-dmc" },
 	{ },
@@ -466,7 +457,6 @@ static const struct of_device_id rk3399dmc_devfreq_of_match[] = {
 
 static struct platform_driver rk3399_dmcfreq_driver = {
 	.probe	= rk3399_dmcfreq_probe,
-	.remove	= rk3399_dmcfreq_remove,
 	.driver = {
 		.name	= "rk3399-dmc-freq",
 		.pm	= &rk3399_dmcfreq_pm,
-- 
2.7.4

