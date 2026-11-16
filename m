Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825684;
	b=ZJkn1PZu567DWTMK4ZUfvvOjuq6UxnDos/nFBIhK8xegk5btBQKS1/BTwymI6YlDdYno
	 cbmGERg9Hl1rvaUyZpCkHtKwZY7KW4VXi5iyVlIlnN88oByOvauiAnMGDvw9HbbLH20An
	 1G/vyey7vEDscoIVzx/usz1R7nLCWuqis18aHOKs7yAtzosgFEemrkUb/U2M1MhX0dzq4
	 a0rJ78tRc7Q+cgVlrbSB1RFfS/+U5f0nZgA8fwJ0bEDT4gNupu3tKKCEGoCTpQ6tENqvL
	 gB82abU/TZXIyjR3Z48IFVmxodwgnTr4rD22XkzMgMaVA93ciebPaUTI7j/ai8KXUIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825684;
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
	bh=O7Nmq+yq5I/rxKDA72nxHgloYX9kmAMN+pJZiFmDy/A=;
	b=iNx2k2QS6gFIjlClyUq3bT1qef65/riQAWe3wreinN//guIADp7u1JdDXHOvs9GFS95S
	 Zq7sPtcS9hKLCi4T3djD3xLF2v67LNs0xDfCQRVppPDoufVmVR/cgmmZwmcw/PGu1jZXV
	 vnM1pau1uujR7vwidHJt9+LYK+oWOqfNI5Ljk9zM5nCuI/Xo5xURTZkzHxhZFxdgUi0gh
	 SM5MBGoRhwKflscRdt9F7JgewLG1o/ZX8u63D+0QQQRGiqf4q8dEqiYygOFWDUdxFz/8g
	 jiA5r+Nlt0ZNnf/pefmKcJ+oPTY0pI2mMAz586fLQPg9UO1OhsE+NmEKc+8x+mbXuDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=AoCKEUm4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.41
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCCE606A8A4;
	Mon, 16 Nov 2026 10:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DCCE606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=AoCKEUm4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUrw+JEC9xd1eVB+9HCdKqyxEBjxjKU+mIV90d02+bgFqwDefIOxkiwWwfz2pasgonujC/Qj/+mV9t+qKiKBZelzytyG+Q6hT7aaW0YZALiHJ9mPh5j5xY7cvRthWgznW3exXZSAAHCHV1hLoyfD3sJEDbudsb8jKBLsIrm2TeKpq2Nm8XZ5l3v/V74X76wi1J+r3uapXm5yA1VhT7f/r06gR7Oa6dbAuEf2oZ9LahN9tT3FUvhjDYQfx3n6gRlmcWWPcJqMhk4j7dTfr2i5jf7W59COQAKudsR7Zf7jIncYhdykJEQ4bE/78Kx1ktumbqOEY285baYUYCZ1oNXXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7Nmq+yq5I/rxKDA72nxHgloYX9kmAMN+pJZiFmDy/A=;
 b=VbDR/cI4HqomkJ4LM0hx6Wtm1L7ArFk2x3BqH5O3ykEQIHc6hHalPn/YyoLGnBO1CpDrxCnW7njNxblcOeHqI3IP47x9kGUb4DiADCjqjmlBJhanXlSPyC19R96H4vI09rt8szvAVZcXrp1WbRAtRihestmJnwtjeKipEKsYZUR9rr13xXGR4RCEGuMcJxTpx++TysNchkiagpdNixP1KFbvv0L8OeZ8FIP15McLDdgCC1wc7KT3qOFWuRvnNoReRtvNOEyzUC8GEqhEiEJWStObNqSbrKq4Azx7fXZRhzy9lxgkZt4v+xBRlxY5dUjDi18BevSSJSCoMrshzmytfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7Nmq+yq5I/rxKDA72nxHgloYX9kmAMN+pJZiFmDy/A=;
 b=AoCKEUm460nLlrirKCcqFMwY4WD/GZWtlo4oWLlokik86CQihJtv3x73R6lu5m0bcHKrxCfD0YzPrPyywKI6iIy1gc49HFgbBqLyAShYzw/0Xr3v6Dy49p8pQO85owq4WSUQvp5CUPVZ3TJVQWhDYdE4DNBLvmTpIKHIbqWUH8oXVWh06MsbSoQtjBejMJyoCwPvdvRKfZyMmQW7xjcCRClzr8zX0EGiTQsoHM204jnuGcH0D26CZlkhrnaiOoq43rFGn7obtdrNbc9pCILtdxutw+wDJIYlvTE5ON9emNK58qfVpj64zLxMHyYVps8djbC+V70tuvBGYgW6115RTQ==
Received: from DB8PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:10:110::36)
 by AS1PR10MB5390.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 10:41:16 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com (2603:10a6:10:110::4)
 by DB8PR04CA0026.outlook.office365.com (2603:10a6:10:110::36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13
 via Frontend Transport; Mon, 16 Nov 2026 10:41:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 10:41:16 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:41:59 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 11:41:15 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH 7/7] arm64: dts: st: add power domains for STM32MP21 family
Date: Mon, 16 Nov 2026 11:40:32 +0100
Message-ID: <20261116114024.RESEND.7.Ibc243544a13186cabedd574e63a3a1f881f9fcad@changeid>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|AS1PR10MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: d03abc8f-0d04-4b3a-c01f-08df43ce2470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DIR1WFwtFJaSp5XHjbo7Zt6zIsfdV8I7+nmBvVEBtyToYgshAmbQG9qboF5M+qQfLwXcBzTCZnqSHYsS0zdooN8ajzXxyIcsUQM8HSGeVCNDJWXqvd1eMgoHmw37nqsd3uldXXiN86saqSk6mjpPSP7eScNgnk5Nl1J7Z1MClONmMjSj1wnPUbYeCFx1Q+qWl01PcDWe2Hl2xuGH3d+9Aq/9wBQk2qWwuaeoTS0nRZEmTyFRTBVxujb8LI1/pM1jNIAloryIOcNeOOPrdt/EdW6BotQHYCsCwh0nglHhcP6FGM5W7wW7q3lILaT5JkTcRG8dRVwH1/AlPILzXpsZc7k35g2cJAdWjqf8wgFbDFTOVRl4zacfZkq3cinl+DJ+6l6NwZaBxUxzMvjc1V/BJt22SOz2dloYkAFSa007B86Pbwuc3BLy2O1Nx6IDgR3hd1rUABAzpK/FRxrY+NktMJwVYY/EsjCAwM7MajesMsNToRfFpZQT5WBCrW9zhRbhmzRG0BDM3KfqD0Y5HsvE/w/ydDlHDxFQrRNPCaUbWhRwvOfCjfDNaVP5R3B6f4D608HMOKz8OMVY8b9D7pXbYKx/uFpyzYnK4sUicx+UqkHjjJRJyrtd9PRnU+bVusOcNZNQcT8+aoiTGD2oISnirqVrFVQ+jsGlVjGaKbjSiMJRZQPHdKyKEL1x4IAXOzYlBi1GKk8DPAXkoSvMEN41qg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WUIl4G6U44tll8O0RhoS0ldEQ08WkkLniTYgW/5pJX6GkNwOP7CtVmME0b/1dmZrYjkDAKVQHQh9te7ACnHXqhJoiMpUEZBl0XFP5FM3DCtk7df9eWDagqNxoivYQttDDVGbKz6Os+xYsEJmbx2rqghlUteD8N69DohAAyFFqVqeyafvlwxOsRh0zwuGY7NgBLNPqPEfhWH11cuAqDHLI9ySWeNR8CyG1NGhRp0/+sV8WfJHJwQliSAu9X0Z4D51O3jwLKFFSvNOnzEylvawS5x3nX6zIV5A+0RLggpJV7buc5JIX+ksbudQvxzL8Tsv/TnoYj+8dH07UqxEgPFZLm4DgiitRRm1y27TyLc/zGOJNAwhCydyLrNfj8+Skfcw5hYjDI9/T6IdIxpsAoulJcwDIc/N7ky7aHQ9qdvCkIA8tGPK0Yyec4UDrtF9PCuK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:41:16.2493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d03abc8f-0d04-4b3a-c01f-08df43ce2470
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5390

Add the PSCI power domain for STM32MP21 family on CPU and cluster,
and the D1 power domain for devices that require the Cortex-A35
cluster to remain in Run1. The wake-up handling is only managed
by the PSCI power domain with EXTI.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm64/boot/dts/st/stm32mp211.dtsi | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp211.dtsi b/arch/arm64/boot/dts/st/stm32mp211.dtsi
index 4bfd58b26b51..aad7c87dc8ca 100644
--- a/arch/arm64/boot/dts/st/stm32mp211.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp211.dtsi
@@ -18,6 +18,21 @@ cpu0: cpu@0 {
 			reg = <0>;
 			device_type = "cpu";
 			enable-method = "psci";
+			power-domains = <&cpu0_pd>;
+			power-domain-names = "psci";
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_sleep: cpu-sleep {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00000002>;
+				local-timer-stop;
+				entry-latency-us = <150>;
+				exit-latency-us = <200>;
+				min-residency-us = <1000>;
+			};
 		};
 	};
 
@@ -70,9 +85,30 @@ scmi_reset: protocol@16 {
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
+
+		cpu0_pd: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_sleep>;
+			power-domains = <&cluster_pd>;
+		};
+
+		cluster_pd: power-domain-cluster {
+			#power-domain-cells = <0>;
+			power-domains = <&ret_pd>;
+		};
+
+		ret_pd: power-domain-retention {
+			#power-domain-cells = <0>;
+		};
 	};
 
 	timer {
@@ -108,6 +144,7 @@ usart2: serial@400e0000 {
 				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&ck_flexgen_08>;
 				access-controllers = <&rifsc 32>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 		};
-- 
2.43.0

