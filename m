From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] Thermal/int340x: LPAT conversion for temperature
Date: Wed, 28 Jan 2015 11:56:48 -0800
Message-ID: <1422475009-20759-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1422475009-20759-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:53316 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757626AbbA1U0I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Jan 2015 15:26:08 -0500
In-Reply-To: <1422475009-20759-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When LPAT table is present, we need to convert raw temperature to
real temp using LPAT.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../thermal/int340x_thermal/int340x_thermal_zone.c   | 20 +++++++++++++++++---
 .../thermal/int340x_thermal/int340x_thermal_zone.h   |  3 +++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
index 162e545..f88b088 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
@@ -33,8 +33,17 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	/* _TMP returns the temperature in tenths of degrees Kelvin */
-	*temp = DECI_KELVIN_TO_MILLICELSIUS(tmp);
+	if (d->lpat_table) {
+		int conv_temp;
+
+		conv_temp = acpi_lpat_raw_to_temp(d->lpat_table, (int)tmp);
+		if (conv_temp < 0)
+			return conv_temp;
+
+		*temp = (unsigned long)conv_temp * 10;
+	} else
+		/* _TMP returns the temperature in tenths of degrees Kelvin */
+		*temp = DECI_KELVIN_TO_MILLICELSIUS(tmp);
 
 	return 0;
 }
@@ -227,6 +236,8 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 		int34x_thermal_zone->act_trips[i].id = trip_cnt++;
 		int34x_thermal_zone->act_trips[i].valid = true;
 	}
+	int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
+								adev->handle);
 
 	int34x_thermal_zone->zone = thermal_zone_device_register(
 						acpi_device_bid(adev),
@@ -237,11 +248,13 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 						0, 0);
 	if (IS_ERR(int34x_thermal_zone->zone)) {
 		ret = PTR_ERR(int34x_thermal_zone->zone);
-		goto free_mem;
+		goto free_lpat;
 	}
 
 	return int34x_thermal_zone;
 
+free_lpat:
+	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
 free_mem:
 	kfree(int34x_thermal_zone);
 	return ERR_PTR(ret);
@@ -252,6 +265,7 @@ void int340x_thermal_zone_remove(struct int34x_thermal_zone
 				 *int34x_thermal_zone)
 {
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
+	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
 	kfree(int34x_thermal_zone);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
index 11f2f52..9f38ab7 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
@@ -16,6 +16,8 @@
 #ifndef __INT340X_THERMAL_ZONE_H__
 #define __INT340X_THERMAL_ZONE_H__
 
+#include <acpi/acpi_lpat.h>
+
 #define INT340X_THERMAL_MAX_ACT_TRIP_COUNT	10
 
 struct active_trip {
@@ -38,6 +40,7 @@ struct int34x_thermal_zone {
 	struct thermal_zone_device *zone;
 	struct thermal_zone_device_ops *override_ops;
 	void *priv_data;
+	struct acpi_lpat_conversion_table *lpat_table;
 };
 
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *,
-- 
1.9.3

