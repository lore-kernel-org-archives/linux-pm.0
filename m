Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803621;
	b=zK9ThxLeuoPDz/BfYcm07LkD1m8b7Pb9hJy2ja7sB5UpYm9MkTZzRlvOhHiS+HoqUBqn
	 lc/ERtjad9j5NGC3SHwDGfIV6hzdHBU7pWe67ov3/34xojVix/OuKQl1EkXqJnAtjtLnh
	 vOHBm8X4qcxH0ifqJnoQ4q1DlHE6wOkzs6p2ll8HSg7OCGeo9WJX1kq6N1315LjJQnMDB
	 4m9KULFueNduGax+6N50DvgQcJIXDADGzYbAOSDV6eNAV9DkRg7lHtWuFbaCGjhW24npM
	 NfdSoydvBgVHubADcj7WCM/0lMRKStU3i6sLTF1NzrYVAmrEtdjYD+rXV0cmoczbU/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803621;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tLXnhak+8cAw1loI0YWSSjXLL1Qx2dXi24NFcFHrKFE=;
	b=p7dyu/bQLxsuyYfd7v1OO501UcCn+s9qckxygQ+spuyROKwksq1boBwzOiNTm6M3p9WI
	 pjpm/40FucENHQKK/XUZPOG/48RRS3nYl2pxNexwCqGpctHyEa7S0gA5NkV1hh+SWuBmr
	 SVnKcLH36+4uDuM5vGfkicdsK5qIerliKU4VPJJWLfkK6ASJ77go325Y1ru0WkElB/voM
	 jOWjfyLz4wz8ZZPgQolllPu1ew6+dzZoMF9IPp7gpxRKPjTsixrjJ+VIwwUzhBg6fKOqH
	 12Kl+gI+0S2f+HhYOVukceQf1FTCOD2x6dl5YfCXzpsGu70h7gRjGidJW2nEuh3n3fA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="oJNl/Mim";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.5
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97162606A692;
	Fri, 27 Nov 2026 18:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97162606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=oJNl/Mim
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybMkT7J6Z2/b6ZcKLWKZlB48ivNwbT4PRt6wRpDNExoEoSTgvUIZbFRsQHGUdFMfyKysXS9LByN4MCZjiMRb/C4mX7yvpSAOkuZ5u5KKI2c1jN8pVXFwKb/gALhLm6gmj2CZACpBUWPbtkNqvdCPCpYBJEVaX3GDB+pST48CSV8hA2qjhZB+PNvZnuWDNdLDaADQknn35VHmd6ldifpX0aRFeqt8PuEkhWW8GRzg7kZR8RWvqHm/aETVoEcXXBahh4icWA1EDs9v65J3K5G7gu+I5jbIVX72eXo+Q8FoxB17hGebW5yj8p4GIvz4u6ZlOZDaAkweBidnMtEjPT5FPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLXnhak+8cAw1loI0YWSSjXLL1Qx2dXi24NFcFHrKFE=;
 b=IeOO3cSZiLExUCF0b5ADFVBfBPcot+xgVvA7oeTlvo2BpJgkOnPaSHyx7e2sLxKJTCDUR1mLh9l/Tbp0i8MQLqSLSyved4PBKLAUPdrt3QCm+eOygl7/EPSqTUmdBdFEYKgJDF/YINltbAYWQWvClKFvCO05do7w62g4d/rvAW6SbkhtavPPEUlT6DKHqtroxGiPS+5y5Y+acB6esLLjUJ3t9lyXQvdXl703QESYnKvP1LSDPj5iqSTXY6Sd91tDKscSst39CPGvL5PpTJZTg9pZSc096uqqr78rXLph2mLjwNKyGAQclzr9LZWQv3U8jOFhm0wMWJtv6a1DjadSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLXnhak+8cAw1loI0YWSSjXLL1Qx2dXi24NFcFHrKFE=;
 b=oJNl/Mimos9DDWssiHqjlmyvJMpdENHHqsp6/158Dmga9JarEt5dVEGtch8Un0dWM9a7gSnvgH0nuJMJLNQ3+Jssy61ZzQEo+jqmL3frONJP2OWDld46uqbY+4AhAIxjiMl/VP+Jg1gZ2x0pd7f7DczEOZ1L1wjo3OJdNTSZ00Ff452dSFay3v7s8JWipD3vaIacBfJbjF1DGraondSDom+Rjcrlm49E8LBSCITpNCvJk4e62HUGgFAxtwywKeccR2ejiscfuSHyZd73dn66jegHdQVVJxPZUdQ+oiMXK1r4GiWrA3dbCYgs7BqdDgD76cu2+u2i/qZundHK8OzhUw==
Received: from DUZPR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::18) by GVXPR10MB9643.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:314::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.6; Fri, 27 Nov
 2026 18:20:15 +0000
Received: from MAD0EPF000008B2.eurprd04.prod.outlook.com
 (2603:10a6:10:4bc:cafe::2a) by DUZPR01CA0120.outlook.office365.com
 (2603:10a6:10:4bc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 18:20:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008B2.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 18:20:14 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 19:21:20 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 27 Nov
 2026 19:20:13 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 6/7] arm64: dts: st: add D1 domain for STM32MP23 family
Date: Fri, 27 Nov 2026 19:18:30 +0100
Message-ID: <20261127191823.v2.6.I69d937a929c3e745f9d11db74298f0e1d91f0c2b@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127181958.113639-1-patrick.delaunay@foss.st.com>
References: <20261127181958.113639-1-patrick.delaunay@foss.st.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B2:EE_|GVXPR10MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4d8094-99fb-4e3e-2a0a-08df4cb3152c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|11063799006|261009223027099003|22082099003|18002099003|10067099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|44046007;
X-Microsoft-Antispam-Message-Info:
	nLpocZKVCTEqNbPVNbglqJdK4G1prTA8kPhN7bKfdFG7DqPwv2x6wx2vbLhEx6d3wD85kyIpmSWIAYFhsmPohUAZri1R3VsW3BJxkRqbiYuRhu0UVJu6E9F3nTyz728UmtcwOr2hpwLM4X4S76LICNHaJY0+9lxgZ8Ci5I67qUR6tH6mGCQVP96JZuCHC46N35jwchK2ZhRzbWcgseRh2ksE9rnu2vBJ8Pbp03IjcyqOD4efEwFJDQCdwaBBkwmUv5G/9tOeG0VIjM6QteLW9sVEY5dK6cK7I2i3FlNb9GYn1D+Gn6W2AYnDbfB9S+byF0/DqhaqgXKLCbBsMobJdznkI0YUaK7ZXvXOyyWy29z4kQnwWOM2RNIDYnW+SGbYm4UiNvmRrTFH5Bbo4YHCqt0/WKcuc1S8ttSjl+F1GowQN/D56dTvh/MRek/RgeGxZmE8c3wejlJWOjKCF0CMvUrKG5kty8kvvn4WLwklIBvhkRv2hAbVpygucKLiNfsRPO/54WPHStSapk0lx76WiHxVJphY+WB0TDssJfSKnZFSTf5AJudA3/3Ngnlgck52dUDQS+lkn80toY7GU9XAxEymVDtzJzE6VydWR6pDPcqUvAh25+QZgAZtH6F/LrqROEOB9LA0qtKTLIMru3RZZdbRuKwenAjfqECnEuiy84Cdz2gfe+2FRFLB9aSU13Vo5CzhVnUlgn2FYLCAGrJsbstSwpmQnG28DgyqfpLC0N9eNdNTSQ5fbi+lCiHMPa6I
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(44046007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RydGcrXLMBX8+KYJXC5UBybyInnR5SbtbHoMUGg9OXczYEYC9APQfYctcuOVrZOaQ4Za3hC7gb70oeae70Fix6LDHa8uM4nSjNkhICq9LZZsyT77kQ+DyPNekDgjnz0iBldFHvibYVOW6pmhGFdl59CBmP3nILwgyJm9VWTQxvNu976NURTkaThWeZ1g3o+uMPATmXmrRA6wqlf9XtqDdtKFmackffYaKSyhAi+gMlKsbO2hUtn0hSo9l6Id8+lf30ZZSLudsFdfpv08rC7KHVStpy9kXBgQJOBLpa2WQd5C1A3LQOTeyAjzghGRBWVozZz+ISx6vLU5EwepLmQp9h3o9dBcTFRKoiImrVjxyAKC++lseEltv9fpNpwo5bbPMhr7s7LoJLxJQ2WcH7FpTIDPlf+bd2YrQnaLYDljWBTFjpyDhi0zQ/24BfnOMPUt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:20:14.6889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4d8094-99fb-4e3e-2a0a-08df4cb3152c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9643

Assign peripherals that require the Cortex-A35 cluster clocks to D1,
a child of the PSCI cluster domain. Keep the wakeup path separate from
D1; the domain models peripheral functionality, not wakeup routing.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- replace "power-domain-d1" by "power-controller"
- update commit message

 arch/arm64/boot/dts/st/stm32mp231.dtsi | 54 ++++++++++++++++++--------
 arch/arm64/boot/dts/st/stm32mp233.dtsi |  1 +
 arch/arm64/boot/dts/st/stm32mp235.dtsi |  2 +-
 3 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index deeda0a252ce..d8295caa8301 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -130,6 +130,12 @@ scmi_vdda18adc: regulator@7 {
 		};
 	};
 
+	d1_pd: power-controller {
+		compatible = "st,stm32mp-pm-domain";
+		#power-domain-cells = <0>;
+		power-domains = <&cluster_pd>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -187,6 +193,7 @@ hpdma: dma-controller@40400000 {
 				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA1>;
+			power-domains = <&ret_pd>;
 			#dma-cells = <3>;
 		};
 
@@ -210,6 +217,7 @@ hpdma2: dma-controller@40410000 {
 				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA2>;
+			power-domains = <&ret_pd>;
 			#dma-cells = <3>;
 		};
 
@@ -233,6 +241,7 @@ hpdma3: dma-controller@40420000 {
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA3>;
+			power-domains = <&ret_pd>;
 			#dma-cells = <3>;
 		};
 
@@ -251,7 +260,7 @@ ommanager: ommanager@40500000 {
 				 <&scmi_reset RST_SCMI_OSPI2>;
 			reset-names = "omm", "ospi1", "ospi2";
 			access-controllers = <&rifsc 111>;
-			power-domains = <&cluster_pd>;
+			power-domains = <&d1_pd>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 			st,syscfg-amcr = <&syscfg 0x2c00 0x7>;
@@ -268,7 +277,7 @@ ospi1: spi@0 {
 				resets = <&scmi_reset RST_SCMI_OSPI1>,
 					 <&scmi_reset RST_SCMI_OSPI1DLL>;
 				access-controllers = <&rifsc 74>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				st,syscfg-dlyb = <&syscfg 0x1000>;
 				status = "disabled";
 			};
@@ -284,7 +293,7 @@ ospi2: spi@1 {
 				resets = <&scmi_reset RST_SCMI_OSPI2>,
 					 <&scmi_reset RST_SCMI_OSPI2DLL>;
 				access-controllers = <&rifsc 75>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				st,syscfg-dlyb = <&syscfg 0x1400>;
 				status = "disabled";
 			};
@@ -325,7 +334,7 @@ spi2: spi@400b0000 {
 				       <&hpdma 52 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 23>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -356,7 +365,7 @@ spi3: spi@400c0000 {
 				       <&hpdma 54 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 24>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -383,6 +392,7 @@ usart2: serial@400e0000 {
 				       <&hpdma 12 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 32>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -395,6 +405,7 @@ usart3: serial@400f0000 {
 				       <&hpdma 14 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 33>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -407,6 +418,7 @@ uart4: serial@40100000 {
 				       <&hpdma 16 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 34>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -419,6 +431,7 @@ uart5: serial@40110000 {
 				       <&hpdma 18 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 35>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -435,7 +448,7 @@ i2c1: i2c@40120000 {
 				       <&hpdma 28 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 41>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -454,7 +467,7 @@ i2c2: i2c@40130000 {
 				       <&hpdma 31 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 42>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -473,7 +486,7 @@ i2c7: i2c@40180000 {
 				       <&hpdma 46 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 47>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -488,6 +501,7 @@ usart6: serial@40220000 {
 				       <&hpdma 20 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 36>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -518,7 +532,7 @@ spi1: spi@40230000 {
 				       <&hpdma 50 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 22>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -534,7 +548,7 @@ spi4: spi@40240000 {
 				       <&hpdma 56 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 25>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -550,7 +564,7 @@ spi5: spi@40280000 {
 				       <&hpdma 58 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 26>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -665,6 +679,7 @@ usart1: serial@40330000 {
 				       <&hpdma 10 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 31>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -711,6 +726,7 @@ uart7: serial@40370000 {
 				       <&hpdma 22 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 37>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -724,7 +740,7 @@ dcmi: dcmi@404a0000 {
 				dmas = <&hpdma 137 0x60 0x00003012>;
 				dma-names = "tx";
 				access-controllers = <&rifsc 88>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -750,6 +766,7 @@ spi8: spi@46020000 {
 				       <&hpdma 172 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 29>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -766,7 +783,7 @@ i2c8: i2c@46040000 {
 				       <&hpdma 169 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 48>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -781,7 +798,7 @@ csi: csi@48020000 {
 					 <&rcc CK_KER_CSIPHY>;
 				clock-names = "pclk", "txesc", "csi2phy";
 				access-controllers = <&rifsc 86>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -793,7 +810,7 @@ dcmipp: dcmipp@48030000 {
 				clocks = <&rcc CK_BUS_DCMIPP>, <&rcc CK_KER_CSI>;
 				clock-names = "kclk", "mclk";
 				access-controllers = <&rifsc 87>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -809,7 +826,7 @@ sdmmc1: mmc@48220000 {
 				cap-mmc-highspeed;
 				max-frequency = <120000000>;
 				access-controllers = <&rifsc 76>;
-				power-domains = <&cluster_pd>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -825,6 +842,7 @@ sdmmc2: mmc@48230000 {
 				cap-mmc-highspeed;
 				max-frequency = <166000000>;
 				access-controllers = <&rifsc 77>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -840,6 +858,7 @@ sdmmc3: mmc@48240000 {
 				cap-mmc-highspeed;
 				max-frequency = <166000000>;
 				access-controllers = <&rifsc 78>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -869,6 +888,7 @@ ethernet1: ethernet@482c0000 {
 				snps,tso;
 				st,syscon = <&syscfg 0x3000>;
 				access-controllers = <&rifsc 60>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				mtl_rx_setup_1: rx-queues-config {
@@ -900,6 +920,7 @@ usbh_ohci: usb@482e0000 {
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb2_phy1>;
 				phy-names = "usb";
+				power-domains = <&d1_pd>;
 				resets = <&rcc USBH_R>;
 				status = "disabled";
 			};
@@ -913,6 +934,7 @@ usbh_ehci: usb@482f0000 {
 				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb2_phy1>;
 				phy-names = "usb";
+				power-domains = <&d1_pd>;
 				resets = <&rcc USBH_R>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/st/stm32mp233.dtsi b/arch/arm64/boot/dts/st/stm32mp233.dtsi
index cebefd99906f..3fa91f7f2762 100644
--- a/arch/arm64/boot/dts/st/stm32mp233.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp233.dtsi
@@ -70,6 +70,7 @@ ethernet2: ethernet@482d0000 {
 		snps,tso;
 		st,syscon = <&syscfg 0x3400>;
 		access-controllers = <&rifsc 61>;
+		power-domains = <&d1_pd>;
 		status = "disabled";
 
 		mtl_rx_setup_2: rx-queues-config {
diff --git a/arch/arm64/boot/dts/st/stm32mp235.dtsi b/arch/arm64/boot/dts/st/stm32mp235.dtsi
index 7a87c344a4fe..561b12ba74eb 100644
--- a/arch/arm64/boot/dts/st/stm32mp235.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp235.dtsi
@@ -20,7 +20,7 @@ lvds: lvds@48060000 {
 		clock-names = "pclk", "ref";
 		resets = <&rcc LVDS_R>;
 		access-controllers = <&rifsc 84>;
-		power-domains = <&cluster_pd>;
+		power-domains = <&d1_pd>;
 		status = "disabled";
 	};
 
-- 
2.43.0

