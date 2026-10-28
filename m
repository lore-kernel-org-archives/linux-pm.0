Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793227177;
	b=EoZ4/hDmjdRS2hOD9vto2dxDSr5dttLJd1xncwocleGD9kCMIuo9RfCer5gjISLaVLPO
	 tiq2PgWHytdcWnCYqrV4ManFob+1HKHlhO4+fM/ly08HCYZxtv3tKLEmYC68WgacNskVG
	 vM5SWREqVe5VqSxOVe5bxJveJIeo6vdHg0pzV6NoFp16Anwf3YUL5XUKzTKY6bLI8i3p9
	 T7B6ySpBPm9eQ/L4bJv3tnrHmREFzt2hIyKdwnfkGvXWhI9yRG0xHuXQeyeF0zF2EIHfY
	 mjiPTxzn8txWOnOgtugQZ7Qvbo2A4hG9bXQTV61Q4FjwluXyKjeRheM/fagukYOGfTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227177;
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
	bh=+xdJGizzAYuIfv3lEkYxyCT3NpOl7JZbepTnYzmAV7U=;
	b=IWHYqRD2+KgZ08oA2OBBLMbMOFEdvEKAomBOy/6TCESrpREes2VjCqsljSQ8lvxkUw6D
	 rJy/oQNv2gX/Ida0dsh74+2nF+lgWA7q6HGCzle6qY9yU5lU1PWjHcFZAbCuhz0pD8bOE
	 AR+r5stwwaef0B9AXh9SbUs40ewiQ7Tz3v4p/79noCgNcipqrqMM4G4MzejXw2LTg6GW4
	 1Xz724KvexeyLw3ZEtBk7tyY9EVwBIPaC0h+jtlyoS24CH0lEs5Feftl8cxnm15kKoSkV
	 LUqeGXzeXYbM6T7UrGe/R+vXpnocm7Fw5Dm33tHwqB8P6NCpwj2uGEnbislxA+3zLjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=rGK3cBBu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE1606A31F;
	Wed, 28 Oct 2026 22:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97AE1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=rGK3cBBu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAlyxM/sqIgQI7QWuZ6FPz8jyiP3SIZQ4kqYHMaXbX5YpEZRWfy47Ao6+sLSygFx2Ngu3s9ri9uq4d4ALOisaHCFRqV7GouEQ6LXRVYUh9SsbIJwRZZs6TAqnXdLWrlBzUn0G2QmGCBF8ZrvfnMkXCUq2bcszSQkKN8ZE5EIA84nlzBpEOPIwyRR9fM0Jp6YJ+QlmGfczzPvdH14o/iRCyV20kOYk8IkzpkOb7G2piTl6rgJMfBQSdgpgb1IOdw8ziqN2dqyPLraGxQM21xF7z1awOWzmvEHVHPngLcvedbXlkBzwo09HegvpMJ3T+yfUVoSGsV9x9vSSNEPHR5Nlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xdJGizzAYuIfv3lEkYxyCT3NpOl7JZbepTnYzmAV7U=;
 b=Jc7bcR7/EDZ+nDgplmPoHXEIyqjBZx34ayMF08NtZo2DXEQDFyI7+dqxHQonMPPIzQEnObgAUnaHodkeNXk6nmUYizT7ENobTtcVfpppCjl3lkNLTs/nSAjY/A+aCBJ5JFpqYrc5/9Sp1fWnsQuUu0UtynBy5ov/fW7hXTIQlL3uHlY4BY3BIvR6hMxAqo4c8MpmEXWxTADH9CGU1kcVh2uoNjNHLeONk5oSSOS7rtA8Phu5lGDpvwCr4WUWSQ1wkOzcOF+s72ItFA+K+egSkL8LSWh8EclwXxI+JgpisTTjp9dLBi+fw8UZb5KTeZopBDLIvFxxeFeKGzWot6UNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xdJGizzAYuIfv3lEkYxyCT3NpOl7JZbepTnYzmAV7U=;
 b=rGK3cBBumem1qR+q/ZxWxQNTTBvouroh3NrI6rRTx+bVVDJvjv87BxOqjjYwNqJddoldjltwqXbBDLMXc5dq3c5u04GmQnjyOHB4ilWafEBI4P2CulNJz+eTwRDROvFwJK4jPf1hszhZHqyyF/OX9eQFemori34AdLiYAG02WCg=
Received: from DU7P250CA0021.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::10)
 by PR3PR02MB6122.eurprd02.prod.outlook.com (2603:10a6:102:6b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 22:39:33 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::4d) by DU7P250CA0021.outlook.office365.com
 (2603:10a6:10:54f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 22:39:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 22:39:32 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 23:39:31 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/7] docs: ABI: power: rt9471: Fix invalid inline emphasis
In-Reply-To: <cover.1793225920.git.waqar.hameed@axis.com>
References: <cover.1793225920.git.waqar.hameed@axis.com>
Message-ID: <38e21b9fcf7cb784e950b51aac7488831e8f7eea.1793225920.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 23:39:31 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|PR3PR02MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: e81a9fc6-93d6-4348-fee3-08df354455df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|261026121527099003|13003099007|11063799006|56012099006|261021123027099003|10067099003|261009223027099003|261022105027099003|261021121427099003|18002099003|22082099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	o67hfNThuX4RaAsZnhgN1er0TfzqnZUWoTrThsezkAsNqK2+xrQfLlzkebEco3xFdxNHawSbxLXCrd1rIphWEcSpguZs95oIb/2sjnq995tvB7ePPLu16kORr4kJTXcp95gTnytLJUrSFLUIGFYMKr5pct957AY6MszJlkWervgVvlhb7L8l8UlZ5UPIXYdGVfoUqbIBZrxpWrfmwR/6vhpCYyI3CCa0DTZ7LQKO6Cs4xv7mstVM1YKJREoDO6EINZcNWfsitZHP/AXQ8zW+M3DX8kH3wq7KorJcByMn1O3aAGNAH2EVM+I8wI2oq1kcS3/01x0OYVMD25nzKyia2HdU5AwQHk6pYLnipBwObea/gLgqZEzQEzsBcP4ADk7hPoz223D/tX9hPJtaXNmRcLVnWl5S7mtm7AtHOvRFJ82EOHQe0lsdicMyj0T7B/6vzOU02YyYPnHNkhX0qWWuJy/QFjHYzyWOAmivnblMe8xDte77lIGYLGZT7A1eayceqUsiXPpG80EnbgF+kTYW8oX7BAWbyqHRIgNLiXLhk6F+F9VvUuf6oZCpT4Iqxu/vXAdU705N4TYTJzV7oAjq4w8yguV7qCT6WXgdinOUarrGYvuodU9HJ+jyTaYsvwDbKk7oqKUMoKuQilnDOOiKgg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(261026121527099003)(13003099007)(11063799006)(56012099006)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(18002099003)(22082099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AzkGIor50LlHqb8Ib6HXMzfLMMkOSnlTlYAcsrTgoWBFdH5XxsK5+buXMdeYUmJp6TOfOl6OyAcK3vBu1V1QnM9C9zLks+dDq3BVP94pgROins8rGk64dqRx+OdNlMUUO5Ib910FJ0pDr9o45D9PySQDdGmlpSRAcMnIXgycY6rd4thgKYJJolW0a5PPlpLO7pzaUcHTJ3Y3ic6b9JPiAVTXNppVEq9cE0LVlumFWT/0e3nu2/0o/2aZS25hylS3LPkVMA2fzrL14rv6jMFYQ/y1lgwmAyi8Y2FndKXcozS+1pXmjRjcN4kht3UAzV2AGnyijQ1erOD30nUzXfhyIW2WqbZbbZiGKwyVwofPx82QJWDITcuJHBh5vvpslNY7T7Er2rhMPtNhoXXhvjTXKGtXdXgQIN7fYtOASnW3u6iNougaOf2bIxCnzjPZWQI4
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:39:32.4194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e81a9fc6-93d6-4348-fee3-08df354455df
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6122

`docutils` warns:

  Documentation/ABI/testing/sysfs-class-power-rt9471:1: (WARNING/2) Inline emphasis start-string without end-string.
  Documentation/ABI/testing/sysfs-class-power-rt9471:14: (WARNING/2) Inline emphasis start-string without end-string.
  Documentation/ABI/testing/sysfs-class-power-rt9471:21: (WARNING/2) Inline emphasis start-string without end-string.

Fix this by escaping the `*`.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609110722.GAZVme6v-lkp@intel.com/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
index 90cf94c1cbf6b..d4ea9c9a5a9b2 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9471
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -1,4 +1,4 @@
-What:		/sys/class/power_supply/rt9471-*/sysoff_enable
+What:		/sys/class/power_supply/rt9471-\*/sysoff_enable
 Date:		Feb 2023
 KernelVersion:	6.3
 Contact:	ChiYuan Huang <cy_huang@richtek.com>
@@ -11,14 +11,14 @@ Description:
 		mode. 'Disable' also can help to leave it, but it's more like to abort
 		the action before the device really enter shipping mode.
 
-		Note: use /sys/class/power_supply/rt9471-*/load_switch instead.
+		Note: use /sys/class/power_supply/rt9471-\*/load_switch instead.
 
 		Access: Read, Write
 		Valid values:
 		- 1: enabled
 		- 0: disabled
 
-What:		/sys/class/power_supply/rt9471-*/port_detect_enable
+What:		/sys/class/power_supply/rt9471-\*/port_detect_enable
 Date:		Feb 2023
 KernelVersion:	6.3
 Contact:	ChiYuan Huang <cy_huang@richtek.com>
-- 
2.43.0

