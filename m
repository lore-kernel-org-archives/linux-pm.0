From: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH] Fix multiple definition error under lto
Date: Sat, 26 Nov 2016 17:25:28 -0500
Message-ID: <20161126222528.15261-1-pefoley2@pefoley.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35343 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbcKZWZe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2016 17:25:34 -0500
Received: by mail-qt0-f172.google.com with SMTP id c47so92634984qtc.2
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2016 14:25:33 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: Peter Foley <pefoley2@pefoley.com>

drivers/thermal/built-in.o: In function `type_show.lto_priv.33':
(.text+0x3d80): multiple definition of `type_show.lto_priv.33'
drivers/base/built-in.o:(.text+0x2a40): first defined here

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 drivers/thermal/thermal_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 226b0b4aced6..23ec1dd2ff3b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -643,7 +643,7 @@ static void thermal_zone_device_check(struct work_struct *work)
 	container_of(_dev, struct thermal_zone_device, device)
 
 static ssize_t
-type_show(struct device *dev, struct device_attribute *attr, char *buf)
+thermal_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 
@@ -1159,7 +1159,7 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static DEVICE_ATTR(type, 0444, type_show, NULL);
+static DEVICE_ATTR(type, 0444, thermal_type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
 static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
-- 
2.11.0.rc2

