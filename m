Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792965941;
	b=manDoJwPqe6CuQkKv4+SMVlQQJVXFr7J6x+6ndLBFJ7biuZ1N4YBhxfmnD68i/WD/PcI
	 VkbeNy/j4uMi0M8+kmeFfBpsHgFRr/jRF1Jhv94fEzHhnUyvv5Mqg9nZ508+9KnVF1mcP
	 CA6l8ib3EmeDxO06yYna6lW/Cbsd9JRqOBbB+bExuKLkTnJSRSUKWtfbZGK8iuVbjg0QI
	 3HR+1ZgyyfJoVv/c6gIM9Dvw6qn+A1JM1ShYQOF4ojvB6UvDNJnrJ0OjX+JvSXZtCfmxA
	 OsrrlS1BDqFLRw2u4JkyhtcgckYW4Mol187Cc3+IuAp12vwyf2TzjV3Vw4Y0uKeqvjw==
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
	bh=FX5XzzlQpuc6MDZ8KCOytj4o847kzZuTWHEiaFX/IMY=;
	b=Joz6FFR7kCUKoBo9bdnsi5N/nJY92/9OkQF9cEgvu08LDk9g5F4TBU76c2TTJFabh2j5
	 E0nXVobCOowfXiBDjft4Ezqh4D6BCAJj0+CKburjaWTSBY1WX7wL1OdxVkT6GIfV2oZLC
	 FOvjhNWPyD8tcwk/UDPZZN6rDvF/5ESpuXi0zJMjFO7iUOw4HZfe04ccn4Mj41LwFFhRo
	 EOT34QFNa0NQQOLFz8ANXliHI7P62VpTtoUZ2vnfIsa4WV7Xg32Mqj1PaPMK/9CvmhEFr
	 V5l/Ajz9XnLubYf25mv3hxZVxRr+x9fazsKP9s1T2H6HmyenwA3w6KMONCOx68KVZFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=IT7zOJ03;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.46
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE72606A31E;
	Sun, 25 Oct 2026 22:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE72606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=IT7zOJ03
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa2q+7NHCCYmcgjw/F7T1XW09Y0kbOHMrurF4XV+QwmJW1dAUjqn3bvDKOsVbAv/Ew+iQuQN0/cI1/vBEAwa0JPFVkC6yMQEnpgDGVw/LWAD/4SxnuwOkJaGhgpkopgknjVL18+ri5ohtm/a1J4RpLvbrvm7W4cuNSvzK0ra02pG5gspw9WslB6w8FLO9qzkKxYsTOu9pxPw/ZuJmCP4nmb5Vu+cs013sJCTQ/OWE9ZlBQTl7oqr1uDALlU/SO4yBNHJr8uhxNsm4A+J+yDbDHz0qS0yna4q8NzAyP+PO7muy1Hrf7LZ2G5AuoG7RRrs9OqRcDe2l0hAWOWGWTaIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX5XzzlQpuc6MDZ8KCOytj4o847kzZuTWHEiaFX/IMY=;
 b=GH9JI/tmYXZ/uCXg+6JSGVLVQ1POAP1KI3LrrfWPkMIsrVGuKzi2SOy4Hnxyy9KeXdZ2iB3Jf1DkYM5AmoQXkcRLZ2I0QyuGJ8CoGxHvTXUTPELHf+K8pm9lYsxfT4ij2HSo1qP+Oi3VWsecXuLe+8ts04pg15bxGFLM1KGAYsr0bTYyxjkPUUIhL3vvxOIUpHAS27TbEFaGtSaQRFnID2Y8KO607kY6irD92YXMAhpYNDPmLw/ZwJadSh0q9DEjvItCDNAnybYWVte1BtUGIV8dNeI8oS+0s/VpEywZXjxNi8MpbyMXv0HOftEyqZa9XAOLzUcouVWlyDCkea/SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX5XzzlQpuc6MDZ8KCOytj4o847kzZuTWHEiaFX/IMY=;
 b=IT7zOJ03A7m70qOX18gYOwAuLiiPPUOPGeUgMiKmtScx5BsPkE29gHyO9RNgSCGqXtQZSEkh5f2ymtAvmEJZ+0FP2HC8oxku2Vl8IrhEiOlYxGNjsVNHWjOAgo4fU8GXeZj4PpAExcZfIiuHWyzXwInOLmd1b8NTMo39UztMPj8=
Received: from DUZP191CA0069.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::22)
 by PAXPR02MB7814.eurprd02.prod.outlook.com (2603:10a6:102:227::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 22:05:36 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::62) by DUZP191CA0069.outlook.office365.com
 (2603:10a6:10:4fa::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun,
 25 Oct 2026 22:05:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sun, 25 Oct 2026 22:05:36 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Sun, 25 Oct
 2026 23:05:31 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 5/7] docs: ABI: power: rt9467: Add newline for paragraphs
In-Reply-To: <cover.1792965060.git.waqar.hameed@axis.com>
References: <cover.1792965060.git.waqar.hameed@axis.com>
Message-ID: <24dea57880fdb48d384ad4ab98b56538441703fd.1792965060.git.waqar.hameed@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|PAXPR02MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf86f2d-6339-4bcd-fb0a-08df32e4192e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|261021121427099003|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3aZDpzw2xFIfqdz9nHIRlTHlSwC9Z0RTjgHPABYQl+qkybkDky3isKRiYcZ9hDAmRa2KYQxbOLvKDsnPeIV3YJK4N+3c/W9gMfpXYDmFq9IIu+tryXythOQVw+/c7g1wCdZ8WPwYd5c30XIeJO8Z5HtDh7K9aGEzPq+p5/wjDGOWzzl+UaFYbZix7ohdkfhvfyR8Pi/+0+UkFC5A3ewWV5lj0mr7SPCg/pSLOVY3z/QYpfa1wPwbHsICUvs6G+NTPkC1oHNdqXbMfFqFzC6/2TJQwuyGet0LHj8h+Lhp+m+2RqcLolEAw1o7YYUhGH/FF96/b3il81d9sSRNCyScJMow7YhefxUvHOlA6D9xGFhm9E1vOELCVbmuSUfsDkoXcQO2cirv0zjN3VNUnxUS7ZKJOGhqQd63f86EULLA1DaDkS+5OxIAoHniIuazdJzjxKyjeYTs2AEryyHgfGuIzv1NVfWygeYhKT379hi403vwWuYPZHZs3B8mTf49uvXebCOwSW5mxM8zVjj3qWPP5oFcA6lw1AGkFTHNORM07BaKqGaGmwzPcQYbNqUUM1eiWPVbHlb91/0mrVFktw5oStCPN3hoBTaqzliUSZfBoCo+oenKKf0UkawMSfO3ChWeXBggSPGmNMIJ4i58IW/3iOry53uCpw39U/JHyKnxVXM=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NbIZbgYWqIeNMBIsrBnXyD9sRVPWVU27fs5P4GVahUv2zGUdEbcIUUM5/9+lsaMlObSQUS6yv8iyuZVifp27WIAWxLQqdCVPzw3YEDD1L9jKR7yos+5BsNetE/hZR0JV2gsYwT9GwYMprFkkwRiARMx7TppSy6VxJS4zZbHCNW/hpxUeEV7nt9AaSWaePSr0Aq9BjbDIyam33hI2T4n6Pvjd22ONa4mwqOm7Bjn1l1APKcT6kmChzhAfEQQjSwy2ZJL2UWVfQrCplGWNqfzWNpB/C6Pq8WY7orLJZKaCcf0PbzNisJBHYFjYH8niFQ2vDDm90sap3i/CXh+3fXf1Mi2WQY4jax7+n0p+brHfQChHARwH7MfrzU8o4Msjx5GAA3aSiO2FWst6IvEC+LFB+2Q4vLuZAM2WX4j39om2rSe75PJ7pVON15KYAFJkSIEe
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 22:05:36.5692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf86f2d-6339-4bcd-fb0a-08df32e4192e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7814

To split paragraphs in reStructuredText, an empty line is needed.
Otherwise the output will be:

  Access: Read, Write Valid values: - 1: enabled - 0: disabled

Add a newline in order to properly format it as intended:

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9467 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index db37ca64cb625..4d9f5893bef50 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9467
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -14,6 +14,7 @@ Description:
 		abort the action before the device really enter shipping mode.
 
 		Access: Read, Write
+
 		Valid values:
 		- 1: enabled
 		- 0: disabled
-- 
2.43.0

