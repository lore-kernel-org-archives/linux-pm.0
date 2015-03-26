From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 01/13] thermal: Make temperatures consistently unsigned long
Date: Thu, 26 Mar 2015 16:53:48 +0100
Message-ID: <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The thermal framework uses int, long and unsigned long for temperatures
in millicelsius. The majority of functions uses unsigned long, so change
the remaining functions to use this type aswell.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/thermal/thermal_core.c | 10 +++++-----
 include/linux/thermal.h        |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 174d3bc..0e4ad7c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -378,7 +378,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 
 	if (trip_type == THERMAL_TRIP_CRITICAL) {
 		dev_emerg(&tz->device,
-			  "critical temperature reached(%d C),shutting down\n",
+			  "critical temperature reached(%lu C),shutting down\n",
 			  tz->temperature / 1000);
 		orderly_poweroff(true);
 	}
@@ -453,7 +453,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
 static void update_temperature(struct thermal_zone_device *tz)
 {
-	long temp;
+	unsigned long temp;
 	int ret;
 
 	ret = thermal_zone_get_temp(tz, &temp);
@@ -469,7 +469,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 
 	trace_thermal_temperature(tz);
-	dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
+	dev_dbg(&tz->device, "last_temperature=%lu, current_temperature=%lu\n",
 				tz->last_temperature, tz->temperature);
 }
 
@@ -512,7 +512,7 @@ static ssize_t
 temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	long temperature;
+	unsigned long temperature;
 	int ret;
 
 	ret = thermal_zone_get_temp(tz, &temperature);
@@ -520,7 +520,7 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%ld\n", temperature);
+	return sprintf(buf, "%lu\n", temperature);
 }
 
 static ssize_t
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5eac316..db6c12b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -180,9 +180,9 @@ struct thermal_zone_device {
 	int trips;
 	int passive_delay;
 	int polling_delay;
-	int temperature;
-	int last_temperature;
-	int emul_temperature;
+	unsigned long temperature;
+	unsigned long last_temperature;
+	unsigned long emul_temperature;
 	int passive;
 	unsigned int forced_passive;
 	struct thermal_zone_device_ops *ops;
-- 
2.1.4
