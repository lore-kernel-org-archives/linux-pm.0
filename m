Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825683;
	b=bIrQdQncBoDXcTY1M3iLvRJ1AN6GnRASc+5AMeMW3xu5z/m7TqN5sxD8LiSznGm64Tf9
	 7lC4xgKY1IMoaztBJv5m+bcbdhmx39cNhn5PBMo1arKZFnG0TDbIssA0B8cN9wezA2zHm
	 xVGN8vat8gU4gp3pVwVsLauCzCnN/K4f+jleM6w0kMNTcqYNncGe8lflTkyedeBbFy/ja
	 ADj1ullyXjWvxvgICz4qyHf5p+FSdX04RKegAhl3DN43jC1lVWpMYpCPoeNvSoobyWtBf
	 tx4KxA3wxBBMrbYySeOV94Ts0EUm/TEsLdVREUMQnhSMxR6UPmHHg9ZKXjDiKOb+Ygg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825683;
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
	bh=jvswK6w3AIQI+1f1eBo4t/jQYo2CoheT5B9K0xis2KY=;
	b=D4DQedNNte5V9hsfcM0bpbxhhlfLRuDhuaG9OryTMe+V2XZkDo4nc+57Nb+jlwD+Wv4M
	 SpeQ/OZQGfClTFchcGE5HPYFRuYYSITXbtVMdi9uIISt6wJnNufHqILPInksvd5yB1mxv
	 N/7eVJhu4SXgHVBnH9rCTZzHMwYpxkk1jQlTMNLekhs04F8pz5hEqMVXmGALgrbc2/oUa
	 ZN/ApXctApmCyLAYS10AJKsBdT+11KdD8935pih6KnsmX7AZgFwcaOn/kXdVdXHWBjMw6
	 hvNs8o85O0NyTIjCtwipde+snlrWnNopNL3OUWZxZFjjz8/CNnjYa1G9BIpsuh6atPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=P+Dyoq20;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.35
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429E606A33A;
	Mon, 16 Nov 2026 10:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C429E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=P+Dyoq20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTKZOg4tSBFkcCVDBaCLt0CFxTwvhLXDmmqeU7669z8i6Bymoulsrgmr7KYB54mhLzoaJ+T9n7DObGAQb4hdGtADBm00vcn6yz7gv0o8eoPPBO2fviLrjfZlimibiVV46EEFuG6Pni4kqdzL7NQ3iVmEtzj7hmj2ivaVqZOQPna6X5lfpw2Or1Ma7MVWY4NuwKPV+clNYAF1weDY4pRFxeUr/Oy4ueIqWqHRDDh/7Rmw4TzgtNs32dZUYCAiuV0+rviLrGOlNNfJVZWp+JajhsEgfoaF53DdRBche6ccPexUFamLa4MdL/tUERP25Gcqma2MdVnV4IIMdJJZrUY/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvswK6w3AIQI+1f1eBo4t/jQYo2CoheT5B9K0xis2KY=;
 b=KBSZ//1XLlzRem8e3lw3oQ37VyNOHjr2SIuLWOy9k0h3otTgvrGohsacIf1yz9LkQXrUiCUBl79otRA86UYUQtkTLGXzu+54aGOtVJd5eD9asEzE9m9Z1Qkts22L8w6JyLP9PZIKfITWmhkWzncCA2WgGMZxeKl7TW4GjUZ/FSXukkPg9ZgoChxi746B2pqPDFvH48YBgMPUmhKonKJh7OIV3l7r+MMRZd2Ws30ti6FK0YxSCfOeDD/ZMeAncxGiJcbEJVk/Q+fCh0txaSu9AXr/pF56lpyLiFZe/UzKARr2vTKquaDgTLC2krQbTHlRJxhAgn2uieyYJPAZCH61Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvswK6w3AIQI+1f1eBo4t/jQYo2CoheT5B9K0xis2KY=;
 b=P+Dyoq20Cr7myVQzOG77l+PuviaoarxdSZ1eGHm8K6nBktGAkA94zI9cZQmcMoimVSCD23jkEyp3MNFQP+9pxpcm2x88r70D3A/S8KMz2UgH/Y7PFhqnaNEg+YT3ENV+A9xsfqN3+d2Rw2r3Cr7osOkp+vaHjo7umapxyXhhjQ1WnZBGZLI3D/FW/NpYfWONnfYx4M9kp1Ye7IT0u9hjOeRCfPpk+bYwomYq3yhQT0j86sdrB0zEhAw5i382FOJaME9c4v6VQxQqTogPbXs8OLtBM/kw3PhE+2GvDTR+qvBnkKNaJAZy2yzHFd2vp9nyayDS1cV42lsRVKNz1tRbGA==
Received: from DUZPR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::16) by GVXPR10MB9163.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Mon, 16 Nov
 2026 10:41:13 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::3d) by DUZPR01CA0031.outlook.office365.com
 (2603:10a6:10:468::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 10:41:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 10:41:13 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:41:56 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 11:41:12 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH 5/7] arm64: dts: st: fix power-domain labels DT coding style in STM32MP25
Date: Mon, 16 Nov 2026 11:40:30 +0100
Message-ID: <20261116114024.RESEND.5.I7e77e53b955d7d0f13e898bca1d395584cb6e2d6@changeid>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|GVXPR10MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 310552fe-31c4-47c2-7919-08df43ce22af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|7416014|82310400026|261021123027099003|261009223027099003|56012099006|261022105027099003|261026140227099003|11063799006|261021121427099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qNkrzHtw6wtKd605bJqdwl3zwNgka1fuwH7+hwpwjC9cEY4nmRalUhQFsXpMQ3QDIMEcWDC+IX6S7qPQ5YsubqX/E5aNfOilg6FWNs23XpFCQp05V2nPHGgbaFdjjQkAHby0sRl8DZP+GhQ/lJi2GVh+/CCO44MeB83QZrX63O/iiL4KhBeIXzg806Qil13Hii12EHKGOwfubEOF2yYj8Pfhw2LnzWjNmfOI+2Zr7bAWlY/8pIXkZp2MwTbJfMBBWPXiibyd/fbckkPt6S5GlBv3cdA72S5m53FRsNpyR/TwIjp24RU/SvZw96QRVX3jMjfklKaa40uTb3NADxIbZpxkKyXyTRsW5mrWTwpxo5QwX3N5S9r83LiG5YKa/I+fLfsfINcGkltCEwIolmf0B6AfNC16jR8U2VSm6X9H/v76cTjiZCdibttgJt79PQx7UAJpDLpvqy02FlerFyK+LEgUjpVL+dZ8fqRAH441aI0vgxy0CQ/XALwZKLtvhAcHqo9UnkxiuVUxAYBwtBLEPlxLm8sxDEWQA/or1C3vXQi/Dn1XEi6k4qYgrKi5IJ1Fv+UyltHUGlhXDlw+DERqH1RR6MxHNL5vrKPmMEjtXBOqm5F4MsDpp96Qpz/YuyySu/LH7OokwZPH9xGZZ4VJjPZ+AsVqSRXVcs6mCsQGtzNBradFZOgtoetvvSU6uAEaOmUsR2B911sFC2rWHQadcQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(7416014)(82310400026)(261021123027099003)(261009223027099003)(56012099006)(261022105027099003)(261026140227099003)(11063799006)(261021121427099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	whoCqt+IRGnLwNWmHt0SlAcTuANJ6Y6qtW64NX9QoLOnOTQSiDixY5YmhfTUqz+UEHDjK9dHYpv8PFRL1OShejvpxbOFy31VbA7x25oLfZp+Wz2+GdP4tuptS8sBcwthq4tQpwDzByRV/OqS4+dzzeAPPM0y2d5hpe3jbbSZ82PseoIibcxQAzmPi18r8eG8c/tyjluwCaYXVzX2s91dfNh5z7Be79m/o0JIhFK1hmTi+oDweiqIyZHmMm0faeS1FSVqxq6YWbUZNEpEpQ7H38rcLtl2M0uEi/QDc88L5nP5yfKyJu4IyUzCvV0smP8iG7Hy4UxB//Xhikcw4qg3IlvAraAU6duD76R0t1bRAMesg8rSUSTz85mJ3K+cfQhVkI5NJD2fBQIXIndQndQzcA/Od19+EKhTWuLN/jScXhRSv8ZNkdY6heJTve/evRcQ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:41:13.2899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310552fe-31c4-47c2-7919-08df43ce22af
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9163

Update STM32MP25 power domain labels to comply with the Device Tree
coding style requirement that labels use only lowercase letters,
digits and underscore.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm64/boot/dts/st/stm32mp251.dtsi | 24 ++++++++++++------------
 arch/arm64/boot/dts/st/stm32mp253.dtsi |  6 +++---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index d5204d88344f..43b4edfa07fc 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -22,7 +22,7 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD0>;
+			power-domains = <&cpu0_pd>;
 			power-domain-names = "psci";
 		};
 
@@ -155,25 +155,25 @@ v2m0: v2m@48090000 {
 	d1_pd: power-domain-d1 {
 		compatible = "st,stm32mp-pm-domain";
 		#power-domain-cells = <0>;
-		power-domains = <&CLUSTER_PD>;
+		power-domains = <&cluster_pd>;
 	};
 
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		CPU_PD0: power-domain-cpu0 {
+		cpu0_pd: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&cpu_sleep>;
-			power-domains = <&CLUSTER_PD>;
+			power-domains = <&cluster_pd>;
 		};
 
-		CLUSTER_PD: power-domain-cluster {
+		cluster_pd: power-domain-cluster {
 			#power-domain-cells = <0>;
-			power-domains = <&RET_PD>;
+			power-domains = <&ret_pd>;
 		};
 
-		RET_PD: power-domain-retention {
+		ret_pd: power-domain-retention {
 			#power-domain-cells = <0>;
 		};
 	};
@@ -215,7 +215,7 @@ hpdma: dma-controller@40400000 {
 				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA1>;
-			power-domains = <&RET_PD>;
+			power-domains = <&ret_pd>;
 			#dma-cells = <3>;
 		};
 
@@ -239,7 +239,7 @@ hpdma2: dma-controller@40410000 {
 				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA2>;
-			power-domains = <&RET_PD>;
+			power-domains = <&ret_pd>;
 			#dma-cells = <3>;
 		};
 
@@ -263,7 +263,7 @@ hpdma3: dma-controller@40420000 {
 				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&scmi_clk CK_SCMI_HPDMA3>;
-			power-domains = <&RET_PD>;
+			power-domains = <&ret_pd>;
 			#dma-cells = <3>;
 		};
 
@@ -605,7 +605,7 @@ lptimer1: timer@40090000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 17>;
-				power-domains = <&RET_PD>;
+				power-domains = <&ret_pd>;
 				wakeup-source;
 				status = "disabled";
 
@@ -641,7 +641,7 @@ lptimer2: timer@400a0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				access-controllers = <&rifsc 18>;
-				power-domains = <&RET_PD>;
+				power-domains = <&ret_pd>;
 				wakeup-source;
 				status = "disabled";
 
diff --git a/arch/arm64/boot/dts/st/stm32mp253.dtsi b/arch/arm64/boot/dts/st/stm32mp253.dtsi
index 8562f13e5284..7df1031b7e91 100644
--- a/arch/arm64/boot/dts/st/stm32mp253.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp253.dtsi
@@ -12,7 +12,7 @@ cpu1: cpu@1 {
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
-			power-domains = <&CPU_PD1>;
+			power-domains = <&cpu1_pd>;
 			power-domain-names = "psci";
 		};
 	};
@@ -24,10 +24,10 @@ arm-pmu {
 	};
 
 	psci {
-		CPU_PD1: power-domain-cpu1 {
+		cpu1_pd: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&cpu_sleep>;
-			power-domains = <&CLUSTER_PD>;
+			power-domains = <&cluster_pd>;
 		};
 	};
 
-- 
2.43.0

