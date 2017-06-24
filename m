From: Willy Wolff <willy.mh.wolff@gmail.com>
Subject: [PATCH] thermal: fix source code documentation for parameters
Date: Sat, 24 Jun 2017 14:06:03 +0100
Message-ID: <20170624130602.lj4nqtxq5ip3mi7b@inc028000032.lancs.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Some parameters are not documented, or not present at all, in thermal
governors code.

Signed-off-by: Willy Wolff <willy.mh.wolff@gmail.com>
---
 drivers/thermal/fair_share.c | 1 +
 drivers/thermal/step_wise.c  | 3 +--
 drivers/thermal/user_space.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index 68bd1b569118..d3469fbc5207 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -71,6 +71,7 @@ static long get_target_state(struct thermal_zone_device *tz,
 /**
  * fair_share_throttle - throttles devices associated with the given zone
  * @tz - thermal_zone_device
+ * @trip - trip point index
  *
  * Throttling Logic: This uses three parameters to calculate the new
  * throttle state of the cooling devices associated with the given zone.
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index bcef2e7c4ec9..be95826631b7 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -186,8 +186,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 /**
  * step_wise_throttle - throttles devices associated with the given zone
  * @tz - thermal_zone_device
- * @trip - the trip point
- * @trip_type - type of the trip point
+ * @trip - trip point index
  *
  * Throttling Logic: This uses the trend of the thermal zone to throttle.
  * If the thermal zone is 'heating up' this throttles all the cooling
diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index c908150c268d..8e92a06ef48a 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -24,12 +24,13 @@
 
 #include <linux/thermal.h>
 #include <linux/slab.h>
+
 #include "thermal_core.h"
 
 /**
  * notify_user_space - Notifies user space about thermal events
  * @tz - thermal_zone_device
- * @trip - Trip point index
+ * @trip - trip point index
  *
  * This function notifies the user space through UEvents.
  */
-- 
2.11.0
