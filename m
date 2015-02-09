From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 08/12] thermal: fair share: fix kernel doc entry
Date: Mon,  9 Feb 2015 17:34:09 -0400
Message-ID: <1423517653-11359-9-git-send-email-edubezval@gmail.com>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Update kernel doc entry and correct the format. Now
kernel doc does not complain about it.

Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/fair_share.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index 6e0a3fb..a15ef0b 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -70,7 +70,8 @@ static long get_target_state(struct thermal_zone_device *tz,
 
 /**
  * fair_share_throttle - throttles devices asscciated with the given zone
- * @tz - thermal_zone_device
+ * @tz: thermal_zone_device
+ * @trip: the trip point
  *
  * Throttling Logic: This uses three parameters to calculate the new
  * throttle state of the cooling devices associated with the given zone.
@@ -85,6 +86,8 @@ static long get_target_state(struct thermal_zone_device *tz,
  *	whereas the throttling is at full swing if we trip critical levels.
  *	(Heavily assumes the trip points are in ascending order)
  * new_state of cooling device = P3 * P2 * P1
+ *
+ * Return: 0.
  */
 static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 {
-- 
2.1.3
