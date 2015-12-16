From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 1/3] thermal: setup monitor only once after handling trips
Date: Tue, 15 Dec 2015 19:49:12 -0800
Message-ID: <1450237754-31906-2-git-send-email-edubezval@gmail.com>
References: <1450237754-31906-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450237754-31906-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Instead of changing the monitoring setup every time after
handling each trip, this patch simplifies the monitoring
setup by moving the setup call to a place where all
trips have been treated already.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
V1->V2:
	fixed typo
---
 drivers/thermal/thermal_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9e525c..8fa82c0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -457,11 +457,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 		handle_critical_trips(tz, trip, type);
 	else
 		handle_non_critical_trips(tz, trip, type);
-	/*
-	 * Alright, we handled this trip successfully.
-	 * So, start monitoring again.
-	 */
-	monitor_thermal_zone(tz);
 }
 
 /**
@@ -547,6 +542,12 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
+
+	/*
+	 * Alright, we handled these trips successfully.
+	 * So, start monitoring again.
+	 */
+	monitor_thermal_zone(tz);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
-- 
2.5.0
