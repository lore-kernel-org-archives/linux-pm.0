From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH] thermal: mtk_thermal: Staticise a number of data variables
Date: Wed, 28 Dec 2016 14:16:45 +0530
Message-ID: <1482914805-21950-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, matthias.bgg@gmail.com, edubezval@gmail.com, dawei.chien@mediatek.com
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sparse throws following warnings:
drivers/thermal/mtk_thermal.c:186:11: warning: symbol 'mt8173_bank_data' was not declared. Should it be static?
drivers/thermal/mtk_thermal.c:193:11: warning: symbol 'mt8173_msr' was not declared. Should it be static?
drivers/thermal/mtk_thermal.c:197:11: warning: symbol 'mt8173_adcpnp' was not declared. Should it be static?
drivers/thermal/mtk_thermal.c:201:11: warning: symbol 'mt8173_mux_values' was not declared. Should it be static?
drivers/thermal/mtk_thermal.c:204:11: warning: symbol 'mt2701_bank_data' was not declared. Should it be static?
drivers/thermal/mtk_thermal.c:208:11: warning: symbol 'mt2701_msr' was not declared. Should it be static?
drivers/thermal/mtk_thermal.c:212:11: warning: symbol 'mt2701_adcpnp' was not declared. Should it be static?
drivers/thermal/mtk_thermal.c:216:11: warning: symbol 'mt2701_mux_values' was not declared. Should it be static?

Make these variables as static to fix these warnings.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

Based on Torvald's master branch. Build tested.

 drivers/thermal/mtk_thermal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 34169c32d495..1aff7fde54b1 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -183,37 +183,37 @@ struct mtk_thermal {
 };
 
 /* MT8173 thermal sensor data */
-const int mt8173_bank_data[MT8173_NUM_ZONES][3] = {
+static const int mt8173_bank_data[MT8173_NUM_ZONES][3] = {
 	{ MT8173_TS2, MT8173_TS3 },
 	{ MT8173_TS2, MT8173_TS4 },
 	{ MT8173_TS1, MT8173_TS2, MT8173_TSABB },
 	{ MT8173_TS2 },
 };
 
-const int mt8173_msr[MT8173_NUM_SENSORS_PER_ZONE] = {
+static const int mt8173_msr[MT8173_NUM_SENSORS_PER_ZONE] = {
 	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2, TEMP_MSR2
 };
 
-const int mt8173_adcpnp[MT8173_NUM_SENSORS_PER_ZONE] = {
+static const int mt8173_adcpnp[MT8173_NUM_SENSORS_PER_ZONE] = {
 	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2, TEMP_ADCPNP3
 };
 
-const int mt8173_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
+static const int mt8173_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
 
 /* MT2701 thermal sensor data */
-const int mt2701_bank_data[MT2701_NUM_SENSORS] = {
+static const int mt2701_bank_data[MT2701_NUM_SENSORS] = {
 	MT2701_TS1, MT2701_TS2, MT2701_TSABB
 };
 
-const int mt2701_msr[MT2701_NUM_SENSORS_PER_ZONE] = {
+static const int mt2701_msr[MT2701_NUM_SENSORS_PER_ZONE] = {
 	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2
 };
 
-const int mt2701_adcpnp[MT2701_NUM_SENSORS_PER_ZONE] = {
+static const int mt2701_adcpnp[MT2701_NUM_SENSORS_PER_ZONE] = {
 	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2
 };
 
-const int mt2701_mux_values[MT2701_NUM_SENSORS] = { 0, 1, 16 };
+static const int mt2701_mux_values[MT2701_NUM_SENSORS] = { 0, 1, 16 };
 
 /**
  * The MT8173 thermal controller has four banks. Each bank can read up to
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
