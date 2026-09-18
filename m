Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010045.outbound.protection.outlook.com [52.101.229.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295094FDA5A;
	Fri, 18 Sep 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744164; cv=fail; b=RbRl9egmo9fW2C/9YRTXVZNg5QkXi35mKiKCcqY2fijQC1CIRJ1mSdnDTc+NlUPufLIbHS59yNn6+8is/ONGIEy6xzI52Y6VMWfFK2SOB0Bm9wW/XkaCQiLCHFdJG0rHSQFVYNx8Y64xayURoNdMf8k2nfDFZhluFGm2UddxuSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744164; c=relaxed/simple;
	bh=q3oclApbeHWsHokOVdyJF20bG+2vML2EooI9yJ/dkQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7S3ZbQMwlYYWKcEpOvlpL8EQmsq1gGgPqmuwQ4bdGUBkepDWYuQpKcdZuEPfWXJMENCPX4/COURgGyYHkQ2VnQ/3/NUax1+zCPunVCmJak4X9kPylguVMehXbYkrClcdC/BG40eNiQJyjdvSRWCWsVJkUk6Lpp/FRYYhvdD+hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=h3wIxEkC; arc=fail smtp.client-ip=52.101.229.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="h3wIxEkC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+SzLCFd3Vw35nEa0S1lanuPwsATlIYIi76VTe+hW8xNzAz+tgi13xTnOK/MAGjz8zUI4mYQ9k69WCfSe5m7NQ4bXzrflQ8IQ22hGktcKL82EAmbyjLinGXtjmkQsZKTb3Whc0L4lhGHG+LGESYvPP0oJzHO4RfSc0DnGpNa0Udx0W0GHnO/DwmCBQ7esbJwFI0X7DXA5ZPv6X47oAp6CUwdfeYRTWaffgKnS6PjiKKelztsdzWAw0J2Q8F3xZ2gJdhfodemQ1phgV718VHwYrVcWrVvuSLzwYFh/8KbqITb9PE6W+xlphqOHybUdwSBLeBXwss4ydU4RZW/L3IRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aN3++/yh1Zg5o5hX8zzcYwVYlHG87Pr2zhFXSxoKVg=;
 b=OQ+8gmsaiM/XqjA6TZoQysoLYVv+jXuW/jHl5J0cJ552hWg9+QNI4uo/jZR6qWwWIpqS7cLKDrgJB0C+W8UfH0n4ThnCD7HkGjxGRGK5q5LKwWLBmMcgaUSarcfHqW145imYnR8c0h1Y3cKK/hVkoaDiyGGyqBkHHk9hRsfoDVtn6kqx2rzsnRSlCrQnyVN6+BSLkU8/IfVkuPik/pectipooutz42NnJtYDP0HH195pbcA3EenWfj8tnMq3Egh9tYkw2pH3ORS9Z5kG2AvEABdCGKeLCzB79fucav/Q/BRnbfjq/maiB2FPaupgxydjnscJTs+BZsi9YJCwxcn7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aN3++/yh1Zg5o5hX8zzcYwVYlHG87Pr2zhFXSxoKVg=;
 b=h3wIxEkC1kTyXwNQeeUwEHM9EcU1uDheE8IwGp7aFAvofe+f4pZMJWikOjhgOIcw65KEPVP1SceosCOegkGzINFE6YaNmCmn4jjxUmueI/44XtNDXeBqBmzqvgbaFjOSQ9xDvw93wgZNP+WKlTnirLoUK9Eg/WWXT+Y8YHolokE=
Received: from OS7PR01CA0030.jpnprd01.prod.outlook.com (2603:1096:604:24f::19)
 by TYVPR01MB11168.jpnprd01.prod.outlook.com (2603:1096:400:368::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Fri, 18 Sep
 2026 15:09:15 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24f:cafe::91) by OS7PR01CA0030.outlook.office365.com
 (2603:1096:604:24f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 15:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 15:09:14 +0000
Received: from biju-VirtualBox.adwin.renesas.com (BGR-5CG2270RS1.adwin.renesas.com [10.226.92.53])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id DF98530007D4;
	Sat, 19 Sep 2026 00:09:04 +0900 (JST)
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
Subject: [PATCH v2 7/8] iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
Date: Fri, 18 Sep 2026 16:07:24 +0100
Message-ID: <20260918150730.122056-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|TYVPR01MB11168:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a3fe6755-7ee7-4589-b27c-08df1596cd9d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	wOuCupC8UeR1AQ+LC8ycGV9+tS2zR4nMBCBu1LATY7bGRuDm7nREOykEo1qHu7dlRkelJaVUqGtGIUDwOTqDks2uuVCcxG6+SxU1ReG2YVGkrXIzFKMUHfDuvFWFqZthqxVGGeUxwCiaxjfMPsvHP4KLOd1jduoUvJMRGeYsVcx17pVV9O0yQLpJccBZsZym8owLK28GogdElpVgWT5OGkR0xZ+92Ydzgw6qikmNTvLnUgx2lez+8eDtIQUlrapAx/nHsiOltrn2ffwBTmnS/OErg9XWjcXhDSVE0hPWWOicKzT2pby2Ypk3LjrZyCysMul2esfeJaUXk1yn9SNz2+zez8Zuz8pPdqtTNAOEl3jAvtB8PQHfpmBw9AwqkQNu04GPyPAltKRFf7lSou0Xxt3R7ChT0Y3X7sadooAA2x4ojbxn5sJokzOPCAmPkZnqNW5vbdjgHNdVfmeWuCrz4W9Z9P8GU+SZVg/unUREc4JWnCl8HvtuNp0pp+pzMM2HP3lUkYBVv/zJYWlHl3xQ1UJMBybQ6dG1BXlPF9rN3MNmNHMNg3KvwWlUVk7ly16MC4IU2+MRH8lEsEZPCuCtWnauMZZjpv+cVqTjbB+Qd5jT4VHeRL6hOJIP1e0+IP/BIFLXXxUCS7DJooDDvtEEGkXs9bnB2yZnsXeT6TyU4cHHilYKnNRA0k2DcsOJhm6UDhHcsPXZvPl1Y96oSX2U3A==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UzymEy1y4GzpIkDOpWAcJcNZJIk1UqHYGSVeDKTZ5Z7JMLBja+ouQ2wlo8WEtIYVZC0br5LGoqTy3o1T+OabUeCdW4IchcFrJlQ2kVXDrRUpcUvj2SyAPpHMTD6KSJq2m4is6D9ppQeNCWxZu+xSWGx+MP95vwHVXw7VKUQUbSinliVAXH4hJhXBGH4AzwkRFleinc+iYYlmTlS16OIWQoOhO8l5Ls8iJwcwAekbk7AzImq9kpgC3p0UYs9A9K8jGTO92vmtEaYxtCQe3GywJFW888bjJBceyW/EPpdj40M7iOOvk1PQKZKgZcxT5CqjAmaWB72zQMjjZ2UbalK9KwPq41ViRj4J6fX8BrE08TC8GcX4E69hj094A84KzEcDuDVw4NctxzXbzhXJW5q1olwfQfOy/uKAgUTDh/NqkZbcH0q6awCWp6xeZH8EEB6C
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:09:14.8344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fe6755-7ee7-4589-b27c-08df1596cd9d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11168

Add renesas,r9a08g046-adc1 compatible string and its hardware
parameters for the ADC1 IP on RZ/G3L, which is dedicated to
the on-chip TSU (thermal sensor unit).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No Change.
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 408fbf8c29cc..35eaebfbdd77 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -500,8 +500,17 @@ static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
 	.adint_inten_mask = GENMASK(11, 0),
 };
 
+static const struct rzg2l_adc_hw_params rzg3l_adc1_hw_params = {
+	.num_channels = 9,
+	.default_adcmp = 0x1d,
+	.default_adsmp = { 0x7f, 0xff },
+	.adsmp_mask = GENMASK(7, 0),
+	.adint_inten_mask = BIT(8),
+};
+
 static const struct of_device_id rzg2l_adc_match[] = {
 	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
+	{ .compatible = "renesas,r9a08g046-adc1", .data = &rzg3l_adc1_hw_params },
 	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
 	{ }
 };
-- 
2.43.0

