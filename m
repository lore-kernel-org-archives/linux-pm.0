Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792965931;
	b=22JFwCWRliMxVXev5cwPdTsbTQeWfTY8zKyWw4T/c4AYvPIkZ3skhsN1nNHAnpH1ACaW
	 pkyzuUWhYDmYfXLcGhq1/Yz+V1R100+Gl6adjx2V1YgPXeqAVNTHkNbKezH1/iIJXIBR8
	 ApfG9ZhjByvTOzl2QGRegMixN1CCYtTTDuCLnSKbEvysycfmhaUk8N4e5CZWlRzPXnh3b
	 CsgynPhPNdnJrU6NCXLtx4SlHqAqCEynlxdcvU4mvSWPCqHVKW1dbdoHgkPPeRPwlnDBB
	 y7FY9WyCtaZ15bE8LCnZ2XfF2pI+OCWJnP40BlLei8LAsc9YnPIX0CwIIXE9TSSxpXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965931;
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
	bh=Ckp4AcselHaGnRWw+RuixuLWQ2fM0cKysf8u4FoxUlE=;
	b=iKzZ9YXQAF7UXjgvHDaWBDCv9ufk7RKHGvY50nHLqkr1KPXWwe5x/c8B0FdqudHT5ur6
	 8OLoUXAQfxCgjFY0DYWcQUmfJUFoiz9jCfkxL0XkueANTUNljMncrOiokJwTylXHD+s+f
	 Fj29SV16fAR0U2o+/pc8cGX/loEncIsZHeKfSD3BvGHQbc8xfibaqW6vUEwva3YuGFgw6
	 WoGDG84XJHf/YYZv6aUUZFVQ6kA1gUdg5KrVmS3uCM/MH4r3UnjOczV3z64rq+fUxPOJ4
	 3ksUXHwcQt7EnrJuh7mNTtMpsLIitdoBGJz0foS/tXXjfEWOHZp/oXKHM2m8nLwSK9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Xhxl9TIL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.19
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7A606A31A;
	Sun, 25 Oct 2026 22:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B7A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Xhxl9TIL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IE5mcvyiH2ld/YxvT+LmEs1MmYd7dgspUkLr7A018yKhcQrzvKvGDLr51inE75sqPWr1aWpnz/lJWlXVKU0c+J2g5JA80cD9GKL4/xup61lPuIdZYCL+sUcMPnxbO2Vs+3g8rZnH3rGrxWIGsfAWrOk2lbC7fGfKZoiYoryDw/Nvhk8kR/7Y6kgoz5zJg9qsGskgA/CpvTPvXOl/aeYr2/oLoUKXi8iE7+QzbKFkNNThMJkK+0RV0RtALrPBQe7OndPqOEpf36EvsRoonp4EchhJXqXrKan1Lm4mHl5lTtIovZybL3k0VEi6nMSjE42TJ4vdVteGMgaqvFHPn0jYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ckp4AcselHaGnRWw+RuixuLWQ2fM0cKysf8u4FoxUlE=;
 b=E3W8RkOug1OPmykj5mkMNAmqSzCpI9hvCXx9Ek0+U6ed7yrUpAjrrR+1V1QIuL5797707cTr5CV3sn0myEWz+9fs4aVcFvqSMiwEyKsM9hH23LlGNPxd0ler5Zi1k5xgsH1xYOnF+1UaTwxPNbTJ7eA6N4yZwhnID9SDaN5eJjdIwp5ABy18SUv6pUTIzV36a0wnGy8RcWkzpCkrucgveYHRxF+a2ESzS/Iqcv3ieueArxnwZm/MeYnn3RX9V1yNJ50oEgsLz1jNuPuMTk9MImZs6EBaegGI1ExJqOj8NR+16RIlr26vgTLBO8k1WyzvpWih1uCgWSt5qZhGtOnheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ckp4AcselHaGnRWw+RuixuLWQ2fM0cKysf8u4FoxUlE=;
 b=Xhxl9TILN88bfbnfD2W146xCceFFKfL0LbaWiujUBCOL2nDwQ4LfR1pw0gmr0SZOgnByDZSNGedhBb0WNT5R9mVzXj8Jp8PS3rKQF0IlYREMRlqElA7vdN/ZEG1Is5W2LO7nwVb+27MosrKvHEJCccWabBrRznDBhUvJihaALK8=
Received: from DUZPR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::12) by AS8PR02MB7206.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 22:05:27 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::37) by DUZPR01CA0111.outlook.office365.com
 (2603:10a6:10:4bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Sun,
 25 Oct 2026 22:05:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Sun, 25 Oct 2026 22:05:26 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Sun, 25 Oct
 2026 23:05:25 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/7] docs: ABI: power: rt9471: Fix invalid inline emphasis
In-Reply-To: <cover.1792965060.git.waqar.hameed@axis.com>
References: <cover.1792965060.git.waqar.hameed@axis.com>
Message-ID: <ba11515d8e0dc45ad90f162302bcd1b20db9bd92.1792965060.git.waqar.hameed@axis.com>
Date: Sun, 25 Oct 2026 23:05:18 +0100
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0A:EE_|AS8PR02MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a07d7fc-fb48-46f9-8d0d-08df32e4136c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	NMUWp6Tlc1HKNRGEImTfSiYxv7Eg++YSvwYxnafmXweLwDGc46i6p+4brMOVr4QzcJxzAd3FpTgKMcqjx0Yb2RtSGFtBTXpL+JH+ZKKdFu2f/j+l4cByZxMo4qRKslXkiX+jqsRc34w5GbY5WqUUcgwhDWBU8fdPTJvtuJWo8kQ2ttbBz4kZChQ9RuC13Fl2UWs5FdmjqO5lP8zQkKNXZMmrrKBM82EWQHrMYhn9lu8CqcGkt7sU3degMOeh1nLz1R/8KtfDA8HwrtcLgd0cImamj45ZsV9joE3QqkezZvu/K/h16nmh0LDZsEIhhyzcdVuW9v7eUZXSbsEy2dIwGB/HyrHJmgYN9VyK2gSisFcai6FCCiYC083zJn/cetOyxGQMpBIb6hgLcOxFdOTePw72pKHjuZYjISfQixmC5S2LH7cuPFygnmsRNJHu+65jG6hN4HFzFzmAP3GfpasYS9Io8e816BByEiJ/xZ78ntMklp6ozZ/Rkd0spGMWtHVczeqlPVe3mxsbGI70vYexBi6TrIAnDiseT57XO1TWbsPXXgjtPzsMHOiFuXFk1yfvCDwxpfFyOikkXrBqRGU8gzUbiqpGHCBvATsa6a6NT+pzIfx2PGUUfbOmeQ3eqwBmwMw1Env2LKv6pUkc0vR5Dev7Vh3fqX8YMLCPHghlxN8=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/qMutsXiVP5JZI8rQR4ekGnAZTkQiKnpEuIAjqg9giefy+e2d29mqsPrCOFOltggkcsqRAAsl7fz8p2KWW7W68e+TX3ArI3iXVp8iMVzc4MxWyusO0rYKMOTCiMirg+RP487QFppgQ0Bs6FiZQjVJhXsV47jQSNCVhUJenAmhug/r4qZNfjXhHgMcNTtRmFs+DuBHVuDyYVfF58HJ09A94TbOe4yfQvjZreBpxrgIdmV4yPTpfX670pNIwgsWUcTOCuoG926MWTyT3njc53RlljVDcOMzy5OGosut0cUP/F6GpTrpfUhDUpHGSFo73sjSbEWcanUN6AMQq9bZqoeMyBwPoiBlfQP1uN45o54+rLvmgzX7I5EI2sVxaPYzqrqW2rAe4xUelpZwbBKRPijDd4In7ej9wnHO+faKFJhvv+D3+IG9JDrB55SSGDeDApA
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 22:05:26.9084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a07d7fc-fb48-46f9-8d0d-08df32e4136c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7206

`docutils` warns:

  Documentation/ABI/testing/sysfs-class-power-rt9471:1: (WARNING/2) Inline emphasis start-string without end-string.
  Documentation/ABI/testing/sysfs-class-power-rt9471:20: (WARNING/2) Inline emphasis start-string without end-string.

Fix this by escaping the `*`.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609110722.GAZVme6v-lkp@intel.com/
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
index 0a390ee5ac21c..04a771cd23512 100644
--- a/Documentation/ABI/testing/sysfs-class-power-rt9471
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -1,4 +1,4 @@
-What:		/sys/class/power_supply/rt9471-*/sysoff_enable
+What:		/sys/class/power_supply/rt9471-\*/sysoff_enable
 Date:		Feb 2023
 KernelVersion:	6.3
 Contact:	ChiYuan Huang <cy_huang@richtek.com>
@@ -16,7 +16,7 @@ Description:
 		- 1: enabled
 		- 0: disabled
 
-What:		/sys/class/power_supply/rt9471-*/port_detect_enable
+What:		/sys/class/power_supply/rt9471-\*/port_detect_enable
 Date:		Feb 2023
 KernelVersion:	6.3
 Contact:	ChiYuan Huang <cy_huang@richtek.com>
-- 
2.43.0

