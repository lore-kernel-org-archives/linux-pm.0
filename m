From: <michael.kao@mediatek.com>
Subject: [PATCH 5/7] thermal: mediatek: add flag for bank selection
Date: Fri, 1 Feb 2019 15:38:11 +0800
Message-ID: <1549006693-11659-6-git-send-email-michael.kao@mediatek.com>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =Zhang Rui <rui.zhang@intel.com>, =Eduardo Valentin <edubezval@gmail.com>, =Daniel Lezcano <daniel.lezcano@linaro.org>, =Rob Herring <robh+dt@kernel.org>, =Mark Rutland <mark.rutland@arm.com>, =Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Michael Kao <michael.kao@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

For past ic designs, the thermal controller should select banks before
reading the thermal sensor.
And the new ic design architecture removes this mechanism.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index e5cf3f4..3e97638 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -213,6 +213,7 @@ struct mtk_thermal_data {
 	const int cali_val;
 	const int num_controller;
 	const int *controller_offset;
+	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[];
 };
 
@@ -327,6 +328,7 @@ struct mtk_thermal {
 	.cali_val = MT8173_CALIBRATION,
 	.num_controller = MT8173_NUM_CONTROLLER,
 	.controller_offset = mt8173_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 2,
@@ -365,6 +367,7 @@ struct mtk_thermal {
 	.cali_val = MT2701_CALIBRATION,
 	.num_controller = MT2701_NUM_CONTROLLER,
 	.controller_offset = mt2701_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 3,
@@ -394,6 +397,7 @@ struct mtk_thermal {
 	.cali_val = MT2712_CALIBRATION,
 	.num_controller = MT2712_NUM_CONTROLLER,
 	.controller_offset = mt2712_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 4,
@@ -417,6 +421,7 @@ struct mtk_thermal {
 	.cali_val = MT7622_CALIBRATION,
 	.num_controller = MT7622_NUM_CONTROLLER,
 	.controller_offset = mt7622_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 1,
@@ -463,12 +468,14 @@ static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
 	struct mtk_thermal *mt = bank->mt;
 	u32 val;
 
-	mutex_lock(&mt->lock);
+	if (mt->conf->need_switch_bank) {
+		mutex_lock(&mt->lock);
 
-	val = readl(mt->thermal_base + PTPCORESEL);
-	val &= ~0xf;
-	val |= bank->id;
-	writel(val, mt->thermal_base + PTPCORESEL);
+		val = readl(mt->thermal_base + PTPCORESEL);
+		val &= ~0xf;
+		val |= bank->id;
+		writel(val, mt->thermal_base + PTPCORESEL);
+	}
 }
 
 /**
@@ -481,7 +488,8 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
 {
 	struct mtk_thermal *mt = bank->mt;
 
-	mutex_unlock(&mt->lock);
+	if (mt->conf->need_switch_bank)
+		mutex_unlock(&mt->lock);
 }
 
 /**
-- 
1.9.1
