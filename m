Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011041.outbound.protection.outlook.com [40.107.74.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907693EB105;
	Tue, 22 Sep 2026 04:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051303; cv=fail; b=aS/1+gVmMZ+ECJ/08vJiMwoQcvQAUMOx3oG7iDYyZIXIydhHkAf01xc3Sw/XJd1twdAnwUtYwnfRMLnEeWb9u56gTAhIMQe/HQAfnT3fg+b35nGzcu/gPutknW/FTHpO7SzWdzetqI9kKcxVfw5oXwCiwQgsX7OOTnsylbo69no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051303; c=relaxed/simple;
	bh=eiUaBU+b+BjbfvHLDjLsxjCaZ1NX09J/tLVQ/eKu8q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRhXnLGSg+gA5YixSjHq2zzJ25MkzH/Wj5qQJXMtmOyZvCnyyZRL+DUwheeExxqos7dgamGs6IBpZTvx6OWYKwmZ2Igs/v2xrnX5NgpGhfR7/saGgNnCITBPBSzraP3BAttQcorMpAOuQYqzfTl+xpla57l7E4GrZIynpqYso2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VbNBaMJG; arc=fail smtp.client-ip=40.107.74.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VbNBaMJG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg3tWkia7FjWgGSJ6rz3/tR2Rkz9Iv0xTVFXTS8FrYKP/gIRhQYpjZaQ/jR2B5p9ELS2l4gydBa3pOm1rMiOHDosDptI/T1XP37C3ssmLZmzQ3YiOd05myrCSZNx2E5RCiNSbCahRxEn+Q1Wme1KOgxSatGo1dVuMsWozj2QCOiEbM1sl0FFF+EJZDIsBL5+GGN66o0yEYcuK6VGEpY+9usjbwbERNZS8K7be7V4rqhfkeqiX7n2b4Y2myTaK7jGipGG5Z1RishFV/pvrzv4XwcBuZXVgGgl29sI6aqvlNvqnfY5mLjAoMT0C4rWtoJfvlb8GsjzBwBfcjQWquS+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1vd2koHcYNjVN9z+9+rt+QOg6V3747MkEW3XMUYnU0=;
 b=LOf0gK3IgUckerSMS79pKRbIctkD49k1fHMesNbpRJDAMIxVPcewr4ILc7EClvZuTTZAJUgLvYY6nSnjvS4DPy8bBCAWeDPRifUTw4B6y+5ULLv9uxlpvs1SEUKn2Qun6OsLGxsfKuzhcOpxMFop3s7rSkfg36Ck/b6yXoT3/ElshW5cxUj4FdXwX/tqWxneyjeuaC6WJ2DMMZ25hKlB4EtjgZRhKATs/gJVsMCEPhwWP+OeZxKNHHuwSlvPifFyq5NJtgsLNAo2CVlQgf1lsELfGQi8nFC1nI5BnYHn6sMJLOs8XEMVblwSHuNZSz34FcDwRoPhVM61GmnPC/0zTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1vd2koHcYNjVN9z+9+rt+QOg6V3747MkEW3XMUYnU0=;
 b=VbNBaMJGkGQJAdYPZ+B8TL4qy5s8wt1kVZ9nvSSKK20HtD169Rf403t3dkii4TvMvDvigRvaTiddAE6SUffhtkI8WZxu+NZgJSV0fGd1mLyN9zlS2uuGtsNy4/mZ7SI2nf1s1W5TIYGyuLk8RO1BScrZwMcNsRPFMLwUgxEwk/g=
Received: from TY4P286CA0041.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2b2::18)
 by OSZPR01MB8204.jpnprd01.prod.outlook.com (2603:1096:604:1a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 04:28:16 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2:cafe::af) by TY4P286CA0041.outlook.office365.com
 (2603:1096:405:2b2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 04:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 04:28:15 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 0B37C300028B;
	Tue, 22 Sep 2026 13:28:05 +0900 (JST)
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
Subject: [PATCH v3 6/8] iio: adc: rzg2l_adc: Rename num_channels to max_channels
Date: Tue, 22 Sep 2026 05:26:58 +0100
Message-ID: <20260922042707.116378-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OSZPR01MB8204:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d753495-75dd-42f5-22ef-08df1861ebda
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|1800799024|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KBAa7FqWS/u7hMXDnmnMf953NMpyYmLlE8hLhhVXzG3LKipxpkH4p3aNR1eSkF1HczLzF7E9q2RSLXd/TQnsZ5yMUTnUjGzWZwcrauuMef0oOv7hDC4u/BZoL7HIh7Fn+0xOmC+uHYg/GR5/kXbokC3n1XzwApo0tpBR7wH9wY0es+6TKQHte6jcA/iOPgA9NCdsi27sJjdHHYJ5MYrNkD4U4aR2v9WXpgAfLmGisFCv4LkwdunriuZZDRzAz4LMgHk2/fhpr9hPxaH+2XZOCuV9ROK/OxmklkKhGkqQ1PELLxk+4ADFKQ/Wz/OVgK5KAmC9n8JtuFckzqi7mSf1WcU74W+INmfsnCXn5gVWYZ9sunnfJT+ZPJb8IinkRM+seQedzA4gOHctNjrup2rBEp35k4eij6H+lqpDH/C96cSW5NoWOnd9P4oZfxpqOn4ICPQLAESpSnxafuxNeacW7GQmaB+7/tx9WbhLNtu0D+DufTCRdDtjm3bpvhR1q10E/Zyw0J5w1ZF1h1S0lkJf+p3TNQc4EgNa1q7Z/y9q5h1UlcSUjzliqQsspqVUOlA5pH4xTIxUk50jT1+t63Dbeoay75LiKw6NCQF9qGy+ojxbSeILpz1iXkEsRBKmlLxltVx89FSlra5gQ3gRamskg52JYNK0t1kKajZxPLmKBYHxp0TpNenh7rjxW+kDM4DSK4B+SpNV+f8k6itR9lV6WQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RZnds8gJk9JMhrEKd0lGBz9LxEBtt1bLyp4VHhDSF7PFbrSqRLPeO1xtckenqNZLWxduqnpHy67cLS4eoZQx9iipnNL0OPYFr8xJAGwzDrIL5QbeyQ1a8zsewz/6zRa7JtPK12chY6VbaPzlXOqS7AS037TmqOfEyzd0hu5WQ6bByNEhDcDtEoaGX4zLVyZO0HRZ/KxPmdfqWbYJP/KmF40Nr8woiEX1zwOSZg39EWzL+P5QW9kzTils1IvPGJtWojoYXNTlhIddz1ZOrlp0RtgVjM4k1g7cTHyhALhIPUdnHdr8VPlpP/0SF7yh3UYrWxBljEGhW2C4IVBtm6WUgj0Ug/Xd2zT84h8dq35yp7KW+cmRT6Q86A9hsdFXdHnxtEZ01WurVp95C3re9aQw4cZcNFdA2puhK/Ae6jY1Bb5cajZ/n9IPlGYYX9bNOzW/
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 04:28:15.7247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d753495-75dd-42f5-22ef-08df1861ebda
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8204

Rename the num_channels member of struct rzg2l_adc_hw_params to
max_channels, as it represents the maximum channel supported by
the ADC hardware rather than a count of channels currently in use.

No functional change intended.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/iio/adc/rzg2l_adc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 408fbf8c29cc..aaf7e2ceff8a 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -62,7 +62,7 @@
  * @adsmp_mask: ADC sampling period mask (see ADM3 register)
  * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
  * @default_adcmp: default ADC cmp (see ADM3 register)
- * @num_channels: number of supported channels
+ * @max_channels: the maximum channel for the ADC
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

