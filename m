From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V7 07/12] thermal: of-thermal: allow setting trip_temp on hardware
Date: Fri, 11 Mar 2016 11:10:48 +0800
Message-ID: <1457665848-29960-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

In current of-thermal, the .set_trip_temp only support to
set trip_temp for SW. But some sensors support to set
trip_temp on hardware, so that can trigger interrupt,
shutdown or any other events.
This patch adds .set_trip_temp() callback in
thermal_zone_of_device_ops{}, so that the sensor device can
use it to set trip_temp on hardware.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/of-thermal.c | 8 ++++++++
 include/linux/thermal.h      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 5a515f8677ec..57828841b6e6 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -331,6 +331,14 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
 	if (trip >= data->ntrips || trip < 0)
 		return -EDOM;
 
+	if (data->ops->set_trip_temp) {
+		int ret;
+
+		ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
+		if (ret)
+			return ret;
+	}
+
 	/* thermal framework should take care of data->mask & (1 << trip) */
 	data->trips[trip].temperature = temp;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 9c481991fdc7..fcaab873b94f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -338,6 +338,7 @@ struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, long *);
 	int (*set_emul_temp)(void *, int);
+	int (*set_trip_temp)(void *, int, int);
 };
 
 /**
-- 
1.9.1
