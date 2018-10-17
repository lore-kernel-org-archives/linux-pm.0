From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 10/17] thermal: rcar_gen3_thermal: enable+check sensor
 after its setup is finished
Date: Wed, 17 Oct 2018 17:52:36 +0200
Message-ID: <1539791563-5959-11-git-send-email-b.zolnierkie@samsung.com>
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155416epcas2p32f63571e9c06cd1aba2b40bcf23de8e1@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Amit kucheria <amit.kucheria@linaro.org>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Enable+check sensor after setting tsc->zone and checking ntrips.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index c72453e..eb50f33 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -421,9 +421,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
-		thermal_zone_set_mode(zone, THERMAL_DEVICE_ENABLED);
-		thermal_zone_device_check(zone);
-
 		tsc->zone = zone;
 
 		ret = of_thermal_get_ntrips(tsc->zone);
@@ -431,6 +428,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
+
+		thermal_zone_set_mode(zone, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(zone);
 	}
 
 	priv->num_tscs = i;
-- 
1.9.1
