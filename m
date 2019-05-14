From: Wei Wang <wvw@google.com>
Subject: [PATCH] thermal: make thermal_cooling_device_register accepts const string
Date: Tue, 14 May 2019 10:33:03 -0700
Message-ID: <20190514173304.213692-1-wvw@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>, Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Change the argument similarly to thermal_zone_device_register. This will
help register names get from of_property_read_string during probe.

Signed-off-by: Wei Wang <wvw@google.com>
---
 Documentation/thermal/sysfs-api.txt |  7 ++++---
 drivers/thermal/thermal_core.c      |  6 +++---
 include/linux/thermal.h             | 12 ++++++------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index c3fa500df92c..0c26c05197ad 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -31,7 +31,7 @@ temperature) and throttle appropriate devices.
 1. thermal sysfs driver interface functions
 
 1.1 thermal zone device interface
-1.1.1 struct thermal_zone_device *thermal_zone_device_register(char *type,
+1.1.1 struct thermal_zone_device *thermal_zone_device_register(const char *type,
 		int trips, int mask, void *devdata,
 		struct thermal_zone_device_ops *ops,
 		const struct thermal_zone_params *tzp,
@@ -160,8 +160,9 @@ temperature) and throttle appropriate devices.
 	drivers for temperature calculations.
 
 1.2 thermal cooling device interface
-1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(char *name,
-		void *devdata, struct thermal_cooling_device_ops *)
+1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(
+		const char *name, void *devdata,
+		struct thermal_cooling_device_ops *ops)
 
     This interface function adds a new thermal cooling device (fan/processor/...)
     to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..b708b66fef94 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -941,7 +941,7 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
  */
 static struct thermal_cooling_device *
 __thermal_cooling_device_register(struct device_node *np,
-				  char *type, void *devdata,
+				  const char *type, void *devdata,
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
@@ -1015,7 +1015,7 @@ __thermal_cooling_device_register(struct device_node *np,
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-thermal_cooling_device_register(char *type, void *devdata,
+thermal_cooling_device_register(const char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
 	return __thermal_cooling_device_register(NULL, type, devdata, ops);
@@ -1039,7 +1039,7 @@ EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
  */
 struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np,
-				   char *type, void *devdata,
+				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
 	return __thermal_cooling_device_register(np, type, devdata, ops);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f46c2f..0f58fffee9a8 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -442,10 +442,10 @@ void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
 void thermal_zone_set_trips(struct thermal_zone_device *);
 
-struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
-		const struct thermal_cooling_device_ops *);
+struct thermal_cooling_device *thermal_cooling_device_register(const char *,
+		void *, const struct thermal_cooling_device_ops *);
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, char *, void *,
+thermal_of_cooling_device_register(struct device_node *np, const char *, void *,
 				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
@@ -496,12 +496,12 @@ static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 static inline void thermal_zone_set_trips(struct thermal_zone_device *tz)
 { }
 static inline struct thermal_cooling_device *
-thermal_cooling_device_register(char *type, void *devdata,
+thermal_cooling_device_register(const char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-	char *type, void *devdata, const struct thermal_cooling_device_ops *ops)
+thermal_of_cooling_device_register(struct device_node *np, const char *type,
+	void *devdata, const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 static inline void thermal_cooling_device_unregister(
 	struct thermal_cooling_device *cdev)
-- 
2.21.0.1020.gf2820cf01a-goog
