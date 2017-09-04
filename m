From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2 01/13] thermal/drivers/hisi: Fix missing interrupt enablement
Date: Mon,  4 Sep 2017 21:56:00 +0200
Message-ID: <1504554972-2624-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
