From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2 08/13] thermal/drivers/hisi: Fix configuration register setting
Date: Mon,  4 Sep 2017 21:56:07 +0200
Message-ID: <1504554972-2624-8-git-send-email-daniel.lezcano@linaro.org>
References: <1504554972-2624-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33588 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbdIDT5p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Sep 2017 15:57:45 -0400
Received: by mail-wm0-f45.google.com with SMTP id f145so6663904wme.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Sep 2017 12:57:44 -0700 (PDT)
In-Reply-To: <1504554972-2624-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org

The TEMP0_CFG configuration register contains different field to set up the
temperature controller. However in the code, nothing prevents a setup to
overwrite the previous one: eg. writing the hdak value overwrites the sensor
selection, the sensor selection overwrites the hdak value.

In order to prevent such thing, use a regmap-like mechanism by reading the
value before, set the corresponding bits and write the result.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 7747b96..10ef6bc 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -30,6 +30,8 @@
 #define TEMP0_TH			(0x4)
 #define TEMP0_RST_TH			(0x8)
 #define TEMP0_CFG			(0xC)
+#define TEMP0_CFG_SS_MSK		(0xF000)
+#define TEMP0_CFG_HDAK_MSK		(0x30)
 #define TEMP0_EN			(0x10)
 #define TEMP0_INT_EN			(0x14)
 #define TEMP0_INT_CLR			(0x18)
@@ -132,19 +134,41 @@ static inline void hisi_thermal_enable(void __iomem *addr, int value)
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
+	writel((readl(addr + TEMP0_CFG) & ~TEMP0_CFG_SS_MSK ) |
+	       (sensor << 12), addr + TEMP0_CFG);
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
+	writel((readl(addr + TEMP0_CFG) & ~TEMP0_CFG_HDAK_MSK) |
+	       (value << 4), addr + TEMP0_CFG);
 }
 
 static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
-- 
2.7.4
