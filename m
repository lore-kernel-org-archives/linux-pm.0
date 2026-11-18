Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022746;
	b=3mbhY0s6IiffBh/8bGCYyrPJIym5sqL/hK3JqWvt6XZwh7VljBwfNgbgVgMhSQubf3/t
	 ustIbbpTgyqu7yDNmGYBrkel4xGwHMCDP+OareHE0AV8HNUBG2EtaQHDw60Ibj95oAKQ8
	 QQg5CRg1DsQDPwr8CCmp0EiverXdICHXIPHhozn3In/W6vY1fs3zKDrjRrLGkIIDvE9F9
	 A4jH9ShRJ8ZdvgktQN9yJ+Fuw+UDpZrN+tJJEArJPK/QHqisrbJcdbqOumM5S4MmN76Ma
	 S5cKJvkMot+hPvE8D6mVxHXMD1D9/3fcLEPI8VH36ZJ8++IdcnTL0P42vJhM8h5081Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022746;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SGIyNjjq9EdM5gVCovBqMkBrVYf05V9Ai0/3lEbZlWs=;
	b=Czc5evTRNFcabtCkTW4P6/RE5LGe0Oi4ccuSQo8Ss/YwVEtVV6ut0kQqXachq+aXAIvj
	 XArDOtkGRGg3ZBZxkzfqwtriY5lqh2uttne4n3WDu8aUe9wgHUKuBr73c+DKRgUi5ZhmW
	 7b8M5mTt8Pi4+JqEy9T0nUwBY/dTa7t4NSJ5lbXINlZHw+lDKCoP3EBoekMRopE5pzYyt
	 FqY+foWHn2nejDoOO/It5g2DGhZ/YtnqD2QXIgp8kP8jlAqPG7CkcgSCbmdAa5233NqA/
	 W8uFkLwEbhxxjAzBloOWEwEAc403Yt/m6XyjLelwqZQ/Vjq3/cgOFfFzBl7ZOpqAEtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=es6vCkRP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225260A261B;
	Wed, 18 Nov 2026 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=es6vCkRP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022746;
	b=ZBJQEgq9hLulGwM8Ek0VfVtDqO3Wrv5MoO1Hkj+DiAqcx6hrEUvG0NNo6yNI9u5mlCK7
	 ZzVm60GT8p1a33G8eCFXyyDVkIJGU9nCc7BGWvSbcTSBH1ybSg1TlrsrTlktZxYCK489e
	 cGVotfByO0wd8MXzXNhjPiDGmTp9ThU6PflrrNYtvyg40syrgWTyBc/Z325Unn4RDQL6I
	 aJ+19EKyHd1+x3puLVHr2a7hCxPwg25nax+AEqPgftOFZdF/VYOAQ4XphuZ9/Ww06lll7
	 DFilRVcOpd//v7p7DMbbfgj6yW9NVO9hWj9z6gradysjwg7IsuU+9M7dN+beSXQWniA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022746;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SGIyNjjq9EdM5gVCovBqMkBrVYf05V9Ai0/3lEbZlWs=;
	b=YFtgpyP4gGYlqLNLwnECocVf3AILMMNAPSZ6h1KCvM6d8RWiSC69M6VJsDkH3mN9hmmq
	 371bfhoZfNgLk6t2igoQfm/sdSXMZGrj92a2V0Dpe/g40xspUHKL3/eImKO5bdI4DZZoj
	 bfml6DFP5+AQ5tvquWpHZ9vt7BmvlvKfrUu1IF4f8xV5QISoJty/giULSJOk4khUA3H5I
	 +h68LhWAR8V+7R3OP+2/igHLzhEWHiFxhWJT6T7KgNWWs+HPm0vcWbL0kEO7D2q4Qusp9
	 HHcE9ZLdX9gl5SlcNS9G84uk2LbD6gD76mx0XJ0/WUdH+TKjhyd/tOzU+Mv9WzQ3XAw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6ABD21F000C6;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022746;
	bh=SGIyNjjq9EdM5gVCovBqMkBrVYf05V9Ai0/3lEbZlWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=es6vCkRPhwPnzGNK68+pimmFnECtOr+gJIcyC4lAkvo/qWuOkdeSvmubjY8CuHOD/
	 OosFTyYfmtlVdimmXaPB0aA2+xjrCC4iwn220jssw3+w6qeoliuN7HSE3u3m6eZIxw
	 Fhgl39O6yT0I0smY2dPECRQ7GN8YirSJoMaSNAJ/DyBkS50FvjoTLbwMke/tjBlHh6
	 z6dKtrjzyZMpqLKSFPhtZ1Z/Q3xFNp67v8dgfODsL5sh+JyAHH5ftAAnTd15J2hotB
	 Hu1pgSoj6h76BcF1/dHmEY7CNlLpRdO+v/8jkrvfp0CRz5s6S1Ndy3cs7hvBRJmzcO
	 fXZo8NeEKzFVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EB3C64AEDE;
	Wed, 18 Nov 2026 17:25:44 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:35 +0100
Subject: [PATCH v2 02/12] regulator: qcom_usb_vbus: Add support for pmi8998
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
Message-Id: <20261118-pmi8998-vbus-v2-2-3c77a72b280a@ixit.cz>
References: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
In-Reply-To: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Robin Snyders <robin@snyders.xyz>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=9lTr2DbmYbgEO/XSdLxjtaeMnYcrX8YD7AeBwt1Utr4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+WBuCgNZLjX8R/DFVgJW4axGbZ2NQXzr3SE
 L5zd9UP/qOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flgAKCRBgAj/E00kg
 cu/LD/9AVnXgyhWvoYjRuHuNp8P0mZvN1DKN42sr/v231fYrpwEUb78AqWl1OQX7tmXHDNl7LuL
 iFHUxI3rG8Mb38vPgNq5xvHq8vKpi2nGpvr9NVWtMK3Fk8BEFnB11fUNb3AiFqiaIfyZaFghdI4
 g65tZ3iZPKqck785sinmmAofaRaEb4FrSC0d9K5sV+Vy8tYKN1XbKDajyjrAztNMF/LJC8rXpub
 x7dr3i2SgfoKSiHHzqVwUb1Wt231aEdbIp1mto+kyXetkLPTG2lKMu0KvbpTDSHcfEZNyrPDMYf
 8rtv9gJYAG3aiD1rCQMO7gKL90Ub6FxH3s7uyzwrBI2Ov8OQpBfDUCvZB/3MgoTpxKpBPsFdLkc
 fF69t3DLFagQSIjmPh3B0SV+y3nEw+4EHxowfWawsP8wnHhYLSXU9mQjVLzi1pULii6yRbdbNEB
 Agtcwp7ueNJRK80t+nBkJLJi5obpg+cRbM3akDAw9MVvwVPf135um87j8d+jNr+hK9RGuCzdjcc
 jRUdK8Q1xQKhzrbiom/zGXKLUQyYNcMOx0W1629D5zMX6keq2quiECaKf16Vh0SLIxoXery+Ly9
 NpDm5Vk5IAeL9F0laWj36qeki/gR8fNmjjJrSXHu5/SRnhDqISFgfM4VQd1gAhwpD8YIfl0/w3x
 /Fst4K33dwqCgTA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

The PMI8998 uses different register layout, but due to the limited
functionality of the qcom_usb_vbus driver, the basic registers are the
same as the PM8150B, thus reuse these. For more advanced features it'll
differ.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/regulator/qcom_usb_vbus-regulator.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/regulator/qcom_usb_vbus-regulator.c b/drivers/regulator/qcom_usb_vbus-regulator.c
index 88f5a6ba79e6e..0617106a82cda 100644
--- a/drivers/regulator/qcom_usb_vbus-regulator.c
+++ b/drivers/regulator/qcom_usb_vbus-regulator.c
@@ -63,16 +63,27 @@ static const struct qcom_usb_vbus_reg_data pm8150b_data = {
 	.otg_en_src_cfg = OTG_EN_SRC_CFG,
 	.csel_reg = OTG_CURRENT_LIMIT_CFG,
 	.csel_mask = OTG_CURRENT_LIMIT_MASK,
 	.curr_table = curr_table,
 	.n_current_limits = ARRAY_SIZE(curr_table),
 	.ops = &qcom_usb_vbus_reg_ops,
 };
 
+static const struct qcom_usb_vbus_reg_data pmi8998_data = {
+	.cmd_otg = CMD_OTG,
+	.otg_cfg = OTG_CFG,
+	.otg_en_src_cfg = OTG_EN_SRC_CFG,
+	.csel_reg = OTG_CURRENT_LIMIT_CFG,
+	.csel_mask = OTG_CURRENT_LIMIT_MASK,
+	.curr_table = curr_table,
+	.n_current_limits = ARRAY_SIZE(curr_table),
+	.ops = &qcom_usb_vbus_reg_ops,
+};
+
 static const struct regulator_ops qcom_usb_vbus_pm4125_reg_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.list_voltage = regulator_list_voltage_table,
 };
@@ -161,16 +172,17 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
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


