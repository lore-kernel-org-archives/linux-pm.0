Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792965938;
	b=NEzXStAmmI5AS6E/oasWwtns661A6R133WZHFu/NLAEHRsHKDTtbmOPkgs4PPMG5VcfG
	 oM93zLDn4VOj1ar76w3n1kL49partj9DmpguDJbzdziQSw5eSHyCxHG7PP4HOQU0aUZk9
	 ZwLnaWINtAcynmLwBOzz1CfelcCi5euh0rxcBIfX8nnip4TemA5jpaJMMfVzQNgD/SVtV
	 Sg6Hv0HNPayySR6CIc2tDv19el8WyVTRrwZZTh/xLGO9sIro9BsCv/41v/HPxFsMGWmLb
	 kY6MIclwdljdu+yeG7YqgCdxAScnztg/y/7+Ic5dIksVwn5Eeo2f495ultWwSqBdkUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965938;
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
	bh=s2pec41WnmqNfteRoZAfQjBf0Qo1lveCFcNQoV/scb8=;
	b=Jwpaz/Mvwhx0VnKldzoPNaKPNO677Ehd4Br8FFffkQ5DScqA1+DeTzslg/sMvgDKDLu6
	 9/d6hketrwsL0vPV1DDFetwXlePIE+vycT25YQr1aX6kV59YBw19W3KhinEQoTt4PpatC
	 mFfiy4m8J/mczVIX/0DvBbGtZbMLnBxzWGXMZTesY72/CLA2u8bCaSAhVt+r1zmUXWH6c
	 GX0hOoZTtEsbxw5YxAFjS/j70JPs327MjVFAakUDAKrs7GO2Zhr3Nf3yiriGvMDS+pD25
	 cqYO8L16ml02z9FJBkaPqZK9eXlS2226nNEYagCgSzHj/AVpXq8h9OgFBAYERVNHuKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="ZMU/BbkK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.3
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07E3606A31D;
	Sun, 25 Oct 2026 22:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A07E3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=ZMU/BbkK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0sGEWq4eiE+sL6wFP1Clh0mDm0Foda1yN6vMhlKf2ZAywsqkCX5ZHOtNLYqwyWgRRxZl46Seytz1uqq4Hxk4d2OmWzAfnK5YIDcN5HXqK2farsimIvIR18ShajwzQ8i1abK0bVPve19aVnbkJUfGI+D/+9S6gkYkm/gAtVnqhQ58DOUbW+4TayNmvzfRiQ1BnjcVMklmUfaafywX/rKlPTQYvPcX/kXqYQFZRtYkkSu0u9/5IYJSzIiFas3tFnmHVc//Dou0jGA21A3HscE0z4ryPYpxTwEDuXM891HYgSO0mxqnHL35ziEy5nfcVsYOdGLSphZriEd9fvImbpkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2pec41WnmqNfteRoZAfQjBf0Qo1lveCFcNQoV/scb8=;
 b=aoOj0Lmvj3ISVgVE/Nnnuu9N+j3CA2xEMuTk33l4xpH33v7rUTdNqsswHi13zOZWat+DVsRJNR+N8EXUJFHuIcCx2LHuy8FM+F1NAVmCqo5pf33V2XsbX7zcGu/kjjuGfTF5nT6JUQ2Q12XTN1h5jqR1UDJF9Dp/TVLuvp4rCFSgi7Spx0OqLwzC40weAoO4qOVeMVnwlOFuPQJIJH9kJWZ1GGsKUgNyid0q8IVK1SNqQCbF7JqPo92AhePXerEregPyNswAW5zkaGlpbC6/vIQgROXTv+MznGDxeqQYpYHrsyEbcZ7hJRiX5AL3wM/QO2ICbOMA7g2CZsgvtUywdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2pec41WnmqNfteRoZAfQjBf0Qo1lveCFcNQoV/scb8=;
 b=ZMU/BbkKZvwqzmLdM8LePIbWFX+4WXAIMs1/8qr9WNj36mPbRW+dTPgLZdfeZrwydUPbUIzEfO6YO4DcY8FZtHt+gSTGubUggMSa/jkx79IAqkL+PV4VoWbtHiunEOwFVqb1/nb4g54dz1Y2L1T0OxwjF8BzMff7UBKigIL5UoI=
Received: from DUZP191CA0056.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::14)
 by PA1PR02MB11449.eurprd02.prod.outlook.com (2603:10a6:102:4f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 22:05:33 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::62) by DUZP191CA0056.outlook.office365.com
 (2603:10a6:10:4fa::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun,
 25 Oct 2026 22:05:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sun, 25 Oct 2026 22:05:33 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Sun, 25 Oct
 2026 23:05:30 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/7] docs: ABI: power: rt9471: Add newline for paragraphs
In-Reply-To: <cover.1792965060.git.waqar.hameed@axis.com>
References: <cover.1792965060.git.waqar.hameed@axis.com>
Message-ID: <eb8f0f6be0386b0f114c3d7cf2be1594d062d94b.1792965060.git.waqar.hameed@axis.com>
Date: Sun, 25 Oct 2026 23:05:26 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|PA1PR02MB11449:EE_
X-MS-Office365-Filtering-Correlation-Id: 082b442a-7986-412a-10f9-08df32e41736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	dpyR4qVQ43I3VEvlx6yKwl+BFwuMuwJ5r3/A96wLJ/h7jtaP6IqI6H4p7XVuB5rmQdYaI3EhBGiNzp7uTRDjeNmfh/yBFfnqkqez05UzzUeasrb07athkSEOf1NnxnP7k/PcOB0h7F52v22V6n87ItMlXlkidyOJqVnUGxE5PpzVq8D8ZOyr1bkMIgI5oG2gCxqfG0evmaysfK4lsMIULNSkvOs/9xXbz/l0HrQiUtUMEm/hfHyGvNMFrqtXsylPbUwxZe8BwCxMPX2sALrB+hWnOngJrGlu9TJdBihhhcjcurCZIC5soAifBZEnyU+af0nxIPFz25eDoHU1yAQ+RKrIMZBVLXNPW9/3NQFgmHNYkIEsz3+ulbZTF7t19zxwU/leO37I9apFhr5eucLIm6Boaq2mzb1G5gnu/C6ir5zV2vrAqZAsf65Ig0+5Gp6lhoJBNZlUvkggMmWHOPuIgfWYpd7tB66AMUqm4dWDeOdXiAszpHNHK9kyjk0QfieZyJK/I2PCU+MB0tofKyHQjB/PvP9DOd/NJ5IMvtJ8k0hNE7BkF4V6XERxwiU5M0n4nhOmWN53m0pdR48wS7j5I8LMapHGmKdHai36Cg/XvYpCYouzM0CizW1Efd/al47J3nX3z3XDJ3nRWxYvQkrLO703KhyGPVMdUUCsjgQ61qQ=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vyuNsiVkh9dhZ/ThYuYGMbD/iHRSBOQIGNX4+ku1VlmPjfMQafE3kJIqIMGaSphXQS8itGkVQEwDoi+Z/a/4j8DvKuB0pG4ih9zmyLOA/UNzTO8Ly0J18neDqSihv5TMiWNHNQPM5oHm8jGlR3QJ7lVuwy7Lt/Sd4J5PhYtEhQp4NDbSBz383jD04KKSbIegM/n1ST+2RVqOFONFCGzz0qOpTGNuWcRV49LivAQvScavDVbInNyWd1iJEC/TdJQjDa01IptJMzTh8yXobWaUFnN6aKqG2do5cC8HfPxUrljIIbaEPiAOiRkTv428hjJ/2WrdvqnSrZ+W4Q5bFQCBuUrvn+SQ08JE4E3VDL9z7SPw/rZqgS81DW5fAoSa1KRgOqBaiaq9Vu+f5VVN3tBterPGhtlD0pY02IqggkYFH95lqdM8evtqQs0GMSlhCaEo
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 22:05:33.2603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082b442a-7986-412a-10f9-08df32e41736
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11449

To split paragraphs in reStructuredText, an empty line is needed.
Otherwise the output will be:

  Access: Read, Write Valid values: - 1: enabled - 0: disabled

Add a newline in order to properly format it as intended:

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
index 04a771cd23512..c306e2ead6bb7 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9471
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -12,6 +12,7 @@ Description:
 		the action before the device really enter shipping mode.
 
 		Access: Read, Write
+
 		Valid values:
 		- 1: enabled
 		- 0: disabled
@@ -27,6 +28,7 @@ Description:
 		datasheet for details. Normally controlled when TypeC/USBPD port integrated.
 
 		Access: Read, Write
+
 		Valid values:
 		- 1: enabled
 		- 0: disabled
-- 
2.43.0

