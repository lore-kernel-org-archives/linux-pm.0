From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 14/17] thermal: ti-soc-thermal: enable/check sensor after
 its setup is finished
Date: Tue, 10 Apr 2018 14:42:08 +0200
Message-ID: <1523364131-31059-15-git-send-email-b.zolnierkie@samsung.com>
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124436epcas1p3422f3653277634b8cc8bef223bc9298f@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Enable sensor after setting sensor data and check sensor after
writing update interval.

Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 3c2299b..a9afbf9 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -197,13 +197,15 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return PTR_ERR(data->ti_thermal);
 	}
 
+	ti_bandgap_set_sensor_data(bgp, id, data);
+
 	thermal_zone_device_toggle(data->ti_thermal, true);
-	thermal_zone_device_check(data->ti_thermal);
 
-	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					data->ti_thermal->polling_delay);
 
+	thermal_zone_device_check(data->ti_thermal);
+
 	return 0;
 }
 
-- 
1.9.1
