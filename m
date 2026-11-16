Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825687;
	b=qbYdEh3oEqWEenRst9ur4t5Mr5lyFGB+TRmENrlm8PgwuvBDUr/qiumlF9QVIS4GMRxX
	 VVS7PA7HZz7AHguR/HHz6AIysZTHq1uuf1+qV1B7vOtq+Vlo8VymSCBCwmMHEcSJKvlmY
	 U5M2mjaGKDf92213czAoNvPn2rfiFyBep0vMtQI/34EzRGB2coMnjcZpIXw2C1CiC6F4c
	 P4Lt0nXIY41gtMCac3Vf7Ta86kaV9wpY8USN+UNmxcrS1nv18YkmAqR9qAIEPCQg5m/7f
	 sJ+pkpuBOyiks0GYsQBZIy3zWtAG3ZLfpFcwkc0InpA/4D4sv9slUDRlgzlielsRREw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825687;
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
	bh=82PBrT8GiewUmm8qTnXj6CHXuDY9tv+0OgwqybUdYOE=;
	b=PBhxZ/KWEnKgZIEQpFqSdmbzpJL6Mdd8yIZKg0aT/m6tBl+Fe8TZYoNNMgs/FWrJ5xFs
	 LUx5Zi2w80zTPYOl8ohrxcpK0K+1yX38PmxLgrJEOor0DweM/gRwcmvdUMu9PZX6zst9u
	 bI0v1h97y55wX3fHqvDCQLpWwc29W6KzwEMbB9qGAIv8iwb9NirwI5VXFDxJXaSLEDAAC
	 258g9QRjza0lOleSlpsFHtn/wKcKKav7/yBS0VkLLGjQy5Iv07nSPMEYzSIHhLgcnEuxJ
	 s5Fu5ZQdhAojY8VOwowaOJPWDC+3lK1gbzzjWKjxD/HIr42vlHrh+PMBLkAAgHOVBWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=YIbV2LK6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.57
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D73606A882;
	Mon, 16 Nov 2026 10:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D73606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=YIbV2LK6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwbHNdfhU2cNa0DdGMJzT+FdJcKN7eO7nV5UPJuv7kj3EOglidKdCtfaOZ5i79UwVQ5OoXp1i9v4NZVB/KrSzJCPvVA2Yo1QsePevguV0lgesApgV7Tpge4wXTK0jUbowtxTNhtcCmeTr4Ecob/nCW/00Hr8aIxRNv3evJPUObeVGbQEHrSX/C8yW9bUB4sdp7MaXBcWCBx05GbBv7lyS1xcfQoXn68SbuGBo0cxB+7ZhGcI9qOd5DAWUNxNgw1DAs0rwH/4qtHd5UlAVKamD8TRfZlJJLKY5wDrPJkDvSr0tZ7WUrb8ZsLN0yeTOZd0tJ7l429MJ1XdwRo9jA43VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82PBrT8GiewUmm8qTnXj6CHXuDY9tv+0OgwqybUdYOE=;
 b=Qi1Z6ry79+xJNNS4J80yUptaSnJliI3UCcwbpH9jYfQTtdXm2/FuqpXeSIqIuPgJyBV49Fd5HNWkk2q+oj8yYjKN/ddJwo8B36YEt7MgvkoVK515UuT60Se3ycrsoWRfs5J0t7wB40vbY5qjWrw+0Q9o1Zvu/1RryExUN/5mw1c65Z3zHSk+X9jZ24lkvh6jx/7grY6Foj6poQRh3RhcHjW7PuP1hvyPYxdDuuG+R4hww0s4xfmPVKI+mUQtw+4Rao2tQFmoNP1kal8M5+yDj3fA792ErzzTsbfG4uY23SAO82v0lzSA+QHSezxevUQmxqlm6Np8yaTW06CqI5tQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82PBrT8GiewUmm8qTnXj6CHXuDY9tv+0OgwqybUdYOE=;
 b=YIbV2LK6Zbz4Hh/0ZPQ/24PZESMBfe8gTVBGR8XBg/FwwkY7FGguBmQeH6R+goGg4d7TKmR3wW9tKl/a2m+kuVrE1c3y/XN6lBP5qKXawIp0l3+YDykq5+UXcO28cgRBHnF7MEFQ04VUcFaGAEXvb8Wyv49j6NAZ5LIo0jwPOcM5gEc54wM1TxOaeZxT27UumTLB/ZJnJpXw4BYH7jjUHUWvkTk6ep/hpHXxY5azExueHLyqGB9kTIPjlPv0ZnYcVR00zaBkwaL8yDkGHsjb91glYSvBfW/TCx4gEnxSaVQodVk+7yQoCb0SXkKz4pBP4nlo6dqW5Sr1R+io1dqH6w==
Received: from PAYP264CA0001.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::6)
 by AM0PR10MB3538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 10:41:20 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com
 (2603:10a6:102:11e:cafe::46) by PAYP264CA0001.outlook.office365.com
 (2603:10a6:102:11e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 10:41:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 10:41:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:42:14 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 11:41:14 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH 6/7] arm64: dts: st: add D1 domain for STM32MP23 family
Date: Mon, 16 Nov 2026 11:40:31 +0100
Message-ID: <20261116114024.RESEND.6.I69d937a929c3e745f9d11db74298f0e1d91f0c2b@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116104054.94115-1-patrick.delaunay@foss.st.com>
References: <20261116104054.94115-1-patrick.delaunay@foss.st.com>
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E461:EE_|AM0PR10MB3538:EE_
X-MS-Office365-Filtering-Correlation-Id: b462a7b8-c0f4-4e05-13fa-08df43ce255a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UMCa6GTE3giP1tm0nvlObuvdn6FTtkibGTkWV94bwe23p+OklED9ScrPH+BjG9ZR1lNDzTWi8KOm+2qOVFZXategrvJsCG3y4b603AkYE6xpuvYrQXg1wNQyg3tgl+5deWojKxLhJ2nE9EvD52uh3Ku89tGawuFgQ1HpWCaY7iOLp0KPZ8zKXe9/90j3IH8vVreYnHBF4GdFtUyXou6WdwWqe4zAwLLn8UDb4KHpkUPoTolRWsc2eT+eH0n5duboOhRijto0RWwdH49ww9Ymh9pDPsxUQ6NK8pEvs0HG+jtC7LFqP2lyo53GGwueb2kHIa1IDKfXXE7pj/cys02oyFYRR4V9i8I/AJ6cRDg8LogALjTyFR+6JSW65x3H6L1w5IfAaW4ycabVVaHTi6NlzIllfYqEveDXCwGjVN6ubaSxwKrEOqdY46QOI5gMU+BucQzi41DubETXSssLAfMoDZxIdeM1THf5EbbDz4Nf6ALJpLE/7ic77paSDEitqc5jLdYsOk5OSMCUMCKypbIuCt3vnC3RbZgVcionRXnPIaWIVnHmUh1DvU0zk2Y7SMzV4xPxX7tXesnFFRTEmyjluWJzp+GN4A+DnNisbtY+aXM38a68Ef0ZEo9GY8NMcbrVlyCtVYK0ha6Hk3oJs9jPuLmXXVkDGKCP8XI4oqA8N+xVshXGrz/XfC9ea0glPj/A2c7RhwPF2iOL3FSZyN2IHg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sZJSoWHFOldHrwo9puTsakWnUCz3CvtVNZNWW4w1aIWibn77iJb3ia1xMGT+D4J7vS+J8yM1875/LGkyuabXbSt9vG6J84M9RiERfHi+8xeBw1YLaQFscBybItiqSWLTD+tJX1eOCfEFaw38t12uoGuQlFGxjuckDxHe5cwjzY9zJVfbGv4mzb4TO3qk0GXqH8Ohcw9hdhTNTrLYOb1SZrSBReGS5kO2TG9Lglt+PSpfyMKd0a2xZ23dQ5PPwAzLlyMdjQ4H0kiGx2nPuv0JfeBak6jPhajH2Ar9kCmISoX+qpBHbiMWmMdP9ySPVDU5AoIo3sIUVB0LxBaD9YxVtD3ktqIENdW+1VesmP2eB/DTnh8vjpX0V1SALBbtRsIQ2Y9pA6CaJrupIICCDF6Kytgt4nEB0PJUD6yVzipGr540stLGLqI0nLcFvSpl2mAu
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:41:17.8452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b462a7b8-c0f4-4e05-13fa-08df43ce255a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3538

Add the D1 power domain for devices that require the Cortex-A35
cluster to remain in Run1. Keep S2Idle wake-up handling on the
EXTI1/ret_pd path.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm64/boot/dts/st/stm32mp231.dtsi | 54 ++++++++++++++++++--------
 arch/arm64/boot/dts/st/stm32mp233.dtsi |  1 +
 arch/arm64/boot/dts/st/stm32mp235.dtsi |  2 +-
 3 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index 27231e140fbb..4075a9cf1d36 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -130,6 +130,12 @@ scmi_vdda18adc: regulator@7 {
 		};
 	};
 
+	d1_pd: power-domain-d1 {
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

