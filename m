From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: Prevent error in reading trip hysteresis attribute
Date: Fri, 25 May 2018 18:10:10 -0700
Message-ID: <20180526011010.15915-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Some of the INT340X devices may not have hysteresis defined in the ACPI
definition. In that case reading trip hysteresis results in error. This
spams logs of user space utilities.

In this case instead of returning error, just return hysteresis as 0,
which is correct as there is no hysteresis defined for the device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int340x_thermal_zone.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
index 145a5c53ff5c..dfdf6dbc2ddc 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
@@ -147,9 +147,9 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
 
 	status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL, &hyst);
 	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	*temp = hyst * 100;
+		*temp = 0;
+	else
+		*temp = hyst * 100;
 
 	return 0;
 }
-- 
2.17.0
