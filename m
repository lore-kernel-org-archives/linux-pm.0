From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 11/17] thermal: rockchip_thermal: enable/check sensor after
 its setup is finished
Date: Tue, 10 Apr 2018 14:42:05 +0200
Message-ID: <1523364131-31059-12-git-send-email-b.zolnierkie@samsung.com>
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124407epcas2p4c537eb52653af45b85af6b69969c4e52@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

* Enable/check sensor explicitly in rockchip_thermal_probe() (also
  check sensor after doing chipset specific control operation).

* Remove superfluous second sensor enable/check attempt.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
This driver may require some more fixing (probably IRQ should be
requested after ->control call).

 drivers/thermal/rockchip_thermal.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 500cfc3..0b3509b 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1161,9 +1161,6 @@ static int rockchip_configure_from_dt(struct device *dev,
 		return error;
 	}
 
-	thermal_zone_device_toggle(sensor->tzd, true);
-	thermal_zone_device_check(sensor->tzd);
-
 	return 0;
 }
 
@@ -1272,6 +1269,9 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
+	for (i = 0; i < thermal->chip->chn_num; i++)
+		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
+
 	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					  &rockchip_thermal_alarm_irq_thread,
 					  IRQF_ONESHOT,
@@ -1284,10 +1284,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < thermal->chip->chn_num; i++) {
-		thermal_zone_device_toggle((&thermal->sensors[i])->tzd, true);
+	for (i = 0; i < thermal->chip->chn_num; i++)
 		thermal_zone_device_check((&thermal->sensors[i])->tzd);
-	}
 
 	platform_set_drvdata(pdev, thermal);
 
-- 
1.9.1
