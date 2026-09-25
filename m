Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010056.outbound.protection.outlook.com [52.101.228.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D03C10BE;
	Fri, 25 Sep 2026 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317000; cv=fail; b=cOkUeiM0rmNk6M+0Y5YcHpVDycHOtJuS4S3527p4tedXecCwZaXT+WqDk9SrF+hEocaUe2Gv/ICzG4A7AjqZB8x/mzlIDasrmbGhoUPfyl5Iezh+AIUS5c8N5taVNs+sznJZFW2j8F0japsuAGLSnSv7Bs46vwEXe44tlLsGwF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317000; c=relaxed/simple;
	bh=C6brluDpPtAYv5aac1VKaSD0jUDUWCfqO8Hi9jp9APU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EnjA85y6bW2OQVXRHyEtYqOcdA/xW6IsQN/ymkJZCWTyg1RkXhTmv74WEH2wwJwZxUsK1SV7t2EsV8LcYH6xelLmgnMUdT8bxDhT/lgfvy30EPj6IXeC+DZIohMTvssjzZ/sNTp/OT8GxnWedqn1ucWihzPGlbPAqBzzGiu5o3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=jmoWSP2D; arc=fail smtp.client-ip=52.101.228.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jmoWSP2D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaOBp566ybdsCuFOrmg8id0edDH14aqwZ3yECU57xGzkyGvlsv7nHz2UikUuSpQ/r7RHHqwbgaO6WlxFeeC4b6GQLJU6jkc7Wla504+uxGoP0N/cHllOQZzub2WOp6xw0W/5WhDF5BASlzlSXPDlVcDAzrWKq62a9aCIWXAjMK8ryWdP1m9FqXatFO/YSdwM5KE2vlQl1xOUs21y1ZYMDLsGgdBgNHLjP47EXgJAhfG2oyi07f/XmWR0ATqZ4woenpe2a0wLlxSA9B5eEn6rMXoG1InIRqap1uzaFuMA1Rg+HIdqbw0dP5PeAQSE4vsPdW1wQCLOc3RMB9mjiaIh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=af9q/LpxJCGxcJs5TF4vNQetbSrHPR/5YD7TaFOMsFo=;
 b=A4SZQA+7VDqAaXBfPaDYisJ0MLW6Pj2DoQSGungHYQrDoMmsy7skpfLCYk7AKn3lhFCz4t5C536/KtIndatjSFDA3PbNaoLZGmI6u0KFhSDYS+4mKYoGWHKFlO7rjYI/3dsyvtcATDHl6GA2C0JvBnxpQYy8JyklsE06eSsHbEeVi5FpXb/eNNHYhlfi+8/QRDJpy/0OOKfcPfW2TyLEaJPtXGbM8pjVcVOwrD95fKZ81j/XiuSDB/ps9R2kysPL6sGUW80/JC0g+hMHC9o1k+gOCVEKKdxQ4gMgH31FweqTm9yeiL9hsV1uTdoPy17J0Cex1ExrQMmPORrx6f1JGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af9q/LpxJCGxcJs5TF4vNQetbSrHPR/5YD7TaFOMsFo=;
 b=jmoWSP2DKcAwqhXJHPJpU/tQMdcz/rW4Feh7NtXytPUq97BpLkUqFI/rkuwzJwJwpaubyaLOtzjIiWDx3qdGC80ej91TxONEfDimMbZ0gDq70u8RJ+nNLHZBh00kHEi/3XuMFK97Uoqrfotv9B24kHu6kftGUMbJhF21Xcdrs34=
Received: from OSTP286CA0109.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:225::19)
 by TY3PR01MB11891.jpnprd01.prod.outlook.com (2603:1096:400:40a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 06:16:31 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:225:cafe::52) by OSTP286CA0109.outlook.office365.com
 (2603:1096:604:225::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:16:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 06:16:30 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.177])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A4E693000257;
	Fri, 25 Sep 2026 15:16:21 +0900 (JST)
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
Subject: [PATCH v4 0/7] Add Renesas RZ/G3L TSU support
Date: Fri, 25 Sep 2026 07:15:58 +0100
Message-ID: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|TY3PR01MB11891:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8389f657-0878-48f9-0fb4-08df1acc8a5e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|82310400026|36860700016|376014|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	I7o6MwEuirot3C/MaKOzPCiEk9ZXRufLNYiMLBuvxRFI1ekHUB5rWFiDIp8eZmz1jkOE0KQz3AINxCjo3dcTnr4PRnhDd8WVbbyDgVNCwrCBeOBFSTxQ6c+CzAlr458rVCkv5gZQbN0Ru4NZaT9f2fWBkBCUDjICFnm5bhNjZtFyezWqka4jYVH+IU6yBunwyFiS4HQk01everjbMV2ztDEWZ7zOJYPlkzGwCe6kZN6dyCAta6e6mkdOQgGL+PrjsoG0isbtD0AyvKUaZTl/O3iNiyshiDxaOA3cxP8uZoHiYw9Uj9/HI5aMXxtZBzu6bU6Glqv77nkBprbslqmtEao+51L16raAV01kbpOPklAtQoSeznUK4/ljYt83L9e2qOHF2IoNaxTyarhVe8+TKQP4BhZQTZ/XGh4cxmq5YDMZW3N6/TW5hwr7OsjfEQkTAcfvAD8Tzw0JovcqoHg+HGZXYxJ8QIQ+Yh9nFMId3GKCd7dYGZ/IKVDkju4QWAs3hT3qxuq0ULYXvcAdaOylTtNvbvecXffzmCUND0GdIKFhg5N9WMwqlXWCd9zICy9dnkJENSSZApLJtCNj0Ax4IVhvWvIk9CzsEPYxUQCK9+xhK2k9gpDnNqMNomvh+jmz77cUWuwIATkue5mp1kI0buLq2RoK5pBQ9+S2RiJ+yGi5N0HdmD5T33XgmP4/v7nY2jXExDnrJyya4RyMCkjocw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1J3QEb9iaN+PLpiYhGARdJLZmJk8QCJYOofbOucIa1zrljqSX518Gl0hL+WsuUar/BfwKZ1x/J3J4552eQeTDorVW84ZCzAgxvhEZa0pN4ZxPQzdTGyHVOihBKG/fPyAztyt1lKL0z9pfWFuQXYxJieWZXkHrxgLkHA5zFKCbUGJr66u9ZckxRh91JXtGKyemU6HBC1ZjIQc5LxRWJ1xx0nh8Utsraxuy14SE3e3wvNRAJUAa9D/UR5itsJTGqS5isW7L8+OlV/yITmCiEqGf/uLU8OLh5Ehxc2QNMT361SqcOyOcBhyeJM37PEBlNKPMKZD4oeCFXAms5ZHGAZCqn4jFSx+yO+xuKZsMO1qD1cKpY5BuBiUQOMWaQJ4VLxUu1XK7jLV+4wzmgtiu+wnd6YijFUt0wZ/70yHvNAjGBUXXX83d64c6Rs1cStN+2xN
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:16:30.6339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8389f657-0878-48f9-0fb4-08df1acc8a5e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11891

The Thermal sensor unit (a.k.a TSU) IP found on the RZ/G3L SoC is similar
to the RZ/G3S, but it has different calibration constants. Moreover, the
TSU is connected to A/D converter of TSU (a.k.a ADC1) on the RZ/G3L,
whereas it is connected to ADC0 on the RZ/G3S.

Compared to ADC0, there are no A/D conversion result registers(ADCR0 to
ADCR7) on the RZ/G3L, and the INTEN bits in the A/D converter interrupt
control register(a.k.a ADINT)  are also different.

This patch series aims to add support for TSU along with ADC1.

Merge strategy:
  * patch #1-#3 thermal subsystem
  * patch #4-#6 iio subsystem
  * patch #7 SoC subsystem

v3->v4:
 * Dropped clk patch as it is accepted.
 * Collected tag.
 * Updated commit description for patch#5.
 * Updated kernel doc comment for max_channels.
v2->v3:
 * Collected tags
 * Dropped required property '#io-channel-cells' from bindings.
 * Renamed num_channels to max_channels in struct rzg2l_adc_hw_params
v1->v2:
 * Merged TSU and ADC1 series together.
 * Moved the clk patch.

Biju Das (7):
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
 drivers/iio/adc/rzg2l_adc.c                   | 29 +++++---
 drivers/thermal/renesas/rzg3s_thermal.c       | 38 ++++++++---
 5 files changed, 133 insertions(+), 21 deletions(-)

-- 
2.43.0

