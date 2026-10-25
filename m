Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792965943;
	b=xQUJrAeDhA9ITAcusNTYZmOCvY1WS/VpRGq1AXHq6FCd7RgcxKvGKzGRBJXK94HTQdAH
	 F7a3AakLY4dk15GTBBS4fZO+iWvl4+YTlGYd09CC7WK0v+fHcSoZdiWqK3A2s02ezOJhB
	 W2tzBCTXyMiCwtg8raiMLfhk7ErRp9uMm7QIVjyD7pd4w0TjIhJK/8VulBdxFZCPeUVSh
	 P1BNoa3eX+YI1KwSZnCgacLYchxx6c2o7HZTmUGYpP6jxdT++dZTXfoIMp508InllbtJn
	 eI88rHLkLnZSi3gqBo035fov+lsNGD0HkeyOFo4vs9MA3CLf2URGXEnzKhpLxn6s1Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965943;
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
	bh=zB2wa2U8zcOVQBw8siLdX49noQImQpAelgqznrmLFek=;
	b=Z+TCIEojepjNdUgCsH6/s+geiAOIL1FzAd/rDV6GZIq++FwYkWC2yJ+mcFFHtl5MF4GI
	 u/S9C389pg3gjM7RBBZ9uE62FWMCiGqurY9EmG4aSB7p7m9Y1X9XdL9ie9dtTv7KuiAvG
	 VpLWf5wSYfIHxShDHWCZVXcTeWz4/q74DLqiJDB0aE3oHa2Db+Az1ERYSf06s1hReUTD0
	 fQHz2r2hOtATd5SOywl8sLhTbDwtYuxAc5jS4A0/LvAKE/Wgcv2z/9zAKO0nP/szrQgAp
	 54jwNO0/5PrSFI4EzxS/aEQMw4nj+UaQjKnpHmxWRqzeCTz12ECe3Ixkv3LGWsZtJtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=b0Om2XX8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.52
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387F606A31F;
	Sun, 25 Oct 2026 22:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4387F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=b0Om2XX8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2ZMOvBlvB9qYBNDIVYnUhlYhAQgIM7MP6TxUMFXnPpzbGIjO1k0dD3W7WGHfuWk6b0F9HXKoKCX7DRyOIr4LxBg/O06oo6Cn3v9jtanpqWJmTI1791VAOlyNi/ryF8YqVqlSBJ17kRJlRkQZ3kTka5eF4IfQQFVno8LlP111vwrNNbHKrnsc2x0j7fIzT1M1vxWCOxVSk9XhprOHCJ5BpjTfMShU3RM6D7FIXZ+OJiWxD7I9TVgHKZ1t4M0pVy9SCk2Oo99C7MbXDNM0/Yy5eYOOf9SY+5Gu/kXtxqk5NkQJKXp6CbuknO7iyWWbrLIJN5CPmIhOlX5apoY5Bwo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB2wa2U8zcOVQBw8siLdX49noQImQpAelgqznrmLFek=;
 b=b0PfndsZAru0ffkp3wqu7lTllPXWgq6kgXHLucNsH7jWkssu7ff4Kqd6cLuKrXW6MPg5nDxzJ3ubOyZ5wHZQD9ha/1WHsGaTkCwIPA93HdRkDsOr4V4hSC2VsHaLCseyp/ouq9psULjICbiAtIfPJAkVpKD/s73Ozj5z5UKDh6mPMcyICKEyXoc5tA6uZKuuuaXzeP8BEQBD4GBaUj+8eW3XSgeJk+S5TKV12yh1AfU3fN/6yxTSjy84ut2wUg8GBkUCSulSXMMh2G+6bQfF2SpL+mjBw77DOp4PhCMu8vQWlRdpy0OqpOoRBX13TCBMfnM493W30gNKRP8MBd13KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB2wa2U8zcOVQBw8siLdX49noQImQpAelgqznrmLFek=;
 b=b0Om2XX8Y1pABQDtvZFFvj3QRR759TZOd/vQWSlw8sk4Wr699ot2rPqMg/ZqJR1zX++VBPNFTM2of4d1n7f7AVSInBDyLxJ5RafXJ0TsARgdplfyyfL4QQdXmuDS4y6SRwtv7+m6MBAXw1qKdCtnJyh2NQrc9WtupIj6azx8RB8=
Received: from DUZP191CA0064.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::17)
 by PA1PR02MB11572.eurprd02.prod.outlook.com (2603:10a6:102:558::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sun, 25 Oct
 2026 22:05:37 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::6d) by DUZP191CA0064.outlook.office365.com
 (2603:10a6:10:4fa::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun,
 25 Oct 2026 22:05:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sun, 25 Oct 2026 22:05:37 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Sun, 25 Oct
 2026 23:05:32 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 6/7] docs: ABI: power: rt9467: Fix mismatched quote
In-Reply-To: <cover.1792965060.git.waqar.hameed@axis.com>
References: <cover.1792965060.git.waqar.hameed@axis.com>
Message-ID: <d9085e9943a84a6b92c252906526a9ab95fd051f.1792965060.git.waqar.hameed@axis.com>
Date: Sun, 25 Oct 2026 23:05:31 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|PA1PR02MB11572:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a9b0f1-d547-4ff1-ca1c-08df32e419b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261009223027099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	XFdMLlZT+ThlUcuoTpxMf/vuUTZsKIZ0nDEjuNrG1X20P4tbXLUniB3Tl+z1wM21y31e5lITh3zaKMjQ59IdmWOQ2r3NGngNqy+13g2CzF62fp/wm9L78PNIStM5PaQyy5EbAW8g9Idn2yN7Y9ef2ugdXCLHbsRBalL72D3yWJihH6s3Wm6wIk6br9w6oz5JOaCC48k+D/ra4tyDi4l+e6Q/q7RESPFAlHT8zgCrZrbzJ8qSU27EORpb7GwiihHe4LhWHxavMnGuqqzkmzNbC83XEkhYq62CiX1HdXWfuK/hGtOLEEMiWxCOxvdnZCDnCCRN9tHtxs+db1wQvysN91FqgCG+yFY7oH0JEaUwPkdLwIoJMQPeLHgkbBrTlWo06ebjyyXPcCfUTCFQqFUZxuIJy/pLcbQOYK+McyDDAg3OhNjkF1GbyIDVQbU2VBSr8ZQgBMKnga/auKz9NBAOZDpu6gtiGf0XdwfuotpOGwAS77th5iRW9e9jJl/D5k/6aAemjejbis3ONw1Ytxr2TTKNryqiF0xKxeGEw3EdfS1Fti7CWnZnoSr927rthU+ijL9btnCY3VkcfMY6TfeIeHodrsS88489uQvyhbmZE/EOgM94M74b35OEt3eXXMIChBMVAVqNy+sD7m5lap3j7+zRNTlc0aa+lE5Vwb/i9Ss=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f77bhh7e+LGcO63nZnusnn7cAIud60XLckbeKkwdUdn6neRF3Y/7J0Tbf40nBx/gP0x6VYHcxUh9EJlUu4JnJPVehQX/ytBBWB3dkLeZYyAtSymhA7iK99ApxPvdXg7jFY3rbIeTMkJb6r/LKfjO1A88ohQHOok4PKlEoDsZUTscwOC5F8WDezE4zgJ6nupFfRMj9m/YIUaCscav/zZ8EhvAnI3sTZ+KoArN7v+yNkhBt6I1S9F8/zs1zwnsE64gXVnq1kX5EgO3XCp2CyoVPTjFiUf/9LM0OQbyAuCYD0AQLXQT+HvsNOX4Gi4+edFskrYLRuDJqCDLgUvAnAQshJ29zl3Q8Qffn3IhjgMMUcYE2zZTuT+Yl0qkE4ZgX3JmIwPWXEnu7KtcuTC/vkd2FwB0a0/eEiaKRTDCM5YAkzeSANoJM7y/TwdG8kZnPosF
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 22:05:37.4395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a9b0f1-d547-4ff1-ca1c-08df32e419b3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11572

Quotes should have matching characters. Fix this by replacing '"' with
'''.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9467 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index 4d9f5893bef50..9f9e831b0d1cb 100644
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

