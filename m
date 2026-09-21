Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010028.outbound.protection.outlook.com [52.101.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DD4A1DF5;
	Mon, 21 Sep 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998320; cv=fail; b=qjGy6gyc6bnZ9Wdnov0pTQPTkfiamaN514CO4ESoKe6hAuehYKHURycrSdik0V772Oq8GcA+CMydrQOoEIiD6lHKAurstEHwxOQk4a1VNYlfyVZdzxAV3Q3mOKhu+MIV1Jc6CPv9yhAadwadrlE/Tkv3cuxNj7HVLmpPycc18bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998320; c=relaxed/simple;
	bh=HFc0vzTV1fKij1dyZeSeWt8mUa1N+XvgeRipAq/C6Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXdJSOHNMVlBO2S9QdJQYq0vSOVjDjb9OshPBxpHwbTwV86SemQNB3NOLsPMHPopolC9uBuX6D1AbvD+UgdCd0Ivt4dBvcqCqHz8qIJyPIPpehEsnxMKRJYQLkusb2Zb3U6qTyb7aHAYn3tfSI+aoMRVYyj5IxIz5cMS80sZGco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=m6nuVewu; arc=fail smtp.client-ip=52.101.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="m6nuVewu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVVTr0knOKnlzz/Sna0vlUCtupa+F8ucg2mgeERdgAV5FSRt6rlFyc9C1PHzZUcfhbzYDGDnewtNAOycysuTHHVxD3sHGg/Q/0RpyFrsYYO+jkYl1p7dBBtqU0RTZbgqN8pO1ofUjVuYQPaKPGI6kNkaz25NMKCPLLKm2aWxornoLCv+R3tXE4M+eLMvJAxGENORAO7MAjBtGlcoLK1ffchEju0M0SWAf+QbiaUH0RBFI+da7owNkVdpiLnXCgt7XjS1nQpv/P2BFzWXiZyMwmelDBKNej2+4ZQGlKapBlbs7RMIYxdMn/kariXAtX3OXEAHrETImuUT8lLUDqrRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mxgeug/OKSPx80nm7ww08lCXlxW7hDLdPbf/rtwU7E=;
 b=u8TVOXgAIHMHMWMk8Vd6Bl8ey9oRSEa0mP9pFXmePQtH8EGzvu6idKko72af81rxFHWJc2V+LbJuqJGAgP/o2/I37ylOgSB0xap/zs9gWQ53htXGNnddAvl2t7GJMRI7wnNLD2upULIIRL8lNJLiIAD5FOCd2JWtjLeaHl/Y2S02btYw4IgJq6JiZins2QOg3TIGUrzuNqdKcgfDU2DdC6/3WaX2BpXL2Jx06CxWLRDwqPsXBgRVWcXf2wXrirSMi/Vptt+djn0WFJ8hutjieNWLTbIx4Mh9qCkOnfVekTMplO036NKRc5VsLLoLHDlUOgS9u7ot4UOzjn8mt62f0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mxgeug/OKSPx80nm7ww08lCXlxW7hDLdPbf/rtwU7E=;
 b=m6nuVewuHwM7wA3ZM8IEDeIgyB2HzfK1YUmGlFpsMntRmVa3n6jALdCfMErOumedpbW9HYLT5IURGhY2qxyxm/c1nPVVUPuvQHjwwcFKFC8SueFgH2TOVLnXLfo+I7/Z872y+YlDcjjDR82ILO9Op1VSo2c1iaP6RcLpJjvrBrs=
Received: from TYCPR01CA0169.jpnprd01.prod.outlook.com (2603:1096:400:2b2::12)
 by TYCPR01MB10039.jpnprd01.prod.outlook.com (2603:1096:400:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:45:13 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b2:cafe::5c) by TYCPR01CA0169.outlook.office365.com
 (2603:1096:400:2b2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 13:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Mon, 21 Sep 2026 13:45:13 +0000
Received: from laptop.adwin.renesas.com (GBR-5CG34119KX.adwin.renesas.com [10.226.37.103])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 35DAF3000279;
	Mon, 21 Sep 2026 22:45:09 +0900 (JST)
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/9] pmdomain: renesas: rcar-sys: Add r8a774a3 support
Date: Mon, 21 Sep 2026 13:44:23 +0000
Message-ID: <20260921134432.50338-4-ayman.chaudhry.kc@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921134432.50338-1-ayman.chaudhry.kc@renesas.com>
References: <20260921134432.50338-1-ayman.chaudhry.kc@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|TYCPR01MB10039:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ddd1a0c5-66f8-48aa-f077-08df17e68feb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vBbbg1oWaeWm5TcEx46S4fw98HKfasZayDMQF4ZWbDOOBjlc6g63temcI2uQg9Fwdach47Q1hcgAHo778xUqTe29Cdg2y3H/4EGHIgHBPR7ng5R/Drj948GZkJZVXSZLDFcuCuI5rV7XFGJ9A0L0x30qoetnUur+nKM5APB5D4Z8Y3yZLs6jEHLRffYRdZH/RktiQvqxBxO1diKfokONmHzvxObdgBhT27yC3+Z6e57e7sCl8Qs+BVFEU0Wv2tyzSSMMbiDsFcfDhY6Uc2Bo71O5m3j8XL+syXP09JUvc5B/bZElEfbIDWFhO8jXepJ1GR+75YbwfM+cbyHHrmi8hzPjzhW44DoPcGEllOIsg+snPEY56hguvnsm6pp7Hz/PIrRXwR5vQrKcJiR6Jc8BWKwVInZOVCDm43fGQNYlVNgMD2l61YJj+k2BfOpbRLHoxMzcvP0EEF0FJ+qKsGdRGnCJinN9+X9r2XJajQ2XbjFtMdPIAn52goonaLNXCdweYYssOgS/HdVGS4BgWPRzs+lr/EK66hhiQohnHiApq3vNgAIsdZAYFKF7uxUjhYxDGTyMeZ3LAhUrVkpIC0pg8Hdi5vAORWrMT7Vt2YqL/1kg5pHw+24nDOpEfPNrIzCBVPCtaPd2txjWfO0iZ+d0ZoJ3PRD3jhdibWcGY7bQcqqtLM+otIFgo187a8ts2IiyFi/Coj/33NnQImccRXRLSQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KlRyJuSmwd2VYCzUOZ5/wKw10VirPB9fAFmgI0KtAI2FUdPrEimNghKp2fXbzO9T3H/ghV/LtI4fEnWQivopqjue/TbpYEhgZgu6uhFfj+r9CawGwjqUKqobKlj4hA9XmJUXoZlZrkp/F6op06Gyzf5GeCptJrYGMNWEZxrsERVbAF+8kxn3BwaIFRCmYXCzqqwdEu5a0tLi9J3tbs3pG0/6+MPT0kHxDyZ7KG03QQp4WItqJeTgUzg80++rR5Ha9uaMa1SASdS+QLYacp7jJlXuDSI9uDREe/MDlNS+4pf3ifIPltbKPbRF50i4DMed5KItPvo+xttWpRfXOMBLmxJTuTsmx+iZhDZqfysIpL1CdCx+702rI8i9ozJx00Z/hu49dddIPr2PQOGN6CRrsvM9MAe/ElyQuctNf0He4lyna/M7Klf8LQIIhdOFp/zj
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:45:13.3927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd1a0c5-66f8-48aa-f077-08df17e68feb
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10039

Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC power areas
to the R-Car SYSC driver. The RZ/G2M v3.0 SYSC is similar to the RZ/G2M
v1.3 SYSC, however it lacks the A2VC0 power area.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2:
- Added space before closing brace for `ca57-cpu1` area
- Updated include path to SYSC dt-bindings
- Added Reviewed-by tag

 drivers/pmdomain/renesas/Kconfig         |  4 +++
 drivers/pmdomain/renesas/Makefile        |  1 +
 drivers/pmdomain/renesas/r8a774a3-sysc.c | 45 ++++++++++++++++++++++++
 drivers/pmdomain/renesas/rcar-sysc.c     |  3 ++
 drivers/pmdomain/renesas/rcar-sysc.h     |  1 +
 5 files changed, 54 insertions(+)
 create mode 100644 drivers/pmdomain/renesas/r8a774a3-sysc.c

diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
index f2f52d3c29a0..df19b95c4655 100644
--- a/drivers/pmdomain/renesas/Kconfig
+++ b/drivers/pmdomain/renesas/Kconfig
@@ -37,6 +37,10 @@ config SYSC_R8A774A1
 	bool "System Controller support for R8A774A1 (RZ/G2M)" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_R8A774A3
+	bool "System Controller support for R8A774A3 (RZ/G2M v3.0)" if COMPILE_TEST
+	select SYSC_RCAR
+
 config SYSC_R8A774B1
 	bool "System Controller support for R8A774B1 (RZ/G2N)" if COMPILE_TEST
 	select SYSC_RCAR
diff --git a/drivers/pmdomain/renesas/Makefile b/drivers/pmdomain/renesas/Makefile
index 17849aad37a5..8eda820478e4 100644
--- a/drivers/pmdomain/renesas/Makefile
+++ b/drivers/pmdomain/renesas/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SYSC_R8A7743)	+= r8a7743-sysc.o
 obj-$(CONFIG_SYSC_R8A7745)	+= r8a7745-sysc.o
 obj-$(CONFIG_SYSC_R8A77470)	+= r8a77470-sysc.o
 obj-$(CONFIG_SYSC_R8A774A1)	+= r8a774a1-sysc.o
+obj-$(CONFIG_SYSC_R8A774A3)	+= r8a774a3-sysc.o
 obj-$(CONFIG_SYSC_R8A774B1)	+= r8a774b1-sysc.o
 obj-$(CONFIG_SYSC_R8A774C0)	+= r8a774c0-sysc.o
 obj-$(CONFIG_SYSC_R8A774E1)	+= r8a774e1-sysc.o
diff --git a/drivers/pmdomain/renesas/r8a774a3-sysc.c b/drivers/pmdomain/renesas/r8a774a3-sysc.c
new file mode 100644
index 000000000000..58c98700bd55
--- /dev/null
+++ b/drivers/pmdomain/renesas/r8a774a3-sysc.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2M v3.0 System Controller
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ *
+ * Based on Renesas R-Car M3-W System Controller
+ * Copyright (C) 2016 Glider bvba
+ */
+
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/renesas,r8a774a3-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a774a3_areas[] __initconst = {
+	{ "always-on",     0, 0, R8A774A3_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
+	{ "ca57-scu",  0x1c0, 0, R8A774A3_PD_CA57_SCU, R8A774A3_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca57-cpu0",  0x80, 0, R8A774A3_PD_CA57_CPU0, R8A774A3_PD_CA57_SCU,
+	  PD_CPU_NOCR },
+	{ "ca57-cpu1",  0x80, 1, R8A774A3_PD_CA57_CPU1, R8A774A3_PD_CA57_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-scu",  0x140, 0, R8A774A3_PD_CA53_SCU, R8A774A3_PD_ALWAYS_ON,
+	  PD_SCU },
+	{ "ca53-cpu0", 0x200, 0, R8A774A3_PD_CA53_CPU0, R8A774A3_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu1", 0x200, 1, R8A774A3_PD_CA53_CPU1, R8A774A3_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu2", 0x200, 2, R8A774A3_PD_CA53_CPU2, R8A774A3_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "ca53-cpu3", 0x200, 3, R8A774A3_PD_CA53_CPU3, R8A774A3_PD_CA53_SCU,
+	  PD_CPU_NOCR },
+	{ "a3vc",      0x380, 0, R8A774A3_PD_A3VC, R8A774A3_PD_ALWAYS_ON },
+	{ "a2vc1",     0x3c0, 1, R8A774A3_PD_A2VC1, R8A774A3_PD_A3VC },
+	{ "3dg-a",     0x100, 0, R8A774A3_PD_3DG_A, R8A774A3_PD_ALWAYS_ON },
+	{ "3dg-b",     0x100, 1, R8A774A3_PD_3DG_B, R8A774A3_PD_3DG_A },
+};
+
+const struct rcar_sysc_info r8a774a3_sysc_info __initconst = {
+	.areas = r8a774a3_areas,
+	.num_areas = ARRAY_SIZE(r8a774a3_areas),
+	.extmask_offs = 0x2f8,
+	.extmask_val = BIT(0),
+};
diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index bd7bb9cbd9da..3c8a44c6d772 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -284,6 +284,9 @@ static const struct of_device_id rcar_sysc_matches[] __initconst = {
 #ifdef CONFIG_SYSC_R8A774A1
 	{ .compatible = "renesas,r8a774a1-sysc", .data = &r8a774a1_sysc_info },
 #endif
+#ifdef CONFIG_SYSC_R8A774A3
+	{ .compatible = "renesas,r8a774a3-sysc", .data = &r8a774a3_sysc_info },
+#endif
 #ifdef CONFIG_SYSC_R8A774B1
 	{ .compatible = "renesas,r8a774b1-sysc", .data = &r8a774b1_sysc_info },
 #endif
diff --git a/drivers/pmdomain/renesas/rcar-sysc.h b/drivers/pmdomain/renesas/rcar-sysc.h
index ef598ecc710a..b264e727883b 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.h
+++ b/drivers/pmdomain/renesas/rcar-sysc.h
@@ -61,6 +61,7 @@ extern const struct rcar_sysc_info r8a7743_sysc_info;
 extern const struct rcar_sysc_info r8a7745_sysc_info;
 extern const struct rcar_sysc_info r8a77470_sysc_info;
 extern const struct rcar_sysc_info r8a774a1_sysc_info;
+extern const struct rcar_sysc_info r8a774a3_sysc_info;
 extern const struct rcar_sysc_info r8a774b1_sysc_info;
 extern const struct rcar_sysc_info r8a774c0_sysc_info;
 extern const struct rcar_sysc_info r8a774e1_sysc_info;
-- 
2.34.1

