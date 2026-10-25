Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792965943;
	b=f5aVdPwDkCeoYI69kVR74kduN71NFuZpliPw/4WgJqxoxd3Ncyobxgc9Gx2FkzRzTLqU
	 Isg1Np40MVXKvJa/B5NLU6QEeAurn9zc3pGSF9bUOilQSN7M5i6f9ua+qJ0N8ye/d2y8Y
	 M6MatAH6xDo5ZxDxEuFOk6Br9tvk4bIBHKLngZLhnXMHm4rACedrbbz29Tpu4ZUhLb3Y/
	 C6mtCgI/C2bHcWjS7KRT++RH8OGQQl8Z1zSG0aGbD08UpSHNT6dE8zylHeaYGkN0Tk40G
	 d4DJe3nnfVMdAsVGTtqhE6YwUQ7LRot/5XezvGo5Oy1tK8VA6AmkCGaQ5+Zk5gu0mJA==
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
	bh=/ZVw1tmDuxkVt1MeJjhVpmQF0Ox1onk8nmv7nY8cMUM=;
	b=ThY0Al5Lhm9jBqTkodCAt/WZduh/qx+vGyEnFbSf01ezvrr/TuqpHrvJ0Z8EkYQ8f30w
	 XAn7wgXRq8ZgsN0DHQgbG6+x2/yCmccWSbFEp8jOtMZBxIeHodqu8nLWAFdXeHnqArDG9
	 OLP0Bim5BwExrFft+Ufc/0/44KGkIYfkA90ZJ2Dyhd1NmyP2LEwV/b6mDXwc5FHbw9E4E
	 GGT4hIYQdGFPOgYZiKjZnfsMF70YgNdTEoby3aLVX2iRswL+tSOas13sxz0hXqPSK8pXL
	 aZWRHIhn551soAlH6SDpFJbdc8piWfAfyVg/fPokR4E+ANmfGd72Odm39icExC5Xryw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="aZ2/zRfx";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.34
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75207606A32A;
	Sun, 25 Oct 2026 22:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75207606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=aZ2/zRfx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwwrP4UfL8TvcZnoTmsFht+57suGjhOMvLAph1LeAlpxKx74VRQlVfJA+qIiJycGTZEWvUyfYxHHB7lZirzYO4OVmpM/SJt64z48Z3SmUs1lYvJaCAoxqPzHrrtGcI4WmPfrcrWRgAUdQfDg5sy34MM+yrP2xKaKQCuB2e+UfovvIhEsA16GcYPm6vSEKNggSUL0TtOYAPBCF0YqiuK3KBFXjezpFIpnLx1s4hqw0615NS+nMOWeL2hgFGJ1hbHdG5B4U1GVTdfLJBDcveRQ883PgRnp0pN6R62r43W42wsFnO7HwaCyCkJ3HX4PdP8MBpsLcsHqRSjev5V1JB360g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZVw1tmDuxkVt1MeJjhVpmQF0Ox1onk8nmv7nY8cMUM=;
 b=q72ySBhTgakaBgjlLqDfZF460TBajb4rE4pWU+eTkcT/uBGQMv3FsPVFEvLg/lUwfLrhEXvCAn71Q7oseo7zG5vNwaAjV/5Sc1MZfs7JBumrHWme0oOvHKIE2RfyVBTbmOryMAT0iMrDU5q/CmjjHZp3LrotCu2ellLGrdoKumqbKV0DaIYtH7ZV0BAb8HHBC8IK3Iif8r/MdJzfFqrLXqkndpqoK2sHVXYdzl7qBm67AZXzin8AvRosozruRO6lRLFeeVxjZG2dIfHfbR5dGLdfU1xYoX3nYkYxIYpKbt+auzEwXp6HbMzQdZCS5pdQrjPDE8n23XNfnzRaonscDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZVw1tmDuxkVt1MeJjhVpmQF0Ox1onk8nmv7nY8cMUM=;
 b=aZ2/zRfxpa8yF6w3ggnVRcOYrR4hk9qCEt97g5xWHmvGWvFTF0Gf56TULpji9z6p1eNxFSzHx68sMLAWsCoemDpmShcikyWG+qJeYmOZhM71mnLqOI7b+EeuLbnR4MYbTu7YB6dXgO3zRBPlAD91bf+YYNskrVtiyHWOrcYB/KY=
Received: from DUZP191CA0072.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::12)
 by GV2PR02MB9493.eurprd02.prod.outlook.com (2603:10a6:150:d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 22:05:34 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::13) by DUZP191CA0072.outlook.office365.com
 (2603:10a6:10:4fa::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun,
 25 Oct 2026 22:05:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sun, 25 Oct 2026 22:05:34 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Sun, 25 Oct
 2026 23:05:30 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 3/7] docs: ABI: power: rt9471: Fix mismatched quote
In-Reply-To: <cover.1792965060.git.waqar.hameed@axis.com>
References: <cover.1792965060.git.waqar.hameed@axis.com>
Message-ID: <174f866966dcd0b297e783fb2c44e7e35274b6f3.1792965060.git.waqar.hameed@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|GV2PR02MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 435e2a43-79f0-4ba2-9019-08df32e417ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QrbtylvQ7xIVIWf4It+3U9/8NOmpsamTKXeo6WWrd1AdVjkZebhfS9bnCumIpq8Y6HbKx00ZqT6c3VjYnUyAKK1tgWMBAgmZtTMya73mRjmoyt/akeVG50nA5casB1+JdKmrz09XFwYSQ9li+VrfbdCzDVF/oeyqwXPiaZpgHon3u38zeUCX6PZsy8vwGMyrLpzN+mTlYmdA/RSOphYpH14GQVVBOMvC1tKm74HO7sqHDzUPpnKgI8q3QPJujOPZkh9Yp4Qibj3rs0GBbGc3KO9DVBgcZVK0rmX8Ps1Xiln91PRqPcyAijcYK/ET5MFO1AQsrGgX851B5ok2rwlYUS+KsEzNZpSln8S3Js6zoKqpKQHAf7nsg9QKgqt17VE0jQ2UgI2XR2Utrjk9MkFpwpciuvFyrW1Gw1sx0z77xY+X1tXuiTfQ8HNrFNck7ZXIR+y6p5hd8bF0XUgNL1J5yvNUqDlSju8sJB1dK/PstjFi4ecodBT1YhDOm003nHewa8tFUHD8qZwAIi5pmCp74GbYT3Zgp4py0zLakOmWLU9Ekka35R/iOZzJo1N6cxgO80NkAUJbY5nuy8lQZv1AThgNACdNqVcL4I7FVJthdyqoQbutSXEepUjzwQok8pZKPs6z7jATLFeJZLn+1OEzQ+VH556VC3dGgbM0alW3RUA=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qiMl/zaVIRmK4EjvIqfy4PgYSbnodUWflNXzf25NnhHcC+reG9YMmcvkBapx885lAbIL0uwjbAQH7ADBdDZjQEW8wO3753pMm3xybzf1V12d+4MCyNx3aMSOhKeu8YaKWZAkatgcAu2JVvXpAK7IBBaAQ93iao7rAzQyzIX9XuUfuMXEp+XW1bzS+gnZWMfO11NEG/LYS8ZtyMjgMeJ5Kx5cf93zwNXTI1wAeaE79W+TJW6aAArislHmuh2A/mHa+pWn3/4bOKp4Pov7CFnoZC43ZvymcDMrNjMX9kKWpdXSVozAnO+wV5o0z6KuLjKBgYym1cGbZ0jmUqDNnDUx39AezB9dyIsbNgEW2grRDuGQGZXHoYo+czNGn75V5/kou0GrAgaYh2FsDL2JIX0X61v074lxhuTc3PFcBVGnbMioIdEuQKCiroHobX1IQbpO
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 22:05:34.4422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 435e2a43-79f0-4ba2-9019-08df32e417ea
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9493

Quotes should have matching characters. Fix this by replacing '"' with
'''.

Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
index c306e2ead6bb7..eced82ff43022 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9471
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -7,7 +7,7 @@ Description:
 		If enabled and the input is removed, the internal battery FET is turned
 		off to reduce the leakage from the BAT pin. See device datasheet for details.
 		It's commonly used when the product enter shipping stage. After entering
-		shipping mode, only 'VBUS' or 'Power key" pressed can make it leave this
+		shipping mode, only 'VBUS' or 'Power' pressed can make it leave this
 		mode. 'Disable' also can help to leave it, but it's more like to abort
 		the action before the device really enter shipping mode.
 
-- 
2.43.0

