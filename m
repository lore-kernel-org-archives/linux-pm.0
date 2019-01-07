From: Yi Zeng <yizeng@asrmicro.com>
Subject: [PATCH] thermal: of-thermal: support to select governor in dts for thermal zone
Date: Mon, 7 Jan 2019 23:04:39 +0800
Message-ID: <1546873479-20415-1-git-send-email-yizeng@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yi Zeng <yizeng@asrmicro.com>
List-Id: linux-pm@vger.kernel.org

Add the governor property parsing that defined in thermal zone node
in dts. If define the governor property for one thermal zone, for
example, governor = "step_wise", then parse and register the thermal
zone will find and set the right governor, except the only choice
of default governor.

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
---
 drivers/thermal/of-thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a..f9368f4 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -1024,6 +1024,7 @@ int __init of_parse_thermal_zones(void)
 		struct thermal_zone_params *tzp;
 		int i, mask = 0;
 		u32 prop;
+		const char *name;
 
 		tz = thermal_of_build_thermal_zone(child);
 		if (IS_ERR(tz)) {
@@ -1049,6 +1050,10 @@ int __init of_parse_thermal_zones(void)
 		if (!of_property_read_u32(child, "sustainable-power", &prop))
 			tzp->sustainable_power = prop;
 
+		if (!of_property_read_string(child, "governor", &name))
+			strncpy(tzp->governor_name, name,
+				THERMAL_NAME_LENGTH);
+
 		for (i = 0; i < tz->ntrips; i++)
 			mask |= 1 << i;
 
-- 
1.9.1
