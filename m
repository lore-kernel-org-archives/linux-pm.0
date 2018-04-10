From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 17/17] thermal: warn on attempts to read temperature on
 disabled sensors
Date: Tue, 10 Apr 2018 14:42:11 +0200
Message-ID: <1523364131-31059-18-git-send-email-b.zolnierkie@samsung.com>
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124457epcas1p33e959cf61c2a7f54227e29ef5ba9b0eb@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

* Add ops_of_thermal flag to struct thermal_zone_device_ops and
  set it in of-thermal.c.

* Add checking sensor mode for drivers using of-thermal.c to
  thermal_zone_get_temp() (print a warning if sensor is disabled).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/of-thermal.c      |  2 ++
 drivers/thermal/thermal_helpers.c | 12 ++++++++++++
 include/linux/thermal.h           |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index f60ccf1..68ebcda 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -392,6 +392,8 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 
 	.bind = of_thermal_bind,
 	.unbind = of_thermal_unbind,
+
+	.ops_of_thermal = true,
 };
 
 /***   sensor API   ***/
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index bd10b4d..e3fc1c6 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -87,6 +87,18 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
 
+	if (tz->ops->ops_of_thermal) {
+		enum thermal_device_mode mode;
+
+		ret = tz->ops->get_mode(tz, &mode);
+		if (ret)
+			goto exit;
+
+		if (mode == THERMAL_DEVICE_DISABLED)
+			dev_warn_once(&tz->device,
+				 "trying to read out disabled thermal zone\n");
+	}
+
 	mutex_lock(&tz->lock);
 
 	ret = tz->ops->get_temp(tz, temp);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7de102f..31560b4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -130,6 +130,7 @@ struct thermal_zone_device_ops {
 		       enum thermal_trip_type);
 
 	bool set_mode_skip_check;
+	bool ops_of_thermal;
 };
 
 struct thermal_cooling_device_ops {
-- 
1.9.1
