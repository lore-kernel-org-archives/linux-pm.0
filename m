From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 01/13] thermal/drivers/hisi: Fix missing interrupt enablement
Date: Wed, 30 Aug 2017 10:47:25 +0200
Message-ID: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:37651 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdH3Isp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2017 04:48:45 -0400
Received: by mail-wr0-f173.google.com with SMTP id k9so4227329wre.4
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2017 01:48:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, open list <linux-kernel@vger.kernel.org>

The interrupt for the temperature threshold is not enabled at the end of the
probe function, enable it after the setup is complete.

On the other side, the irq_enabled is not correctly set as we are checking if
the interrupt is masked where 'yes' means irq_enabled=false.

	irq_get_irqchip_state(data->irq, IRQCHIP_STATE_MASKED,
				&data->irq_enabled);

As we are always enabling the interrupt, it is pointless to check if
the interrupt is masked or not, just set irq_enabled to 'true'.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index bd3572c..8381696 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -345,8 +345,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	}
 
 	hisi_thermal_enable_bind_irq_sensor(data);
-	irq_get_irqchip_state(data->irq, IRQCHIP_STATE_MASKED,
-			      &data->irq_enabled);
+	data->irq_enabled = true;
 
 	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
 		ret = hisi_thermal_register_sensor(pdev, data,
@@ -358,6 +357,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 			hisi_thermal_toggle_sensor(&data->sensors[i], true);
 	}
 
+	enable_irq(data->irq);
+
 	return 0;
 }
 
-- 
2.7.4
