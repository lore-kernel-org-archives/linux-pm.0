From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 06/16] thermal: inline only once used function
Date: Wed, 20 May 2015 15:20:36 +0200
Message-ID: <1432128046-12921-7-git-send-email-s.hauer@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Zhang Rui <rui.zhang@intel.com>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Inline update_temperature into its only caller to make the code
more readable.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/thermal/thermal_core.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e204deb..19da022 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -450,9 +450,12 @@ exit:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
-static void update_temperature(struct thermal_zone_device *tz)
+void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
-	int temp, ret;
+	int temp, ret, count;
+
+	if (!tz->ops->get_temp)
+		return;
 
 	ret = thermal_zone_get_temp(tz, &temp);
 	if (ret) {
@@ -471,16 +474,6 @@ static void update_temperature(struct thermal_zone_device *tz)
 	trace_thermal_temperature(tz);
 	dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
 				tz->last_temperature, tz->temperature);
-}
-
-void thermal_zone_device_update(struct thermal_zone_device *tz)
-{
-	int count;
-
-	if (!tz->ops->get_temp)
-		return;
-
-	update_temperature(tz);
 
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
-- 
2.1.4
