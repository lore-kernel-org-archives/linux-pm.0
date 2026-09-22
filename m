Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010025.outbound.protection.outlook.com [52.101.229.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD23EB0FB;
	Tue, 22 Sep 2026 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051247; cv=fail; b=PmZ00VEa5WAtnJE5hKTTDGkpeCUhCL0q7FdGiCh1jw7UAKFs+9gsKeKhrQaIFj1HX2Bgbznt+sDkt1c6TAZoJ8ppPy/gsum40lCqZUiSrjk7gtHRd+XrAIz8wJOo/TeVRzS8YdwV19GxRL9YBRU85D04TqMczfKmwtIm6T20ypM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051247; c=relaxed/simple;
	bh=iu6ZP+mrDyJJhadskVYKBiRVq1daX4Jz/5xrUttsTLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TVM57fTglOH5QypYJs0pTx7zn/xjfK2xrP3LOlwjoNohHiS1bbLo9yiNtnkOLV0biSaUD7KwOm7Cloc8dAv3SUMKiQTllntaEdQf4kL3fP3Pylt3bGfF0oVLYyDuXsHDDG8An2YL2RMSbWg/0tMihQ1k+BrMTJJsyK+HWWfaSCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ExFNtdEY; arc=fail smtp.client-ip=52.101.229.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ExFNtdEY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHSOQyS+uKUcB4pYoxpvTTiJzLrvlExCMRz4xCEQnfXH0+9z4IwGFs7fO4JB3ZCKhdmZZS6qQ/icZ7CGQhZPhTWXf62N3kb0PF9r8QcYhO4B8sgWmvgg2uqFCKoBVSdPg1w+d9oyZVVoOwDW4gdYqElduozI6O7F+jQFTM+lPU27lxWgKnbdjeApsg+pdEkOpZ5Orbo+dTMxbHN8mPsqZVtkULz8HC8s4dirbEbqdFp6SDCsyFu8tYkdHLSb9fDQ+ujYikynT04exwiDzjZpGQdHY0qUy4oKVl9nIaEwLjgbUjbqEnfnF1hNLIyiCJCOyZH6eZvbKiLNAAd0BRvGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW3groCXdjb3sStvPHXIBEKSuMVSsTLXckb6WJeB2ic=;
 b=RxpS3ZNmlffgftq+yjfBiKTdAyZs2wZMxnZu97BCMczOdRaSvbsmvkyNz4Bx8HfQa+EQbH26uKfMaAiHHdd40Jo+vsv0kVLxbrsm7w/0XYUeM642uXKLZnmZ/n//qic/TEFMrbh+uqI3mVZPgzlv0UiDaLSJV/VESMuwz7fUvQ8AqCDZM4N+uy9SjTuqSvP7SCE5ccxtSBXPRgtUO7aKIaETF7v/gxRRaqukqcWDuTCL2UDEMUhDkGfvQui1oXPyIU9DG7+IBwpwa+21dDCzORVC5PDXmTaummEkLr6Xh7WwpnD6DYxRNkchl+56t+YxnTTJl8oq1UZU8jnZo5+eDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW3groCXdjb3sStvPHXIBEKSuMVSsTLXckb6WJeB2ic=;
 b=ExFNtdEYd48JWP9o39/wOHydGOQPQheZy8BnA4EjmaUicFuSZR9gzX7X/eWqtqkhBfxU4IBp61fqoLQ9eHwXv/lfcHyA1iJD+QtkDZYstSZ5bpCEJS4wsfwYxSLjMRrjgKawg+u92QfwbhAtGV6jK2gtXuYOdmas6YKqovAkFmI=
Received: from OS7PR01CA0162.jpnprd01.prod.outlook.com (2603:1096:604:24d::12)
 by TY3PR01MB10966.jpnprd01.prod.outlook.com (2603:1096:400:3b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 04:27:21 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24d:cafe::a2) by OS7PR01CA0162.outlook.office365.com
 (2603:1096:604:24d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 04:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 04:27:20 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 6BAD4300028A;
	Tue, 22 Sep 2026 13:27:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/8] Add Renesas RZ/G3L TSU support
Date: Tue, 22 Sep 2026 05:26:52 +0100
Message-ID: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TY3PR01MB10966:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e15520e-08f2-49cd-75e9-08df1861cb1c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	08Pd/HlJaW1Egj3SlRztmy2QYtjDYc8uQrXlRQb3UmAaL43KBrK1sChLrYuSpgQsxah8TSavE2ch01V1JW91iUi79SiD/zOHaH3jGG1o+ESm2P66azP/EPsDN7s0c+ytDj/p8rAnaytgdhS7/qR2ckTRJ6MDBPauhVzcdJWysBE4cwqKS8meFaPotOa1g7YOla4GcR9V/d17AZ2hHPSiRsUQsUj3eeyh1DJZnpE6a2h2zSSkQQIiWnBrT6ixunAv0UmNPXfa+xR8QD0MVGBHCvvmjl8429Z03p8A+Bnv3MmaDRd47ELXgXsNcn7YHXNQJ5/Ps4KC++WdOY8cpM51jsd/GHIdlQglRjCW3mwKaMtAQlFTMANKsVTWFXtZLh0YlObPav7U+9IzVSWTQSp0BVkwHaM92ZhUXVSuIyUIv1VM2za86ghd1XE73vpdqUCC0yWwWmlmQG8C9E28ZsqZQR9XsGPOK8F5W84ckZEQXL2c+aodEMDsagQtkcACGZvvMmFbHK0A7j/8GzUZYpRFmocKdsWxuqb6RTRkuzjPLLrFSVAkbtUHzM3f4gIC/o3BzhyF+oA0GdWTPCaxQ1sVLgYf9AFUL4ndhyOLo/Q5Zn/Gn02ns+NHYB9Uv1V1LN/miuuDCRg55nqeSlhZLj6D3050Xl2Yrxdv+1Pdr923IG9LkRlHp1N/9xd+cH5afGCLLpksEpDBZ5w6Udt3KIiVcA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8vEVq2MFWqJ+DxUnEq9HCls7WWapWWbNvc0FNkPvrsVy3MIaDaIBE0c5ca+H3gNzt4h4SRNTmLiz1/YHCqPJSwaoxDnsQemHRyk4ECGiACLYUjGUJfJNDAOtIQTG33s/9J2D0ggTqWpRcbuCKZwEvnABIGrxo7jd7zAp/KZ5h7paDgg06NlXQ0Ekj4xnyEdGHrl8BzoBz///cS13Z5MQJhqCczMr9wy3mv/N5Nr6QSi+mqfRPYj9EK6fOdYyM2fMrdPBlcHaLwtuLU+UNO7UvTuSJlOsQfet2F33/amy8CfZOb4OQCx2e9GJgmKFi1QMZmlWfrA8kJZLFIRio3vIB5qzCaLkjGbUv3Ab2zrPfQNvERn1VBvq1rnGmgeB5auTCXPPzT8eEODtafw6QipLUlmGxdrpqdmAa0UYxoVZnwY+mtNfIz5nVV8qngbWDtg7
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 04:27:20.7804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e15520e-08f2-49cd-75e9-08df1861cb1c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10966

The Thermal sensor unit (a.k.a TSU) IP found on the RZ/G3L SoC is similar
to the RZ/G3S, but it has different calibration constants. Moreover, the
TSU is connected to A/D converter of TSU (a.k.a ADC1) on the RZ/G3L,
whereas it is connected to ADC0 on the RZ/G3S.

Compared to ADC0, there are no A/D conversion result registers(ADCR0 to
ADCR7) on the RZ/G3L, and the INTEN bits in the A/D converter interrupt
control register(a.k.a ADINT)  are also different.

This patch series aims to add support for TSU along with ADC1.

Merge strategy:
  * patch #1 clk subsystem
  * patch #2-#4 thermal subsystem
  * patch #5-#7 iio subsystem
  * patch #8 SoC subsystem

v2->v3:
 * Collected tags
 * Dropped required property '#io-channel-cells' from bindings.
 * Renamed num_channels to max_channels in struct rzg2l_adc_hw_params
v1->v2:
 * Merged TSU and ADC1 series together.
 * Moved the clk patch.

Biju Das (8):
  clk: renesas: r9a08g046: Add TSU,ADC1 clocks and reset
  dt-bindings: thermal: r9a08g045-tsu: Document RZ/G3L TSU
  thermal/drivers/renesas/rzg3s: Convert calibration defaults to per-SoC
    match data
  thermal/drivers/renesas/rzg3s: Add RZ/G3L TSU support
  dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3L ADC for TSU
  iio: adc: rzg2l_adc: Rename num_channels to max_channels
  iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
  arm64: dts: renesas: r9a08g046: Enable TSU

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 17 ++++-
 .../thermal/renesas,r9a08g045-tsu.yaml        |  4 +-
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 66 +++++++++++++++++++
 drivers/clk/renesas/r9a08g046-cpg.c           | 10 +++
 drivers/iio/adc/rzg2l_adc.c                   | 29 +++++---
 drivers/thermal/renesas/rzg3s_thermal.c       | 38 ++++++++---
 6 files changed, 143 insertions(+), 21 deletions(-)

-- 
2.43.0

