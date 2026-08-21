Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010045.outbound.protection.outlook.com [52.101.228.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3A43C076;
	Fri, 21 Aug 2026 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324724; cv=fail; b=YJhAv7xgzupF9aeltr36Nllh83f8safghCsmJtYIPIwkiXemmaMrAEIykS/R6DpxfFl86tbijHaBkpIkiBG3fHknMsL8Qg7WZ8BGuTDPl21qZWbg9qOcqNtnynSzbiqUvmpnInqmK5vmDVdQWG5puZy4MeP+N1n9bBf4w7klh8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324724; c=relaxed/simple;
	bh=tmuREqGYXjLHFs5GvgFUmjJzcEVLgyUelgZP63rMV3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmxJuUmSk9uZO3ZgfzI2UA4jE5+ttAWLbASl76BTz1+H0OYX3q+gkGr2mToUyW3pEyfJwUlCCEDnQQQpdUGRi3qWLgJarAPNPYzsDKnGonfv/iQFyzSiU+YFE0WyyhRvIo6Pq9GvM2PHu3Zxc7R4RasDMG0j0SWo8dlDFl0WFn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=IckYOEfc; arc=fail smtp.client-ip=52.101.228.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="IckYOEfc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjMZDtfwMhgL+TDtGrItx4Xt+Q/Bf5K2DxTIAcV2+o3C52zj/1LbPCBcmRP7zNqqhQWBRc4sP8jM9YW5kwapEGlz9TAZu3kFoCpfOX8b4dJzdrhj7V1tiXEFGairnzV09cLrBE3Sp0HLHHp29SFOn98UBafzEnN+zUzPKnRGSpvkJtq5wMPxfCbpZT+dDv5+TBGctNG/rIwCuG+106nA0SQIrNEILxpmHQdOK/FeXq3n36aoHWNGV8444hMAMiGH9LrvNrXdj3V5NMIndF1JHuG10tWSFQN85h8cb0h33h3GsG+l9YN8vX7xFCxd8J0n2p3UUCtYmJAl+nIOulc0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V5B+4lqWt1vID7aXtGWWkrDSan4a1Hjt3nv4MyFpxU=;
 b=cKgPSAxoupZy+QnnZh3XDeHN5dfx4WV8URnJlEK0x3w4enF+P8PvUGiLmM0Vn9BHi8XQhOanhvvMfZ43tKxpKJMVWpnUQ9Ert+V9kiQtfCgxzneQZe0k28EX6KzgeLZnpOBKh9RHtIxNNVcdVBOjIrJaGltbwkEjo6EEGnUyRSaCb6+9wNIrsqTcr2AAIJg+js953yx4IGDYhZoe+YUGU/ZPdRkzXB+NzXIZEc42wc/M/e1g5XkfCmEk/yDNpXyRVI9uXz6A3m4XnIvWSKdD84O2UXWM6Bru4WWEfjHkcnSAv27fHSW3PGOPKt1E89JSOQtqPgnU/GlSjCTouR2LWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V5B+4lqWt1vID7aXtGWWkrDSan4a1Hjt3nv4MyFpxU=;
 b=IckYOEfcEOsA7WhBG2x/uiasZVahOgt2XWg52XF7NuYADyERnah/2pIjvRgvN5pMpui34VKxgxEdVSKGOqK01aVqk3Rgnlnzd9Z85AELo6f5fdaCwQuh44/r/7JgMhijarKB82vo7ozMrR5HYTmIpcPIYEysynTdbC9okKHlPY8=
Received: from OSTPR01CA0061.jpnprd01.prod.outlook.com (2603:1096:604:21a::12)
 by TYRPR01MB16071.jpnprd01.prod.outlook.com (2603:1096:405:2eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:05:19 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21a:cafe::6c) by OSTPR01CA0061.outlook.office365.com
 (2603:1096:604:21a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:18 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 038AD30001F4;
	Sat, 22 Aug 2026 00:05:12 +0900 (JST)
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
Subject: [PATCH 02/10] dt-bindings: power: Add r8a774a3 SYSC power domain definitions
Date: Fri, 21 Aug 2026 15:03:27 +0000
Message-ID: <20260821150408.73829-3-ayman.chaudhry.kc@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|TYRPR01MB16071:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5c8fec0d-730b-4fe2-16a9-08deff959d03
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|36860700016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4Mzcevqt0dWmTedLfWzapST4r5wzC64LxVCYFMR2vx+Z8Ty88b2FjG0rjMbuPsssf4hZ06QLpCxaC+50YM1V6BlWt5oHEbjEFHLYVfEayT967wo6wO0QRfqmGXK2lAKobgttFN1b5LnadtgWSsCBdJA/mTiOrPjkZVlQPXPZLj2ac3Et/1MMS5QQAr6JzZ6UT9xlt/m4KlfOflPtN/rC/NWt05Wpoy1RTGzId2E76voabQXvRC1TGxk9lXxHZixQJAZ/x1jd5OQNce69eDxQ14sgvhVlAViTEJeeLojZ8mx7sdgQMl9L97AkQ7Nod5suo5muJPZGHxIbcrSbPtDWDjXPGalVPQXOtOzgbqNbTdNhOVIv1wdWsqbmPfsM3LtWTiRJB6XLavGrJYBoXXT1CDZT5rZO+YaSd0qvd26i/sboBV36r3inZ5ehgDqXdCLfUt3i/ZPwNp2fdT0UGUYwy7br9lR49e7PyxHw53CTmWHybDZJnDLWlww+TpNztI+CRm8Z/CTFKEdKG5vS9mblZEmkcOaRDq3N72V3nekqbpmqr7vzyyN8uygCSwKAFZ/YMbri89Zy4ClLBQDuMrstsEMLdnUJHZR9CBvHwB0lrtPU26QmrP+MoTHnl4dEVShqhOUvrYf+QzdrAnbKnDRSagp2kgTcSXAmET73rLgZxauCUQjvB6ES9k/Kj3oiriZAKAf5y1sNvWKsLs5oUw7IzQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nIMm4Pd0miUuhw1dpDjnWJ4AxebNQOEIau4SF1zL5B2KyGpLyt0nKSvbYur1f9lttMlWmPj6mDhUn7Ow8iQaztEPEZ7ZfBvhF+YZ2V50nPO+/JydiyPA3kky7wrD6R2dc6jT/5i0/f31UzvmwggeSl/RDuPDJogt2jR9IQH6GAq/qj4SKrw6dXYZiZz2oFuqeGrqYOG5nr+9N5MkEWF8854YMgx/nJ3kc0g8kY3Ar9yRhUuQk7JiA8D0nse4Io1V8ygxPPqRdQXaB3Y9lQjF6IhDipV7Q8QYte7WAVau19KhtwMepDHh3BTzuzBr3bK7HDjWt2Tp90g3rAw/yVnJ3inpuYK1zbCbAwOcNfwjyrppKsrtb/vhGydGTq+PBI8iO7FJMOOEla1lsA2108S1m77qQgoGDPWpqBl4u8NevsGqnjG5Ubtkz79IeDgjIiuj
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:18.1973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8fec0d-730b-4fe2-16a9-08deff959d03
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16071

This patch adds power domain indices for the Renesas RZ/G2M v3.0
(a.k.a. R8A774A3) SoC.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 include/dt-bindings/power/r8a774a3-sysc.h | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a774a3-sysc.h

diff --git a/include/dt-bindings/power/r8a774a3-sysc.h b/include/dt-bindings/power/r8a774a3-sysc.h
new file mode 100644
index 000000000000..5694a422b771
--- /dev/null
+++ b/include/dt-bindings/power/r8a774a3-sysc.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A774A3_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A774A3_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A774A3_PD_CA57_CPU0		 0
+#define R8A774A3_PD_CA57_CPU1		 1
+#define R8A774A3_PD_CA53_CPU0		 5
+#define R8A774A3_PD_CA53_CPU1		 6
+#define R8A774A3_PD_CA53_CPU2		 7
+#define R8A774A3_PD_CA53_CPU3		 8
+#define R8A774A3_PD_CA57_SCU		12
+#define R8A774A3_PD_A3VC		14
+#define R8A774A3_PD_3DG_A		17
+#define R8A774A3_PD_3DG_B		18
+#define R8A774A3_PD_CA53_SCU		21
+#define R8A774A3_PD_A2VC1		26
+
+/* Always-on power area */
+#define R8A774A3_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A774A3_SYSC_H__ */
-- 
2.34.1

