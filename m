Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011036.outbound.protection.outlook.com [52.101.125.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7E356755;
	Fri, 21 Aug 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324729; cv=fail; b=I9WJ2ASlfxcsJX4WSNRaCQ2H2Nlbpdi1M3jeTrY6OubvPAZVic1o4nFiPIS4xPqtNTXP0rjN9DJMbh6yy9Ap6Cdgas2iejzh9ppNNWOOczI5RjVDFYxs6RM0sVwthikaFORYTciW9LVaQNQoOSP9c3fsNLOIIyG1UxSnjoun5KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324729; c=relaxed/simple;
	bh=79rYyRtgY9tryETYRXB7YRseUzo+t4g3rOcaPKZn0UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjEKbFbm47+Zu84NH45T/Sm6CoKWbxasPkIhODZ6YzfVcThDQNTgwLs1pvyuQ33OA6P7t2KBaGrQNN5rpCFZFZSh/fkTgWcbh/zj6VYbUlUTsoRjdnGYxamSFmVJt5S4mHg0O8Ao66SnHwDvm1LSpVMM7BzA+N2gfRoVDKX9MsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=CowUO2lg; arc=fail smtp.client-ip=52.101.125.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="CowUO2lg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQMMIa37a1dUL3j7Tc2zu3WFh4XM/BnOPMpJGfjAyWr3ANXPgWPtTMatBDssxsJ7zaknyvCpKgVwmmNzLVQAVzs0Noi1DmlD01dltyCKZnt7hlfm1gnEcHLVsRaOgJPLaqiME4VCM2aIc7EbyRI8sqFJOiferLuZD0lTG/NCfdCSL99araIXbV7scE2Rphj8tHuzBrJfEGT66BK8zn48kWdOxeoH6aed5fg9t64Ep90h6qp3W8NVxyzCLwjI9W0MWgvYgHWFqla84pQoKV28ornOmicyJnpF+1YrTVkBCj41FhgZMFm98I5UUzqgrLnIqyy0UzDDTOJpbifEeF5w8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dalefBxHKvZPvOuM4oG58Duzu0RZpEpu68vHBe5TvV4=;
 b=VfoDfu74TgH8ifdcgTa5Q71UFeKXMwaeFcJ9C/Mapvso/+KxgWQOHSvaxp0zwAbM4+Fs/CmPeDhaukfUTtIedX9NtIe+cWBbMOUcNANFZxVZItd0N0qXxMkYPVSW1ld09J8j0RS5tsVZIjim5RYAjnlGai2QbEI3jPjdhLDcBHJ/D8U1KjwQ1DcXAcSMYRvpvErdgH8BwGsREn+rOAWs6+QnN1p+7w4IPK1MdEGW80IayKRV2JtsA23fk5onNKHdxIZTM/knLO2oJ+9iq1ktDBxtT2DFte22QVcZYRv79CpEB+nAchExnWWV9Yq7VFMOBsIGb7m01OhXRBp0UD8GYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dalefBxHKvZPvOuM4oG58Duzu0RZpEpu68vHBe5TvV4=;
 b=CowUO2lgZuFT2GSDqswABfsYVw79GhyimjqfHoL4Q7QbMWOlQ+9jKvuKaqSQreod2k9LfRrUEwtkHN6rBjU4pPLqx436UxBAF33ezNO1qiTTESgRIbAQhETGk/CXGD55lrFRvgNQqJ+tuKH5/AszemdTR93E1SpRsXLCYQeRSBU=
Received: from TY4P286CA0087.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:369::15)
 by OS3PR01MB6609.jpnprd01.prod.outlook.com (2603:1096:604:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:05:24 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369:cafe::8b) by TY4P286CA0087.outlook.office365.com
 (2603:1096:405:369::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:23 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 8475630002AE;
	Sat, 22 Aug 2026 00:05:18 +0900 (JST)
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
Subject: [PATCH 03/10] pmdomain: renesas: rcar-sys: Add r8a774a3 support
Date: Fri, 21 Aug 2026 15:03:28 +0000
Message-ID: <20260821150408.73829-4-ayman.chaudhry.kc@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|OS3PR01MB6609:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 02fab60c-86d4-44a0-d4d0-08deff95a03d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|7416014|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vMLZ5ivIBdgGIr22KLNjNhYoURN9ClnFUJOWH/BNcuCFXx0y0pVJluDmCvoBjAu1B7gLPhGPvjkvM7KGwYnfHijRpQ0d5jr8YovLebxeCdhJV4m8McSOeB8eCH3/k7M72JXDlhKgTDJcOV7KG+vKNTHW3WBbLbIX4vOHTq/3wmq/JUxrfeoinsKJZ0pSLQgZdbwf0aeFlCtiN/4yfOfOGO5++JrDFF7MHwaIk/35spjKoKQdb5604PfAFmyThVhrws/cziZwLuSkS/b2YwcZlwAhPFv8AeDaEaPfVuBC5oh1en79pnbwlrsRLsOOqDfXmH/pmYxd7MUs5JtNaJiDm76i7KuvswEC9o4KDfnT8fs6fYnO35f6s0dk9VkMJX2DuSdFTdHKwKbSF+agLBNzmP8LZkbE+nuFZm9yp081Ht0B07PBiJ3rYPp8Go0zcVnusw7YMnxs9UQXHoZBPS5LXF4V4ZQjGB2DCROW+j5xlA3rmGLL5tV0GbxBPSVxfRxEi8TJP1zo8FVW072aN6ajcQMrefDAWmcWgi13Dp/iKXxO6YfOQQsxiBx2UYQFO0XmA6fPyy9yazjoguDpItP+GkOCpgoJAm/M5TOENW5dGSIehj9YtfNCSRCyQEdzuJV6t4F7mVuXICTlAMpbDo+SeKG/0tmlp8dnAS0Geq9tryL8e3Y6uXW3UY4cpAocMi3e4qlEG98USUumrI7v18s2YQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(7416014)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	37EH6WcKstTXrR654gxrokfaeqyJQQiN5Aa3ZMEMF7KhOWCu1txJsC5rePbsWKFH585gfidYUQmNW9nEg+//bE2e9Vuv2yDiADbA+WcqYO/ny2zWD7EO2I9hwY80wB/AWEMQ3CxjT5RNWuy6UaOms0lB+LuXxClKtyrXlIbW7PvhxbfOdm8UT5ioP02eDawoeSAf+lglWwvqxH9QErqg82rI3QPYfFTE8cDag8ucjoKqtlASY5EhurwgXymw/p/J7N5G8wCMwEXp+A1l8k4oXnNHIbRbgE+omQx6oBRkUSDmVE231S1IuEjErSXYoW1gw+l2d9RXQsqYfqpg6B/nhrK2ufqhqwVksifCCFofeDMr7kUOWl+1KIP11+04JLOKsEYXA7cnVd6vRht+6eug+SAQN9WnAYUy1yS8iJb5Jtm310idr12oEHQ9v7V0Z7Ng
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:23.6291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fab60c-86d4-44a0-d4d0-08deff95a03d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6609

Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC power areas
to the R-Car SYSC driver. The RZ/G2M v3.0 SYSC is similar to the RZ/G2M
v1.3 SYSC, however it lacks the A2VC0 power area.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
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
index 000000000000..7c8160e09cf3
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
+#include <dt-bindings/power/r8a774a3-sysc.h>
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
+	  PD_CPU_NOCR},
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
index 07ffce310686..9e93a1f98f68 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.h
+++ b/drivers/pmdomain/renesas/rcar-sysc.h
@@ -55,6 +55,7 @@ extern const struct rcar_sysc_info r8a7743_sysc_info;
 extern const struct rcar_sysc_info r8a7745_sysc_info;
 extern const struct rcar_sysc_info r8a77470_sysc_info;
 extern const struct rcar_sysc_info r8a774a1_sysc_info;
+extern const struct rcar_sysc_info r8a774a3_sysc_info;
 extern const struct rcar_sysc_info r8a774b1_sysc_info;
 extern const struct rcar_sysc_info r8a774c0_sysc_info;
 extern const struct rcar_sysc_info r8a774e1_sysc_info;
-- 
2.34.1

