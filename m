Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792965942;
	b=Md4OWk/h4VX8t5/6o6l6tzxOMiAgC3EofBIkcS3DCZ6y/9BywRfniHm18SHM44I7UG5H
	 s+DazvvGO2vOTtRHVyRpZsmCCALtXsLFbG78r+ziGjHcyc01LS7HeOkfLlcjJv14kuNlj
	 gjKxIl4Qxgz3IRnaFYC/L9q60jt1Z8Q5ImJpY5nw4oYdkdoMcAlJ98bRqDXR2FugCxP/d
	 g4+TNKrDAkTywrskKnI4NfM2mL9J9m6fgp4qmsd6f6f4By4hS3U+5sBt1XS5/NHJG8zYi
	 JFnBJ13NBoP75wF5yjVCNfZ0/fbhMxuGWw0qd7rE04b7p/qZXarMqk3vJvE2uFbFLOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965942;
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
	bh=/NawPMF/TAdhigeC8ITp2ZFWsDtoSBiUH1BRHL9vn8E=;
	b=U+x1fbfOAU3X7PEOdAoyDu78yiDOjDVDK2macxMsLNgLXe7fyuJfNwGsACf77tggw8pD
	 CzzbSuX2nV2ifj16sRZzNoS3lq2Yur2rVlkIyE7OTA6BtZdXG7DpoAbnLhy1cSNMuzY00
	 Mw3+rHye4o6U3C69AH6HtLWt4JfTlDkJrfGK/UycKxcjWGlR+3lU/SJvoxxKi/dVtP5QD
	 5m0B2kr89CUItNnjlSE4rTwRbDDRop9QNNzs0t4fJZUY0RZfT1EypVbODFA93a7Az4Cqf
	 bfagHdG/Dk7yYBmq9UDmcapMjpu+yMiwWwJcYCmK2m0GSwpssYqoM1cpjOQTHz0nFIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=SGCihzqv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.59
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07995606A327;
	Sun, 25 Oct 2026 22:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07995606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=SGCihzqv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEkckxeJCR7iQF6dqkjxMeg3a93YScggJQdSMic3xCfOoHqVUEk0NCNNmiqjJrAJ39/mECz9Dxtyn9A7i+g7QT9b3CBuu1xP0X36ny15oz5DyE6tEXgRziHVGqMhkG6ZOjvRSSqbL8ixcMR9otrmmMlFBNSQML4J2HflVzCE7GW7DDiwThx/k9E5cpsCOMPY8qdiymFYNSBY9IYrrB2FEICK4JztxX5caam2KMtOp6jn3AcoTWN+GiQTsHQCDFJZS6o3tib4pO6A7Rqg+EG9yeWSNtwyna9/S6h/SfZvOmFZins5yjKtWDHkL4rCDBcLGo4lghSZQq2SuqptFgVXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NawPMF/TAdhigeC8ITp2ZFWsDtoSBiUH1BRHL9vn8E=;
 b=AyHwdOIhk26JUr/59vpTZfTcFh9mbbvH4Aior62oDHA0I1+5cJ4Yz63fqTgmlY6qpDrZUA5m90Du47g772ufVQzVEbmv/Gy33Wypuwotu2nRhHno/yT2cVXoYiNFpF2hmpuN3NnQH92x/Xk+pBYCYa4xslhHL40iH/m7WVbuQFNaaircue9Jf9n4AEASQjJoV3XJ2YSL0OifBi/e9p1J77s4wu2Nr/GwHkP6mq3X81FU8REaqrql3e9NLrfeRZm3uj89uJ/kZLUqw+vfSTTodT5ZQ1JLeoj4sfElZGFFPMawVVbYyxAZ+x/9YzTl6ZTrtIXhqPcKMr3aL1fLZ4zZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NawPMF/TAdhigeC8ITp2ZFWsDtoSBiUH1BRHL9vn8E=;
 b=SGCihzqvG1Hmltg6kqU3kiiEZt88wH2HxkoEETfREsogDWj7BIOsWQ1pjr8bfIzbKq6ZakK4spCG/8UhsvL7LnLQ5pJtzDFCzTcCSUd5CyP5x8zELkW9qp3W1F8Rc6WkHofE83YhevUV+RSjeysJAuu3zBuRLSGDJlisFDTolCs=
Received: from DUZP191CA0071.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::11)
 by VI1PR02MB10224.eurprd02.prod.outlook.com (2603:10a6:800:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 22:05:38 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::63) by DUZP191CA0071.outlook.office365.com
 (2603:10a6:10:4fa::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun,
 25 Oct 2026 22:05:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sun, 25 Oct 2026 22:05:38 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Sun, 25 Oct
 2026 23:05:32 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 7/7] docs: ABI: power: rt9756: Fix invalid inline emphasis
In-Reply-To: <cover.1792965060.git.waqar.hameed@axis.com>
References: <cover.1792965060.git.waqar.hameed@axis.com>
Message-ID: <51dec5a3f0422a6284d2310c5d7d36af1b59ea77.1792965060.git.waqar.hameed@axis.com>
Date: Sun, 25 Oct 2026 23:05:32 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|VI1PR02MB10224:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a38bc2-5c57-4b45-9013-08df32e41a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u7Oce2hCCtP2mvTwynOT91yLIwYwWUDnZgPaAsNekqHf95t/Ww6UntqqyXi6uDkysGgVQohsu3/6tq07Gy2sKC/Y6Lf4gQIbEegj637zZMZp+Fo/CXS0D0sPz7D7LpJxIQl/k7oiND69MCywljL1bWHoUQOrdbB+MoTp6DGtGZqX6omY8ejHrlhp9Xm1EncWhansViSGNI2ovSK6C5D60BbRVZW2UlC6BbHBpMPHGmWGlsykAJHs8eI5gj0RpuqvOXEuC13GDKMsggpCLDNu3E2lgP50uOun0kSAJzdNM9yRBfxIGDxERdZxtyP8QTYNaG+wvWZ0Ur+zPnogrOfZluByzMrLT8B9u7EDaQU0Ls+18HqMFAWp4OjG5A7C0uk70nU8pQD+RpjgDzJP+uVOqXyr63DSwZQDpdzY/AeMQ5+0Uhj+KB/FVdZ3iODnacdXXw+vbQfz0BNrZg4uo/rXb93CqWCmApZciz/Po4gE+x5SA/Q3gEuZU9brl8KlTAAX1Gw67wsPHQjEtKjhTDVOh3HVnqtJYgJJ5jl2rrCLuJXaTfNccLI0d1fPHTxGeK2w23sfZBTGvJnFdoXcGng5lU/WR/cb7jNCC297nm8xh1Vh05Fzu2QTuf+is0PPQQhr95pvXenHScJ6RfiIOPfDtyDFquPTLlWPRfs0qu2DFaNasOUaDRG59BxBk+VpqYazFvcaEfi5y6+RCRBe8aFCjA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dptTVMQN6x1QRE6aF0uQkE1VuNh+KQNCnks8pZMF7RfVHu5O4M70CTX/d5DyMCdt0AcsoZJblPYL1BvlnSrt3u3trO6aESmFuIVC7xzz/XnuXQWOdtpIsb40VA5OsHgJL32Q5+MxEM0tEVyflK7HzL3RzGpwE8/MM/yI1jY2v/OtqQXITUhowXugBD/w1qNc1vHhr0SXROb1NqTZWlx2uDYrwmSdY7R/P1UJE9RvScrFhc6wmGGtxoLPTblK4f3pC1iGWhXBDWhi11MZpB7poLjXgBhDLuQ8wDTR4/W2M7zINhD0ru5fFYWB4QCvWCPJc/OfBqaFsrRJ0BtaBlKitl6xH5f8BR0ahNkFup6q6+PeGVYo7lVIUH4awlMtSWdvbvEXLn58rqxn6gFS5s6LjVHC8bQysJ+Yiux3g9GnADiTAbow0qGcCxsREJVuZRih
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 22:05:38.6969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a38bc2-5c57-4b45-9013-08df32e41a73
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10224

`docutils` warns:

  Documentation/ABI/testing/sysfs-class-power-rt9756:1: (WARNING/2) Inline emphasis start-string without end-string.
  Documentation/ABI/testing/sysfs-class-power-rt9756:17: (WARNING/2) Inline emphasis start-string without end-string.

Fix this by escaping the `*`.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9756 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9756 b/Documentation/ABI/testing/sysfs-class-power-rt9756
index c4d6c2b4715d3..e1ec7977a3402 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9756
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9756
@@ -1,4 +1,4 @@
-What:		/sys/class/power_supply/rt9756-*/watchdog_timer
+What:		/sys/class/power_supply/rt9756-\*/watchdog_timer
 Date:		Dec 2025
 KernelVersion:	6.19
 Contact:	ChiYuan Huang <cy_huang@richtek.com>
@@ -14,7 +14,7 @@ Description:
 		- 500, 1000, 5000, 30000, 40000, 80000, 128000 or 255000 (milliseconds),
 		- 0: disabled
 
-What:		/sys/class/power_supply/rt9756-*/operation_mode
+What:		/sys/class/power_supply/rt9756-\*/operation_mode
 Date:		Dec 2025
 KernelVersion:	6.19
 Contact:	ChiYuan Huang <cy_huang@richtek.com>
-- 
2.43.0

