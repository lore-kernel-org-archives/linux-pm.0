From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 13/16] drivers: qcom: spm: Add 8084 L2 SPM register data
Date: Fri, 26 Jun 2015 21:02:33 -0600
Message-ID: <1435374156-19214-14-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34516 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbbF0DDE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:03:04 -0400
Received: by pdbep18 with SMTP id ep18so63071878pdb.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:03:03 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Add register data and configure L2 SAW to support voltage control and L2
idle states for QCOM APQ8084 SoC.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 .../devicetree/bindings/arm/msm/qcom,saw2.txt        |  1 +
 drivers/soc/qcom/spm.c                               | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index ad1498e..c54de31 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -90,6 +90,8 @@ static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
 	[SPM_REG_SPM_CTL]	= 0x30,
 	[SPM_REG_DLY]		= 0x34,
 	[SPM_REG_SEQ_ENTRY]	= 0x80,
+	[SPM_REG_PMIC_DATA_0]	= 0x40,
+	[SPM_REG_PMIC_DATA_1]	= 0x44,
 };
 
 /* SPM register data for 8974, 8084 */
@@ -104,6 +106,20 @@ static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
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
@@ -216,6 +232,7 @@ static int qcom_cpu_spc(int cpu)
 	struct spm_driver_data *drv = per_cpu(cpu_spm_drv, cpu);
 
 	spm_set_low_power_mode(drv, PM_SLEEP_MODE_SPC);
+
 	ret = cpu_suspend(0, qcom_pm_collapse);
 	/*
 	 * ARM common code executes WFI without calling into our driver and
@@ -344,6 +361,7 @@ static int pd_power_off(struct generic_pm_domain *domain)
 
 /* Match L2 SPM with their affinity level */
 static const struct of_device_id cache_spm_table[] = {
+	{ .compatible = "qcom,apq8084-saw2-v2.1-l2", .data = (void *)0 },
 	{ },
 };
 
@@ -417,6 +435,8 @@ static const struct of_device_id spm_match_table[] = {
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,apq8064-saw2-v1.1-cpu",
 	  .data = &spm_reg_8064_cpu },
+	{ .compatible = "qcom,apq8084-saw2-v2.1-l2",
+	  .data = &spm_reg_8084_l2 },
 	{ },
 };
 
-- 
2.1.4

