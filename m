From: Pi-Hsun Shih <pihsun@chromium.org>
Subject: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
Date: Wed,  9 Jan 2019 13:57:24 +0800
Message-ID: <20190109055724.184692-1-pihsun@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Pi-Hsun Shih <pihsun@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "moderated list:ARM/Mediatek SoC
        support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
        support" <linux-mediatek@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
but the allocation only allocates sizeof(struct mtk_thermal) bytes,
which cause out of bound access with the ->banks[] member. Change it to
a fixed size array instead.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/thermal/mtk_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0691f260f6eabe..ea11edb3fcced6 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -159,6 +159,9 @@
 #define MT7622_NUM_SENSORS_PER_ZONE	1
 #define MT7622_TS1	0
 
+/* The maximum number of banks */
+#define MAX_NUM_ZONES		8
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -178,7 +181,7 @@ struct mtk_thermal_data {
 	const int *sensor_mux_values;
 	const int *msr;
 	const int *adcpnp;
-	struct thermal_bank_cfg bank_data[];
+	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 };
 
 struct mtk_thermal {
@@ -197,7 +200,7 @@ struct mtk_thermal {
 	s32 vts[MT8173_NUM_SENSORS];
 
 	const struct mtk_thermal_data *conf;
-	struct mtk_thermal_bank banks[];
+	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
 };
 
 /* MT8173 thermal sensor data */
-- 
2.20.1.97.g81188d93c3-goog
