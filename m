From: Joe Perches <joe@perches.com>
Subject: [PATCH 6/7] thermal: Use bool function return values of true/false not 1/0
Date: Mon, 30 Mar 2015 10:43:22 -0700
Message-ID: <04644fca79a1987084bc46fca59c419fab0a4448.1427736972.git.joe@perches.com>
References: <cover.1427736972.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1427736972.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/thermal/thermal_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 9e20e4d..749d41a 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -115,7 +115,7 @@ static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
 static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 					    int trip)
 {
-	return 0;
+	return false;
 }
 static inline const struct thermal_trip *
 of_thermal_get_trip_points(struct thermal_zone_device *tz)
-- 
2.1.2
