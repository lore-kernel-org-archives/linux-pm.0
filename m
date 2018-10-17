From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 11/17] thermal: rockchip_thermal: enable+check sensor
 after its setup is finished
Date: Wed, 17 Oct 2018 17:52:37 +0200
Message-ID: <1539791563-5959-12-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155422epcas1p1644d897c62ceb36b57d33ecd4e3bc81c@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

* Enable+check sensor explicitly in rockchip_thermal_probe() (also
  check sensor after doing chipset specific control operation).

* Remove superfluous second sensor enable+check attempt.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/rockchip_thermal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 90d8175..ef9e2aa 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1161,9 +1161,6 @@ static int rockchip_configure_from_dt(struct device *dev,
 		return error;
 	}
 
-	thermal_zone_set_mode(sensor->tzd, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(sensor->tzd);
-
 	return 0;
 }
 
@@ -1272,6 +1269,10 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
+	for (i = 0; i < thermal->chip->chn_num; i++)
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_ENABLED);
+
 	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					  &rockchip_thermal_alarm_irq_thread,
 					  IRQF_ONESHOT,
@@ -1284,11 +1285,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < thermal->chip->chn_num; i++) {
-		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
-				      THERMAL_DEVICE_ENABLED);
+	for (i = 0; i < thermal->chip->chn_num; i++)
 		thermal_zone_device_check((&thermal->sensors[i])->tzd);
-	}
 
 	platform_set_drvdata(pdev, thermal);
 
-- 
1.9.1
