From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 21/40] thermal: core: match parenthesis on code alignment
Date: Mon, 30 May 2016 14:27:40 -0700
Message-ID: <1464643679-2733-22-git-send-email-edubezval@gmail.com>
References: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Cosmetic change in the sysfs handling functions, as
recommended by checkpatch.pl.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 98aa7d5..f22fd7e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -840,7 +840,7 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 
 static ssize_t
 trip_point_temp_store(struct device *dev, struct device_attribute *attr,
-		     const char *buf, size_t count)
+		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int trip, ret;
@@ -888,7 +888,7 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 
 static ssize_t
 trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int trip, ret;
@@ -915,7 +915,7 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 
 static ssize_t
 trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
-			char *buf)
+		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int trip, ret;
@@ -934,7 +934,7 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 
 static ssize_t
 passive_store(struct device *dev, struct device_attribute *attr,
-		    const char *buf, size_t count)
+	      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int state;
@@ -968,7 +968,7 @@ passive_store(struct device *dev, struct device_attribute *attr,
 
 static ssize_t
 passive_show(struct device *dev, struct device_attribute *attr,
-		   char *buf)
+	     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 
@@ -977,7 +977,7 @@ passive_show(struct device *dev, struct device_attribute *attr,
 
 static ssize_t
 policy_store(struct device *dev, struct device_attribute *attr,
-		    const char *buf, size_t count)
+	     const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	char name[THERMAL_NAME_LENGTH];
@@ -1009,7 +1009,7 @@ available_policies_show(struct device *dev, struct device_attribute *devattr,
 
 static ssize_t
 emul_temp_store(struct device *dev, struct device_attribute *attr,
-		     const char *buf, size_t count)
+		const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int ret = 0;
-- 
2.1.4
