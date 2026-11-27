Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803622;
	b=KbkMT/r461m9TUcIDaGxnFFZZNlT3tDxbrUVSfNbnoKOBq461AdP2riIY03HNpOZkXTu
	 VqFtaRyakuV3ivyhIF1X/zkqvf1HZE9XLZ61wm/44lbSD4rIsnNdAQp0vOWJaJBLMQmXF
	 RGiSXilMaGHNNAmWTJtODv9I0Hx1OcWmFM5BI/mwodVcBA3jWWs5kccXOVeEfPjODp52T
	 WB56PtywA5NQJGAV8a0nwHXsCzOj4s1LF/TtkNQlYpFULtCNsgv9/o5WS637MbCxzYiYc
	 2Dq3JvvoxYDMvhi7nAXe7Wzf/Xd1TjEXmIKz06mDjwB8m4TSImKrRbe7ScwNahaqGlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803622;
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
	bh=TJ8IHwncpD3NzJasE+URR793RNUGLCXM7olPq8fhfX4=;
	b=uK0vj+Yhtz41mBVd4+8PQNGbin42ff2cB6NTk2jB7h64oezuHG1Ke881gx1+M3MEDQtj
	 bCOzPiCZ3fhJXjnQhFNlsb/3OdZumgtC/bay7iwPUCCPtatdjtALiY0Q6mvQzQ/ECUduq
	 xGk1NuL3T85opqZpr23+R4+W8pkTLZTlS6Bz5tQ+eZdjpettU4O+sWgS/vX/95avHJstu
	 MYj+NnOAukVlkneLDAv4meqMpydKJAyJ1HmxijC66yfdQ6WE4UNF2+d1KunsUGjauk7It
	 zHwFV5HrEY+TOJniGz4lDDfdWLdQF7RV7lxOhNVXMp1u6VfmL6ML1nhsE/gCd6xGo1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NUKsTz+k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.17
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EC3606A32E;
	Fri, 27 Nov 2026 18:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39EC3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NUKsTz+k
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEyCMrj6SxM8+BVzMwM12G+RGpEPPep0gc6O4krgLJwaPR0bEqkEHGpHWHh3SZhOc4LXwhtLfZxNnKT976ArRhlcS811K7YhFk13bSXZlV4peYPkPWm2uAmLdP4cYjPjLzVqSScALlDC2bI5vvaS80HnZV8fQy3w5fS9SC1vbWgnUIZyuGyjrfSyQY5VRfgA25+phW1UOYDSP7kkGxoJhMbenSDY+NtxeqjcwnOB6ZPS2QY5b4dVqYHXcbECqF/0Sm4Ftv6nAcbRiy73lPpkBCR4G1uJaHO01v8m4HG2TgU3aAQm8Vp/1C5/9WhIYfNWH5BcVSjlxhpiGB764sAx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ8IHwncpD3NzJasE+URR793RNUGLCXM7olPq8fhfX4=;
 b=QSkgpbb3q1m+EljvO7/MctMgnQNDNFdRS9p+0zAaB7hBw/0kQ5KwZIviCGcnfQVv6GRPvdrxJbOhHaCqyn8fEMs8KVXk6lQV46qbGjFPalrLuR2lNze3ZowbpyUDWG7ti3YkS5fkZu49inr/u/gmQIeiZRH5cN0MppWiFgPy+5B56GZ+sBCqRP+qEXSJSMczwPe6c3xYOyOtnSyO2urZ1zOvnNuhaTF/claqM0/AlbZeArYLPtcFcbcJZl0SM3R/QhqgaZpHuxlotQDr2QOS4oOc+LLrXM+H0CtWfuptY9Sjh7RDSjSQ8U6KUl1QnNMtLiSBq4WvY+1AbkPXt8Vl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ8IHwncpD3NzJasE+URR793RNUGLCXM7olPq8fhfX4=;
 b=NUKsTz+kgOXz7Qnqc8Lv24me0wX9bukz/Q+BqfhMKa3InvIRHvcvcKsfq4igPTHw72vhOC/0U+cS0L3anbdzCEVqQ1UWTli+UIMAu/B0nzkMjeDblKE/NA2DGz6HkgeognhDCfPrq1BCi+yoE5PIQ1dNJSsPg/l8vt0ulkVISPphE99dbwVbGmrNTuFfJJX6gqsI+H0106mDcmSBjDdobMKTerazO4bAzgJ0i10DOFia3Wq2bf3FP2fYgvFLRt0KlmWJkCAiwZeOSwTRuOHkbjqfKm8ANO6MFfPjobcD0vaQwMEsnPnLJ+DvIa7on7pUjyieb9m/v3xTfb9p0Um6dw==
Received: from PA7P264CA0267.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::18)
 by GV1PR10MB8495.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 18:20:14 +0000
Received: from AM7PEPF00000052.EURPRD83.prod.outlook.com
 (2603:10a6:102:375:cafe::1) by PA7P264CA0267.outlook.office365.com
 (2603:10a6:102:375::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 18:20:14 +0000
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
 2026 19:21:02 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 27 Nov
 2026 19:20:11 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 5/7] arm64: dts: st: fix power-domain labels DT coding style in STM32MP25
Date: Fri, 27 Nov 2026 19:18:29 +0100
Message-ID: <20261127191823.v2.5.I7e77e53b955d7d0f13e898bca1d395584cb6e2d6@changeid>
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
X-MS-TrafficTypeDiagnostic: AM7PEPF00000052:EE_|GV1PR10MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4f3f5f-3970-4a9b-0c8c-08df4cb314bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|261021123027099003|261026121527099003|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|261009223027099003|18002099003|22082099003|44046007;
X-Microsoft-Antispam-Message-Info:
	jqNHd59Et2E9QgaCmYpWuprrshsPV+EAEL5aF9fLW5qiqlgByZJfb8/zpvRrXvF+Seq8kGd2G3DDIoQ8R54cIR3hJN3SsKFJR0bB/x6lwhlOi/LuWxvaey+YVg345Ovr957AxQfszOyKmRFmtH4LAikbb658bsknITb/qdGdfha5z2SHfIhnMoGRB8EApgnubIHEIvumdbqF3gRxlTq/l2qs0FWBQ+GnAQTRuTvV5cQANyZKnS0L3hcTaQMkybQllYXTiOSiqY83Bk4MF6PxeLiLJrZGBsF/wkEIYmK8NlwW/Kwrpq5iHPXRxPL4YFRHAn+yqCz4ooKl+qzSuDqBjiwL5++GhoWkwUONqMV+wHrjMddfsbv0uCGEFRyFlhqvqsw65md8A+CUZWF845mkr0z76/e7YPaETx8Ewe2f+eo/tjhiBe50zynJ+rV5JhaCLGIKsiNxlYIzgMLy7WOs2zB29I1hHuEGdL0o0pkM86fiKyTH7EixX5l5sHaduxOsCkhKY8FhOZXcmqddQUiwKzPNmpKJHgwrEzFv+247cdAy6pdVFEZlYaue3GoeKDhAlDgxqS4YghB5WCQRDFmTuMziL2YUkwawmLTYeNnmFzkYz2d5+orgaJpK/AC63viuGrA1Pepe9x35eq0qJMFb9mZlea/GS/hlrzhZukVRpHVf2dlDjYqGpS4Dc+zwjWSVapiaEuUyZ7kvZnd92LP2uhL+8Ai+WatC9IhYs8G26bfaeYYiEUnhkt9iNCCw54Mk
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(261021123027099003)(261026121527099003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(261009223027099003)(18002099003)(22082099003)(44046007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QUfZuPHt6Ne0DlD7eDYpsQTQ+aRNakEEcu4jOm0stFuf+BBcKL2zuDHh1v/4jdx9o1fkTlAuY7L3SS+teVjhdnQAI7dM/S2bpUyv4HB9Mdk1slurr0HwpjChc/2Em5+C2J2R2n075wgpZxm+YpYslLvbSITBJqLYOaPTeyOWcsrXuJD1UQTX3UTF+7iSa+v4/IAZgqZRvUmE/yHDZj7sOfuAND8E3NWlJbv7LimVlalDIHiJTQWCOSlqbehoOZcfyjy0/mfKMX6EKHpunrasvKVr12rG/Gcxx+6pLXMaOqnJBQzEaBeav0fZK9MgpTjLs4gMWfsBoVfAxdgd4coh2NBbYg6ky43OQ9R7ELmsgBIgHhh6saKvIR88LFd+eZZWbf0e7ywnBxulZivAuS/xjyCmrYNUVHOuLd7tYOOEOLt6Rl5McF2yPuDVUvzxbdbe
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:20:13.9882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4f3f5f-3970-4a9b-0c8c-08df4cb314bd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8495

Update STM32MP25 power domain labels to comply with the Device Tree
coding style requirement that labels use only lowercase letters,
digits and underscore.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

(no changes since v1)

 arch/arm64/boot/dts/st/stm32mp251.dtsi | 24 ++++++++++++------------
 arch/arm64/boot/dts/st/stm32mp253.dtsi |  6 +++---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 49bc5ca9cf71..b5869313f2cd 100644
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
 	d1_pd: power-controller {
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

