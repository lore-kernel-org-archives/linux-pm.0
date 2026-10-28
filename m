Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793227182;
	b=IumQ2NYdi9xH8v1p5w9REVHlnS04A+P+dqVTUV1Bpwt/1hbnrIcRHey7LDVSvlzeOqtU
	 PLjqHh/LaBeH21VkdZ7azRqjGasGYef5wFk4QjrD1pSfQtCNX+bY8p2jl19WV+WGXRKNH
	 RWdHCu29xKchcBDqy2+IOlzWHMWY0UsE68pwL7mohcBA31IxKp0+7dHxJ2QRupjpVOWrj
	 r52El78N1RuFm88FdvGED2Cy4rR8BcogCzOtZv5Saq2+6XRFP/vl9eSVMbGHifSq4n1fk
	 VQKKP41BrPXuKY2qxji4K7/SSVRO51o3//0A1ZMsuz/JXByyGjEEnJS9iQP+p6bqp/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227182;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=j7sX3RafLlaIaN494Bx0WHMb49Tq8ZcZXvj14tI892k=;
	b=BzAGVVNR/ehgw/qSgAbmgPvDSjeRUUgMAiwHiK8So5G1rKyrFy+GdJRWQq3nLdYXronT
	 bk4gDrIxvZ8sLG3i88GrwK3Ml0Ukljb9Ilv9A74S+CxXJSQ9xW71IiAshWaanS0mpBLS6
	 OnVutrLriM8yVk1Vhbvka4P1pBqavHJkCfonQLXziNTRwC4vbV5BWGbI0gfyzNTYkV58n
	 L7dkHpJPmRfb0SjvO4jB+on3JlWEbDI1wTznKH4Yo1u9tZQWiqjujLOF98hQCp7BLdrk3
	 yoKWpVxsxHXTXeRyAzTPTc3vpSHI6okHvyLkzLv8qW7MQ/mH6qxeH6VOA3/tHkOTOvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=B+j8HGIA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.52
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBF606A32F;
	Wed, 28 Oct 2026 22:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BBBF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=B+j8HGIA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFT4NiDrZzKbBSPvkMhSAnwICLgmdmVaYcQ7zSPQKJF9LE3jzbAmfZmxIvSLh6l0rMOFcfduBJlMwPJaVj5EPIifFWUkIvz0vCzOkRRzxJp3Bdsn5q92xZvdMWoxj7k++pcmtBn8AwAZ89gpC0YBUN6E7LCQJ7bLsauCFb8NYE8a/Qm68GWFFe4nra/TrLvEVi//oyFPm3HgUKN/B+xR/kCpmG/6qcZf3jUzmZ0jKcHqWQ5cmjDA9wL4Pdwz2VBcn0dRqqENXOgVLnv5oHYEWqVCtx25s5a2EwzNTo0FZnnAqA2V8R+2oteJu5OR0c57Wojgg1KDU0MjbzVYrq0o6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7sX3RafLlaIaN494Bx0WHMb49Tq8ZcZXvj14tI892k=;
 b=jBcLahimO5qSJLEp6zWuTYGmFOWOqkmKQ98LgbXMVGIAgE/E/qZ2ufRZsr7ATpWVtFLRtITDJChrP6aYVzhAvSP86l41zRdwXErjC4LxuVcQlMcJxr6GkNv+Cpz2FlZlgGPiaLRTNn/tc59B3zwGmzKESzVQZ5W93OhiZcqJVJ08Woe1VkayUQT/KJOwQQl0OSMeZsrVc75EsZ5Uqa0rVrP6tMo9MQLEY57zw7oPGoGo50maw/F7Fi1pal/1S79J9sh3ozhGcLGvuEENrgs64Q2Se6gXWu7hgN9eo5JwLcOCNzU5twH3A8x5plYqJgEIOy26UTqRtV+0dE07coHC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7sX3RafLlaIaN494Bx0WHMb49Tq8ZcZXvj14tI892k=;
 b=B+j8HGIAo2uoiom2v4zaMRp8D7fcf4RbS80hRBFvcZ0m6V3RgURwrDjHSPPtcwtk3gHo9RCnLgWG7Oe6bLsWrUUH6hPLEW//d5LbdcAPAQTYc4Uu7HExkqhd/88o9i6ePz/ig4bv0ilW8xMS7MIqSQzjkVMO1BR3wk8+sJAlf80=
Received: from DU7P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::21)
 by GV1PR02MB11141.eurprd02.prod.outlook.com (2603:10a6:150:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 22:39:36 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::34) by DU7P250CA0006.outlook.office365.com
 (2603:10a6:10:54f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 22:39:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 22:39:36 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 23:39:33 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 4/7] docs: ABI: power: rt9467: Fix invalid inline emphasis
In-Reply-To: <cover.1793225920.git.waqar.hameed@axis.com>
References: <cover.1793225920.git.waqar.hameed@axis.com>
Message-ID: <11c2308c9bbd739d3e72f0a2fc614232a5ecd6fb.1793225920.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 23:39:32 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|GV1PR02MB11141:EE_
X-MS-Office365-Filtering-Correlation-Id: 01da1e67-1ba5-4675-614f-08df3544584a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|261009223027099003|261022105027099003|261021123027099003|261021121427099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|13003099007|261028144727099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	ZBfVyu+DzUNBSpcJlet9DNkQqhrYuUB2pkX/rMK+XGUwUGxK3y8Ts8cp1hUlvuBxPChsV4tJ//ihT+AAhugy43E58WQltl6HOnB3vCg0bzwsiuQ5+KmL09NTRAkkqYsGz0iCFdYSVludLQc6fxADhJouY9NsqF7NahRqHGTqbBqxhF3sfY9JQvkA/tllb5zzmK/Uu50ZpmDh8PNpZMBoHcVX6rqW2wAuhrIeWkF3fFmx8ESfigk9l9QxozYCF8D94Ke7lg40Ru1x49A388Kvsu2QWgz+hoa34VTmuG2Y/8QRZB6j5ryrcnWXnsSFM3XauLrb+CKdsuBV4IxQJX9QtX0g7W8+DxYKnGURdjsvQZ+2FA4cZh3jxXrWjbqcloOwPkwzwBTepYuAjiLpv8Ib1PezIC8FYLTB7U4WaFAgm9fLjZ+y9e8TcYYSZ9VqOWpqfb+HYDKJxTB2xfNitjk+R4VGQLezsHpLAYt1UotIZ8n7GbTjXqUUDowUh+UODCdBfTgTGhhjkZTgaL2aACEKa4iRZbE0yqudRYvYdGhZhR3hcbSQbfwEETKgAae9FSFf2Ijlg4pN3iFzhBiqOpxD+N89y5BW724Y4SEf0xCX55ynyh/qLdoJD2DG6dqrxn1QmBpHpvUaijKtKvqlQ/UqMQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(13003099007)(261028144727099003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ivm5v7i8YdDdqxfqHuumGn+Lzywv6t51CaHSL7ftKcebxfDwI0nftZb3Xop+ddUFuW1FNoWE4CjyUDVPDyOESIVe1Y0GD0puDNlpCHryVvoejVaffNLvYWLiAu7/OaC9yTDJxnSFHzu1XwKHqqQBLMtsrZOd+MAuCmdU/+9Z7NRksfZfRDvKMxfot7UZDIAtDBhNkpBaKIMIf/vSSAtM9vA+oCAhyQl1+j7HXPROxC4ARyBdnbe/MD+xfb97SBTQ56exk1/QUK7hf2c7hA0uDgulYmjbjlpLuUiQHmWpLYTR/pPX8JXT+fDdwPgL/td9ettFfcut5fv+DkPg9bHST50e4Otj5esmAvL4EIBRksA6Ya/z0S+yC+2FLL6a/3j5yWtXl+bggTOI8sT+KdaTm4Kbw94yOZPuvtJVQevyQWhqYlN8d8zjD9Sr5QsgGikQ
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:39:36.4721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01da1e67-1ba5-4675-614f-08df3544584a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB11141

`docutils` warns:

  Documentation/ABI/testing/sysfs-class-power-rt9467:1: (WARNING/2) Inline emphasis start-string without end-string.
  Documentation/ABI/testing/sysfs-class-power-rt9471:16: (WARNING/2) Inline emphasis start-string without end-string.

Fix this by escaping the `*`.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610151025.1g5IgCv2-lkp@intel.com/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9467 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index bfbfd78ec1c19..bfb9c0f478e45 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9467
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -1,4 +1,4 @@
-What:		/sys/class/power_supply/rt9467-*/sysoff_enable
+What:		/sys/class/power_supply/rt9467-\*/sysoff_enable
 Date:		Feb 2023
 KernelVersion:	6.3
 Contact:	ChiaEn Wu <chiaen_wu@richtek.com>
@@ -13,7 +13,7 @@ Description:
 		'Disable' also can help to leave it, but it's more like to
 		abort the action before the device really enter shipping mode.
 
-		Note: use /sys/class/power_supply/rt9467-*/load_switch instead.
+		Note: use /sys/class/power_supply/rt9467-\*/load_switch instead.
 
 		Access: Read, Write
 		Valid values:
-- 
2.43.0

