From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 08/13] thermal/drivers/hisi: Fix configuration register setting
Date: Wed, 30 Aug 2017 10:47:32 +0200
Message-ID: <1504082857-21702-8-git-send-email-daniel.lezcano@linaro.org>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:38384 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdH3Is5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2017 04:48:57 -0400
Received: by mail-wr0-f169.google.com with SMTP id 40so15984604wrv.5
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2017 01:48:56 -0700 (PDT)
In-Reply-To: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, open list <linux-kernel@vger.kernel.org>

The TEMP0_CFG configuration register contains different field to set up the
temperature controller. However in the code, nothing prevents a setup to
overwrite the previous one: eg. writing the hdak value overwrites the sensor
selection, the sensor selection overwrites the hdak value.

In order to prevent such thing, use a regmap-like mechanism by reading the
value before, set the corresponding bits and write the result.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index d77a938..3e03908 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -132,19 +132,39 @@ static inline void hisi_thermal_enable(void __iomem *addr, int value)
 	writel(value, addr + TEMP0_EN);
 }
 
-static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
+static inline int hisi_thermal_get_temperature(void __iomem *addr)
 {
-	writel((sensor << 12), addr + TEMP0_CFG);
+	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
 }
 
-static inline int hisi_thermal_get_temperature(void __iomem *addr)
+/*
+ * Temperature configuration register - Sensor selection
+ *
+ * Bits [19:12]
+ *
+ * 0x0: local sensor (default)
+ * 0x1: remote sensor 1 (ACPU cluster 1)
+ * 0x2: remote sensor 2 (ACPU cluster 0)
+ * 0x3: remote sensor 3 (G3D)
+ */
+static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
 {
-	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
+	writel(readl(addr + TEMP0_CFG) | (sensor << 12), addr + TEMP0_CFG);
 }
 
+/*
+ * Temperature configuration register - Hdak conversion polling interval
+ *
+ * Bits [5:4]
+ *
+ * 0x0 :   0.768 ms
+ * 0x1 :   6.144 ms
+ * 0x2 :  49.152 ms
+ * 0x3 : 393.216 ms
+ */
 static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
 {
-	writel(value, addr + TEMP0_CFG);
+	writel(readl(addr + TEMP0_CFG) | (value << 4), addr + TEMP0_CFG);
 }
 
 static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
-- 
2.7.4
