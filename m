Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8558311C2F;
	Thu, 28 May 2026 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939571; cv=none; b=jFgOggfcdyZ795nnRT7vc0yAs0iZ8roxzt9J7dO+axTBhDlo43PVdKLbRwB41CitSYmaRTkuGlqCfuZZvqdC5A4yVXf2qEEFcW96tVHpx8JLtweG/r6rq1DU2ITXwasOn036kFbuzM/bgB7jVwZkM1g5ZLexQaYtSYQLcgWhZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939571; c=relaxed/simple;
	bh=o8kNJddvVcrK7IoCVMe+UkaLiQ35HZDprvVYZkVvtAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jog/+RZZ+XtSob89PJRupCxKZeZgjQFy0wfZth10zcnlqasoVLzwC3oSNwdC5l4cDd91oUrTzXfu7VWCxoeOYPbGfQjFJNSLTPJwtqtUg3leIOkK3os3matCTWni9/WTahURkxnBuvhF1D6POx+eW9Ta1U5szymBxiQqHaWqP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7nemYBs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7nemYBs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FB66C4AF0F;
	Thu, 28 May 2026 03:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779939570;
	bh=o8kNJddvVcrK7IoCVMe+UkaLiQ35HZDprvVYZkVvtAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J7nemYBs2SODUE/Zv0LBj0PoWDb+ZxkjfWC8UQMk/HW1QBn4sxisvbgradguMYrDV
	 ipIsyBKwID1OTmI09oDRZs8uQpnLrOO7dgTfkkOFVMmsy1JcbjznM+MmVq8tnfYEeE
	 CTJcShUqiymWrrWDb284H7koyjMI09ebUVRpSGHVlG4xZl13JuNXq2pdklUlWxWibV
	 OCG22QwHSDffNuMsXjdrAlBkRCcA5Nv7vtHWZ1Reazg4h/6+vjZu6DizzpvsLg+Ox+
	 7z9z1c9HvD+1JrWWpipYq0XKAqJw6kMFdFzWhfoDDsUj0e1kqTU/InpmCs1YmTDIDq
	 NagLpq69SuI9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC6CD6E45;
	Thu, 28 May 2026 03:39:30 +0000 (UTC)
From: Rudraksha Gupta via B4 Relay <devnull+guptarud.gmail.com@kernel.org>
Date: Wed, 27 May 2026 20:39:29 -0700
Subject: [PATCH v2 2/3] soc: qcom: spm: Add MSM8960 SAW2 CPU support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-expressatt_cpufreq-v2-2-b9b7726ccb6d@gmail.com>
References: <20260527-expressatt_cpufreq-v2-0-b9b7726ccb6d@gmail.com>
In-Reply-To: <20260527-expressatt_cpufreq-v2-0-b9b7726ccb6d@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Rudraksha Gupta <guptarud@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779939570; l=2263;
 i=guptarud@gmail.com; s=20240916; h=from:subject:message-id;
 bh=7s3KzFwEWbUff19gMuQdq9JEmjBwkmq5B8cP8DEG7zQ=;
 b=+9RKQtGrbedqx6kW4YRBStMd7qCMFDl+Vusc3AVas4VSS/a4yxvKeFbtMhrKxZbhhd3vtBt/f
 6s7f9UCjtcICfXCOFnNlbrGLQ4ftSr6RniljOOKDojFv/TEw59Zjt2r
X-Developer-Key: i=guptarud@gmail.com; a=ed25519;
 pk=ETrudRugWAtOpr0OhRiheQ1lXM4Kk4KGFnBySlKDi2I=
X-Endpoint-Received: by B4 Relay for guptarud@gmail.com/20240916 with
 auth_id=211
X-Original-From: Rudraksha Gupta <guptarud@gmail.com>
Reply-To: guptarud@gmail.com

From: Rudraksha Gupta <guptarud@gmail.com>

The MSM8960 uses SAW2 v1.1, the same hardware version as the APQ8064.
Add SPM register data so that the SAW2 driver can program the correct
SPM sequences and PMIC parameters for MSM8960 CPUs.

Link: https://github.com/CyanogenMod/android_kernel_samsung_d2/blob/0dbe2b56847b304d30b809dfd08ba3b4a61d9af8/arch/arm/mach-msm/board-express.c#L3265-L3285
Link: https://github.com/CyanogenMod/android_kernel_samsung_d2/blob/0dbe2b56847b304d30b809dfd08ba3b4a61d9af8/arch/arm/mach-msm/board-express.c#L3353-L3381
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 drivers/soc/qcom/spm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index f75659fff287..fb3ec8aa42b0 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -233,7 +233,7 @@ static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
 
 static void smp_set_vdd_v1_1(void *data);
 
-/* SPM register data for 8064 */
+/* SPM register data for 8064, 8960 */
 static struct linear_range spm_v1_1_regulator_range =
 	REGULATOR_LINEAR_RANGE(700000, 0, 56, 12500);
 
@@ -253,6 +253,22 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
 	.ramp_delay = 1250,
 };
 
+static const struct spm_reg_data spm_reg_8960_cpu = {
+	.reg_offset = spm_reg_offset_v1_1,
+	.spm_cfg = 0x1f,
+	.pmic_dly = 0x03020004,
+	.pmic_data[0] = 0x0084009c,
+	.pmic_data[1] = 0x00a4001c,
+	.seq = { 0x03, 0x0f, 0x00, 0x24, 0x54, 0x10, 0x09, 0x03, 0x01,
+		0x10, 0x54, 0x30, 0x0c, 0x24, 0x30, 0x0f },
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 2,
+	.set_vdd = smp_set_vdd_v1_1,
+	.range = &spm_v1_1_regulator_range,
+	.init_uV = 1300000,
+	.ramp_delay = 1250,
+};
+
 static inline void spm_register_write(struct spm_driver_data *drv,
 					enum spm_reg reg, u32 val)
 {
@@ -501,6 +517,8 @@ static const struct of_device_id spm_match_table[] = {
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,apq8064-saw2-v1.1-cpu",
 	  .data = &spm_reg_8064_cpu },
+	{ .compatible = "qcom,msm8960-saw2-cpu",
+	  .data = &spm_reg_8960_cpu },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, spm_match_table);

-- 
2.54.0


