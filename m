From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] thermal: qoriq: remove useless call for of_thermal_get_trip_points()
Date: Wed, 26 Apr 2017 10:50:02 +0900
Message-ID: <1493171402-32479-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:39454 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1434504AbdDZBul (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 21:50:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

Building this driver with W=1 reports:
  warning: variable 'trip' set but not used [-Wunused-but-set-variable]

The call for of_thermal_get_trip_points() is useless.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/thermal/qoriq_thermal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 644ba52..4362a69 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -195,7 +195,6 @@ static struct thermal_zone_of_device_ops tmu_tz_ops = {
 static int qoriq_tmu_probe(struct platform_device *pdev)
 {
 	int ret;
-	const struct thermal_trip *trip;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	u32 site = 0;
@@ -243,8 +242,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_tmu;
 	}
 
-	trip = of_thermal_get_trip_points(data->tz);
-
 	/* Enable monitoring */
 	site |= 0x1 << (15 - data->sensor_id);
 	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
-- 
2.7.4
