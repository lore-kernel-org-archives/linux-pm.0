Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300703;
	b=kN7Kz3q2HH8diRNXCAqXl0Nap9Wdf7GZzeCLjGUV0u5QAGaIenEeOUFTXaAvb04JzLwK
	 /GUb2HFhyZNjI1TvZ7mpk73SHxdgBeYB8fuvSEr6vwQ318AXMF4GfsQWdhceMu3YxZkvO
	 aiWqJRKacCEOsfYJc4MM4AYAvNOoxD6BfBT65xZ3D2LMurE7BngHwnMN26mu8asGSO5F/
	 X08f1/sAmhufJhB+5h9a4Ap/QuYm0b9yL234dOKgRuTGx05cypM7FcRnIyOhwYcbDhqWK
	 ++OxX36qcTa1unn6w0l70wqbdYQ2bsqqsRvxbE01noylUSnuPWsOrIDbj1eZo5bNxsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300703;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XD7EQF7++QV5jgZ6UYMRdry02+/ERyAYf1FpH+mXBZA=;
	b=ma1xwRpKJDhuXSvKKeU+XkcGrgYCBvbYFbsZaRbwBFR0+QFrFEfkRJV0vF4yjoLET3dR
	 czo8OYh1RsAQcuQs2BePA1DeMcG8CkqojacTlGqMfbrGXCuKjUOlXGLD7Rr9kARigmOrV
	 C6G1bMONYHLxUeiPV9F9UNu53/bJzpihI5c1sUD6X6ysWm+0bqIA6CXCRl9YIPah2Y6Kj
	 kwbZ+GTNn6kbgwwu1n3pFy8+3e4+CMvjqfhexzmucOyu499s+7BL8xWsiXjZ65q3Pyv84
	 /Gq5V5+dlKe4SmeTXhBPHaw8vlQZtJFL/023Yf+cp2ZRaFxnyOILUTUiF1wk4APlhjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAOGt6na;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45F1606A68C;
	Sat, 21 Nov 2026 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAOGt6na
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300703;
	b=y1O3FaYDLGuj7Zd8KvNBK//Y6m064IwhZ6h30afCL1nlo364GY0K6Pi7bB2fVgF8+Qv1
	 GS4YCk7FgmwoxNwmk+K4QLHTjkW+9pTOfweDGcCHuEB+O5qxAdtH9MaQZdAReDyLtQzz2
	 vus7BZCO9wEHiLsc+oxX5na2yHqMiyz3Npi+HsAtMJOv8KfguBAwviOW90mwiua8xH+2l
	 Cq6PcHxnZ6wthYr9Mx5gmQxR63Na+hp3TI+UP3EJdfDhbNVecx8cGlnX6sDlA/QpAHZW4
	 I08arxk0GaF5oV2+/qcmOFitsZMZ7sAO8KZIGWC10ln+5LeZSNf4YsS4EmXGjVujsqg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300703;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XD7EQF7++QV5jgZ6UYMRdry02+/ERyAYf1FpH+mXBZA=;
	b=2O4wJENDRE7KrP3ePkjJ0qos9+AZx+lmYf18kjMHxzwWkz/dMHZixAO+NJBmWBhxruAZ
	 uyQKsbI8nW67wv/BNqgyuAEpy7MrdyV13fRO2sUTRwEEBlpb5811g80bFcOGi+7/nERVn
	 aKeLLpZUX+oBQJuv6lhQNrbx7ZgKx38ARSqGs/9lkZpkv3/HX4drZuoMN1gDNU8Msanjg
	 qTzqa2jf1JVudAkicOSB/+W2mwQ6iMMDYESxshXhMmcknPpfIHYcrGJ8nOm8SdWNi2hHa
	 usri3H6iFh6QhkL5AOclOt50uR1XvnDOT3+YfxL23Xztz5oA1vtrWEjPIaQHy2HUmFA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8AA101F000CF;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300703;
	bh=XD7EQF7++QV5jgZ6UYMRdry02+/ERyAYf1FpH+mXBZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WAOGt6na3peZbBGdZhqxhgxVinuVr0LR4MiPzGzL8+gxVF37iGtnEhofmwLDbFnlB
	 5nphEvRDbPKh5K3gF7N7Ley9HEsrmZ0KRVwiQiGROefzxCd3DUtdPXq9y/Q7YrxG3z
	 6vQkrR4WgSXcrV9+8l+HCtFBaLxe5sE1d0nGDdnT9KpQ46Y/i2F8eVmA4nVG4PflVp
	 LOSpmJDi9jb5qGW1Ern6jzF7O9t1JaGpYKhcx9yzt8S45HMaVIQknrjB/LXkTpOGAK
	 p126Uhlt3R2Weq8fv3Lf5nLem3/Flfyf+y0LXOEUmY9AEH+bYqUw8U++UrJrMIByUo
	 NvCa1+iWemuSg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0DA7F4BE2E;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:37:57 +0100
Subject: [PATCH v3 03/12] regulator: qcom_usb_vbus: Add support for pmi8998
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-pmi8998-vbus-v3-3-91ba2e61a877@ixit.cz>
References: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
In-Reply-To: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
To: Abel Vesa <abelvesa@kernel.org>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Markus Rathgeb <maggu2810@mailbox.org>, Rob Herring <robh@kernel.org>, 
 Robin Snyders <robin@snyders.xyz>, Sebastian Reichel <sre@kernel.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Richard Acayan <mailingradian@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3260; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=jayZyl15D6GUZYJTF3MT/rTVZn/RUZVLzfJX2rYw+gc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1aliSo1w5taoGLSLOB/Azx4VQ3dp19WgANg
 Uiq32hpjFqJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWgAKCRBgAj/E00kg
 cjpdD/wIfR0BLZtexyfdulg6uenRDEQ9894sPX6meg2yqJJY0nin1o5/8Ro4XkkE0qTlLlE0gki
 yyoVIPn8g4P2YDRSaEppBZviBISiYNniffI3z6lWPHSx5KL740j9kM3iHcRQEUWsHeCyPM4sWt9
 HAiDxjrjGm94GvQ//sAEtyrG9ffgOSNoOUjrz2RgMZF3HOXzC9+gBMgetDkQKGAVmUafRTCG2J9
 FKeADwEWtqall0FVDFgkrN4haq7CMcwtnbYxDjVw0o9mlRetRyduE/mA15beL6JKPRdPJw9dt+Y
 50pBV+mH13c7psnd3m/6dkPPvlhpPB3DrHJeZqBzNPINiLSU0DNYfrfMrKjuycFLqgrWNQvrDBG
 rbGxQNtaA+icrJLDUuKtlQzBu51p6pebk9vOiLv/f9XtP7r52jGkdqSj3uW33i7MxrNAt/0Vvtm
 qsHf9tkTLnwpQhcGokpWD734MXkq7esOO5Q3+gsZZ5kXDsOs6yFiVCP5nawi7KeHiDimQFTt9mO
 MJykK/wGNlet7+HlNkFK3vu8nRVmhQUicGvi3cCIrSxyEcVsXFmoPbFR0YDVyrnz4D5WhXeEFVn
 U3l95MzWPuImv5eIVnurLXOd076EPuLJMeXt74CLrQB1738mqaVUksxZCa2bJIAmiQYm33VACox
 +ko/BsUwOveMiAw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

The PMI8998 uses different register layout, but due to the limited
functionality of the qcom_usb_vbus driver, the basic registers are the
same as the PM8150B, thus reuse these. Table of currents differentiate
in steps and maximum 2A current. For more advanced features it'll differ.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/regulator/qcom_usb_vbus-regulator.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/qcom_usb_vbus-regulator.c b/drivers/regulator/qcom_usb_vbus-regulator.c
index 88f5a6ba79e6e..61a1b45f36e84 100644
--- a/drivers/regulator/qcom_usb_vbus-regulator.c
+++ b/drivers/regulator/qcom_usb_vbus-regulator.c
@@ -36,17 +36,17 @@ struct qcom_usb_vbus_reg_data {
 	unsigned int n_current_limits;
 	u16 vsel_reg;
 	u8 vsel_mask;
 	const unsigned int *volt_table;
 	unsigned int n_voltages;
 	const struct regulator_ops *ops;
 };
 
-static const unsigned int curr_table[] = {
+static const unsigned int pm8150b_curr_table[] = {
 	500000, 1000000, 1500000, 2000000, 2500000, 3000000,
 };
 
 static const unsigned int pm4125_vboost_table[] = {
 	4250000, 4500000, 4750000, 5000000,
 };
 
 static const struct regulator_ops qcom_usb_vbus_reg_ops = {
@@ -58,18 +58,33 @@ static const struct regulator_ops qcom_usb_vbus_reg_ops = {
 };
 
 static const struct qcom_usb_vbus_reg_data pm8150b_data = {
 	.cmd_otg = CMD_OTG,
 	.otg_cfg = OTG_CFG,
 	.otg_en_src_cfg = OTG_EN_SRC_CFG,
 	.csel_reg = OTG_CURRENT_LIMIT_CFG,
 	.csel_mask = OTG_CURRENT_LIMIT_MASK,
-	.curr_table = curr_table,
-	.n_current_limits = ARRAY_SIZE(curr_table),
+	.curr_table = pm8150b_curr_table,
+	.n_current_limits = ARRAY_SIZE(pm8150b_curr_table),
+	.ops = &qcom_usb_vbus_reg_ops,
+};
+
+static const unsigned int pmi8998_curr_table[] = {
+	250000, 500000, 750000, 1000000, 1250000, 1500000, 1750000, 2000000,
+};
+
+static const struct qcom_usb_vbus_reg_data pmi8998_data = {
+	.cmd_otg = CMD_OTG,
+	.otg_cfg = OTG_CFG,
+	.otg_en_src_cfg = OTG_EN_SRC_CFG,
+	.csel_reg = OTG_CURRENT_LIMIT_CFG,
+	.csel_mask = OTG_CURRENT_LIMIT_MASK,
+	.curr_table = pmi8998_curr_table,
+	.n_current_limits = ARRAY_SIZE(pmi8998_curr_table),
 	.ops = &qcom_usb_vbus_reg_ops,
 };
 
 static const struct regulator_ops qcom_usb_vbus_pm4125_reg_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -161,16 +176,17 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, base + data->otg_cfg, data->otg_en_src_cfg, 0);
 
 	return 0;
 }
 
 static const struct of_device_id qcom_usb_vbus_regulator_match[] = {
 	{ .compatible = "qcom,pm8150b-vbus-reg", .data = &pm8150b_data },
 	{ .compatible = "qcom,pm4125-vbus-reg",  .data = &pm4125_data },
+	{ .compatible = "qcom,pmi8998-vbus-reg", .data = &pmi8998_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_usb_vbus_regulator_match);
 
 static struct platform_driver qcom_usb_vbus_regulator_driver = {
 	.driver		= {
 		.name	= "qcom-usb-vbus-regulator",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

-- 
2.55.0


