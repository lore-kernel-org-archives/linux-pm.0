Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793227182;
	b=nm340B0+j30Fda5/RjREwo0zsBdcNZtcJyOnNPH38v3/P+858IBzWOIJ3Jszz5Hbwchj
	 J8ScebABnPvWPk73gKO12r0fK5WmtRgqkYeuF60+c/PUk6a863VFpEx3RDWlVALztsOeJ
	 y7tvGVtzsLWfj4VSamn9a3MP8rQx+pTg5dpI/UgAR/I2MFxB/cR0kCDa5S6XlhhUUhnOY
	 8QDvBUScX/mus9wDX5rwssxaF/AvaFzVrdTgnaeomrbMoQZ+I1vJDflr3k+1qu1Xq2Rsg
	 1AZTmKQ4vArThQdNG+uj9AKmxVM4Cyx4A77fXt55Zib3AY5Htdu0Nd4I3GQVBQdCRCQ==
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
	bh=SS7LlkHXnZtRO4ndkG/wJLM0wGk18aESf8DGti8I6jA=;
	b=MZDyUEkAFBi3yDuB+mARxPMWNmIWXuGUsR/5k68QVP2TBRIXGuddn8giEK4m/vznOCVy
	 6Efha7Lhmn+dPz3tDa1sf9J8IWUlwPzfTndp73dPLWlpJfGTHVkZjSWS+XMhPuDH47aQZ
	 AiX37wxJhKzIbK0trleXmWYG7H/Z/jb1CPSlpCo6PGmxKyppTKdJ5BUMP0IvAQBaZPQl1
	 Zn0FuQgvi7Vx3SU6rdGejnJQZujLG5NHBiMexj2EoVW0OXAQ4/3aZZXcdXC5R10UMp3f8
	 Y7dGey8TwN6rtstW5t6V6hd7Br0jMf98+hKXdQPMjH5+GDljhc3U4Ee5NHO/AXZ/gYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=nsbKsuCB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.25
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513D606A330;
	Wed, 28 Oct 2026 22:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C513D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=nsbKsuCB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJoAWp7gLw+VAwNxrEIe8AwOOPMb0rYE0UemF6ed7JqzKMhse15XC4qO1Yz0ya29unbcbTexqfVnOdImljxpyQeIv1d53PrUSvlyZ5JOsup9WX6gO1n8MjGSrESnte1UXT1+1/6zeY3h574BdyxSF/Iocu+hU7FHsRS4s1HO/LgeNpg03LsIZSeL4JCow9sow737vA1fiy2d2Jy1qh8fThbNH6CuGzyJL2scV3nuZ+F55i9UgKt7JQ6mIpg8cDuFl0QqMCXcXtp8aaDgZ8TSc4pNbZ3ZjGaNajboPIZ1cE4HuZYPrKfh4riWVOnuVtggiQKTxhbk7nWJa6PjjY5P9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS7LlkHXnZtRO4ndkG/wJLM0wGk18aESf8DGti8I6jA=;
 b=p5U0c+XdJ5sYIgsU9whW1umdj5n6KXpxhLiJsRVY6rrnBpWUM264VKWg4Ifu0c/GtC9cqfKVrrZGvDFv4g0ZZWh/UQZO/jHDADcRff+goQki+w/wUmWdoJ/IXIH3NIW32exNDcw87Gx0ymYlYTIeMRsqmv4J62XtcHxk+gCZ9b/SajJkd9BkFz3h7SbFf4JRT+/fdrnQv84T2f8L5+7AKD9eECOXPvxFMBXQGuy+8Xy1rTP2twVEAIae8ENh6BYuMx1fKiTDjtd/NTi7DEHAS6xBpkQlctYOZs5UjmG10EWENKj8Ni0kO9cy6UqVlTJWsH6Lsfutb4unXZZNJcdOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS7LlkHXnZtRO4ndkG/wJLM0wGk18aESf8DGti8I6jA=;
 b=nsbKsuCBFkH6Ze4SvDa8WXiWlHk4qhodYsAJJDRWNNn/vtnjUiJVxjXXmGlyhaIVbp0USG/8dtUC/Lg0kYuhmfc96p1yvPSsNnIOveeloV6xotix2wfWSpuuhjIxkiW+btMs5NIuaDBlhLqFMnyoj4Bxfvopl1y/tzVZc4zvmqM=
Received: from DU7P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::21)
 by PA1PR02MB11475.eurprd02.prod.outlook.com (2603:10a6:102:4f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 22:39:37 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::1c) by DU7P250CA0006.outlook.office365.com
 (2603:10a6:10:54f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 22:39:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 22:39:37 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 23:39:33 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 5/7] docs: ABI: power: rt9467: Add newline for paragraphs
In-Reply-To: <cover.1793225920.git.waqar.hameed@axis.com>
References: <cover.1793225920.git.waqar.hameed@axis.com>
Message-ID: <779ec7ec716077b1a734612582769a1d5632b902.1793225920.git.waqar.hameed@axis.com>
Date: Wed, 28 Oct 2026 23:39:33 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|PA1PR02MB11475:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2ab44f-ae33-4c6a-0720-08df354458d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|261021121427099003|261009223027099003|10067099003|56012099006|261026121527099003|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	0rScqHlP9taGaSNH81p6b0O+dZe3VzV/NVkY46pnF0aq/Qjfk6h8MvAZ+B89KzLtusoXGCq7+rdB0KNNu0KisABnn8PZTik09TyUC/0ksZKGoo/T5hl/ANSdVtZajR9I3tTftvDT9osf6DmL0MQgsco9nZs2zi4bK7GSyXa7GijItgdFpSjQrkAF+PHSJ7TTWEhASutChY1GbGXFAH70Vh/uxMsLbvw5jbNmehL5lyGZRqzh8qWsLQIisK7tTzi8U+jfmWScjJb3b8EhXOfCmpJ/TuO6KoPWreltEvs9zpEqFTIUgVUtp+Djd62FrmQubp05KBfBxBhj+0xe8YPuQi03BfxIoVyqwI6qkK6FNMKKjhT54wFyeMHATkcLeNguRo10j5JdmDaL8v1pDmdevL6vxP652oVpI1zeKszXu300DzAFIPy1VTDdsgipOsGE9MM7uFvHGOsna8sNtAeTerHqTdVemuIXfldxuS4QY72cJX4eTgb4Y1YL0WeQVvSOc6mxSajPIuA8Vi1A3euI5/3OMdJxBpATHeV4khqpfwCol8d8SKRXKjk6K2lovhf4JfIDCUM3g5zSQwhJ5ZlhizsQhj3qlp5SJ5WXIRA5fsSluOSoroSqnYmih9FQy8lZwod2ydgV+EMR8tCbsyhwcg3DKEUca+Ho7SZmNdpon3Q=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(261021121427099003)(261009223027099003)(10067099003)(56012099006)(261026121527099003)(3023799007)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w1GuowKMoj4Vvyezt5qRdHsoxFstU21uCp2p9T/0/elQC0BCGkEkmkPkTMkIzBTnGTccugt4O02VDOs54x1RXLvrfK2//ZG/dee48MlvSaNm/FaQwTsqF2k5oWXr+0AwyyoeM4JyNqEnwVRoWtEKvlULNCztdEmy/Es96hL1ds9yNtOAuaqGOE7qPw/P6X2pkkImzHJVE4lntTkehuR0ZJqCLvptxHXYJdqXaL0kY8vIKUVSVmsAdhERFiCSjD0P/uB8oLN9S2sxFj219MNl+5LT6Q38ErCQvq8hpkxUReC+BKZ16QrQDFRX76arxusecBiWYcqiRAZV7EDtDSnbbJ5kVpdOe3oHdu9rSkO1ufGFHpT5TY6AwsjecFYzqtR/9hS/K+0r+OIrMqWV4PWmzH2155Tr1Bh5rWJRz8hz8+zavX7IPp3+PGa9K8l3td0R
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:39:37.4005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2ab44f-ae33-4c6a-0720-08df354458d8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11475

To split paragraphs in reStructuredText, an empty line is needed.
Otherwise the output will be:

  Access: Read, Write Valid values: - 1: enabled - 0: disabled

Add a newline in order to properly format it as intended.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9467 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9467 b/Documentation/ABI/testing/sysfs-class-power-rt9467
index bfb9c0f478e45..3090e188ec493 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9467
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9467
@@ -16,6 +16,8 @@ Description:
 		Note: use /sys/class/power_supply/rt9467-\*/load_switch instead.
 
 		Access: Read, Write
+
 		Valid values:
+
 		- 1: enabled
 		- 0: disabled
-- 
2.43.0

