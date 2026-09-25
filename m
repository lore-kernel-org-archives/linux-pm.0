Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E173009D4;
	Fri, 25 Sep 2026 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317055; cv=fail; b=OhQaKwS3tx2+h9lVkxUrHMLmUvXUoGexXMnvD4o1TKYLAvQF7WcYcvt3WysLBU/FJj0TjOydxcT+b9+bzU/xcenw2kM9y+dkf//a4KkznprrTWP4YiR8c8qy5XW6F9kzMgvOykn12dHMlMuxcAxCX0+DOSXprvyZT/qf0iwWH5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317055; c=relaxed/simple;
	bh=P817IUWsXE4+9OTt1GRPbWqyc/SYuvqclvrvfQdgVNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MafzcVn2OMBqxmOSWhl46ei+PHmiXcbuNNY/PoAaa6O456KPfVLUoOSoJVMT8aUZxJhGTiyYMbRlsKKYwmY+/+7CzLA+OL4pwmJt5Fl00JrhD/LY1gsEAkIDi/9GPlFKaatEsn8wukVgnFyev/4CaqhsBgT1RwFGXp6aKcFd/Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kGk78PPE; arc=fail smtp.client-ip=40.107.74.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kGk78PPE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtilQ/6NXEwR9Sx6GZB1Bn08Zg48urund6e5HoGAkCSjS0YmWvWrkaEzY911qOciLwekwSK67ckZEeApSfef4+3XDmtt7SUhPzOIoSfLOwNHL/vvTjQ26l0J7WfSHNihXT9ht88nY4Kg2B/ay51ds6jKR8Zb4luI3OgGKG+2tvgCh59aPdij0CGilIX3siGdVcT2bfL1K+wtQ7mbvOwoMO9JyqZz8uu4Mardkvk84m7oaYPvwxd2Ftl2KSoY9OD79TcXBCnFEvT5Zi+tvz5xKVJO3xtBJCWGNIWcbnTFGXqh6it7YSknbx7BjYOSV0Tu7Y4R/6RPGPQ5VaKeOo8INg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKIuC2A9ST3qmtvfdkyfr0qPKuiE9R2AeAiFs+sCPaY=;
 b=Nhho64BNpbXSraIyYOp4ST20bpR9NJHnf+ch1MHB8y5TPqV7lbd0LQVuWAB/XUsyyK8E0rJ1K3jlqV/80XueqJ2ezHjIUe+ClAAcP4AejApIO0ylWHTRUpG2dKnypliP6wdXR4lGIqsVHmRyf5UIvTg6XBm4MvsHTp2dxcv7VV5CGAJZiIwGTG7IDQ1vyJUnWX6fl939il16eUtmdOov4DWqONMkTPmnaOJtDOKAojKa+AnWb9OX0wGKdBo/KU70cmAbkCqTIwo+zV2wmoPm67rbPzbIJGZ07CZesqj8i5XuibZ1n7H0/5qONhnbzI7I3BSKHu+kkoq6SIdGlPhzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKIuC2A9ST3qmtvfdkyfr0qPKuiE9R2AeAiFs+sCPaY=;
 b=kGk78PPEO2Mv4gHd/HUYeO4PzMTTe0pEwsMuGPoTTWXxTL88SgkHKSyYaxujMwMf8FR2lwcY5vGstO0uGpbz1RHAEGfC3DYDDipg4sTluy6BVqK61r7MGCzLtWI8DtS3VCXsGXsuh/TRy3CB+dpTkr5PnGl48x6Okdq436bAyOU=
Received: from TY4P286CA0109.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:380::15)
 by TY5PR01MB18416.jpnprd01.prod.outlook.com (2603:1096:405:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 06:17:31 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380:cafe::97) by TY4P286CA0109.outlook.office365.com
 (2603:1096:405:380::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:17:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 06:17:28 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.177])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 318CF3000252;
	Fri, 25 Sep 2026 15:17:17 +0900 (JST)
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
Subject: [PATCH v4 6/7] iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
Date: Fri, 25 Sep 2026 07:16:04 +0100
Message-ID: <20260925061617.127349-7-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TY5PR01MB18416:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 596a2dfc-fd54-4dc8-ddaa-08df1accacf7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	f9IxFh1suQ/1c/ZrKSDk2hcq7Ni0veka0a1nVDLQjmHyKwwcF7nMRQfsjfqWryky8EdF6wkm6TW8LuuBAHclOogHDXIIoUvyPFeGWZdUkZypumiswONzp43BLaIg1fkQ1p1Wx1AWvsa1T1Ld7hk5/LFP6WNzCkl5P17B/Lktkz1YLxgDblJYOgDlQONyqIxMJ20nwk6ggrd9i/3+2BTCmUGWOIg8YnwJf/bhUPiEcR8C2/cocFRYODv6fTWGpHhojm2SQRxhf9gw36oadnzcz7u5FK0fP1gryMkFHJZvy25pyPY0B6i4504NwHlp1DF8dTJHHlJFx3M1VCK+qZ8X+B9MxvTQmCBLxD5YeeFw6bM55Bn3MFs3HX57mKcB5BtjaZsd7IDtTDTwwMJFexDG1tHCFKY1GF2v1KbZfsVCOAT/OefZoGdau4/o1eHU+gpz6pb9aFxqIq52eD9VDdZeeauwJidWlUbXWnKD3/sB6o/Ziz99mzltNJ/K7OLR9AECaopSxqSzTNVPrUiU9/DG5MvjRSlEvUXjf7ke0CnFcJl166Nqul1yIkM2nl2LaEZbVZObrpp8axJiDsG3xKqX8wv35NOXQbM6fS0zWosF6Mkt90bVhiFJ0qOAG5auhztQUU39biqaLNhI8G5ygSjZ7yRbhdcI+8xDg6Dp7VZf5xtScsG3fCQaTnrWOqhdkTAGw9Q0I2aCliu9kjvizw2/aA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g0ntIJYav93jYNoZhXUBPqshtkr9nCrbpHIfa1+G/r1xJYdKeHjF+FILBx8aoHrijK0es7J1l+xxxdgLxR8+Gvs1aJh1Es2FDMJBXWoWXZ5fxraxfPDpXwfXQHXxjZlugGobpfuCf20ybZIUy4YGrMxxREgxV1kP051fLtpVq6daukV5kkeZehfQNuWlcR1Gy6VaJR12BIDmmCqr7TBnbTi2ojIcd036DpmyBHNbBD1QlPYTEX91FRtIh13ifKq4C5beOLQ6Cy4eLdV5OmWe4Age4Vk/I/SLo9WkOlyj7N7zK8Ygt81OnOOFkhxGnHbjaUczU9BXVSaAJeU6UQpg7cN3TZ/OAVz2XhK+iM1F+GuRD/OpejmkBkubkaw6c9U0KASqYSof/xwFVg92LjEB+seDsJLlfBsKrTbPbnVQdFDiharUQ3S7MvlYEEPv/r+5
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:17:28.6988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596a2dfc-fd54-4dc8-ddaa-08df1accacf7
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18416

Add renesas,r9a08g046-adc1 compatible string and its hardware
parameters for the ADC1 IP on RZ/G3L, which is dedicated to
the on-chip TSU (thermal sensor unit).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No Change.
v2->v3:
 * No Change.
v1->v2:
 * No Change.
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 19b8f1a546a2..3b95f47445a8 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -500,8 +500,17 @@ static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
 	.adint_inten_mask = GENMASK(11, 0),
 };
 
+static const struct rzg2l_adc_hw_params rzg3l_adc1_hw_params = {
+	.max_channels = 9,
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

