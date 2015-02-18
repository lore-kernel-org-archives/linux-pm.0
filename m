From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v4 1/8] thermal: Provide stub for
 thermal_of_cooling_device_register() function
Date: Wed, 18 Feb 2015 11:07:29 +0100
Message-ID: <1424254056-5904-2-git-send-email-l.majewski@samsung.com>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:35506 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbbBRKJC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 05:09:02 -0500
In-reply-to: <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Odroid U3 fan can work without being registered as OF cooling device
(with CONFIG_THERMAL_OF disabled).
In this situation it can be controlled via PWM entry at
/sys/class/hwmon/hwmon0/pwm1.

Therefore, the thermal_of_cooling_device_register() function needs a stub
to allow clean compilation.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- None
Changes for v3:
- Provide stub declaration when CONFIG_THERMAL is not set
Changes for v4:
- None
---
 include/linux/thermal.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fc52e30..eacf2de 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -293,6 +293,20 @@ struct thermal_trip {
 };
 
 /* Function declarations */
+#ifdef CONFIG_THERMAL
+struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				   char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *);
+#else
+static inline struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				   char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops)
+{
+	return NULL;
+}
+#endif
 #ifdef CONFIG_THERMAL_OF
 struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
@@ -328,9 +342,6 @@ void thermal_zone_device_update(struct thermal_zone_device *);
 
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
-struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, char *, void *,
-				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp);
-- 
2.0.0.rc2

