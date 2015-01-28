From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/4] Thermal/int340x/int3403: Support for thermistor and IR sensor
Date: Wed, 28 Jan 2015 11:56:49 -0800
Message-ID: <1422475009-20759-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1422475009-20759-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1505 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932698AbbA1U0X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Jan 2015 15:26:23 -0500
In-Reply-To: <1422475009-20759-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added two more sensor types: Thermistor and IR sensor. Each of these
sensors have unique ptyp value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int3403_thermal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3403_thermal.c b/drivers/thermal/int340x_thermal/int3403_thermal.c
index 50a7a08..2b5b140 100644
--- a/drivers/thermal/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3403_thermal.c
@@ -24,6 +24,9 @@
 #define INT3403_TYPE_SENSOR		0x03
 #define INT3403_TYPE_CHARGER		0x0B
 #define INT3403_TYPE_BATTERY		0x0C
+#define INT3403_TYPE_SENSOR_THERMISTOR	0x12
+#define INT3403_TYPE_SENSOR_IR		0x13
+
 #define INT3403_PERF_CHANGED_EVENT	0x80
 #define INT3403_THERMAL_EVENT		0x90
 
@@ -238,6 +241,8 @@ static int int3403_add(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 	switch (priv->type) {
 	case INT3403_TYPE_SENSOR:
+	case INT3403_TYPE_SENSOR_THERMISTOR:
+	case INT3403_TYPE_SENSOR_IR:
 		result = int3403_sensor_add(priv);
 		break;
 	case INT3403_TYPE_CHARGER:
@@ -262,6 +267,8 @@ static int int3403_remove(struct platform_device *pdev)
 
 	switch (priv->type) {
 	case INT3403_TYPE_SENSOR:
+	case INT3403_TYPE_SENSOR_THERMISTOR:
+	case INT3403_TYPE_SENSOR_IR:
 		int3403_sensor_remove(priv);
 		break;
 	case INT3403_TYPE_CHARGER:
-- 
1.9.3

