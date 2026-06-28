Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738312E7377;
	Sun, 28 Jun 2026 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684085; cv=fail; b=bOqY3ka5PxZaNEtL/ii99kBC7jrFcIAoF4d/R2Dc0rTt9jIM9cKie5BseFEGLY/j0BYCOnOaRMtRaGdg39kXkPNLGfcqths9JgYNdAgLpAfezzy+/PGSiy/Ia+bBacl9Lh7BzU6JoVz6R7nCD2XnCJvNfEKYABEozyUWJDjr1ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684085; c=relaxed/simple;
	bh=vDNb7BLswjeNns9h/BKhZtdYzn41HHLxfExXq6Yo9sQ=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=T8/sGj2GECrdKx8D2v7zzVh9HzegMuTpCObYD1T1niQIydwKz3Z5lZynpBbUSpTJhNL2ZiB8WVXpUnsavxWgMboMHDWSJuiXNqdEtIOvLmksRmmps/sCvEJoWbbeMzU+WOldc7APjxziqOtC0losJMDuBFU3l+uX/OZOnwq9YQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=eeuasa6v; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="eeuasa6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+A3hHBjTusX5odvfUcpITXdOmj1cm0E0SlHmsGR6hrfrdkGlfGcEzr7vMqvUI0FyfsBOS+D1Cc8PPBAXZE3qqUNKlTsVKvkX6tLUh2uUU3J1sCJKJTO5Cp3F8BaJ0X4dqhgwvRwWTVqgne4sZ7aVDp1uWvpgC85oeIKXJ7ADsocxoLmXBDoACXT4yA1sDid3UCaDGQjvQUHbBIV4FM+tTCDFc2BQYFK07+ox2ubFsrI6RSILKKJwqU/p9277upHq425QWKXwOmqT4q7VIDNRbE1TL0hzkiATAs0xfkE6uCoPNZ1VdaVJd1vFbYsSuJPauP6BfVrDPN7ZZqwHUi6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqbnirpec3NiA2n/qCEnQo5a/2GMoYWy8kdmbsF8niM=;
 b=x2onOGrvB7DJQVGb+wytoKkXVE08diJ+1P+tCrZXgMpwNhUNN16IFN2eztv0Cabra7J2SwqTdNr+TZSWdBDlNTWOCMBPxagyJ1XQ7dZBlXzFz+g93U2hI17clZ/YTkt1cIde6rTqU7OsVKYaykqaCV8ockcGVqTarMjBzxg46eP/IQzLpkohfCNNhjYsAEUllIAYFBazvPLmtzMBRkLtEJSPfMWOTdrWgQw8jgKmHgfUvlN1IiyNpBqUAXgBr3IoRUgeIZpFbWaFLi1jj12TrqUHINo4nAuPxNbFCg6BVaM8jcGn9IkY3GamYrqrPFUA1sqLtNmdVb6vEW+8dvcHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqbnirpec3NiA2n/qCEnQo5a/2GMoYWy8kdmbsF8niM=;
 b=eeuasa6vfxYbPMR1Trf2DCL+eDX5K4G8v0FlU/MI0oaj9YW9HCUV1hW4+h0n3ABBOjrp+WJAh4/VL7s44zBEzJFt/7aAxw1zXeJeIhYTXYSajfpg8LS0yNb7LoSbeZbOOazjQNZKQUyyM/klrbu1o8VxKXkHebeBtboeYcKAShE=
Received: from AS4P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::18)
 by DB9PR02MB8322.eurprd02.prod.outlook.com (2603:10a6:10:395::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 22:01:19 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::77) by AS4P191CA0003.outlook.office365.com
 (2603:10a6:20b:5d5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 22:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 22:01:19 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 00:01:18 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] Add driver for TI BQ25630 charger
User-Agent: a.out
Message-ID: <cover.1782683551.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 00:01:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|DB9PR02MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 044c3808-2c9a-4ccb-49dd-08ded560c8ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|6133799003|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	uyDoKcuieP6dJBATsqgwp9xyVYSlWxbMb26VrnysL8AkbjnQyQ5DInRoy5T037YEKMzJNcP8umvmvpLGbd6jUG93/vKaFSbMI4XD9TGMxDSsSCArFHue/MnmJJKFriOe247ZoeJ4bxcxbpNuJA8cj0jUwwOcQwhblf8ypLz/do3V4vYBCARatCcl51XYKLVGiwaI6qn95pXVc6rQTMreznZqoJjkU7rRDN2VLXTeU6/LwaidvF+8rV9caf1TNeVmI0AAjuHzSN1fTCMpjNlvVabrbF3gCHzdBZWNUzefHUccjn18iznM2H65urd2OY0nvobXDYWYWqXiVdtwPWvZr5d6xVR7l56RJMe2Q+hsIeLj23HVS5QIUlAoM8XO0zjGLSClGuXJKVFqLxZfpiZdeGKVSQA1HBwnSrMrp7YUhG3PWK7FiRO/OV/0b6UYc5hs00E3q3/Pa0XWMTqYhvOExkXMXQvgG4Pk0QeUjujNbxFweuGvtS3UEG77SfpzQI5g8qYInDHARpPX7UYR/oLgJjk/1LORp/OnrYX6vbmcVRTpgvai2+E66bFZ9aow5Ea7bEVTkAsUGRV+8r9FaiiLqFGVIy2/ALjggA6IvC7kT5yuZri8L4+tkBc394o7ukV+/ajsRZZYO/lQaeogCggpyu6n15xxKo3abG01qfi7CtsnwW/C4/7TE3eLMlqcxPCayAHAR4zs8aqKIB1+cDplFA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(6133799003)(13003099007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6jjFCtipFdj/dG+6mtzSJkwBF761wKKRSEmUnrfJfYccXJ2f9EpY/DZxCy79Mtk8u75DdN/CO0Sf0LWvl5bcvOhHb82cEz7HKFCphLGIgf2ixaworTiGZTiSwHugHTsEvpZnzlqSfJOVu862t64NFGDO0fwaxpva5gJNaXP0x3kG6J1NnU84FIHewAdunWHjIs2YjO3a0lA4Zvw6iUKYau4KkkaPmiNe3sM8COpDn/U5Xab/fRkRmOBQrFROZImKSe6Vbo21NGuH2cGTkHD0i/JLLhtswBTj3x+mJ69pX67wGKCxzKTeKckRHFYWxj7rNwCHcK+mda5UTbdCUhbacC3FbMnsn66SGIz38X23Sil5XVekBzcOsEbSQ6pX1eJqlB1SBvVCbQkKKlmwo/RcQYoS4jtfFtTluB4szADDNeKxtfwNB+nN1+x2GuvMZxY7
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 22:01:19.7384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044c3808-2c9a-4ccb-49dd-08ded560c8ed
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8322

This patch series contains a fully working driver for the basic
functionality for the new TI BQ25630 charger (see datasheet [1]). The
other "advanced" functionalities such as USB OTG, BATFET control and
liquid detection, will be handled in separate patches (after necessary
framework changes) according to the design discussions in the first RFC
version.

[1] https://www.ti.com/lit/gpn/bq25630

Changes in v3:

[power]
* Sort variable declarations in reverse x-mas tree order in read/write
  property functions.

[dt-bindings]
* Drop `description` for property `reg`.
* Remove `|` in `description` for property `interrupts`.
* Remove `monitored-battery` from `properties`.
* Use `unevaluatedProperties: false` instead of 
  `additionalProperties: false`.

Link to v2: https://lore.kernel.org/lkml/cover.1781789320.git.waqarh@axis.com/

Changes in v2:

[power]
* Fix return value check for `data->regmap16be` initialization in probe
  (check was wrongly for `data->regmap16le`).
* Remove TODO-comment about BATFET `sysfs` ABI (we will add a new sysfs
  ABI entry in the framework for this).
* Check registers `BQ25630_REG_CHARGER_STATUS_X` as well in IRQ handler.
  Because there might be changes that is not necessarily *only*
  triggered from hardware faults. For example, manually
  enabling/disabling with `echo 0 > /online`.

[dt-bindings]
* Rename file with `ti,` prefix.
* Remove battery-node in example.

Link to v1: https://lore.kernel.org/lkml/cover.1772201049.git.waqar.hameed@axis.com/

Waqar Hameed (2):
  dt-bindings: power: supply: Add TI BQ25630 charger
  power: supply: Add driver for TI BQ25630 charger

 .../bindings/power/supply/ti,bq25630.yaml     |   55 +
 drivers/power/supply/Kconfig                  |    7 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bq25630_charger.c        | 1073 +++++++++++++++++
 4 files changed, 1136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml
 create mode 100644 drivers/power/supply/bq25630_charger.c


base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
-- 
2.43.0

