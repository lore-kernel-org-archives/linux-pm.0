From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 4/7] qcom: spm: Add 8916 SPM register data
Date: Fri, 17 Apr 2015 17:49:06 -0600
Message-ID: <1429314549-6730-5-git-send-email-lina.iyer@linaro.org>
References: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33202 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbbDQXtb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2015 19:49:31 -0400
Received: by pdbnk13 with SMTP id nk13so142840426pdb.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2015 16:49:30 -0700 (PDT)
In-Reply-To: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, Will.Deacon@arm.com, lorenzo.pieralisi@arm.com
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, mlocke@codeaurora.org, bryanh@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Add SPM register information and initialization values for QCOM 8916
SoC.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 .../devicetree/bindings/arm/msm/qcom,saw2.txt       |  1 +
 drivers/soc/qcom/spm.c                              | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index ae4afc6..986a8ea 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -27,6 +27,7 @@ PROPERTIES
 			"qcom,apq8064-saw2-v1.1-cpu"
 			"qcom,msm8974-saw2-v2.1-cpu"
 			"qcom,apq8084-saw2-v2.1-cpu"
+			"qcom,msm8916-saw2-v3.0-cpu"
 
 - reg:
 	Usage: required
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 392a714..ffb6045 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -115,6 +115,25 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
 	.start_index[PM_SLEEP_MODE_SPC] = 2,
 };
 
+static const u32 spm_reg_offset_v3_0[SPM_REG_NR] = {
+	[SPM_REG_CFG]		= 0x08,
+	[SPM_REG_SPM_CTL]	= 0x30,
+	[SPM_REG_DLY]		= 0x34,
+	[SPM_REG_SEQ_ENTRY]	= 0x400,
+};
+
+/* SPM register data for 8916 */
+static const struct spm_reg_data spm_reg_8916_cpu = {
+	.reg_offset = spm_reg_offset_v3_0,
+	.spm_cfg = 0x1,
+	.spm_dly = 0x3C102800,
+	.seq = { 0x60, 0x03, 0x60, 0x0B, 0x0F, 0x20, 0x10, 0x80, 0x30, 0x90,
+		0x5B, 0x60, 0x03, 0x60, 0x3B, 0x76, 0x76, 0x0B, 0x94, 0x5B,
+		0x80, 0x10, 0x26, 0x30, 0x0F },
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 5,
+};
+
 static DEFINE_PER_CPU(struct spm_driver_data *, cpu_spm_drv);
 
 typedef int (*idle_fn)(int);
@@ -325,6 +344,8 @@ static const struct of_device_id spm_match_table[] = {
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,apq8064-saw2-v1.1-cpu",
 	  .data = &spm_reg_8064_cpu },
+	{ .compatible = "qcom,msm8916-saw2-v3.0-cpu",
+	  .data = &spm_reg_8916_cpu },
 	{ },
 };
 
-- 
2.1.0

