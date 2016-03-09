From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 1/6] thermal: doc: Add details of thermal_zone_of_sensor_{register,unregister}
Date: Wed, 9 Mar 2016 18:40:05 +0530
Message-ID: <1457529010-6538-2-git-send-email-ldewangan@nvidia.com>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add details of the interface thermal_zone_of_sensor_register() and
thermal_zone_of_sensor_unregister() in the thermal/sysfs-api.txt.

The details describes the functionality and parameter which
are passed to these interfaces.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

---
Changes from V1:
- This is new in series per review comment from V1.

 Documentation/thermal/sysfs-api.txt | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 8c745c8..18a3a5e 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -72,6 +72,51 @@ temperature) and throttle appropriate devices.
     It deletes the corresponding entry form /sys/class/thermal folder and
     unbind all the thermal cooling devices it uses.
 
+1.1.3 struct thermal_zone_device *thermal_zone_of_sensor_register(
+		struct device *dev, int sensor_id, void *data,
+		const struct thermal_zone_of_device_ops *ops)
+
+	This interface adds a new sensor to a DT thermal zone.
+	This function will search the list of thermal zones described in
+	device tree and look for the zone that refer to the sensor device
+	pointed by dev->of_node as temperature providers. For the zone
+	pointing to the sensor node, the sensor will be added to the DT
+	thermal zone device.
+
+	The parameters for this interface are:
+	dev:		Device node of sensor containing valid node pointer in
+			dev->of_node.
+	sensor_id:	a sensor identifier, in case the sensor IP has more
+			than one sensors
+	data:		a private pointer (owned by the caller) that will be
+			passed back, when a temperature reading is needed.
+	ops:		struct thermal_zone_of_device_ops *.
+
+			get_temp:	a pointer to a function that reads the
+					sensor temperature. This is mandatory
+					callback provided by sensor driver.
+			get_trend: 	a pointer to a function that reads the
+					sensor temperature trend.
+			set_emul_temp:	a pointer to a function that sets
+					sensor emulated temperature.
+	The thermal zone temperature is provided by the get_temp() function
+	pointer of thermal_zone_of_device_ops. When called, it will
+	have the private pointer @data back.
+
+	It returns error pointer if fails otherwise valid thermal zone device
+	handle. Caller should check the return handle with IS_ERR() for finding
+	whether success or not.
+
+1.1.4 void thermal_zone_of_sensor_unregister(struct device *dev,
+		struct thermal_zone_device *tzd)
+
+	This interface unregisters a sensor from a DT thermal zone which was
+	successfully added by interface thermal_zone_of_sensor_register().
+	This function removes the sensor callbacks and private data from the
+	thermal zone device registered with thermal_zone_of_sensor_register()
+	interface. It will also silent the zone by remove the .get_temp() and
+	get_trend() thermal zone device callbacks.
+
 1.2 thermal cooling device interface
 1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(char *name,
 		void *devdata, struct thermal_cooling_device_ops *)
-- 
2.1.4

