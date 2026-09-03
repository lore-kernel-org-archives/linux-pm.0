Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC540099B;
	Thu,  3 Sep 2026 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427487; cv=fail; b=h46cAJdL8g08NksXqVsA9Hks6Kyf7mu5ATBeWdTfusJEQBy01Hs+hVQsu9K13rHOlDvn2y+KEh0HbCU0C36UvhUiTPy1RdUvxSP0mgdfv+uOorem1/sZpmrR8kIMsA/6C6HbbxyJTyK8FmqHwjCME39d0XazePF9u+CWNbiOfWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427487; c=relaxed/simple;
	bh=3l0GPRDIPQWJAS+/DpOMV/mHjPp61Fl6tB1ujZB/fsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPgBreyNSUW0oSh3wrO0oYoQHWuZ/lwQzxHRkQk1zzZq5bJEtSU6ncMjvU/pczjzw/qwKm8te57xR9o2L8yY+deHFQycWLJDjIrb5nOwtiOVPaoilxK3YodD4aekMxSoPdz7ijfGq4A2HxHzHb+UI4xUCeIqIJhZT2kiaOfjDgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NONgxbZBMijXRjJEjsle1hhvAn6SvlE0MXD0eDxCjdabTqp0Jpw1pJWsPbW0lknnYMOXsldytiZLlCTnXQ8np2SwoKeOAzEC+yFtlzg5TWE9AW6WYE3kZdt9q0mTED8uI38N1Umw65Ial2f5iGNG5+YoNy0u3ZreJvigWM3zGUNfj5seq76RqpwkenRg/MwfSq0zqR4KOqMv1ovDkMYK+aT28C2g0j/FNaXN89V1BtiTrdjaeAq2zuNdCBwydygB8FrRD+mF6+tNKKOnRsLMNySa9ayt8aERcl8R8cOmA7nsCTEXNr6+iD044oiX7uPYIEqG3rxmgJNXDnb6sFzSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjBw/XDu33pE99GYlGcc285pULYGKLNEyYkhQzlYyok=;
 b=B9ugZuKxY+0Xyz+M73JBy0D+iMsJ+VQ3l+ZRMGL5Dmd0SAScQ67bnjfASySXzejfabxqXRXmana7NTy+yi44dIpG9qhr7+lFiw4N5VVYbzfFg64HQsG+77aZ7JG2AiABttmTnJrHYOViRo6+SQ4WQKSMNyPdFeEkgJpEkMFofWlZ96LexutoITLOsnOPiBiLu07qdthUWQ8CEjsoQ8bcU5CMmvL0rXVI6ail86diQFAk9Qt+xbxq0fiQU2m2DFe6qQRSRKOmwHsZH+ew219Y1dwxhJq9QQFVzIw0rl5NS0EQjqYaTWaGrwwdS6usAfox0ZjkOyu/ggRGfkbT4X80mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0680.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 3 Sep
 2026 09:24:31 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Thu, 3 Sep 2026 09:24:31 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: rahul@summations.net,
	anup@brainfault.org,
	lftan.linux@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	joshua.yeong@starfivetech.com,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: Add RISC-V RPMI device power driver
Date: Thu,  3 Sep 2026 17:23:47 +0800
Message-ID: <20260903092347.620060-4-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
References: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::14) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0680:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ce0725-7fd5-4829-ac6b-08df099d291f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|23010399003|921020|56012099006|6133799003|22082099003|38350700014|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CdUNBsEXoHCdXw/SopHYYNlT+c1vra8EUINzvYeGGmSZBBTip0VOiiFEBWJ1bVD3d3BWrCe2RFCDkOOmpUyVYmS/LGi8bwoEwLDyVvmNTb8rNwK3TzPOadZHBZzz0liIthOOnJujKGJlHHpYeRviNFeBfWCMsICY9aNg3gA+o/foe8ikvLYZlt6gUQHzkp/nplO/NDfS72+4F0JqXSjpXBC7NtUr1DOTEIj5WZarUim2MCJpbsnRlAda9dr8l1C7Mlb6jVMhbbLDNqY6rWU+X/Z8moi/2i07/3TChEIG1aLXCVguk05PQSGs0VROhjsJvaY4FKJ7KNIDWouSwyXmaCx2JvyJJOJaRoHy0yGYMx2/sziVY4ZaAgrQwWQxsirIOXEp9Z8LkYWo+7lxEV2AO9pip3YZNnPIHTs7/R+VWNgBCbxx0OP8qAw3ZMs6+pRRcTuzDBCjI3LJakVBJzpoe0nuvZDHjWp4Rk/10BI0Rh97kCW70uf2anu4Dsor35R9Bo1XE9JQjWjZmcERcR7M4Zi1e/bE+o7uquMahGxnVB5fndxrHBpsVzDLXfwUatMqaGeEJiF+byuLf9AX8eIL/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(23010399003)(921020)(56012099006)(6133799003)(22082099003)(38350700014)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LD8HifGKADlO2OAIOjy8gR4WK1iS3o/6fScqoQYjok1L4ohYc3MdK9Uw5Tv6?=
 =?us-ascii?Q?2A76nZ6h5QT4v+sMajBznW+6UFQcgJjagnqrSUIpDMkD+Mw4tK3CEoE8BNM0?=
 =?us-ascii?Q?9MOIvPzYboL96sNs/Va8PdIz8+4GOXyI7CLVc2SVpY/aemLKcT/QcqTfQh5u?=
 =?us-ascii?Q?Zxqd0z8K12WCq0+GhKpLWtSgkeFWD2StBWurxRopSyd+w0Hw/Ms+4VwpIXTR?=
 =?us-ascii?Q?DU+ZNXJOpy3MU43Bm+S5v8ggrkZc6S1OO/WuRSrfpAP4q6dhbWZDCCrI140W?=
 =?us-ascii?Q?Yz/TAKUkm6uoOvpUYw+UVrWpfDzUsNkZMZGoqWFsS9Z1b62ml65oRFXE07aa?=
 =?us-ascii?Q?UodgrKZQtlQDN9BR0bs/a2vzMcu9ZcFHXvk6jLLG4X5e576qep1TOyBRTgom?=
 =?us-ascii?Q?7zcitoO2pNfRNUFOmsU9LZBi2wPb1UXXfBvcyHfAiZJ1ZNbCovnW/rjKLeJ5?=
 =?us-ascii?Q?gn6cn4tgFIz8o9Hny+ZivhYF1Py8uUeI0IaM+x9v37L9GnN13hINLBrfDy2e?=
 =?us-ascii?Q?qSEn0KOjLpp8oA9hfpttUwqGm2bjqH/OGIHSs6G3Tr9ePxy/CMVXxDriqsHm?=
 =?us-ascii?Q?KgiczSiVvr4LG9Nq6DUHe2qSqtJS+l/Js3j46cjdnaQ5bucIPvb3MZRnemnd?=
 =?us-ascii?Q?6U4DkkFc5xL2pJ9iWrVAjOsfRZYns+ABetKzzfnEiLis2a2L4/oqIL8F0Bz2?=
 =?us-ascii?Q?1scfQVHrb6CpxHqg9gfA0a7j67azWc/ifXOx9k2C1mWt4FFVd7OFPGlivicy?=
 =?us-ascii?Q?RWM0ju1UGN+9dNsdfbDU+Lp5e8rMiHIJMpIwWtXFXUsqoya5cOOpNQ7eYqKX?=
 =?us-ascii?Q?XfwjGiXeCINmmdSYuicrN4sPwRv/mTV6jCzGHPuGCHQ+Bsbx6UXcswLu1MxP?=
 =?us-ascii?Q?s5rzGi1Qeiifs5c/MLUQXvoJakmkQReKKI/8Oxrk869YJo2sdhkIFO4XcDtR?=
 =?us-ascii?Q?bve6oNTcbgPW1H7h7dSXW8LyyJSpBdxlDbh0zAwS3eRVShlh3y7PkoWePjSd?=
 =?us-ascii?Q?sLZkHsqftfX/Z/aCtKnP9/xTVtoS7qd+1ftIgXm8FmDfo4qPlSSSnPHUSXyQ?=
 =?us-ascii?Q?jO+SvAXHjtYHFUYQ0RF801n4kICkvmlDLHdp3QDXHqgVosuAyV2AUl5inEpZ?=
 =?us-ascii?Q?O2nagGNZW2g9TaaZA+SgeS1RlaxSHdx7YICEpnJKWVaWYYWp68AC3JeaoJEh?=
 =?us-ascii?Q?oDjzyPAN5fDE58lq+2RHKAM3+ItmPCSFAjxGdZTo2X5x47TCmaj5uMfS2cx9?=
 =?us-ascii?Q?5SN368KyYWWPvyCEUC1plClyUzGBz3E2yg3axpghvJKCz2jjfCTsnsngxKXz?=
 =?us-ascii?Q?mqlcnalKbyjPyYNOXxc+xc3ZFvwUjV5y2yjly3o9+NUfz9QPOpg46yHOWNID?=
 =?us-ascii?Q?IOWha6Avhjc+8NydI09QjYhdMyhwSw9THL3rdo30s/iLG0h9x3pPt/JtrjWH?=
 =?us-ascii?Q?pysfQrTODJl/HlmHuqSu41gJx51f3CfgGaacZeNJk570auNY5K52sgXiis9/?=
 =?us-ascii?Q?qRRsdKK2J5tIndCAm0NCaWz1MH1ES4S4DtzrJ0EVwtDSMX+W09yGpZ/41bXy?=
 =?us-ascii?Q?embYYAoTNu3tXvrJeCrC0uRdr0KhOk86sZTudFKqLKBWE9ef6m2J00BMQt4B?=
 =?us-ascii?Q?qM3FTmr0fZpRtl+LsXEatckdv+0BsumZgw1Zppve4Q3aGbV4bUFXDN60O8Rz?=
 =?us-ascii?Q?zwg7G/x112AepwxL5imAZHa6nluvfMp7wajXZTZxNkA8pHtmtaeACdh/qcCt?=
 =?us-ascii?Q?tetd+kaj5eaSShPDoADSsRtlNLvqjkQ=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ce0725-7fd5-4829-ac6b-08df099d291f
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:24:31.7155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lk4jbExgljKmUCszcAHsN3g9dsl+WJpEA/Ae9ewn5u87NYNS0bq9DZSwmpg1vxDS2dHE2MZuHOQEC16ADeD5KfMvyGjhM5crBHHUuRF3YrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0680

Add a separate entry for the RPMI device power driver and its bindings,
rather than extending the existing RISC-V RPMI and MPXY drivers entry,
which covers drivers maintained by others.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..4716da916aa1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23308,6 +23308,14 @@ F:	drivers/irqchip/irq-riscv-rpmi-sysmsi.c
 F:	drivers/mailbox/riscv-sbi-mpxy-mbox.c
 F:	include/linux/mailbox/riscv-rpmi-message.h
 
+RISC-V RPMI DEVICE POWER DRIVER
+M:	Joshua Yeong <joshua.yeong@starfivetech.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
+F:	Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
+F:	drivers/pmdomain/riscv/
+
 RISC-V SPACEMIT SoC Support
 M:	Yixun Lan <dlan@kernel.org>
 L:	linux-riscv@lists.infradead.org
-- 
2.43.0

