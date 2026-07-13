Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEAB360EDC;
	Mon, 13 Jul 2026 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921899; cv=none; b=XT0wQpUjiAEcOW3TmIhY6d4GfrlExVP+/mAstQ/XpMt6tlzeMldYKjhPIyRoPg3AVUeFmYLo+a0UagxGzBQVVEGFA0O2JBCZpMFmRQQRjvZ0aPW1wuUF6zSo9PwJgqpTrzkpnFUjqRf+4UXh/3vfp5oK8/VfgOXA9v+qEa/ETcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921899; c=relaxed/simple;
	bh=NqsYvoPObx4tRY5M+T/QipNFYfyhGBpP8fWEUfWIYlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ndi+Z71NV3OkARVTq9v0CInJXYpHqa7L2oaE0MF0g7qfzsXcq72iLFeCQNfBUaiqt437G82wpAalO/DfUyDd7uECY3cdgAtWZUHuB+/1B54xigHu7JatJoVrogSplklkjgmwDM1BlR5C/aL+v9hleFEWHm4Xw1QVvJXzaPl28WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLj/25Cc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLj/25Cc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9AECC2BCC7;
	Mon, 13 Jul 2026 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783921899;
	bh=NqsYvoPObx4tRY5M+T/QipNFYfyhGBpP8fWEUfWIYlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aLj/25Ccl0GQJEgDbb31uT/LJ7oOzGanRf/0RWWSE2eczhhj07Ly9hzg1fouozQQb
	 Uz1jqt/I8XHiP8lMB/y28eed1s4NTgoCPgmDP9jIp/WcyFXDMo7ZFU5Mz8VjhpJBXM
	 kSeZE31Tr6ISdSOsmyytKo6/1nA0RHqCkT6Co3DALFqAaZnNXM2lmZ0KV6jH1cAKEv
	 5BBOXdUDv5DMX+lOPY172ncRVQvRiZbDIXCme18uzOnqFTqyYZ5dQWpSfhTSEetIp4
	 7n2YwsseqcnMZp21RlqzWDwSVnGACCIZCpthiilPjR39rbEJVL8YnUrI0juLLoxxyX
	 hr6/e3lDWm+/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC384C44501;
	Mon, 13 Jul 2026 05:51:38 +0000 (UTC)
From: HaoNing Cheng via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Date: Mon, 13 Jul 2026 13:51:34 +0800
Subject: [PATCH v5 2/2] thermal/drivers/imx: Add calibration offset support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-2-69405c306c6b@cn.bosch.com>
References: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-0-69405c306c6b@cn.bosch.com>
In-Reply-To: <20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-0-69405c306c6b@cn.bosch.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Haoning CHENG <Haoning.CHENG@cn.bosch.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783921893; l=2618;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=4RI3KwRlC8Yl5nDcFypymQ95vC8TXe4NB1RjWrUCQYE=;
 b=PE28GS7jCEZkFmW2gN2/FX2Qk8TCsqJlffhYSmDjpOmN7A8hOepF5Lqh2WHKJMXriDwxz+Dva
 RW61JO6wgsOAKfEEMneU9s0MonXBId7yhMbxCSpzckRtjNRCtDN31Wk
X-Developer-Key: i=Haoning.CHENG@cn.bosch.com; a=ed25519;
 pk=glQGwad/fosRS5gZUJYbLDPPLGe7rFTrTV2VxY/ySdc=
X-Endpoint-Received: by B4 Relay for Haoning.CHENG@cn.bosch.com/20260709
 with auth_id=860
X-Original-From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
Reply-To: Haoning.CHENG@cn.bosch.com

From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>

Some boards need a small per-design correction to align the reported CPU
temperature with board-level measurements.

Read the optional fsl,temp-calibration-offset-millicelsius property from
DT and apply it to the i.MX6/6SX/7D calibration formulas. When the
property is not present, the default offset remains 0, preserving the
current behaviour.

Signed-off-by: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
---
 drivers/thermal/imx_thermal.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 38c993d1bcb3..0a443e608957 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -207,6 +207,7 @@ struct imx_thermal_data {
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_init_calib() */
 	int temp_max;
+	s32 calibration_offset;
 	int alarm_temp;
 	int last_temp;
 	bool irq_enabled;
@@ -223,6 +224,7 @@ static void imx_set_panic_temp(struct imx_thermal_data *data,
 	struct regmap *map = data->tempmon;
 	int critical_value;
 
+	panic_temp -= data->calibration_offset;
 	critical_value = (data->c2 - panic_temp) / data->c1;
 
 	regmap_write(map, soc_data->panic_alarm_ctrl + REG_CLR,
@@ -239,11 +241,14 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
 	int alarm_value;
 
 	data->alarm_temp = alarm_temp;
+	alarm_temp -= data->calibration_offset;
 
-	if (data->socdata->version == TEMPMON_IMX7D)
-		alarm_value = alarm_temp / 1000 + data->c1 - 25;
-	else
+	if (data->socdata->version == TEMPMON_IMX7D) {
+		alarm_value = DIV_ROUND_UP(alarm_temp, 1000) + data->c1 - 25;
+		alarm_value = clamp(alarm_value, 0, 0x1ff);
+	} else {
 		alarm_value = (data->c2 - alarm_temp) / data->c1;
+	}
 
 	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
 		     soc_data->high_alarm_mask);
@@ -277,6 +282,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 		*temp = (n_meas - data->c1 + 25) * 1000;
 	else
 		*temp = data->c2 - n_meas * data->c1;
+	*temp += data->calibration_offset;
 
 	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
 	if (data->socdata->version == TEMPMON_IMX6Q) {
@@ -629,6 +635,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	of_property_read_s32(dev->of_node,
+			     "fsl,temp-calibration-offset-millicelsius",
+			     &data->calibration_offset);
+
 	if (of_property_present(dev->of_node, "nvmem-cells")) {
 		ret = imx_init_from_nvmem_cells(pdev);
 		if (ret)

-- 
2.43.0


