From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/4] thermal: int3403: Process trip change notification
Date: Fri, 26 Aug 2016 16:21:19 -0700
Message-ID: <1472253679-15084-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472253679-15084-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbcHZXVd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Aug 2016 19:21:33 -0400
In-Reply-To: <1472253679-15084-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When ACPI sends notification for trip point change re-read trips and
notify thermal core, so that this can be passed to user space thermal
controller.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3403_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/int340x_thermal/int3403_thermal.c
index 7643489..c4890c9 100644
--- a/drivers/thermal/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
@@ -25,6 +25,7 @@
 #define INT3403_TYPE_CHARGER		0x0B
 #define INT3403_TYPE_BATTERY		0x0C
 #define INT3403_PERF_CHANGED_EVENT	0x80
+#define INT3403_PERF_TRIP_POINT_CHANGED	0x81
 #define INT3403_THERMAL_EVENT		0x90
 
 /* Preserved structure for future expandbility */
@@ -75,6 +76,11 @@ static void int3403_notify(acpi_handle handle,
 		int340x_thermal_zone_device_update(obj->int340x_zone,
 						   THERMAL_TRIP_VIOLATED);
 		break;
+	case INT3403_PERF_TRIP_POINT_CHANGED:
+		int340x_thermal_read_trips(obj->int340x_zone);
+		int340x_thermal_zone_device_update(obj->int340x_zone,
+						   THERMAL_TRIP_CHANGED);
+		break;
 	default:
 		dev_err(&priv->pdev->dev, "Unsupported event [0x%x]\n", event);
 		break;
-- 
2.7.4

