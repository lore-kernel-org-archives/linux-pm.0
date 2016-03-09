From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 4/6] thermal: doc: Add details of devm_thermal_zone_of_sensor_{register,unregister}
Date: Wed, 9 Mar 2016 18:40:08 +0530
Message-ID: <1457529010-6538-5-git-send-email-ldewangan@nvidia.com>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457529010-6538-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add details of the interface devm_thermal_zone_of_sensor_register()
and devm_thermal_zone_of_sensor_unregister() in the
<thermal/sysfs-api.txt>.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

---
Changes from V1:
- New in series.

 Documentation/thermal/sysfs-api.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 18a3a5e..ed419d6 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -117,6 +117,29 @@ temperature) and throttle appropriate devices.
 	interface. It will also silent the zone by remove the .get_temp() and
 	get_trend() thermal zone device callbacks.
 
+1.1.5 struct thermal_zone_device *devm_thermal_zone_of_sensor_register(
+		struct device *dev, int sensor_id,
+		void *data, const struct thermal_zone_of_device_ops *ops)
+
+	This interface is resource managed version of
+	thermal_zone_of_sensor_register().
+	All details of thermal_zone_of_sensor_register() described in
+	section 1.1.3 is applicable here.
+	The benefit of using this interface to register sensor is that it
+	is not require to explicitly call thermal_zone_of_sensor_unregister()
+	in error path or during driver unbinding as this is done by driver
+	resource manager.
+
+1.1.6 void devm_thermal_zone_of_sensor_unregister(struct device *dev,
+		struct thermal_zone_device *tzd)
+
+	This interface is resource managed version of
+	thermal_zone_of_sensor_unregister().
+	All details of thermal_zone_of_sensor_unregister() described in
+	section 1.1.4 is applicable here.
+	Normally this function will not need to be called and the resource
+	management code will ensure that the resource is freed.
+
 1.2 thermal cooling device interface
 1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(char *name,
 		void *devdata, struct thermal_cooling_device_ops *)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
