From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 01/25] thermal/drivers/hisi: Fix missing interrupt enablement
Date: Tue, 10 Oct 2017 20:02:26 +0200
Message-ID: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:57149 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756288AbdJJSEt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 14:04:49 -0400
Received: by mail-wm0-f52.google.com with SMTP id l68so7682935wmd.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 11:04:49 -0700 (PDT)
In-Reply-To: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org, Leo Yan <leo.yan@linaro.org>

The interrupt for the temperature threshold is not enabled at the end of the
probe function, enable it after the setup is complete.

On the other side, the irq_enabled is not correctly set as we are checking if
the interrupt is masked where 'yes' means irq_enabled=false.

	irq_get_irqchip_state(data->irq, IRQCHIP_STATE_MASKED,
				&data->irq_enabled);

As we are always enabling the interrupt, it is pointless to check if
the interrupt is masked or not, just set irq_enabled to 'true'.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 9c3ce34..f3b50b0 100644
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
