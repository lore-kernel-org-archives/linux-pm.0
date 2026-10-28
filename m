Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793227183;
	b=Cll8rkvRwgvJadZJpGwVkJ889jMxiH1DNb9Ml4dYMI+HPy+vPAt11zYRVK3+0tn8CixZ
	 UepVYJ0+1WVnyrHba07I4GbZ8whtvwGcpA9EU8INKZ5MygsvOG5TxSbWXMalS7byK/rQu
	 TdtdfgB6JcVqIFQFHDqwDNWmc/yyfUOgMG+S2ES7loRoQJ2sQa5Va0KzA74OYpbr0l5Es
	 OU3JsfQq7tJ8flQ2Hi8aTfO0PvrduG9HrBWJsaNCg9WbUC8DG9RwRkPl5ZNgmnCxWEBTg
	 xtx1rPq4oJBokh/znG6gMkR4gl1aZezjA0ilJ1wbA5rA3HqfoiN7xHydgjZGN4ylaCg==
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
	bh=/NawPMF/TAdhigeC8ITp2ZFWsDtoSBiUH1BRHL9vn8E=;
	b=F7A+PXhp5CS8xiAS6FLCt9AJg5F0rVgvW4HEX0RbbEh0UWZMnixLfQCKRewVadYLITRU
	 Wp6Hzh/ys2Dbmw19wHIUIqfdUfvccXRC5c8t4ViZpt+dNf85I3bVMFli+el+neFSM6DA4
	 afREF9252/f43oa1X0v7rVwUrHBpnAvMiEeVY6FdVDUcGmxoMhgFcpOY9aMMuZR3ra298
	 qOt4HKfaRQgnGrD/BdMdJglxjjddYhby4wii0E2wAnglpmW9OQnjMM5K1QX4UJ1dJ4TWe
	 J/8wDsYrXFB7fhyMrUiAR7WCZRMXDr8VGvmpbdwYW7EcwGbraA/wcgLANX4vtV0XPng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=YOEqTPfn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.41
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5A606A320;
	Wed, 28 Oct 2026 22:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA5A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=YOEqTPfn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AM52Q9gu/MXYbgDDMIhr/g840oBTZhUKueaIpk06j1DFd46lmehx6OWI/32KfT2genwGolJmwXvYEd3aTDLpkoYL0GlqF0yHigsdhTNFoyVQ9NAr5NRaoJVkyJ2kZrJ3LaZdPnoyp5D0ET8hW4HW6s1/2/fstKb0quxsxxrcqztCQmaUo3AJDLk5GTliCZG+jc8uXmz5Utwk5rPmYRmPoWfDUkFgF061pG4W3SF0IJrFqbj3vRpLYtTvSubJEgrPCcMsWCwha1VcyZGsPfZCtCnucaXOk5eAD31BF2YrMJVIzLGh8NfS6maHiD5ZHqMaVvtmRT80cICicymCD+s/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NawPMF/TAdhigeC8ITp2ZFWsDtoSBiUH1BRHL9vn8E=;
 b=qqiOcWMEFpTRt+QwkGS2h1Hb3gULLkewRRkDRNC9wS2JDO3IH3R1/1R2WgJkPCiwuAAB9VBDHEqzMcPIyVTO8y3MRjCE5gwJgA/lhGd/vXZUpXegzwsnchIpGLlF4BFEpTF66HwTcwn7LkQw23+G5zxXrPKqi7KlPybo4kBrrRH5GJ+gEs/WOdBHqtuH2eM9fA0W3VLxbL+QMpsuRb225mnpTRKhBZ/kDfFBh2J9PG4xR6a6QNR4WBeCmrKXVwiepzt2m6s+uzIa1Sh7IxfShsIei4cXDSJACD6cKI61AqK8KCPeO48J4CJO57KE/2hsH5lto/I1HiaxVa6YmFqLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NawPMF/TAdhigeC8ITp2ZFWsDtoSBiUH1BRHL9vn8E=;
 b=YOEqTPfn9pycKWQOT9BzoNu/xRdxUN5PdWXcPYnfe04ZQ8xM/5K4sLYqbhDhdjOVUbvX/uVuzgd6ueAB8hEEjNU9Ftd2R8FSiL0glAYHfj7fAUw8Dn6/zMZxwz7O1c7FV8DJ1bYYib/r4Jsu+GRJFmZnjj92zhh+sDJG7AAYQ+I=
Received: from DU7P250CA0009.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::13)
 by FRZPR02MB12261.eurprd02.prod.outlook.com (2603:10a6:d10:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 22:39:39 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::a4) by DU7P250CA0009.outlook.office365.com
 (2603:10a6:10:54f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 22:39:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 28 Oct 2026 22:39:39 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 28 Oct
 2026 23:39:34 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 7/7] docs: ABI: power: rt9756: Fix invalid inline emphasis
In-Reply-To: <cover.1793225920.git.waqar.hameed@axis.com>
References: <cover.1793225920.git.waqar.hameed@axis.com>
Message-ID: <2d5ebe3886651217d55c338188f11a2711df19ef.1793225920.git.waqar.hameed@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|FRZPR02MB12261:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d963e7-8475-4b3f-0b61-08df354459e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261026121527099003|261026140227099003|261021123027099003|10067099003|261022105027099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	KbYQkO7JMBd3ML7XACskgN8P9qABGZjcK84zOdU8mNCMgrMvPJXCuVUFf0DC8cNy3jb3q2zr930OTqW5jbcZGxazohQK+7PL8SLy+IzPFQ8yrEpXgPcJLyD7oCVPFiDuUhRpy4vMD1JvGt94D/2M46LAZHyvLsAz6Y+yyndhxi6sROir4PPOY38MDBIXKjckjOIabsdFQAnO2qbaPOdtSFuwY8nVCWBXk7z3MynmbOxMhKGUxpSbDX3fTCctUZp+svVYlLTJiZGuK2+Z/7A0DG8qzKHPD+5mg41sJ/AaYHkF3kFfrN8qbVcXnQTXe4mHUKuH7i37+SrayOgC92De8wfoRICWOArEPPCObG31j5ARZo4kXffByvyzocavHFtnnkZTHdzKYHB/qsVakznZjbg5rfZUo/YhmW7ZjoVtr7L89VjT/nx/ogg90mk/2nLMLolAK75J7GPs3Zqj/WAeT4AQhdCI7JmkFEeEl4RFXkRpdFp5nGdmgnfBJMwMr+Gk5WLSGicoUN/gpzHtyowcHoacJvWecRi2yQzm9mu6GdQRMeTXn7H1rVez+79+yss8iXCQ7LQjhcjC6r3OYcyvzXRVPrHoyIIIT74fC2D/PR9UMBGWtzpJIzYcYYqDtF+FwI6NQ4UP5YTo78Ue7ragV0R6bXMgGOcWgViJDZCsi3T36QhTWyBvytz00zXeh+2nvyQSODEQsRyuIvM69gaAVA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261026140227099003)(261021123027099003)(10067099003)(261022105027099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YZzeE6R9lzS+wAJJlfcnafl7YjxUrT9dvKTqMn/vixDk3RYIqXs5qkRFZMw3jeiiw12gY2kSXHH3lQp0ZfayVlIIjeR0Lv7Fn3d4ZbTm8i/WzJ5kP+YLRsqCoHKHfWr4SR3CjEXk21kclKFfH9O3WlGYvE49SPLI18bCXhP4IWFUX/M/jxNqsxjisY4wzbKmJMhP5eY2wliS8nRdaHDztGKh7IzGGOvc2uF76r31pz1FYcP9w8vqX64AgmOHCm+bmSjMjFkyCHZsZXQQw4dEF/gljGjzQzmJ8UpglPGp/UBtyed1l95AgZU/B93rq4xRq56Xr6tLgxiYZx9nrJ/0Cu9cvSCeXO3qtNEsoVsYnVWSAf/xxzDeH3egYj9NGs25ctSeCZ4YLSVATQEyyhvbBgrbbLqcTcFIQQHHLiu149xl0vkL2pK+i9ddVKmoOrll
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:39:39.1420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d963e7-8475-4b3f-0b61-08df354459e2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR02MB12261

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

