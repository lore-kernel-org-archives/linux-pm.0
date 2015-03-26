From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 09/13] thermal: of: always set sensor related callbacks
Date: Thu, 26 Mar 2015 16:53:56 +0100
Message-ID: <1427385240-6086-10-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Stephen Warren <swarren@wwwdotorg.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Now that the thermal core treats -ENOSYS like the callbacks were
not present at all we no longer have to overwrite the ops during
runtime but instead can always set them and return -ENOSYS if no
sensor is registered.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/of-thermal.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index b39e22f..df14fdd 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -91,7 +91,7 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
 {
 	struct __thermal_zone *data = tz->devdata;
 
-	if (!data->ops->get_temp)
+	if (!data->ops)
 		return -EINVAL;
 
 	return data->ops->get_temp(data->sensor_data, temp);
@@ -178,7 +178,7 @@ static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
 	struct __thermal_zone *data = tz->devdata;
 
 	if (!data->ops || !data->ops->set_emul_temp)
-		return -EINVAL;
+		return -ENOSYS;
 
 	return data->ops->set_emul_temp(data->sensor_data, temp);
 }
@@ -189,8 +189,8 @@ static int of_thermal_get_trend(struct thermal_zone_device *tz, int trip,
 	struct __thermal_zone *data = tz->devdata;
 	int r;
 
-	if (!data->ops->get_trend)
-		return -EINVAL;
+	if (!data->ops || !data->ops->get_trend)
+		return -ENOSYS;
 
 	r = data->ops->get_trend(data->sensor_data, trip, trend);
 	if (r)
@@ -366,6 +366,10 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 }
 
 static struct thermal_zone_device_ops of_thermal_ops = {
+	.get_temp = of_thermal_get_temp,
+	.get_trend = of_thermal_get_trend,
+	.set_emul_temp = of_thermal_set_emul_temp,
+
 	.get_mode = of_thermal_get_mode,
 	.set_mode = of_thermal_set_mode,
 
@@ -399,13 +403,13 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	if (!ops)
 		return ERR_PTR(-EINVAL);
 
+	if (!ops->get_temp)
+		return ERR_PTR(-EINVAL);
+
 	mutex_lock(&tzd->lock);
 	tz->ops = ops;
 	tz->sensor_data = data;
 
-	tzd->ops->get_temp = of_thermal_get_temp;
-	tzd->ops->get_trend = of_thermal_get_trend;
-	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
 	mutex_unlock(&tzd->lock);
 
 	return tzd;
-- 
2.1.4
