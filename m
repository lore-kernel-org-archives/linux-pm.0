From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Thermal/int3403: Fix thermal hysteresis unit conversion
Date: Mon,  3 Nov 2014 01:53:01 -0800
Message-ID: <1415008381-11584-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11866 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbaKCJyK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Nov 2014 04:54:10 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: tianyu.lan@intel.com, linux-pm@vger.kernel.org

From: "lan,Tianyu" <tianyu.lan@intel.com>

Thermal hysteresis represents a temperature difference.
But the original code treats it as a temperature value,
Convert it from tenths of degree Kelvin to Milli-Celsius
by deducing 273200. This is not right.

Kelvin and Celsius have same degree size. From temperature
difference view, the conversion between tenths of degree
Kelvin unit and Milli-Celsius unit is just to multiply 100.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/int340x_thermal/int3403_thermal.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/int340x_thermal/int3403_thermal.c
index d20dba9..6e9fb62 100644
--- a/drivers/thermal/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
@@ -92,7 +92,13 @@ static int sys_get_trip_hyst(struct thermal_zone_device *tzone,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	*temp = DECI_KELVIN_TO_MILLI_CELSIUS(hyst, KELVIN_OFFSET);
+	/*
+	 * Thermal hysteresis represents a temperature difference.
+	 * Kelvin and Celsius have same degree size. So the
+	 * conversion here between tenths of degree Kelvin unit
+	 * and Milli-Celsius unit is just to multiply 100.
+	 */
+	*temp = hyst * 100;
 
 	return 0;
 }
-- 
1.9.1

