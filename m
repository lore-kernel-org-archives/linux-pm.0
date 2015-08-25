From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v1 3/3] thermal: user space governor: Notification for IIO bindings
Date: Tue, 25 Aug 2015 12:58:32 -0700
Message-ID: <1440532712-5025-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1440532712-5025-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48119 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756250AbbHYT7i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Aug 2015 15:59:38 -0400
In-Reply-To: <1440532712-5025-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jic23@kernel.org, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When user space is notified during thermal_zone_device_update, when
governor is user space, also call IIO binding notification function.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/user_space.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index 10adcdd..52e2914 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -34,6 +34,7 @@
  */
 static int notify_user_space(struct thermal_zone_device *tz, int trip)
 {
+	thermal_iio_sensor_threshold_notify(tz);
 	mutex_lock(&tz->lock);
 	kobject_uevent(&tz->device.kobj, KOBJ_CHANGE);
 	mutex_unlock(&tz->lock);
-- 
2.4.3

