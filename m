From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 11/14] thermal/drivers/hisi: Remove pointless irq field
Date: Tue, 25 Sep 2018 11:03:09 +0200
Message-ID: <1537866192-12320-12-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

The irq field in the data structure is pointless as the scope of its
usage is just to request the interrupt. It can be replaced by a local
variable.

Use the 'ret' variable to get the interrupt number.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 941c2c4..87d8a13 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -83,7 +83,6 @@ struct hisi_thermal_data {
 	struct clk *clk;
 	void __iomem *regs;
 	int nr_sensors;
-	int irq;
 };
 
 /*
@@ -579,16 +578,16 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		data->irq = platform_get_irq_byname(pdev, sensor->irq_name);
-		if (data->irq < 0)
-			return data->irq;
+		ret = platform_get_irq_byname(pdev, sensor->irq_name);
+		if (ret < 0)
+			return ret;
 
-		ret = devm_request_threaded_irq(dev, data->irq, NULL,
+		ret = devm_request_threaded_irq(dev, ret, NULL,
 						hisi_thermal_alarm_irq_thread,
 						IRQF_ONESHOT, sensor->irq_name,
 						sensor);
 		if (ret < 0) {
-			dev_err(dev, "failed to request alarm irq: %d\n", ret);
+			dev_err(dev, "Failed to request alarm irq: %d\n", ret);
 			return ret;
 		}
 
-- 
2.7.4
