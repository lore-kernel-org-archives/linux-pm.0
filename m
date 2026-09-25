Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011015.outbound.protection.outlook.com [52.101.125.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689C1DDA18;
	Fri, 25 Sep 2026 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317042; cv=fail; b=c+ycM5iCsPekVYV009pmEy5h9giV+Ig/SFtQ4Tv6x28rW6MLfogMqrjV9jbLkPeAB7kM2qnXJyydJiRNpvQFwsrRdrTlN35pKkvjilRxgvnkNTeoFu0hI9n5QQ+VK3X0fubdmbVEUOAw3g3oLR3f5l38ZyxDs9tuU9G7vLI7mtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317042; c=relaxed/simple;
	bh=0nH6GvdJrxSAs/2zUY1CiwFQ7d5csAel18OXuZYoONQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOG6f5LTp7xo/LKzQ3Kemub6J7dxI+hGyJ1WjWM+ztLvCOQ3c9rdr1MWMFv7UUVteUMo5ke2MwwQl0U1BqxPNhqRR7q3Vq1qLodhjHplHn4TrjOvsMeAudfUz9/z15LKbvw5MtQbX355DjqEAp6PtzM4yAfI/izlvowIo95uyXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PsCQdFvT; arc=fail smtp.client-ip=52.101.125.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PsCQdFvT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UC1ZLmZ2+NfTN9IDslJDJF43iLKZG0ny9Y3J+aED4A1vk2xk0eqvVYpi7CwiwHmh/AN6Lwvk7bQ7k7mA+Ay7/NAnVy00IDu20puVQZ+xo8OVpfoN52p4tWMr2IH9oaEQzdWeQAm46uTWL6yxLsADsDuaoWK3E1OU6DawQgn/Eq1KPOHftLFPomzO65I7QeukPY9HRukX15QbrIkW9YTwDVggn2IEg0Z/5Kx1nq2CoxOpv49g+68bYrOScSwgjeH5CgqAq0ZoePOyMoOjoRnZ5r+6cZA1F1rlpF9tfE+G973Ix7Arx6KIqnG22MSnFzok/v9vf+S3o3jSiM5jhwXV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8778IA2dlXPT0G2NpRy7N6jIDJMiSEozVaWeUYl65oY=;
 b=gMd0HVUDLkJwLvN+11iK6o0I9GzQtZwRPs5QdSqJb2EVnMfSQcnjou1/mfikETJAb2xiMbxAWCfyy3SeVPjqv922aXN6HdA0UdHhbFphKVz/JvM6rUVj8S8AOjyBNAN/bPiWB0p2YzpG8/gxit/Qwsc7083S4y2RmAbkDbhIV1uqn7xihtjTQq1KgE84MqKnPJHQ/LNE8f/mFELk8BgXVyrbweDtRsjZSjVXxGPH5wJuVLlWuAoed089wA74iKYAJbCZjo3Iu9DlzDqzqlqEfhF1wYWKCLnTJoHIjGK3A7sQ1tagfB8UCOrUCj1+SlAkWJQRh6EwozD4EnB+2SuniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8778IA2dlXPT0G2NpRy7N6jIDJMiSEozVaWeUYl65oY=;
 b=PsCQdFvTm5mvSH+v40vr1xfafdjbMBoQPlQb3MKOs7nfxP2LHDEERqgF+oQgVbfvgzDCx1HJdgIXN/2YMNZmbmsQhJCYdImmiEaqls8f30Eq/wXGhIM0baPW7FdQs+hZ4PmF9Bjg2mJbynd6DWyTchfzoJ2m/r9oCztPTZPgmbA=
Received: from TYCP301CA0030.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:381::20)
 by TY7PR01MB14605.jpnprd01.prod.outlook.com (2603:1096:405:244::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 06:17:18 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:381:cafe::2f) by TYCP301CA0030.outlook.office365.com
 (2603:1096:400:381::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:17:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 06:17:17 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.177])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 121963000259;
	Fri, 25 Sep 2026 15:17:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v4 5/7] iio: adc: rzg2l_adc: Rename num_channels to max_channels
Date: Fri, 25 Sep 2026 07:16:03 +0100
Message-ID: <20260925061617.127349-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TY7PR01MB14605:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 194e65ba-aab1-40d2-81da-08df1acca63e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|10067099003|18002099003|56012099006|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	946VHzuBNf/6CdYSHmGBGki5fyD6h7vTeDlQWSx9qSG+rbW4iqp/cvLV4c9a6OuKxsyP0W0kTykv2jwlQz8/it2h+khxDeHqWuNy58YVcI9fixB+5uX5LAVYD23vrblXrAP5yD/rne2FFiNiNraDskuADHgFr+jy3fkRTYfG7zqglYiGhWPvcu+lRSITmkA1ssHKegxvizz4uk6qMtjSwC8CdT2zuDtuDTkBM7GTLUEcChyrmx5OzHAx2iP3bJzn67+8DigXIHAswstxKWk2iWk9eTue8UF8P0hZpHpZoMSJrhUSispRA5StiHTmAvvdxqcgJkczR1DTT+icsOza25TYs/PO21RSXjhF4N4d6APVzHgmX3FCyLhebkiIFKTvzhuXgUjxazoPGcRBKicyDTGPy42pO35VA7T5MNO8H/B+Qsnao6GvN1eSZdjL0Ev7BnikXHX832cGMhOThYpa16OTE56NDXuC4VDcUybuYFvMybc4jg26OLK+m70t01/nQ9pexzjznaUm0tNCLTQJ1IKCI9XvK2jrch2iwOECfTOVQ34JH/Pftw36DGiMsQbdHWwBef8Y191NDqjNxeD9rmK2Tg+2IlFhyda/bxDf8jSoEIKy+VbChcY9rxzi44gTqpTVm1/UlOUo95SKlQ0trkHZLb/sCM/1mLt/iucVkbPunE0gCrh6N0vTKU84l4M8jK5A9YdxboKwqINux4TT2A==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(10067099003)(18002099003)(56012099006)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m+m99+dxQAoEirOt6CUmtCxpxHvXMFE3Q9zzgLG68S0+xZ2IkU9AJZ8YjNAUyy1VdSJp+Lj+9kAfFhSW8XsnC4elZfhdXPOraLtjAVSgvfd5EququjPx7//ES6w4Kr/Iew4YlR4uBsiTznK45tUfYfQPa8NqcnXgPdZpUoVstwA9ICvzUZaXpgWHUYpltUIp8NrF+hF0oZj4CjFYM4t23UBfin45uhpXtZerKqb/xCPE8AMgtvWXAhoTSd+tW7e5quf3KhzQ4lxd6NkuXtCCa6MemHwMkHg5k1Fj3INoTnZi2Crdmo5AZdBfwwKeLuXpAWY6mMS8vqE1r2qcpaAsEsOgyyGBaVatihoeq7bcjWyd2dT76+aIA8crGmDfEiUKQjcQ5dbBS+ObWqjg03A+KrPR9+29/VlTPF/2GQpi8dMo34aNtMI4bTe7WziRqp87
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:17:17.4151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194e65ba-aab1-40d2-81da-08df1acca63e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14605

Rename the num_channels member of struct rzg2l_adc_hw_params to
max_channels, as it represents the maximum number of channels
supported by the ADC hardware rather than a count of channels
currently in use.

No functional change intended.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Updated commit description.
 * Updated kernel doc comment for max_channels.
v3:
 * New patch.
---
 drivers/iio/adc/rzg2l_adc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 408fbf8c29cc..19b8f1a546a2 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -62,7 +62,7 @@
  * @adsmp_mask: ADC sampling period mask (see ADM3 register)
  * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
  * @default_adcmp: default ADC cmp (see ADM3 register)
- * @num_channels: number of supported channels
+ * @max_channels: maximum number of channels
  * @adivc: specifies if ADVIC register is available
  */
 struct rzg2l_adc_hw_params {
@@ -70,7 +70,7 @@ struct rzg2l_adc_hw_params {
 	u16 adsmp_mask;
 	u16 adint_inten_mask;
 	u8 default_adcmp;
-	u8 num_channels;
+	u8 max_channels;
 	bool adivc;
 };
 
@@ -196,7 +196,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 
 	/* Select analog input channel subjected to conversion. */
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(2));
-	reg &= ~GENMASK(hw_params->num_channels - 1, 0);
+	reg &= ~GENMASK(hw_params->max_channels - 1, 0);
 	reg |= BIT(ch);
 	rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
 
@@ -307,11 +307,11 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	intst = reg & GENMASK(hw_params->num_channels - 1, 0);
+	intst = reg & GENMASK(hw_params->max_channels - 1, 0);
 	if (!intst)
 		return IRQ_NONE;
 
-	for_each_set_bit(ch, &intst, hw_params->num_channels)
+	for_each_set_bit(ch, &intst, hw_params->max_channels)
 		adc->last_val[ch] = rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) & RZG2L_ADCR_AD_MASK;
 
 	/* clear the channel interrupt */
@@ -341,12 +341,12 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 
 	num_channels = devm_iio_adc_device_alloc_chaninfo_se(&pdev->dev,
 						&rzg2l_adc_chan_template,
-						hw_params->num_channels - 1,
+						hw_params->max_channels - 1,
 						&chan_array);
 	if (num_channels < 0)
 		return num_channels;
 
-	if (num_channels > hw_params->num_channels)
+	if (num_channels > hw_params->max_channels)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "num of channel children out of range\n");
 
@@ -429,7 +429,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	adc = iio_priv(indio_dev);
 
 	adc->hw_params = device_get_match_data(dev);
-	if (!adc->hw_params || adc->hw_params->num_channels > RZG2L_ADC_MAX_CHANNELS)
+	if (!adc->hw_params || adc->hw_params->max_channels > RZG2L_ADC_MAX_CHANNELS)
 		return -EINVAL;
 
 	ret = rzg2l_adc_parse_properties(pdev, adc);
@@ -484,7 +484,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 }
 
 static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
-	.num_channels = 8,
+	.max_channels = 8,
 	.default_adcmp = 0xe,
 	.default_adsmp = { 0x578 },
 	.adsmp_mask = GENMASK(15, 0),
@@ -493,7 +493,7 @@ static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
 };
 
 static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
-	.num_channels = 9,
+	.max_channels = 9,
 	.default_adcmp = 0x1d,
 	.default_adsmp = { 0x7f, 0xff },
 	.adsmp_mask = GENMASK(7, 0),
-- 
2.43.0

