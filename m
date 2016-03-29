From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V9 07/14] thermal: of-thermal: allow setting trip_temp on hardware
Date: Tue, 29 Mar 2016 17:17:36 +0800
Message-ID: <1459243056-25424-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

In current of-thermal, the .set_trip_temp only support to
set trip_temp for SW. But some sensors support to set
trip_temp on hardware, so that can trigger interrupt,
shutdown or any other events.
This patch adds .set_trip_temp() callback in
thermal_zone_of_device_ops{}, so that the sensor device can
use it to set trip_temp on hardware.

Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/of-thermal.c | 8 ++++++++
 include/linux/thermal.h      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index acc767b6fdee..85288029b46c 100644
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
index a55d0523f75d..97b86c549df1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -340,6 +340,7 @@ struct thermal_zone_of_device_ops {
 	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, long *);
 	int (*set_emul_temp)(void *, int);
+	int (*set_trip_temp)(void *, int, int);
 };
 
 /**
-- 
1.9.1
