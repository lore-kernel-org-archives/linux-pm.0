From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 2/7] thermal: ti-soc-thermal: remove external heat while extrapolating hotspot
Date: Wed, 29 May 2013 11:07:41 -0400
Message-ID: <1369840066-20357-3-git-send-email-eduardo.valentin@ti.com>
References: <1369840066-20357-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369840066-20357-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

For boards that provide a PCB sensor close to SoC junction
temperature, it is possible to remove the cumulative heat
reported by the SoC temperature sensor.

This patch changes the extrapolation computation to consider
an external sensor in the extrapolation equations.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)
---
This patch was added to the staging tree post 3.10-rc1 but
is not included after the move from staging to thermal. This is
because the thermal tree is based of 3.10-rc1 and not staging/next
or linux-next/master.

For your reference:
https://git.kernel.org/cgit/linux/kernel/git/gregkh/staging.git/commit/drivers/staging/ti-soc-thermal?h=staging-next&id=a85fd2c8fdefa0d504882f0e110d68e564903fcb

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index e3c5e67..8e67ebf 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -38,6 +38,7 @@
 /* common data structures */
 struct ti_thermal_data {
 	struct thermal_zone_device *ti_thermal;
+	struct thermal_zone_device *pcb_tz;
 	struct thermal_cooling_device *cool_dev;
 	struct ti_bandgap *bgp;
 	enum thermal_device_mode mode;
@@ -77,10 +78,12 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
 static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
 				      unsigned long *temp)
 {
+	struct thermal_zone_device *pcb_tz = NULL;
 	struct ti_thermal_data *data = thermal->devdata;
 	struct ti_bandgap *bgp;
 	const struct ti_temp_sensor *s;
-	int ret, tmp, pcb_temp, slope, constant;
+	int ret, tmp, slope, constant;
+	unsigned long pcb_temp;
 
 	if (!data)
 		return 0;
@@ -92,16 +95,22 @@ static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
 	if (ret)
 		return ret;
 
-	pcb_temp = 0;
-	/* TODO: Introduce pcb temperature lookup */
+	/* Default constants */
+	slope = s->slope;
+	constant = s->constant;
+
+	pcb_tz = data->pcb_tz;
 	/* In case pcb zone is available, use the extrapolation rule with it */
-	if (pcb_temp) {
-		tmp -= pcb_temp;
-		slope = s->slope_pcb;
-		constant = s->constant_pcb;
-	} else {
-		slope = s->slope;
-		constant = s->constant;
+	if (!IS_ERR_OR_NULL(pcb_tz)) {
+		ret = thermal_zone_get_temp(pcb_tz, &pcb_temp);
+		if (!ret) {
+			tmp -= pcb_temp; /* got a valid PCB temp */
+			slope = s->slope_pcb;
+			constant = s->constant_pcb;
+		} else {
+			dev_err(bgp->dev,
+				"Failed to read PCB state. Using defaults\n");
+		}
 	}
 	*temp = ti_thermal_hotspot_temperature(tmp, slope, constant);
 
@@ -273,6 +282,7 @@ static struct ti_thermal_data
 	data->sensor_id = id;
 	data->bgp = bgp;
 	data->mode = THERMAL_DEVICE_ENABLED;
+	data->pcb_tz = thermal_zone_get_zone_by_name("pcb");
 	INIT_WORK(&data->thermal_wq, ti_thermal_work);
 
 	return data;
-- 
1.8.2.1.342.gfa7285d
