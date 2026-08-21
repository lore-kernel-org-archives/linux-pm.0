Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011009.outbound.protection.outlook.com [52.101.125.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E931ED8B;
	Fri, 21 Aug 2026 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324747; cv=fail; b=iAAzNgUpkOrN7WteKqrBS46q9PSomC7K31tSKvLah7xolSuLjELdp5AextP/7EKsFpgy9y9/JPPTpkvyp83pKrXK/Mn78LMR7N5eLWQFeSlNEENon74JsLW3bcFlMlIm/wVpB7o5dGq+zvjiMpma1ZYFS57Kxivejki4EFnWK8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324747; c=relaxed/simple;
	bh=RsHENBB6ABjn39j4u/0BcuYJ1m2gM4BWb1NJlJpmkGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kORg/umNhUGxAlWkGv3BU4QR9m8BqjBXYxQPB6LOxgYrH0A6ix/bduE1AaX1C6X3JF++wAZUQcuPjiVdzFldVD1v7zfOwwfJ2LZ7tE/mQv7WImqe3M9tHNfX7J8m3VLg86+whP2gdNn0uBAX2mYyvBGInSpwGSQofEIes+UC4N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=kj9guysC; arc=fail smtp.client-ip=52.101.125.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="kj9guysC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9vr0gXd85SghyZIb6a8JVLjHEVyvmCo8kxjd+NAdWl2O4ARrBV7Tm6aESf6iAh5yi4/wRGgw+KHyyGBqmaXqrYZ5L4naNhnu73fU/LqsDWdcGYM2BfPUo9ZGZUQ8Y2YIT6iq+gXZ+wA/A+OfTRY79Sc3PaxXsMRRbrat6UnqypbIAGH/Sh7pFaItWjhQYk+5sHGm3DIa6R2h1tOi4MvJevBnRcAM44xkKHoesF45Ew2ZAFWT52GmpbXlhofaXhvhSh1GsRWpXFXFNCzquxysKKpxpLkMj8wXCfPUqnHz2oGFz2NHW8LAc/tu14XGszwFfOVZCDnnr7qJ9DlDneaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyHXVljQ9w/qrnheKILWArQFHXqf+rrC/nNqAzeGeQM=;
 b=x1mlbHhHzkd5umy8LlktwKmK4p7umrZj5tpk5Nw9zF17gOylC6OzYcBCAYbTIViAZRwCA4ezF01IutEnsvr68q4nJ6ORxs8lEpy/mhaxlKyJqz2dVmiKYvnz8otwnZVX7GdSxxQB5IR/BsRcrH94PwV0iHvGE3E0rgnDG4TAYsqGCtsUBSVzEgE6iKH0YeJYv9bByfzkNcJ3tkI8BcLjHENhhQLvgqWsB3+ZeNautfI648+cxJTDog8JFAqSvjAVAL4BevkpmpEnP042jI4UsLkoDXw4nSRFGu+WSjo/ZEenCHofhsKiyBr0cLjeR08kO+bg6bQbT+DB8QxKglxBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyHXVljQ9w/qrnheKILWArQFHXqf+rrC/nNqAzeGeQM=;
 b=kj9guysCAXqtQDfCWZO/7QjVaKb9xAJ6I2bOSz6wr0IBGYHe24eNoJWQc4LHG3RpDLOiF94nMu3B5DO7t2FUXFnWKZjrUqJWzMtxAR0O4gUBfyJMPH4belL15FSN1SokOwFxBX3/vEi+1vtgCK4u1z9000A4xjdOZCSE+PTrNqo=
Received: from TY6P286CA0023.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b9::9)
 by OS3PR01MB9287.jpnprd01.prod.outlook.com (2603:1096:604:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:05:41 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9:cafe::68) by TY6P286CA0023.outlook.office365.com
 (2603:1096:405:3b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:40 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 2C93430001F7;
	Sat, 22 Aug 2026 00:05:34 +0900 (JST)
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
Subject: [PATCH 06/10] dt-bindings: clock: Add r8a774a3 CPG Core Clock definitions
Date: Fri, 21 Aug 2026 15:03:31 +0000
Message-ID: <20260821150408.73829-7-ayman.chaudhry.kc@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|OS3PR01MB9287:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 956f2626-3920-4127-97a1-08deff95aa4e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|3023799007|56012099006|10067099003|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7nt1xNABsmWTNMjJvaVFVTlTWUYgccCWvs5Y+Xoa44bsdTDxyS0VE1hle1nlKz9506FhFVzbW/Sy4nB6BegCIeBGHZXNTbNSKL9+X0aPSDV8pofnOQnVDYmXceCcoOL4SuK1VcghDa8tqdVpjA39faBggKbL4506MoIS3gq6uHOK/bILSX+osqtrhx1SLgLc3zJ+DdYuXyv/LGz2qbUC65GsNFzvQ1eC3SNNnzE9paM/sc+UpbpaI4foZJlEr8wlLhhZTy9EXNgYnaxN8tlmEjCQ8ruj3WnnLiZBW1m/aOSjDowKhv1N18N5t+rxS6O7555hMxOxvPfp3UQqEGrjKjqaK9KO3ITJHhVuJNv84yn67OAfJXdpMvlmAi2eed8acnvgJEB2c2qgT0/dMa3cu+nyuGHoictosk4ZKqyqnFJJ8AtT5ETT/vWDPqKD3h7qtJjNvUsxYqb5dXWRImbrDf2/uux4s6YlN2K1qBs44j6yJD5Fzyh4gwRzIQQ0wFb8hdmiu+rM17RKoRrdRxNHDCMT4N5WlgHoqiahg36N+UTDUqejpMLs4onyBJot2+zBIWDywrUA2oh2ULxKAby7bHcJGij0K89c3BNmZNY/xW5dDLUhzJG+Twya4ph0OsNhrHguaggyXAoxAlG2Fnx+Z4T/exXfjLISBGyrd3HPLuCNG5M09ayK0mXRAqtiYybX4u/vqf2oi9EqgxwnNl+B1Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(3023799007)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rg8l528866KqQStAQwC1Wt1wa4cwX1DTJcdi3TKLDx9U9mfiHezbEZ3YOf6x6+8E9TMrAqOE+gA+1/sU5yznpfmr7jpiSuAm66XUKx6Fd1ZD+BAVdrgyiOh1OoBeEV9wZV0+/KSqlev0uD1hxKz8cl62QyLCEnGXsVGF7QkcKwbQeWtXcdRwrv6cQ2AdJLEbQz6IssLA/x4DKcVfBjoPbVAakxGbFPiL4AfbKvGWmFWdlzIEaNTYLnTIX3B0DQ7K484Wxfx0GexgeocxE7U8FdN5KbZHkCAsSDmV5BPA/CRL7wjspda273BCbYK3A0P2ekZWddQI2We4vfO+exKonCWTTMyVOCjCEs65fwI7v3ntLBh2iME1voDhyAYhj6WGWzsWP5DdXt9WBKva4K94BNIniIRMTdBTi28whFsSPyOgHXDVeY98S94lZxFw6cX/
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:40.5164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956f2626-3920-4127-97a1-08deff95aa4e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9287

Add all the Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC Clock Pulse
Generator Core Clock Outputs, as listed in Table 11.3 ("List of Clocks
[RZ/G2M V1.3, RZ/G2M V3.0]") of the RZ/G2 Hardware User's Manual.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 include/dt-bindings/clock/r8a774a3-cpg-mssr.h | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a774a3-cpg-mssr.h

diff --git a/include/dt-bindings/clock/r8a774a3-cpg-mssr.h b/include/dt-bindings/clock/r8a774a3-cpg-mssr.h
new file mode 100644
index 000000000000..213695ddbd50
--- /dev/null
+++ b/include/dt-bindings/clock/r8a774a3-cpg-mssr.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R8A774A3_CPG_MSSR_H__
+#define __DT_BINDINGS_CLOCK_R8A774A3_CPG_MSSR_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* r8a774a3 CPG Core Clocks */
+#define R8A774A3_CLK_Z			0
+#define R8A774A3_CLK_Z2			1
+#define R8A774A3_CLK_ZG			2
+#define R8A774A3_CLK_ZTR		3
+#define R8A774A3_CLK_ZTRD2		4
+#define R8A774A3_CLK_ZT			5
+#define R8A774A3_CLK_ZX			6
+#define R8A774A3_CLK_S0D1		7
+#define R8A774A3_CLK_S0D2		8
+#define R8A774A3_CLK_S0D3		9
+#define R8A774A3_CLK_S0D4		10
+#define R8A774A3_CLK_S0D6		11
+#define R8A774A3_CLK_S0D8		12
+#define R8A774A3_CLK_S0D12		13
+#define R8A774A3_CLK_S1D2		14
+#define R8A774A3_CLK_S1D4		15
+#define R8A774A3_CLK_S2D1		16
+#define R8A774A3_CLK_S2D2		17
+#define R8A774A3_CLK_S2D4		18
+#define R8A774A3_CLK_S3D1		19
+#define R8A774A3_CLK_S3D2		20
+#define R8A774A3_CLK_S3D4		21
+#define R8A774A3_CLK_LB			22
+#define R8A774A3_CLK_CL			23
+#define R8A774A3_CLK_ZB3		24
+#define R8A774A3_CLK_ZB3D2		25
+#define R8A774A3_CLK_ZB3D4		26
+#define R8A774A3_CLK_CR			27
+#define R8A774A3_CLK_CRD2		28
+#define R8A774A3_CLK_SD0H		29
+#define R8A774A3_CLK_SD0		30
+#define R8A774A3_CLK_SD1H		31
+#define R8A774A3_CLK_SD1		32
+#define R8A774A3_CLK_SD2H		33
+#define R8A774A3_CLK_SD2		34
+#define R8A774A3_CLK_SD3H		35
+#define R8A774A3_CLK_SD3		36
+#define R8A774A3_CLK_RPC		37
+#define R8A774A3_CLK_RPCD2		38
+#define R8A774A3_CLK_MSO		39
+#define R8A774A3_CLK_CANFD		40
+#define R8A774A3_CLK_HDMI		41
+#define R8A774A3_CLK_CSI0		42
+#define R8A774A3_CLK_CP			43
+#define R8A774A3_CLK_CPEX		44
+#define R8A774A3_CLK_R			45
+#define R8A774A3_CLK_OSC		46
+
+#endif /* __DT_BINDINGS_CLOCK_R8A774A3_CPG_MSSR_H__ */
-- 
2.34.1

