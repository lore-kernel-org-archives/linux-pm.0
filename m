From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 15/17] thermal: uniphier: enable+check sensor after its
 setup is finished
Date: Wed, 17 Oct 2018 17:52:41 +0200
Message-ID: <1539791563-5959-16-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155447epcas2p2db761f6575de357b65eb5e39b709fead@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Enable sensor after checking trip points (unipher_tm_enable_sensor()
enables IRQ so we need to toggle sensor before calling it) and check
sensor after doing chipset specific enable sensor operation.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/uniphier_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index ed3a920..9ccc1fc 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -307,9 +307,6 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
-	thermal_zone_set_mode(tdev->tz_dev, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(tdev->tz_dev);
-
 	/* get trip points */
 	trips = of_thermal_get_trip_points(tdev->tz_dev);
 	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
@@ -332,8 +329,12 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	thermal_zone_set_mode(tdev->tz_dev, THERMAL_DEVICE_ENABLED);
+
 	uniphier_tm_enable_sensor(tdev);
 
+	thermal_zone_device_check(tdev->tz_dev);
+
 	return 0;
 }
 
-- 
1.9.1
