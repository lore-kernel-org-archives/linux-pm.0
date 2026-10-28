Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793227183;
	b=1BGcBwupO4M96Kcfbm3ZM0y9PBonqTHBZuh0hCMvzCv9WhgF+tTDBHfU0CC/5yV1JGsb
	 F+i7hhE+RjBHYgLhDtl+J/M7b+ceowzbHsj22YhsYocawGZ4Kj6H2h6dNcnhsbjRzpKFQ
	 XrqH89oJyQo0ZNLAxrY8rCAnJ9FI8UDHHyDuh8esytk939V8Xasd6vlYY3nM39h9H9FvM
	 TcCGgWvOlmVTWdnCe4vKsHSFQXlrT/IoAmM6wTtPT7H4X55YkZIlhroh53hSNK3qeYxw8
	 OLMj3Iat3YhoNAj781/20jnmgR7dWFndDXAYEhlC66/+d4fjuLPkP9NYghGJ45IYU3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227183;
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
	bh=MnaO8tPjy9eYR2EY9s7eUwXJks91sV9nbTMtUi5BlwE=;
	b=JKWotxz+cYPyTklrklziT3l2t5b0FTUbeaUiPJokUwjaaFxaFfSr8T41oZL6Jr7y5Uk/
	 yDjjFkxVVkJ7fXhBa3PdCVlCNBt1FUg+uB5q1CZW4bkSieyRiXCH6TXKYozgeg08MSRi9
	 yNb+Xpo3OZ6UFkdI/5AL9j1VHoSOoMutq1B6xKD4+papT7puqmt/dO3z6fOxyitmzPR+Y
	 Jl/71iTgQdbNzUKj7jP3wgapcJoaMtVJTxe0YinLB1D3X4o7re5LmM4oqwExhMB3ZCIvV
	 HShBIrneSDzuNRlk50MlXs4GgyRJp4bvLKuhIb8S6d9LU8qeh8W597X8iDBV7IMO5Tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Yx4sGMzZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.54
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDC606A336;
	Wed, 28 Oct 2026 22:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8EDC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Yx4sGMzZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKMrHkpwwWWbLis75b/Ld2ig3CoCaxyZa4vHH+E/g/juYEzSRFfL56gzZ5V5ugXHOBlOv7vAB3TAw5xEY5rTxKy82LYmxaLptKXDE8jdvY+NlUdV41uy3iryrKRTr7/gw6KaWw/O1cyk/Ik3C3lDYQcQSSgW0y/oWBwtyLWTLL/WniGAD6nAqQ1YAghyBraMjouso4UMYdoxkRhcozlyd36TB9oMYizunLeYN0hcxGgWrbj41Cg6H0ZMH8W0joF9nc1oX6Lq9upu4k47APMTi3qFtaa3guLMyUEqLTzC17gPBh9OzMmeNtnNflX49GiZ/GXLPpT4plUXNh0TmypO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnaO8tPjy9eYR2EY9s7eUwXJks91sV9nbTMtUi5BlwE=;
 b=ishmzLbDPhvyf/2Ot1yeQMhiZy7nhEV2VJqAlbrLqRYtjxGeJTo7JZ8iVy9p+ExEgSpJDhwk2gqCKWLt0sfi3XeRArDp6W0L+HroEIA8ovLXyVRF2qnslpjZYmMmam7CsbfqdYk1G5euf5FV48dqPNEGfp/1CtspTHjGg6YNlg5uhDkGmBTPOvSWYfR/GlZJAPCjHp+gbZNCd3HmpZS8LrATtNY9SrPuxWw65btoo2n8xT2hlyQL3tQkOiShdDxa1bcFpBKXec6s48pfFIeGJTkI9LLRuAcM3rCVRAqLZ0vhbbA9unpSbRpUaZOhUFKchhteZDeP7UBzSOvBDAXUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnaO8tPjy9eYR2EY9s7eUwXJks91sV9nbTMtUi5BlwE=;
 b=Yx4sGMzZ4WW8W7g7R0n5lCXkb56q+iSinOTprf9/BA+CIULHDTnqujJxWRGD6DXa1WGYH0kbrOulzXORFR8+kXgUpRbdUr4zJ8jStxUOaEYO3Iu5kLUe8f+oUO8j2KN/BJhg8pJ0TfyZcYDorPrUtExqtXK7ZuybwdL461chVLA=
Received: from DU7P250CA0026.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::9) by
 PA4PR02MB7040.eurprd02.prod.outlook.com (2603:10a6:102:106::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 22:39:38 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::84) by DU7P250CA0026.outlook.office365.com
 (2603:10a6:10:54f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 22:39:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 22:39:38 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 23:39:34 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 6/7] docs: ABI: power: rt9467: Fix mismatched quote
In-Reply-To: <cover.1793225920.git.waqar.hameed@axis.com>
References: <cover.1793225920.git.waqar.hameed@axis.com>
Message-ID: <0f2be3c01b9424746af97ea848f87433c70249e4.1793225920.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 23:39:34 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|PA4PR02MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 280c7c9a-1231-408a-2f21-08df35445965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006|261028144727099003|10067099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	RDc49IeiVQgSk/1JLVON7gdGkXPeIdebgCbJps6e4k9AMzF29RgBb5l4eDIWEA87TdWAYplNmqBiWljxOjn1kegpgd1GTChRv/EKuQI1Qa2MoHyBO+ZIowRk8Ccl//FOYO7TRFKY3r+8SlRceM9qX2fG+kmME9bxhYR7Pj2oGKfYufakoKSwaonFYka6u4N55av2ZNV9oWSuqDQkHBuhrP/4cMXYA/ZTl8C8tGoEVijGT6qSjEJ304IwIiVwy9k2vEmHQY7PWW13Zu9dbmQD7NWYSbyrIEGQHBrR3dD8KnBE0ViKOnN3E+IHF3+UZk7Y16qH7HqzMrunca5FpSyVKtqozO0dpR+6cSOjxW8+i/051Qav1MTIYkJQRATx/v5TXElklW0bUK89N61kOjldj3ElAx/TMFRXFmESNVeG+ikvd/BBYSQa07f2kBpsRbCN+3yLrurkncMhsTBILltBl/EuE1z6Dsmw/AkuMcfVM7wu0zfw5zPscsdIpVvSdPhnHkdnQeZqG9QG+9AGD5j24rs8qAkNQAX5RCDGi79cOpylTVgHr/qq6XcLujv+ve0O1ouEhslJtXj5y6nnhPm19ZDQ+uEt3IifbKtlP2GAjgMfzNEt7MA/cSTTpu10NH/CCk29vJ4Z6LBCK5eDlpOu66fXRc2rTb1xECi95rY/t1U=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(10067099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6p31U4/cS2Y8wV3kFnCwc0w5YQBFMzPoke3VDazB45zZh7y6BAt1bqu0+VW2WcJYUzyJ8QpdKMF9JDDMytBYZX9BoqOwPhFtcqi4ObZpABZ6NXYQIFJfNBqEhD3edMhdB22UiyEaClWZxU1G/pRyb5ZyuPgJx9Zs5o7oFzUnG7FRFJ4PkdlqUEVFvFCFTAAaY2U+Dol/nLF/f7oVnms3AxaY5/hxPyGm0IoGwljYS/jGrWbml96ROpRs5kaLNDYXek8aSkTA01V6B3qBIwTy0gcZYYz/rH+SQWNipAAR+H3W2Q4WtafZxSkwiGKADGAb2xBZiNABokwBrdkmxh0U8mPLoFYBxLma/E9uUw1es1uhPBlbIhcD7XZdWE0F9A3tLORK7yKqUzyj33oWnIBS5RFfh2+KKurTcZim0vc+jBb7PonvSvBgErO0UD9IuJKa
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:39:38.3262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280c7c9a-1231-408a-2f21-08df35445965
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7040

Quotes should have matching characters. Fix this by replacing '"' with
'''.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9467 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index 3090e188ec493..a36f5e6dd9160 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9467
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -9,7 +9,7 @@ Description:
 		is turned off to reduce the leakage from the BAT pin. See
 		device datasheet for details. It's commonly used when the
 		product enter shipping stage. After entering shipping mode,
-		only 'VBUS' or 'Power key" pressed can make it leave this mode.
+		only 'VBUS' or 'Power key' pressed can make it leave this mode.
 		'Disable' also can help to leave it, but it's more like to
 		abort the action before the device really enter shipping mode.
 
-- 
2.43.0

