From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 10/12] thermal: bang bang: fix kernel doc entry
Date: Mon,  9 Feb 2015 17:34:11 -0400
Message-ID: <1423517653-11359-11-git-send-email-edubezval@gmail.com>
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
 drivers/thermal/gov_bang_bang.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index c5dd76b..5154929 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -74,8 +74,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 
 /**
  * bang_bang_control - controls devices associated with the given zone
- * @tz - thermal_zone_device
- * @trip - the trip point
+ * @tz: thermal_zone_device
+ * @trip: the trip point
  *
  * Regulation Logic: a two point regulation, deliver cooling state depending
  * on the previous state shown in this diagram:
@@ -98,6 +98,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
  *   * In case the fan is running, temperature must fall below
  *     (trip_temp - hyst) so that the fan gets turned off again.
  *
+ * Return: 0.
  */
 static int bang_bang_control(struct thermal_zone_device *tz, int trip)
 {
-- 
2.1.3
