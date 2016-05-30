From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 21/48] thermal: core: match parenthesis on code alignment
Date: Mon, 30 May 2016 15:15:57 -0700
Message-ID: <1464646584-14322-22-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34861 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423358AbcE3WRO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 18:17:14 -0400
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

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

