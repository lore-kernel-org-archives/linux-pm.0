Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792965941;
	b=DsdbHewckx/2VW5OvzzI85wtHDHoe8iu/3EQ3RKfKJk1oXLAs7VRy9iTDo5+6ugxjpdM
	 Geh8TAgh1C0qNFkGW8TnELLtXlNmz2RzcuHYnTiMwMLgz2cyAECwE/+uMMafDpXA/dAJ2
	 b6yxqXhYzdz8nj5U7nHOBw0S7U8V8TuEgoPG1t1O4r+v7j5/yad/Gr3mn4+MDymsIgAX/
	 WiLUFvqxeK3EHDmYkJgqumQ8yVqzm1THQunlgo+Axot2gMVpz2lk9RhTxNaFIPnAw76tw
	 d16h2XILonq13RirwiIlhaE9V+EGiy48o7Q+5KhD0rA3zTCgOkZq6nmDUI9RbAJkofA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965941;
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
	bh=dWrsstQ9Fb0qOWWuL/UwNElH9DVdIzonIbf1nSKx7lQ=;
	b=vr1jSIqus8J79ZHKixj31y7CNskF00FsplSCZGK6pc7G+j3oVjhl2K2VOT6vQhpaytPu
	 3XFzn3kj11EItgvdKa7y2rusX8fKW589tI4iYtH4uPAas/2vkKZaxbI+KLp0bUCPXMAeJ
	 HVuM8lqr7FtfrK+SiJxitltvVk6qDxIKCjCHiWA5leji+QLmh+Pd/PgOXFVCyEMH8i9Mz
	 EP1744tGig6idy5QKIz7zckwMYner/CKGjGGC9dJO+gqFRPmKyaocp9qoyt12g/Sci3H9
	 3vS1TRg9KcC/aXqLN0ngKSe9afZ3pW4cisZJvuCS5AtlIiJTVR8bk7SiIOhvm+P2Vxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=r1ic4FF3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.21
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0AC606A31B;
	Sun, 25 Oct 2026 22:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0AC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=r1ic4FF3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpFZXtWbXpcOzBpDkplf8ZvV10mdRJHF8IFXPCN4gZzztI0XKM56ljyJPK88WY0xj4Z3podRXzKfFAmjS5DXOvdr1oljfM8V4DBRX3aBn/s0qQ6PGuk3bAH68v7J3sYYS5UREuKLM3m+VOB8po7WxvzE8RwNa8Yjnaprkmh8g9lmg+mjI4hpvX1uBFfelPl7dxKOuqIyFglauTdJo7WcVg8MlefbD6AfxKRer8nSn7jscgL8o0WYM0H/QiBj/j56cryogGzYWAcRiGsk5UJyEJP9fv8tPc6GkfElt3GzcriLabIz8XBRE9N5wFCwZNV1wVbYcOrAPKRprMETqF4Buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWrsstQ9Fb0qOWWuL/UwNElH9DVdIzonIbf1nSKx7lQ=;
 b=tKtiQ3Ppai36zWbYaGqUjaLHYoJx1looM74rHgR83T9KajnUXQfX3qiams07En/mxypntwKM/KwmkoV1fOFIY6wi9qNJT/eM6+cQXxX1EEdP6Qiocnu2mSIbNQL4fFerRhcAOV9QnLwkW0+KdAR1HZc10v5CrSq4K6MzCS3sWj46SltQj8v3sbVz50/XX+WBVFT8MRsyixVRU9/fVHW3DEwPeOGxq9rrNfSOMIQt+B7RFRNIaQw6uBNrUUHTlwFBmznahkQN+Oy9cvGRox5Y06tb6mNR6dsa5WP/UbKz1KdK6Z3IeijfQ+uDCLmAG91+LXd5aYAtLxAbF8dAk8MV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWrsstQ9Fb0qOWWuL/UwNElH9DVdIzonIbf1nSKx7lQ=;
 b=r1ic4FF3KLY72QdZzjmePyOKfLQxu/xJhn1S4E5q6CE0OMmM/TJy1aGJpzWpn+z5Jpg2rCPNuy8HGIidJMzu55+pT1oEcMuNWljH9a7G4ZtSjSicQhnA2VmIevNV3pV//x9etDFzqpZo8oZH0AE68bke5cPevWK8ynpIeIFJkvE=
Received: from DUZP191CA0069.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::22)
 by VI1PR02MB6095.eurprd02.prod.outlook.com (2603:10a6:800:18e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Sun, 25 Oct
 2026 22:05:35 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::62) by DUZP191CA0069.outlook.office365.com
 (2603:10a6:10:4fa::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun,
 25 Oct 2026 22:05:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sun, 25 Oct 2026 22:05:35 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Sun, 25 Oct
 2026 23:05:31 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 4/7] docs: ABI: power: rt9467: Fix invalid inline emphasis
In-Reply-To: <cover.1792965060.git.waqar.hameed@axis.com>
References: <cover.1792965060.git.waqar.hameed@axis.com>
Message-ID: <ab57552107bcfafc57a5e07d733024b912790851.1792965060.git.waqar.hameed@axis.com>
Date: Sun, 25 Oct 2026 23:05:30 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|VI1PR02MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: e527bb5d-502a-4d0e-56d2-08df32e418b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|261021123027099003|261022105027099003|56012099006|11063799006|261009223027099003|18002099003|22082099003|10067099003|261021121427099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	hMWEoMikIyZdlD+NNDayhyslUt3yFouQwfNByEknqeB+POfF/4/P9KcbtXFFCVbwAbnlUYu1oidlz1aZzTyvnOIQeUqZ/8pcwmoLCxHhNsUZOUwLtA6TixwUB0g/MrO1Akvw01wh5/lq/ekOTNLJqIyCN19350dsYrOuAmj5B62EAGuC/Lp4U3hvXX+Nf09hfujkpvRCvikatoKdbu4MLIT1bstbGZnbCn2R/OqYr2Rj8WrGjMdgkjW3NYmFMVnooojI/yxJX0kVUMZj6rkJN4OrUbesyMXRKkGa+rlnZIOO3odmfviPjjZAh38kIY1nYuMyEZr+34I7YFc/y1YZCptIRENYA9dkdsXd4IRM0XIyt2OQiAVKvTSI586AOuCiPE08L1lM08+CTE3JL5SKz/wi/7F4QO/Bdkwapg2fcUHsm2zdh9K8LIkyu9gEyKVKCJb1Wn3fcuL3dRFX2AlX7iyuSRrgnxlv1NrdOBm/t6ud+uBd2vtlD71eDRuyJvXQk+up4WFpBE6TkA5zG87F60eld804OHSLaNlRESnSatHSmpkJ9OPfhG393DqYJw2gOBBkIb4P8uwnsY+nG/gpRGiuXZYwSepHNDrc4SYpfhgVzQTDQMgxI+vXSvnIBF0YCYDXpQmO9GUW8BH0kFfIMQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(261021123027099003)(261022105027099003)(56012099006)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(261021121427099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eRE7wdKm2ZNXtpLtyZYHG5NNpGGSegPQ7mldzmeMIl1ApNthHkFlkL4rJFPqPFl241rQKPSuwVvyxuSjkIu06iR0uLSNVn/hDPk6BJvXaXY/HwLRT05Tb42CPa+P4/gHJEHnQVrYqxgqichEcZQOBjq+z+aRlL5Ob7anKLyylfHYdA7dBOoKqHUBqeahZ/Paf7A/T8U2POGiFzxB5yN43JJDArMPEbEyWozSbHj2MdLoVF8Q7uYwBIDJLP0uUn73FRqFb+WF9Wv8PRyt2bgXTVYhWX7xb/MJuA+A124ikhOVlIEP4fDeZ09Ei52kv46zKwZWyeQEUOflFE9vL2bjCKKsML1AcEDLUqg66vMPxuFzEDxYYdOPjGyNsPrtLu/Hrouw5zmuyALSGmzzcrmidQJpHd4Plj86nPM75e3a6d53y0rQNRg0RIJ3qZhcs0Rm
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 22:05:35.7846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e527bb5d-502a-4d0e-56d2-08df32e418b7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6095

`docutils` warns:

  Documentation/ABI/testing/sysfs-class-power-rt9467:1: (WARNING/2) Inline emphasis start-string without end-string.

Fix this by escaping the `*`.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610151025.1g5IgCv2-lkp@intel.com/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9467 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index 619b7c45d145d..db37ca64cb625 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9467
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -1,4 +1,4 @@
-What:		/sys/class/power_supply/rt9467-*/sysoff_enable
+What:		/sys/class/power_supply/rt9467-\*/sysoff_enable
 Date:		Feb 2023
 KernelVersion:	6.3
 Contact:	ChiaEn Wu <chiaen_wu@richtek.com>
-- 
2.43.0

