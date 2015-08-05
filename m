From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 02/10] drivers: qcom: spm: Add 8084 L2 SPM register data
Date: Wed,  5 Aug 2015 10:32:38 -0600
Message-ID: <1438792366-2737-3-git-send-email-lina.iyer@linaro.org>
References: <438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438792366-2737-1-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: msivasub@codeaurora.org, robh@kernel.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, agross@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Add register data and configure L2 SAW to support voltage control and L2
idle states for QCOM APQ8084 SoC.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 .../devicetree/bindings/arm/msm/qcom,saw2.txt         |  1 +
 drivers/soc/qcom/spm.c                                | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index ae4afc6..91430ff 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -27,6 +27,7 @@ PROPERTIES
 			"qcom,apq8064-saw2-v1.1-cpu"
 			"qcom,msm8974-saw2-v2.1-cpu"
 			"qcom,apq8084-saw2-v2.1-cpu"
+			"qcom,apq8084-saw2-v2.1-l2"
 
 - reg:
 	Usage: required
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 9f5edaa27..efbf5e5 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -78,6 +78,8 @@ static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
 	[SPM_REG_SPM_CTL]	= 0x30,
 	[SPM_REG_DLY]		= 0x34,
 	[SPM_REG_SEQ_ENTRY]	= 0x80,
+	[SPM_REG_PMIC_DATA_0]	= 0x40,
+	[SPM_REG_PMIC_DATA_1]	= 0x44,
 };
 
 /* SPM register data for 8974, 8084 */
@@ -92,6 +94,20 @@ static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
 	.start_index[PM_SLEEP_MODE_SPC] = 3,
 };
 
+static const struct spm_reg_data spm_reg_8084_l2  = {
+	.reg_offset = spm_reg_offset_v2_1,
+	.spm_cfg = 0x14,
+	.spm_dly = 0x3C102800,
+	.pmic_data[0] = 0x02030080,
+	.pmic_data[1] = 0x00030000,
+	.seq = { 0x1F, 0x00, 0x20, 0x03, 0x22, 0x00, 0x0F, 0x00, 0x10, 0x22,
+		0x12, 0x32, 0x60, 0x70, 0x80, 0xB0, 0x11, 0x42, 0x03, 0x01,
+		0xB0, 0x78, 0x80, 0x12, 0x22, 0x44, 0x50, 0x3B, 0x60, 0x02,
+		0x32, 0x50, 0x0F },
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 7,
+};
+
 static const u8 spm_reg_offset_v1_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
 	[SPM_REG_SPM_CTL]	= 0x20,
@@ -186,6 +202,7 @@ static int qcom_cpu_spc(int cpu)
 	struct spm_driver_data *drv = per_cpu(cpu_spm_drv, cpu);
 
 	spm_set_low_power_mode(drv, PM_SLEEP_MODE_SPC);
+
 	ret = cpu_suspend(0, qcom_pm_collapse);
 	/*
 	 * ARM common code executes WFI without calling into our driver and
@@ -327,6 +344,8 @@ static const struct of_device_id spm_match_table[] = {
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,apq8064-saw2-v1.1-cpu",
 	  .data = &spm_reg_8064_cpu },
+	{ .compatible = "qcom,apq8084-saw2-v2.1-l2",
+	  .data = &spm_reg_8084_l2 },
 	{ },
 };
 
-- 
2.1.4
