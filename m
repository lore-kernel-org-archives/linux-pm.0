From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH 4/5] thermal/drivers/hisi: Fix configuration register setting
Date: Mon,  3 Dec 2018 11:31:06 -0200
Message-ID: <20181203133107.4002-5-rafael.tinoco@linaro.org>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203133107.4002-1-rafael.tinoco@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sashal@kernel.org
Cc: rafael.tinoco@linaro.org, gregkh@linuxfoundation.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

patch b424315a287c70eeb5f920f84c92492bd2f5658e upstream.

The TEMP0_CFG configuration register contains different field to set up the
temperature controller. However in the code, nothing prevents a setup to
overwrite the previous one: eg. writing the hdak value overwrites the sensor
selection, the sensor selection overwrites the hdak value.

In order to prevent such thing, use a regmap-like mechanism by reading the
value before, set the corresponding bits and write the result.

Link: https://bugs.linaro.org/show_bug.cgi?id=4053 (PATCH 4/5)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit b424315a287c70eeb5f920f84c92492bd2f5658e)
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index a803043f37ae..31b52ebf426f 100644
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
+	writel((readl(addr + TEMP0_CFG) & ~TEMP0_CFG_SS_MSK) |
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
2.20.0.rc1
