From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 01/11] thermal: remove unused function parameter
Date: Tue, 16 Oct 2018 16:56:12 +0200
Message-ID: <20181016145640eucas1p10d60eaf07c6a4b0c539e46053d2ea7de~eHqEkMsUc2218322183eucas1p19@eucas1p1.samsung.com>
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145640eucas1p10d60eaf07c6a4b0c539e46053d2ea7de@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Clean unused parameter from internal framework function.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/thermal/thermal_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab9823..2c6d72a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -313,9 +313,7 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
-static void handle_non_critical_trips(struct thermal_zone_device *tz,
-				      int trip,
-				      enum thermal_trip_type trip_type)
+static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
 {
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
@@ -416,7 +414,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, type);
 	else
-		handle_non_critical_trips(tz, trip, type);
+		handle_non_critical_trips(tz, trip);
 	/*
 	 * Alright, we handled this trip successfully.
 	 * So, start monitoring again.
-- 
2.7.4
