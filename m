From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 07/17] thermal: hisi_thermal: enable/check sensor after its
 setup is finished
Date: Tue, 10 Apr 2018 14:42:01 +0200
Message-ID: <1523364131-31059-8-git-send-email-b.zolnierkie@samsung.com>
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124339epcas2p31bdbdc3d5fc602b3c7fe60b02e8faacd@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

* Enable/check sensor after checking ntrips and doing chipset specific
  enable operation.

* Remove superfluous second sensor enable/check attempt.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/hisi_thermal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 1936eb4..d4c5055 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -488,9 +488,6 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 		return ret;
 	}
 
-	thermal_zone_device_toggle(sensor->tzd, true);
-	thermal_zone_device_check(sensor->tzd);
-
 	trip = of_thermal_get_trip_points(sensor->tzd);
 
 	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
@@ -553,6 +550,9 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	thermal_zone_device_toggle((&data->sensor)->tzd, true);
+	thermal_zone_device_check((&data->sensor)->tzd);
+
 	if (data->irq) {
 		ret = devm_request_threaded_irq(dev, data->irq, NULL,
 				hisi_thermal_alarm_irq_thread,
@@ -563,9 +563,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
-	thermal_zone_device_toggle((&data->sensor)->tzd, true);
-	thermal_zone_device_check((&data->sensor)->tzd);
-
 	return 0;
 }
 
-- 
1.9.1
