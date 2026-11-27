Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803620;
	b=WNTbkiAi8KW1dqAU5ysd0YSa/Htm9DftQIummgXQzOEoChfjpnULya+FabLemRC5+/o/
	 /TfSwSPboY9zmnbfN0MNi0hy/u7k8TbNm+57JSkmoAgGhjt27E7tf0MAl+1RYg3MtB4hB
	 wxkdBgEaqYvoUXmi0GKQiAQ0/yHSDkkGJWsq6xJV0MkCqA5aiG1m22TTajXaX+EeV4keO
	 hiM/P807WoZksMA34C7/lfC4dqgg5AJpymycIniJ9pEBi6lusuED4uM9xz8ApXYNOWJZ+
	 1Y+TG2C/p/sPf4uaYwNV1vYTKXO8BL5mmY5tZi05IrbwUlLJo4N4qx/GzbMGRDbOiBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803620;
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
	bh=3CPT6WDmwWIxn4JYrnMd5nhC3nsqE3bdgNxLEpeDIsA=;
	b=DiZ4i/AS5bnjAvqfDcpsI4HncYWwXs7WALKpWfueyZ2WRqpVhTFDyginGJhvwhj6ycsx
	 2IcYaVGOi5LOAEJm7bGIrkOrsXqoPLWrSdZg8nEGHlEB3BfLS2lVvYQdQgrTeiwMGMrYc
	 HjweRFGulu7NjjGQJtkA3bvJVaPt86iZ2blGQP8nH0ndArwqJtzrH2s+5EoI/77if0II3
	 su47al1r/W88FShDHNVPJwmFfM8A6nPBli+XHvwhydvpvlfEigKG6pb+xrST4n5HJHXAG
	 8p14de+iwuv3eal7jGJSlMBzggLEMxx5GBxNvaeSCNoLgE86ECAEAKvvJCQ9e/MGviA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=aN7IPKUy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.45
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB67606A687;
	Fri, 27 Nov 2026 18:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DB67606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=aN7IPKUy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8KuOzIALyqSNA8hT3L2E+zq2X9kyaDsM70i5p3vQVlCVT4rXmMCG5ciCVUJvxsMMWCGNZBOrpxnrDJSOLb8ZBLHN7XdNZ+IChqBlkbOs9Xs8REJOEX6b1I8pe1l5hDu0gTP6ZjBoDbtbHaEa+fYZ5cr702LdIh1Q90JCebaqg98CoG8mQe/Q5Uvo+6ZJCsJ3bFsgO5pWh/FOrf8d0mgmKsBgbKypcnwJNtKVaUQLxvdVyu36JMIqM5SVD0w14RU8I8VU7oJtgUXQvlMIW7JNe9yIskzEWz9YaGtiI4qC8qqu8GRPQFU1qFzJgovHElBcN4mx8TzsXKd+c/BJ+7rRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CPT6WDmwWIxn4JYrnMd5nhC3nsqE3bdgNxLEpeDIsA=;
 b=iLkBMD9TVucfdsq32DKtZpCBHQPqsw3O2vFIvbJlH+dS4cq4hcGLfAC1MnQxqyF9e1yApPWKbr09p2BucklboYJwSDeRAlTa8qCBGKPSw1QJEA/V/Uo5SPjPQWy+mYUl9lAvrRJI6hJFN53c7AMoPFYrYB6hl+V8KfpgZmc4GxmiMKs+Vw9RpROy7Z0EcDX89ui5PsjKi/46HsHBeddeNNe+Mn5eejfGXCx3f99GOmfM7tDZO2Ksr2lc5fqzKCbkkwdzJizocBMu19GTO2+4j5vFyFPjzz977O73eG+UjtHs5pfzG8hc562zIZ0mpQU4I+3kuiN4RohGJXZcTx1NSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CPT6WDmwWIxn4JYrnMd5nhC3nsqE3bdgNxLEpeDIsA=;
 b=aN7IPKUy5blpx6vicR3pOf9DZFFj+0z9n9f2zA5F9D14VqyJWUfqZgGSSbfAWk5d1GKUftR9YVQexZz4/ISDmR3JTnWwuqXgFZpHj1smaJlbOdOteItAj4dlooMKxfYjl+F7e3XY3AuPlyMJ09keYHzFip71iV43OxekRrU+Lnkmb6BaNTqnuULxwNRENVpkdgyDQBDLLGgKOMN5pLIBMSoBgUok4vR97Lre7e5QAopw9c8tY9TDOtGNM+Le5jw4IyBCgndhwbozUQyYJJEG0oRX2FTbN4dk7XI3YRN+iRXCdai1uB4/A5SvLOsQvJLP/oqTh7NIqt0jsCzMrEk3WA==
Received: from PA7P264CA0270.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::8)
 by VI0PR10MB9335.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 18:20:13 +0000
Received: from AM7PEPF00000052.EURPRD83.prod.outlook.com
 (2603:10a6:102:375:cafe::4d) by PA7P264CA0270.outlook.office365.com
 (2603:10a6:102:375::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 18:20:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM7PEPF00000052.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 27 Nov 2026 18:20:13 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 19:21:00 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 27 Nov
 2026 19:20:09 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 4/7] arm64: dts: st: add D1 domain for STM32MP25 family
Date: Fri, 27 Nov 2026 19:18:28 +0100
Message-ID: <20261127191823.v2.4.I1233f0c68bba42732eb6dc470b5eebaf6db441a7@changeid>
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
X-MS-TrafficTypeDiagnostic: AM7PEPF00000052:EE_|VI0PR10MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 13699c7a-bcee-4f17-8582-08df4cb3145b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|261009223027099003|10067099003|56012099006|11063799006|261102123227099003|261026121527099003|261028144727099003|261021121427099003|261026140227099003|261022105027099003|261021123027099003|44046007;
X-Microsoft-Antispam-Message-Info:
	FGpyIMND+QgglU2/e9Ik4yJEmIyZtSXQHkYX+HmXo4+f3j994dnLSCoH6Zqw0L4vIrIscsIMOuKNshKH+wYQbPFQFAMFHUcmf8ozRJ1BYc/UQjH3Z/LYHtxDtoI7V0mQ/fsjbM82WfuaBxmosFCeBkfT0//++KxJXVraDDuI+0An9SjHvpv0d9yVSZU0svM92O0hTAZxt41eD17AauNb2tT1MQ4Wjy2xCYLMWOj9ALib2tyN57w1ksHw8puyWRjs3B2IYjhOdZqgWbK8cCiEr/D26kgL3rhF749/tLjtAszNtz6YRq3unblfqhlEAw9mfKCFF6xP3lynSt/kLyM50cFfJOCqPEdpdHrjdO8BUj5N8s3EMcwUz3h88zt7xQDAXFmwkT0ZL/gjad5wJ5q7Dt9aorpL170cCrCPJ3+Vn76bLmwg5wR/gV9Av6ykouyzyNdPA7Ld3GN9uSFRDvu9batp1YflKQCP7MT6FEz4Bvaid841yxqojfFWwvEuoBeKqX6KMpPCNvQNTl9ODvSKB93InvXhVpEpfH/bF+Xxu5/7QQO/E67a8esf8j52DRTyZ3wQaV4bfRcjZENFAMAhaBGrDyjtcLBis3GSz9HWNB3BvRN4OX/byBVgUgWTqKn6h5AqrdviGj/EvDRB13tWlk+UNFmk46CsLbNCoZfurgJatK6GGJRU5WbWDfQEYXNA71cni0EYqsBJxE+hZGlP4pTsszkQ2MV48cjQGYZw5Hq85w4q7PcOyAVhnE7IBzQ8
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261026140227099003)(261022105027099003)(261021123027099003)(44046007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jb9OPbHW91rYgt/0nJGDXKh6+nPSVi3Sb3sXKP6ZpRetwuZCCywTot92Cbco6ax6df7uGU7dyDtLen+mOVyL4LoYSzfQ6YhvGKi5+hnFGnhkBwpagBWlzAeJnRSc+QKMzpoTsHj6zVxPAuvyIH24XEWSvbCaEyzJI96pDMYxQfAhqrEKdjMiprSSTqrdsSd5KH2W562UJahg5amjsYNK4y4DBfsAEwxLrFNgV5xY7tNaxA9cG0yd2+FSbnWgecVCgCQDnW3TOVJQTbXzrGR2CJR81UlngYfQL+q41PXlCnvaS41IbyoI8cI0dPVTMO06h5IA1g10gGAySJH2NZZqmAZn/zz6rwr39wKYE9i/eIkJ6MHb91yEa+yStDAmhJkpu7wIvr6XGK3X113zQHtXPz2g0X3SofH9TM6dyZWoEVUahI2pvNYyGr42D4zvumUD
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:20:13.3529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13699c7a-bcee-4f17-8582-08df4cb3145b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9335

Add the D1 functional-dependency domain to the STM32MP25 device tree.

Assign peripherals that require the Cortex-A35 cluster clocks to D1,
a child of the PSCI cluster domain. Keep the wakeup path separate from
D1; the domain models peripheral functionality, not wakeup routing.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- replace "power-domain-d1" by "power-controller"
- update commit message

 arch/arm64/boot/dts/st/stm32mp251.dtsi | 110 +++++++++++++++----------
 arch/arm64/boot/dts/st/stm32mp253.dtsi |   3 +-
 arch/arm64/boot/dts/st/stm32mp255.dtsi |   2 +-
 3 files changed, 69 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index bf1542818be2..49bc5ca9cf71 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -152,6 +152,12 @@ v2m0: v2m@48090000 {
 		};
 	};
 
+	d1_pd: power-controller {
+		compatible = "st,stm32mp-pm-domain";
+		#power-domain-cells = <0>;
+		power-domains = <&CLUSTER_PD>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -209,6 +215,7 @@ hpdma: dma-controller@40400000 {
 				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA1>;
+			power-domains = <&RET_PD>;
 			#dma-cells = <3>;
 		};
 
@@ -232,6 +239,7 @@ hpdma2: dma-controller@40410000 {
 				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA2>;
+			power-domains = <&RET_PD>;
 			#dma-cells = <3>;
 		};
 
@@ -255,6 +263,7 @@ hpdma3: dma-controller@40420000 {
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA3>;
+			power-domains = <&RET_PD>;
 			#dma-cells = <3>;
 		};
 
@@ -273,7 +282,7 @@ ommanager: ommanager@40500000 {
 				 <&scmi_reset RST_SCMI_OSPI2>;
 			reset-names = "omm", "ospi1", "ospi2";
 			access-controllers = <&rifsc 111>;
-			power-domains = <&CLUSTER_PD>;
+			power-domains = <&d1_pd>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 			st,syscfg-amcr = <&syscfg 0x2c00 0x7>;
@@ -290,7 +299,7 @@ ospi1: spi@0 {
 				resets = <&scmi_reset RST_SCMI_OSPI1>,
 					 <&scmi_reset RST_SCMI_OSPI1DLL>;
 				access-controllers = <&rifsc 74>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				st,syscfg-dlyb = <&syscfg 0x1000>;
 				status = "disabled";
 			};
@@ -306,7 +315,7 @@ ospi2: spi@1 {
 				resets = <&scmi_reset RST_SCMI_OSPI2>,
 					 <&scmi_reset RST_SCMI_OSPI2DLL>;
 				access-controllers = <&rifsc 75>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				st,syscfg-dlyb = <&syscfg 0x1400>;
 				status = "disabled";
 			};
@@ -330,7 +339,7 @@ timers2: timer@40000000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 1>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -361,7 +370,7 @@ timers3: timer@40010000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 2>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -392,7 +401,7 @@ timers4: timer@40020000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 3>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -423,7 +432,7 @@ timers5: timer@40030000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 4>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -454,7 +463,7 @@ timers6: timer@40040000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 5>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -479,7 +488,7 @@ timers7: timer@40050000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 6>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -504,7 +513,7 @@ timers12: timer@40060000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 10>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -535,7 +544,7 @@ timers13: timer@40070000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 11>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -566,7 +575,7 @@ timers14: timer@40080000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 12>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -686,7 +695,7 @@ spi2: spi@400b0000 {
 				       <&hpdma 52 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 23>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -717,7 +726,7 @@ spi3: spi@400c0000 {
 				       <&hpdma 54 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 24>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -744,6 +753,7 @@ usart2: serial@400e0000 {
 				       <&hpdma 12 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 32>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -756,6 +766,7 @@ usart3: serial@400f0000 {
 				       <&hpdma 14 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 33>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -768,6 +779,7 @@ uart4: serial@40100000 {
 				       <&hpdma 16 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 34>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -780,6 +792,7 @@ uart5: serial@40110000 {
 				       <&hpdma 18 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 35>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -796,7 +809,7 @@ i2c1: i2c@40120000 {
 				       <&hpdma 28 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 41>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -815,7 +828,7 @@ i2c2: i2c@40130000 {
 				       <&hpdma 31 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 42>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -834,7 +847,7 @@ i2c3: i2c@40140000 {
 				       <&hpdma 34 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 43>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -853,7 +866,7 @@ i2c4: i2c@40150000 {
 				       <&hpdma 37 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 44>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -872,7 +885,7 @@ i2c5: i2c@40160000 {
 				       <&hpdma 40 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 45>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -891,7 +904,7 @@ i2c6: i2c@40170000 {
 				       <&hpdma 43 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 46>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -910,7 +923,7 @@ i2c7: i2c@40180000 {
 				       <&hpdma 46 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 47>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -926,7 +939,7 @@ timers10: timer@401c0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 8>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -957,7 +970,7 @@ timers11: timer@401d0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 9>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -991,7 +1004,7 @@ timers1: timer@40200000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 0>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -1025,7 +1038,7 @@ timers8: timer@40210000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 7>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -1055,6 +1068,7 @@ usart6: serial@40220000 {
 				       <&hpdma 20 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 36>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1085,7 +1099,7 @@ spi1: spi@40230000 {
 				       <&hpdma 50 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 22>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1101,7 +1115,7 @@ spi4: spi@40240000 {
 				       <&hpdma 56 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 25>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1115,7 +1129,7 @@ timers15: timer@40250000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 13>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -1146,7 +1160,7 @@ timers16: timer@40260000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 14>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -1177,7 +1191,7 @@ timers17: timer@40270000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 15>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -1210,7 +1224,7 @@ spi5: spi@40280000 {
 				       <&hpdma 58 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 26>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1325,6 +1339,7 @@ uart9: serial@402c0000 {
 				       <&hpdma 26 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 39>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1341,7 +1356,7 @@ timers20: timer@40320000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 16>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				counter {
@@ -1371,6 +1386,7 @@ usart1: serial@40330000 {
 				       <&hpdma 10 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 31>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1420,7 +1436,7 @@ spi6: spi@40350000 {
 				       <&hpdma 60 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 27>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1436,7 +1452,7 @@ spi7: spi@40360000 {
 				       <&hpdma 62 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 28>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1449,6 +1465,7 @@ uart7: serial@40370000 {
 				       <&hpdma 22 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 37>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1461,6 +1478,7 @@ uart8: serial@40380000 {
 				       <&hpdma 24 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 38>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1474,7 +1492,7 @@ dcmi: dcmi@404a0000 {
 				dmas = <&hpdma 137 0x60 0x00003012>;
 				dma-names = "tx";
 				access-controllers = <&rifsc 88>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1500,7 +1518,7 @@ spi8: spi@46020000 {
 				       <&hpdma 172 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 29>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1517,7 +1535,7 @@ i2c8: i2c@46040000 {
 				       <&hpdma 169 0x20 0x3021>;
 				dma-names = "rx", "tx";
 				access-controllers = <&rifsc 48>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				i2c-analog-filter;
 				wakeup-source;
 				status = "disabled";
@@ -1649,7 +1667,7 @@ csi: csi@48020000 {
 					 <&rcc CK_KER_CSIPHY>;
 				clock-names = "pclk", "txesc", "csi2phy";
 				access-controllers = <&rifsc 86>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1661,7 +1679,7 @@ dcmipp: dcmipp@48030000 {
 				clocks = <&rcc CK_BUS_DCMIPP>, <&rcc CK_KER_CSI>;
 				clock-names = "kclk", "mclk";
 				access-controllers = <&rifsc 87>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1674,7 +1692,7 @@ combophy: phy@480c0000 {
 				resets = <&rcc USB3PCIEPHY_R>;
 				reset-names = "phy";
 				access-controllers = <&rifsc 67>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				wakeup-source;
 				interrupts-extended = <&exti1 45 IRQ_TYPE_EDGE_FALLING>;
 				status = "disabled";
@@ -1692,7 +1710,7 @@ sdmmc1: mmc@48220000 {
 				cap-mmc-highspeed;
 				max-frequency = <120000000>;
 				access-controllers = <&rifsc 76>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1708,7 +1726,7 @@ sdmmc2: mmc@48230000 {
 				cap-mmc-highspeed;
 				max-frequency = <166000000>;
 				access-controllers = <&rifsc 77>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1724,6 +1742,7 @@ sdmmc3: mmc@48240000 {
 				cap-mmc-highspeed;
 				max-frequency = <166000000>;
 				access-controllers = <&rifsc 78>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1753,6 +1772,7 @@ ethernet1: ethernet@482c0000 {
 				snps,tso;
 				st,syscon = <&syscfg 0x3000>;
 				access-controllers = <&rifsc 60>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				mtl_rx_setup_1: rx-queues-config {
@@ -1784,6 +1804,7 @@ usbh_ohci: usb@482e0000 {
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb2_phy1>;
 				phy-names = "usb";
+				power-domains = <&d1_pd>;
 				resets = <&rcc USBH_R>;
 				status = "disabled";
 			};
@@ -1797,6 +1818,7 @@ usbh_ehci: usb@482f0000 {
 				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usb2_phy1>;
 				phy-names = "usb";
+				power-domains = <&d1_pd>;
 				resets = <&rcc USBH_R>;
 				status = "disabled";
 			};
@@ -1828,7 +1850,7 @@ pcie_ep: pcie-ep@48400000 {
 				resets = <&rcc PCIE_R>;
 				phys = <&combophy PHY_TYPE_PCIE>;
 				access-controllers = <&rifsc 68>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 			};
 
@@ -1854,7 +1876,7 @@ pcie_rc: pcie@48400000 {
 				resets = <&rcc PCIE_R>;
 				msi-parent = <&v2m0>;
 				access-controllers = <&rifsc 68>;
-				power-domains = <&CLUSTER_PD>;
+				power-domains = <&d1_pd>;
 				status = "disabled";
 
 				pcie@0,0 {
diff --git a/arch/arm64/boot/dts/st/stm32mp253.dtsi b/arch/arm64/boot/dts/st/stm32mp253.dtsi
index 19b3e55a4414..8562f13e5284 100644
--- a/arch/arm64/boot/dts/st/stm32mp253.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp253.dtsi
@@ -56,7 +56,7 @@ m_can1: can@402d0000 {
 		resets = <&rcc FDCAN_R>;
 		bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
 		access-controllers = <&rifsc 56>;
-		power-domains = <&CLUSTER_PD>;
+		power-domains = <&d1_pd>;
 		status = "disabled";
 	};
 
@@ -86,6 +86,7 @@ ethernet2: ethernet@482d0000 {
 		snps,tso;
 		st,syscon = <&syscfg 0x3400>;
 		access-controllers = <&rifsc 61>;
+		power-domains = <&d1_pd>;
 		status = "disabled";
 
 		mtl_rx_setup_2: rx-queues-config {
diff --git a/arch/arm64/boot/dts/st/stm32mp255.dtsi b/arch/arm64/boot/dts/st/stm32mp255.dtsi
index 7a598f53a2a0..003024eb2fc7 100644
--- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
@@ -20,7 +20,7 @@ lvds: lvds@48060000 {
 		clock-names = "pclk", "ref";
 		resets = <&rcc LVDS_R>;
 		access-controllers = <&rifsc 84>;
-		power-domains = <&CLUSTER_PD>;
+		power-domains = <&d1_pd>;
 		status = "disabled";
 	};
 
-- 
2.43.0

