From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 04/34] Thermal: Add platform level information to thermal.h
Date: Sun,  2 Dec 2012 22:44:38 +0800
Message-ID: <1354459508-3707-4-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33009 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2LBOpe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:34 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch adds platform level information to thermal.h
by introducing two structures to hold:
 * bind parameters for a thermal zone,
 * zone level platform parameters

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/thermal.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 32af124..4caa32e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -157,6 +157,7 @@ struct thermal_zone_device {
 	int passive;
 	unsigned int forced_passive;
 	const struct thermal_zone_device_ops *ops;
+	const struct thermal_zone_params *tzp;
 	struct list_head thermal_instances;
 	struct idr idr;
 	struct mutex lock; /* protect thermal_instances list */
@@ -164,6 +165,34 @@ struct thermal_zone_device {
 	struct delayed_work poll_queue;
 };
 
+/* Structure that holds binding parameters for a zone */
+struct thermal_bind_params {
+	struct thermal_cooling_device *cdev;
+
+	/*
+	 * This is a measure of 'how effectively these devices can
+	 * cool 'this' thermal zone. The shall be determined by platform
+	 * characterization. This is on a 'percentage' scale.
+	 * See Documentation/thermal/sysfs-api.txt for more information.
+	 */
+	int weight;
+
+	/*
+	 * This is a bit mask that gives the binding relation between this
+	 * thermal zone and cdev, for a particular trip point.
+	 * See Documentation/thermal/sysfs-api.txt for more information.
+	 */
+	int trip_mask;
+	int (*match) (struct thermal_zone_device *tz,
+			struct thermal_cooling_device *cdev);
+};
+
+/* Structure to define Thermal Zone parameters */
+struct thermal_zone_params {
+	int num_tbps;	/* Number of tbp entries */
+	struct thermal_bind_params *tbp;
+};
+
 struct thermal_genl_event {
 	u32 orig;
 	enum events event;
-- 
1.7.7.6

