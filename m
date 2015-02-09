From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 11/12] thermal: step wise: fix kernel doc entry
Date: Mon,  9 Feb 2015 17:34:12 -0400
Message-ID: <1423517653-11359-12-git-send-email-edubezval@gmail.com>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Update kernel doc entry and correct the format. Now
kernel doc does not complain about it.

In this change we reuse the comment that explain the
algorithm as a kernel doc entry. However, blank lines
are added, otherwise it will appear in a single paragraph
in the kernel doc output.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/step_wise.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index fdd1f52..413ee30 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -27,22 +27,34 @@
 
 #include "thermal_core.h"
 
-/*
- * If the temperature is higher than a trip point,
+/**
+ * DOC: Algorithm
+ *
+ * If the temperature is higher than a trip point:
+ *
  *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
  *       state for this trip point
+ *
  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
  *       state for this trip point
+ *
  *    c. if the trend is THERMAL_TREND_RAISE_FULL, use upper limit
  *       for this trip point
+ *
  *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
  *       for this trip point
+ *
+ *
  * If the temperature is lower than a trip point,
+ *
  *    a. if the trend is THERMAL_TREND_RAISING, do nothing
+ *
  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
  *       state for this trip point, if the cooling state already
  *       equals lower limit, deactivate the thermal instance
+ *
  *    c. if the trend is THERMAL_TREND_RAISE_FULL, do nothing
+ *
  *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit,
  *       if the cooling state already equals lower limit,
  *       deactive the thermal instance
@@ -169,16 +181,17 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 }
 
 /**
- * step_wise_throttle - throttles devices asscciated with the given zone
- * @tz - thermal_zone_device
- * @trip - the trip point
- * @trip_type - type of the trip point
+ * step_wise_throttle - throttles devices associated with the given zone
+ * @tz: thermal_zone_device
+ * @trip: the trip point
  *
  * Throttling Logic: This uses the trend of the thermal zone to throttle.
  * If the thermal zone is 'heating up' this throttles all the cooling
  * devices associated with the zone and its particular trip point, by one
  * step. If the zone is 'cooling down' it brings back the performance of
  * the devices by one step.
+ *
+ * Return: 0.
  */
 static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 {
-- 
2.1.3
