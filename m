From: Ranganath Krishnan <ranganath@ti.com>
Subject: [PATCH 2/3] thermal: ti-soc-thermal: Set the bandgap mask counter delay value
Date: Fri, 23 Aug 2013 11:08:22 -0500
Message-ID: <1377274103-27770-2-git-send-email-ranganath@ti.com>
References: <1377274103-27770-1-git-send-email-ranganath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40781 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155Ab3HWQI4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Aug 2013 12:08:56 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id r7NG8tFi013463
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2013 11:08:55 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id r7NG8tdj017479
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2013 11:08:55 -0500
In-Reply-To: <1377274103-27770-1-git-send-email-ranganath@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Praneeth Bajjuri <praneeth@ti.com>, Ranganath Krishnan <ranganath@ti.com>

Set the bandgap mask counter_delay with the polling_delay value on
registering the thermal zone. This patch will ensure to get the
correct update interval for computing the thermal trend.

Signed-off-by: Ranganath Krishnan <ranganath@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 4c5f55c37..4f8b9af 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -174,6 +174,9 @@ static int ti_thermal_set_mode(struct thermal_zone_device *thermal,
 			       enum thermal_device_mode mode)
 {
 	struct ti_thermal_data *data = thermal->devdata;
+	struct ti_bandgap *bgp;
+
+	bgp = data->bgp;
 
 	if (!data->ti_thermal) {
 		dev_notice(&thermal->device, "thermal zone not registered\n");
@@ -190,6 +193,8 @@ static int ti_thermal_set_mode(struct thermal_zone_device *thermal,
 	mutex_unlock(&data->ti_thermal->lock);
 
 	data->mode = mode;
+	ti_bandgap_write_update_interval(bgp, data->sensor_id,
+					data->ti_thermal->polling_delay);
 	thermal_zone_device_update(data->ti_thermal);
 	dev_dbg(&thermal->device, "thermal polling set for duration=%d msec\n",
 		data->ti_thermal->polling_delay);
@@ -313,6 +318,8 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	}
 	data->ti_thermal->polling_delay = FAST_TEMP_MONITORING_RATE;
 	ti_bandgap_set_sensor_data(bgp, id, data);
+	ti_bandgap_write_update_interval(bgp, data->sensor_id,
+					data->ti_thermal->polling_delay);
 
 	return 0;
 }
-- 
1.7.9.5

