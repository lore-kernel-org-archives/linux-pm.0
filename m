From: Rocky Hao <rocky.hao@rock-chips.com>
Subject: [PATCH 2/5] thermal: rockchip: Support the RV1108 SoC in thermal
 driver
Date: Thu, 24 Aug 2017 18:27:52 +0800
Message-ID: <1503570475-7850-3-git-send-email-rocky.hao@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, cl@rock-chips.com, william.wu@rock-chips.com, rocky.hao@rock-chips.com, jay.xu@rock-chips.com, xxx@rock-chips.com, linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com
List-Id: linux-pm@vger.kernel.org

RV1108 SOC has one Temperature Sensor for CPU.

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
 drivers/thermal/rockchip_thermal.c | 67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 9da3e1819210..299a8ade71fa 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -242,6 +242,45 @@ struct tsadc_table {
 	int temp;
 };
 
+static const struct tsadc_table rv1108_table[] = {
+	{0, -40000},
+	{374, -40000},
+	{382, -35000},
+	{389, -30000},
+	{397, -25000},
+	{405, -20000},
+	{413, -15000},
+	{421, -10000},
+	{429, -5000},
+	{436, 0},
+	{444, 5000},
+	{452, 10000},
+	{460, 15000},
+	{468, 20000},
+	{476, 25000},
+	{483, 30000},
+	{491, 35000},
+	{499, 40000},
+	{507, 45000},
+	{515, 50000},
+	{523, 55000},
+	{531, 60000},
+	{539, 65000},
+	{547, 70000},
+	{555, 75000},
+	{562, 80000},
+	{570, 85000},
+	{578, 90000},
+	{586, 95000},
+	{594, 100000},
+	{602, 105000},
+	{610, 110000},
+	{618, 115000},
+	{626, 120000},
+	{634, 125000},
+	{TSADCV2_DATA_MASK, 125000},
+};
+
 static const struct tsadc_table rk3228_code_table[] = {
 	{0, -40000},
 	{588, -40000},
@@ -779,6 +818,30 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	writel_relaxed(val, regs + TSADCV2_INT_EN);
 }
 
+static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
+	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
+	.chn_num = 1, /* one channel for tsadc */
+
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+
+	.initialize = rk_tsadcv2_initialize,
+	.irq_ack = rk_tsadcv3_irq_ack,
+	.control = rk_tsadcv3_control,
+	.get_temp = rk_tsadcv2_get_temp,
+	.set_alarm_temp = rk_tsadcv2_alarm_temp,
+	.set_tshut_temp = rk_tsadcv2_tshut_temp,
+	.set_tshut_mode = rk_tsadcv2_tshut_mode,
+
+	.table = {
+		.id = rv1108_table,
+		.length = ARRAY_SIZE(rv1108_table),
+		.data_mask = TSADCV2_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
 	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
 	.chn_num = 1, /* one channel for tsadc */
@@ -928,6 +991,10 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 
 static const struct of_device_id of_rockchip_thermal_match[] = {
 	{
+		.compatible = "rockchip,rv1108-tsadc",
+		.data = (void *)&rv1108_tsadc_data,
+	},
+	{
 		.compatible = "rockchip,rk3228-tsadc",
 		.data = (void *)&rk3228_tsadc_data,
 	},
-- 
1.9.1
