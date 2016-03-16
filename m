From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V8 07/14] thermal: of-thermal: allow setting trip_temp on hardware
Date: Wed, 16 Mar 2016 16:57:55 +0800
Message-ID: <1458118675-29864-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11839 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966143AbcCPI5r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 04:57:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

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

