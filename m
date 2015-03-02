From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] Thermal/int340x: Fix memleak for aux trip
Date: Mon,  2 Mar 2015 13:12:07 -0800
Message-ID: <1425330727-18854-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1425330727-18854-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38510 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756056AbbCBVNQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Mar 2015 16:13:16 -0500
In-Reply-To: <1425330727-18854-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When thermal zone device register fails or on module exit, the memory
for aux_trip is not freed. This change fixes this issue.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int340x_thermal_zone.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
index f88b088..1e25133 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
@@ -208,7 +208,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 				trip_cnt, GFP_KERNEL);
 		if (!int34x_thermal_zone->aux_trips) {
 			ret = -ENOMEM;
-			goto free_mem;
+			goto err_trip_alloc;
 		}
 		trip_mask = BIT(trip_cnt) - 1;
 		int34x_thermal_zone->aux_trip_nr = trip_cnt;
@@ -248,14 +248,15 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 						0, 0);
 	if (IS_ERR(int34x_thermal_zone->zone)) {
 		ret = PTR_ERR(int34x_thermal_zone->zone);
-		goto free_lpat;
+		goto err_thermal_zone;
 	}
 
 	return int34x_thermal_zone;
 
-free_lpat:
+err_thermal_zone:
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
-free_mem:
+	kfree(int34x_thermal_zone->aux_trips);
+err_trip_alloc:
 	kfree(int34x_thermal_zone);
 	return ERR_PTR(ret);
 }
@@ -266,6 +267,7 @@ void int340x_thermal_zone_remove(struct int34x_thermal_zone
 {
 	thermal_zone_device_unregister(int34x_thermal_zone->zone);
 	acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
+	kfree(int34x_thermal_zone->aux_trips);
 	kfree(int34x_thermal_zone);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
-- 
1.9.3

