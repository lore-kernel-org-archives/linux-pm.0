Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010045.outbound.protection.outlook.com [52.101.229.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9BD4D2EDC;
	Fri, 21 Aug 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324754; cv=fail; b=OSYSQrUWDM/Fp0RAkzmhrYRVsMr1rwHM23VafF65UNTjO62rcHKB7Lz8V4nE9i7kKFKhcaLMAFTwDu9Vglwn0oXRDSFlOpuwjxIG/5uF3ydI0IdkMAeRZS1TkZVFy+g9ZkP7wRxtoE5Fo3Pubo/8KYpQGRQXtrGAEhl5YSllwTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324754; c=relaxed/simple;
	bh=wGSvMa+i15NE5ucO5Cg2YzlM5YRHd2v3ae1FFMZXf+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vh1MSoqIZU3yMfTXe+A5+9Gzqv6uBYNJXJvjPVcRp91ZCfmnX5I8wAXVMHJbO8xwHd7O1bJ0aUvlLgSVRAMxkgdkiRbYLwKQ7z3VaxuwzbUpkd3kXMg4jM8NAV5Tv8RANktjigieWFgHvI8TZMn8/+VpoU03lfRWaOM3DcEkTKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=NEUegzmw; arc=fail smtp.client-ip=52.101.229.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="NEUegzmw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4DwCIFmRmbJjmSd5mtYh11qbjwyM1Ph7gqidQH81+dQs/Lb/hHJe+IN/FeJXc6IyeMPJtWGQ+ECP9xyWcKuAp9/nD7hCsO6L43zdDQPJ1Hl43WVTwVKfuJ6Bh5X8tKyhNT69Y4CmPhceCrUxjKktIR8nuVeQkY1YGEjn+KHqJlE9JV4BQ1EboWPeP9B+QWnM25WyOiFHoR8Bz8IHGn2x8vZuQAS+YEoVK3tlFIl8cJJQoU2W3qFCZkVdcgvnhcIYV0Y12+6qoeKgeaBwV6P+Yuvn6rxrkygbC9altjz5sX42lIha1dY0vb7TgUUz6yuxgUY1uPrkNkVoFxwsVElUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLAtwbHdjKHttJ901bInMdw3r6NuF82qv4ntgRhDnRk=;
 b=jIaoX0DGYsqOILy++rslJQDunNA1bEt1kV9n7heAOaaYhTSlXfXZIQ61K4vsJUIA4uaCuveSSPimO6qa50QiFKEbw5RMY4qqAdXHm3G2Uov0nZ+SrNeT+uxFNSWkayHw5Mo0qpcFZEZAdNJNTkW6AGo0Xlc9/898bHn2Twhws7rJqN1ATcmupaIynx5ipH20Rbl6/m93hbvO5+pUiDdEV1ESJs2r+2wc98s7ZMdHDmbAHOdDamzNawPGClXWnndrOmPAOktvXzNC6T4odb5KhY2hZG0s0ICXUX2HVb7QVQoNNn4t9mZguPh5C7JpvtOK1rSU7mNw67D3f4QEvlyEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLAtwbHdjKHttJ901bInMdw3r6NuF82qv4ntgRhDnRk=;
 b=NEUegzmwvujdjipue/WXSlx6DLts0GiAgmmLzLwtJJv3OGIjeBiZUcad6Uaq1IivkTfywGrWf4oWBC/iNlFNpiOulX7AUZJM27FEjjG6yuQC9WBJw3UIi1hUQRLZU1C7L8BXdvFmIFBJ7L1K8qz0AQkZepKwpo7gJVwaJExGoqo=
Received: from OS0P286CA0022.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:9d::9) by
 TYCPR01MB10215.jpnprd01.prod.outlook.com (2603:1096:400:1ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:05:46 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9d:cafe::40) by OS0P286CA0022.outlook.office365.com
 (2603:1096:604:9d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:46 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id DCA9130001F4;
	Sat, 22 Aug 2026 00:05:40 +0900 (JST)
From: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 07/10] clk: renesas: Add support for RZ/G2M v3.0
Date: Fri, 21 Aug 2026 15:03:32 +0000
Message-ID: <20260821150408.73829-8-ayman.chaudhry.kc@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
References: <20260821150408.73829-1-ayman.chaudhry.kc@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYCPR01MB10215:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a22f794-c7fb-4c6e-a358-08deff95ada3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cMqc4/b3cEyFQv9Az615yUxrA/MpzEaQ/6TDPbigFoAYjjW8/E0Rp/CWF+9TEFrH2g0O3l/s2oSJdCx2yU7yU9CoW7IKV6oYhUcW3kFrufFTsDOrioQ1iV6kZ6GTKTMqWJOpc4/D3Tkd9g2ZgQAMCC4k+u5EiTgx0ctCJq4pRMyTswqY1Hxa2rNte6GxBlIcyC+A6Ev37pPv1UFbtM+68E56zQRYo7gShVWYOJIuw4aGtRLjsyEOffX7WkKf+ve72azC/wsPsY1RqMqcmH4q3K0kmj4P86G3CeLJJ7e1OZzwZ/6bgJcHGuAq+NXqhzj7sxHVsCa/IIcrwH1YE63E6YzF/WSwOmRFdbsGHYkrlGbxbuRan9CbNKGS8Pl4Gq0zSfttsyyIPP++CjuYMjjZIs4z9Pz10TjQM3uR7u6br/2eRQubh9ZbneIEB9eRb0LAhnm7jMgKvBu65dDD0y1ydq5bM+BiwDOCiOOBNLNCS+C3ez1mLri7lY93Yo2pTeU+VSth04JKGICsKthAGPBYzgZBuBWU4kpRxA04solTYGXLepsgjpBB7HC8E1ebx5r4ZpbnNkoh8+uPrMBazCFOHH/cOT6CznIB+usbta+gyNQIB6cRCK+kbNgQSGTauUIUfN2cdh+AMrL56d6wPNwc545Z+tYQJ/IPVHrWgwBQ3mg/Sd5H8ORf+TKHD6m7s/54ePYLIznUrmxnMrvTVjLCLg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cSc2zaQZx8QK5hzH7ZyVtmF/2kZRkNmy7MLGqjP4GDZwHSexWpoKflg+MNBCLtOnb3+Xhq06PAi2uzxhGtb5nb5gQCZWIPB0cHw9rjp1PCysY0g8M7mXgxkr88qoTSd5g87QakjxNrFRg8LL6m949G+vrE8MnsEnv8xlDJTmB2ZqD8MP5Ze+gdTiZ20omQVrZvU1AwL16WinezqpZ0rbERdvSZIqs2Su4lCSJCCFrq3G3Gie2BzbH2TebdAIoMVOw15YJtAqRfpjHSSBD25n71LdGMGrTdx7GyaFx5XOgOe6Ye1JC81uC6neIlwwLLKqhwibTNLDQfKVNZKjJZp1exhFzeAL8C5RexNpgFWsUlj/kNgic2efp9kIVfxQ9gfsoiY49KiDvD2Qp0DLD3mIYcMiAyauMqIClfGZVsgJYqLn83WG7aY2ufPcxTBR+M27
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:46.0929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a22f794-c7fb-4c6e-a358-08deff95ada3
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10215

Add initial support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC,
including basic core clocks, and SCIF2 (serial console) and INTC-AP
(GIC) module clocks. The RZ/G2M v3.0 CPG is similar to the RZ/G2M v1.3,
however it lacks some modules such as the FCPCI.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 drivers/clk/renesas/Kconfig             |   5 +
 drivers/clk/renesas/Makefile            |   1 +
 drivers/clk/renesas/r8a774a3-cpg-mssr.c | 168 ++++++++++++++++++++++++
 drivers/clk/renesas/renesas-cpg-mssr.c  |   6 +
 drivers/clk/renesas/renesas-cpg-mssr.h  |   1 +
 5 files changed, 181 insertions(+)
 create mode 100644 drivers/clk/renesas/r8a774a3-cpg-mssr.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 17b95a2e96fb..86d1c48c2cec 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -13,6 +13,7 @@ config CLK_RENESAS
 	select CLK_R8A7745 if ARCH_R8A7745
 	select CLK_R8A77470 if ARCH_R8A77470
 	select CLK_R8A774A1 if ARCH_R8A774A1
+	select CLK_R8A774A3 if ARCH_R8A774A3
 	select CLK_R8A774B1 if ARCH_R8A774B1
 	select CLK_R8A774C0 if ARCH_R8A774C0
 	select CLK_R8A774E1 if ARCH_R8A774E1
@@ -93,6 +94,10 @@ config CLK_R8A774A1
 	bool "RZ/G2M clock support" if COMPILE_TEST
 	select CLK_RCAR_GEN3_CPG
 
+config CLK_R8A774A3
+	bool "RZ/G2M v3.0 clock support" if COMPILE_TEST
+	select CLK_RCAR_GEN3_CPG
+
 config CLK_R8A774B1
 	bool "RZ/G2N clock support" if COMPILE_TEST
 	select CLK_RCAR_GEN3_CPG
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 658f8aac5127..5c1b798118db 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_R8A7743)		+= r8a7743-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A7745)		+= r8a7745-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A77470)		+= r8a77470-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A774A1)		+= r8a774a1-cpg-mssr.o
+obj-$(CONFIG_CLK_R8A774A3)		+= r8a774a3-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A774B1)		+= r8a774b1-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A774C0)		+= r8a774c0-cpg-mssr.o
 obj-$(CONFIG_CLK_R8A774E1)		+= r8a774e1-cpg-mssr.o
diff --git a/drivers/clk/renesas/r8a774a3-cpg-mssr.c b/drivers/clk/renesas/r8a774a3-cpg-mssr.c
new file mode 100644
index 000000000000..327e529c562b
--- /dev/null
+++ b/drivers/clk/renesas/r8a774a3-cpg-mssr.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * r8a774a3 Clock Pulse Generator / Module Standby and Software Reset
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ *
+ * Based on r8a7796-cpg-mssr.c
+ *
+ * Copyright (C) 2016 Glider bvba
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/soc/renesas/rcar-rst.h>
+
+#include <dt-bindings/clock/r8a774a3-cpg-mssr.h>
+
+#include "renesas-cpg-mssr.h"
+#include "rcar-gen3-cpg.h"
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK = R8A774A3_CLK_OSC,
+
+	/* External Input Clocks */
+	CLK_EXTAL,
+	CLK_EXTALR,
+
+	/* Internal Core Clocks */
+	CLK_MAIN,
+	CLK_PLL0,
+	CLK_PLL1,
+	CLK_PLL2,
+	CLK_PLL3,
+	CLK_PLL4,
+	CLK_PLL1_DIV2,
+	CLK_PLL1_DIV4,
+	CLK_S0,
+	CLK_S1,
+	CLK_S2,
+	CLK_S3,
+
+	/* Module Clocks */
+	MOD_CLK_BASE
+};
+
+static const struct cpg_core_clk r8a774a3_core_clks[] __initconst = {
+	/* External Clock Inputs */
+	DEF_INPUT("extal",      CLK_EXTAL),
+	DEF_INPUT("extalr",     CLK_EXTALR),
+
+	/* Internal Core Clocks */
+	DEF_BASE(".main",       CLK_MAIN, CLK_TYPE_GEN3_MAIN, CLK_EXTAL),
+	DEF_BASE(".pll0",       CLK_PLL0, CLK_TYPE_GEN3_PLL0, CLK_MAIN),
+	DEF_BASE(".pll1",       CLK_PLL1, CLK_TYPE_GEN3_PLL1, CLK_MAIN),
+	DEF_BASE(".pll2",       CLK_PLL2, CLK_TYPE_GEN3_PLL2, CLK_MAIN),
+
+	DEF_FIXED(".pll1_div2", CLK_PLL1_DIV2,     CLK_PLL1,       2, 1),
+	DEF_FIXED(".s0",        CLK_S0,            CLK_PLL1_DIV2,  2, 1),
+	DEF_FIXED(".s3",        CLK_S3,            CLK_PLL1_DIV2,  6, 1),
+
+	/* Core Clock Outputs */
+	DEF_GEN3_Z("z",         R8A774A3_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0, 2, 8),
+	DEF_GEN3_Z("z2",        R8A774A3_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
+	DEF_FIXED("s0d3",       R8A774A3_CLK_S0D3,  CLK_S0,         3, 1),
+	DEF_FIXED("s3d1",       R8A774A3_CLK_S3D1,  CLK_S3,         1, 1),
+	DEF_FIXED("s3d4",       R8A774A3_CLK_S3D4,  CLK_S3,         4, 1),
+};
+
+static const struct mssr_mod_clk r8a774a3_mod_clks[] __initconst = {
+	DEF_MOD("scif2",		 310,	R8A774A3_CLK_S3D4),
+	DEF_MOD("intc-ap",		 408,	R8A774A3_CLK_S0D3),
+};
+
+static const unsigned int r8a774a3_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(408),	/* INTC-AP (GIC) */
+};
+
+/*
+ * CPG Clock Data
+ */
+
+/*
+ *   MD		EXTAL		PLL0	PLL1	PLL2	PLL3	PLL4	OSC
+ * 14 13 19 17	(MHz)
+ *-------------------------------------------------------------------------
+ * 0  0  0  0	16.66 x 1	x180	x192	x144	x192	x144	/16
+ * 0  0  0  1	16.66 x 1	x180	x192	x144	x128	x144	/16
+ * 0  0  1  0	Prohibited setting
+ * 0  0  1  1	16.66 x 1	x180	x192	x144	x192	x144	/16
+ * 0  1  0  0	20    x 1	x150	x160	x120	x160	x120	/19
+ * 0  1  0  1	20    x 1	x150	x160	x120	x106	x120	/19
+ * 0  1  1  0	Prohibited setting
+ * 0  1  1  1	20    x 1	x150	x160	x120	x160	x120	/19
+ * 1  0  0  0	25    x 1	x120	x128	x96	x128	x96	/24
+ * 1  0  0  1	25    x 1	x120	x128	x96	x84	x96	/24
+ * 1  0  1  0	Prohibited setting
+ * 1  0  1  1	25    x 1	x120	x128	x96	x128	x96	/24
+ * 1  1  0  0	33.33 / 2	x180	x192	x144	x192	x144	/32
+ * 1  1  0  1	33.33 / 2	x180	x192	x144	x128	x144	/32
+ * 1  1  1  0	Prohibited setting
+ * 1  1  1  1	33.33 / 2	x180	x192	x144	x192	x144	/32
+ */
+#define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 11) | \
+					 (((md) & BIT(13)) >> 11) | \
+					 (((md) & BIT(19)) >> 18) | \
+					 (((md) & BIT(17)) >> 17))
+
+static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[16] __initconst = {
+	/* EXTAL div	PLL1 mult/div	PLL3 mult/div	OSC prediv */
+	{ 1,		192,	1,	192,	1,	16,	},
+	{ 1,		192,	1,	128,	1,	16,	},
+	{ 0, /* Prohibited setting */				},
+	{ 1,		192,	1,	192,	1,	16,	},
+	{ 1,		160,	1,	160,	1,	19,	},
+	{ 1,		160,	1,	106,	1,	19,	},
+	{ 0, /* Prohibited setting */				},
+	{ 1,		160,	1,	160,	1,	19,	},
+	{ 1,		128,	1,	128,	1,	24,	},
+	{ 1,		128,	1,	84,	1,	24,	},
+	{ 0, /* Prohibited setting */				},
+	{ 1,		128,	1,	128,	1,	24,	},
+	{ 2,		192,	1,	192,	1,	32,	},
+	{ 2,		192,	1,	128,	1,	32,	},
+	{ 0, /* Prohibited setting */				},
+	{ 2,		192,	1,	192,	1,	32,	},
+};
+
+static int __init r8a774a3_cpg_mssr_init(struct device *dev)
+{
+	const struct rcar_gen3_cpg_pll_config *cpg_pll_config;
+	u32 cpg_mode;
+	int error;
+
+	error = rcar_rst_read_mode_pins(&cpg_mode);
+	if (error)
+		return error;
+
+	cpg_pll_config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
+	if (!cpg_pll_config->extal_div) {
+		dev_err(dev, "Prohibited setting (cpg_mode=0x%x)\n", cpg_mode);
+		return -EINVAL;
+	}
+
+	return rcar_gen3_cpg_init(cpg_pll_config, CLK_EXTALR, cpg_mode);
+}
+
+const struct cpg_mssr_info r8a774a3_cpg_mssr_info __initconst = {
+	/* Core Clocks */
+	.core_clks = r8a774a3_core_clks,
+	.num_core_clks = ARRAY_SIZE(r8a774a3_core_clks),
+	.last_dt_core_clk = LAST_DT_CORE_CLK,
+	.num_total_core_clks = MOD_CLK_BASE,
+
+	/* Module Clocks */
+	.mod_clks = r8a774a3_mod_clks,
+	.num_mod_clks = ARRAY_SIZE(r8a774a3_mod_clks),
+	.num_hw_mod_clks = 12 * 32,
+
+	/* Critical Module Clocks */
+	.crit_mod_clks = r8a774a3_crit_mod_clks,
+	.num_crit_mod_clks = ARRAY_SIZE(r8a774a3_crit_mod_clks),
+
+	/* Callbacks */
+	.init = r8a774a3_cpg_mssr_init,
+	.cpg_clk_register = rcar_gen3_cpg_clk_register,
+};
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 80f4403ea2ba..2d815712bbcc 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -944,6 +944,12 @@ static const struct of_device_id cpg_mssr_match[] = {
 		.data = &r8a774a1_cpg_mssr_info,
 	},
 #endif
+#ifdef CONFIG_CLK_R8A774A3
+	{
+		.compatible = "renesas,r8a774a3-cpg-mssr",
+		.data = &r8a774a3_cpg_mssr_info,
+	},
+#endif
 #ifdef CONFIG_CLK_R8A774B1
 	{
 		.compatible = "renesas,r8a774b1-cpg-mssr",
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.h b/drivers/clk/renesas/renesas-cpg-mssr.h
index ad11ab5f0069..3e28bbf50d42 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.h
+++ b/drivers/clk/renesas/renesas-cpg-mssr.h
@@ -190,6 +190,7 @@ extern const struct cpg_mssr_info r8a7743_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a7745_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a77470_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a774a1_cpg_mssr_info;
+extern const struct cpg_mssr_info r8a774a3_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a774b1_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a774c0_cpg_mssr_info;
 extern const struct cpg_mssr_info r8a774e1_cpg_mssr_info;
-- 
2.34.1

