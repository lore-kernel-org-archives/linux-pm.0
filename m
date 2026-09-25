Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010019.outbound.protection.outlook.com [52.101.228.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B50255F28;
	Fri, 25 Sep 2026 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317062; cv=fail; b=A/CFLLHJ1RFEkJT/kaIOcxOPwn7gpsAUmUj7SxoNVoa4vg3vEBr2guwksFskbDS6+X34ER/FWW3A8ZMtgEnLRLBoU01gc7Xbpj+wUMTqmIK/AYhyJn2gUw0ISyOTFQByzLXbrg/OUSNMlrC5JYKECTElxPhJeeruovKZ6b54aCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317062; c=relaxed/simple;
	bh=GmV5cd2HQUW2jgJtBTPra+9aOOp5uIKcuENgmdysjRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jN9Nd7hinrX6XP2YNaEM3zJGTFepm0NEDh7BSxcMNrGhBiUik2SDPYmM4ESrLQ4NoI5vrAS9oR/96BJNC7ul7nkyhAPiTI/PCfIsmYrWGQWqhyd7YrYR2X1xWmGESklQqSyMy65DtSW277VN6NEmMRgIr2voEU3zKKqqBl5jaOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=lB5iOYRx; arc=fail smtp.client-ip=52.101.228.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="lB5iOYRx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbh2SookufarXOXcICX8AcunIbNwef7udiRPDjA8iIna/iZhfBXvYZd+JefKtwlqmHrNxS4gFjDGj5riz6ml4HGNo+Q47XKFQgsrXuPzWzaI0yn3BR+lDD+Pq6ml37UvM6qgrcSg8X28fpCilkMUFc5ec7WCzEpflzZ3MlFkVsA4ewtY+Oq90dljs+QLZCv0GPI//c9ocdZmCXCS69iXsMCPq+kzJ1HfFhNF0BTlDP9+mbxPiD31RNdcWI2dQxmGEninBcHnq8ES7Zw+aOjaRAF7ysOwHEk0WtQnx4Y4s8LV3UaGUAKUP3JJARF6f0PAbpIxzavVh/WmigQXE9v5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKr7Lq2zOHRojKrrWjg1cMW7PQ6j8IFupu6zxkWi0pE=;
 b=qvKwKe1GR7xgk9xpD3eneiUXZp5IPvIW4IIwBJxJk1wk4pVhumcVRxVo6C+QAeYyGsR7bJIOP58o+qn7a66WgEClXZw4cO7mSppyV99+z1uhiAbPnqlUxqRobg/WsV5jIoDZlnEayU7pIANqms52ioMyyiwfpPGAGA5irNDEOd/KUSHjmlKp090vNCzZR13FyuLMfyMRv0HMzdMdflRoYJ3vAqAg24K+t5NrHxLAAnPkAAN14bqrGOO2j69aIwiMa7fTuXNSs4xRU7SnPnoEtPnZ+6ERSOTyQhRy5YGcFLiQnaci8EXuQ7bUV5xbr0povTMmQrevJwVuB8OOSSJdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKr7Lq2zOHRojKrrWjg1cMW7PQ6j8IFupu6zxkWi0pE=;
 b=lB5iOYRxo5pkAzbmlnzqIgkTH1ECTyEtPxuR709+E5u8DBs89khe3Vdnqo1NzMkkI61HF01Q4KtyhKVdXvng1YP9fwtOqinOj16l0dYnzpJX+H3XlSJWQBl9aV7zAK8B8V2nDfDlh0bRLsXDndz25quEKVPMeSS7oJ84kexK+AY=
Received: from TY4P286CA0083.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:36d::15)
 by OSZPR01MB8671.jpnprd01.prod.outlook.com (2603:1096:604:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 06:17:37 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d:cafe::6c) by TY4P286CA0083.outlook.office365.com
 (2603:1096:405:36d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:17:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 06:17:35 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.177])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 61A6B3000259;
	Fri, 25 Sep 2026 15:17:27 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 7/7] arm64: dts: renesas: r9a08g046: Enable TSU
Date: Fri, 25 Sep 2026 07:16:05 +0100
Message-ID: <20260925061617.127349-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
References: <20260925061617.127349-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|OSZPR01MB8671:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d102fd62-b3f0-460c-ad33-08df1accb14d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|23010399003|376014|36860700016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J/TJqWD2dxS1pf8rXfPE2p0JU3B7Vbs3IPtRVz7AJT4dXT8OqB+6+FcnJgNUgGKP4/bOvRz3dLguPlNA5Gw3Haj4iLO30fU8tSRnuZt1kmgREbFClweWBQirG05XH7x7TB99aKMocLL66qCOXYndCo1pC5KnYu0tYSSLX0lVwmFkbfNus34yc+cpjzsGpOBQKHXBs0MMPTjPa8cLb0G3YILxYT1EddkQIhIMCVijB4hKjuFwNHUtg+r1BtSkHlDQ5fnQQh95c2qzqQJPCJDav2L31UrWb4W3CDwXPZtwiE6G1QyHNbo6oDjiZGL8ucyU6E4wWDCtBiR+tzP8i8tRemxrIwMcveKmJizcrvkAHyNkXk46m8MVc7ctrUbsU5VZPQz2BSxehjK7QQr9BMob+WIi7q3cyIobG8jkOCiitwF5l7cYh9+cAESu2Uu/hyXgwBQJAuJjRJidGyvnI0tUX9OYpPC4HoRTwqTPVOz1kWG0qne9hAzHPVTpI+RkNMXQ7OAtyxQdrNBR3Hm7qCSkOQKuHL2h7s+PEITNRgjw0v0F6VQeQMvz8sILbrQgN3LoKL64pYELg6oA6wIezL2hwLVsMXPfxMP+ChNtahJhp7ig26aQx2HxjEV5oydFngcPpd/kFd/NwzK7kXxPQnFJXYnDS3oxk7nuPkKZzPpn4KV5UZJaoRpwhvMf+SUeCz4mJ9gddERN/0UAplrQ+sDsrw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GuaN/EoKuivB/0+XNdXbEwzOW2fwXX88w3UFptlLVi3C9sIAIvJoprVA8OaxjNbWznsAevau8hxxtOWa7mXjMzditWzZ2Mzz/wHSFkwp0l4midsyOajYqXznGrP/MJEf5AmhHLoxbKnBqAOeSCkcTtJZ6TylQkLHyxdxlItdfzpDNxYRBEot+Cv4bYAy4kurRP8OjPB3AyxupQsi6N9b/F42GzMQjdOZQyRkFPsOJf8Nq3M2wXDJBDhQj2L8qs9r127wO7JQFudu8g7zca0M2bSJMbSw+rqTzHHQIyAkQVGTPcH7Mj67b6R2xEhZwOYrXxGakJbgWKkZ19sBac1emBtsFV5jp01df6MgUQKB/GVrkJuz4Jfs5AOYTXS8nlTf+KNOY7X7jqL9WAcTdGLCzm8JRYb1DqDzTdq59fw4Jj9Epk+PREdFS1eAs41Zqdz8
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:17:35.9711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d102fd62-b3f0-460c-ad33-08df1accb14d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8671

Add #cooling-cells to the CPU nodes, and describe the ADC1 (used
exclusively by the TSU) and TSU nodes along with a CPU thermal zone
using passive and critical trip points, with CPU frequency cooling
maps for thermal mitigation.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No Change.
v2->v3:
 * No Change.
v1->v2:
 * No Change.
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index f33d5d7468ff..35046c7dac54 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -179,6 +179,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A08G046_CLK_IC0>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -189,6 +190,7 @@ cpu1: cpu@100 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A08G046_CLK_IC1>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -199,6 +201,7 @@ cpu2: cpu@200 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A08G046_CLK_IC2>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -209,6 +212,7 @@ cpu3: cpu@300 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A08G046_CLK_IC3>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -374,6 +378,37 @@ scif5: serial@1004e000 {
 			status = "disabled";
 		};
 
+		adc1: adc@108c0000 {
+			compatible = "renesas,r9a08g046-adc1";
+			reg = <0 0x108c0000 0 0x10000>;
+			interrupts = <GIC_SPI 378 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A08G046_ADC1_ADCLK>,
+				 <&cpg CPG_MOD R9A08G046_ADC1_PCLK>;
+			clock-names = "adclk", "pclk";
+			resets = <&cpg R9A08G046_ADC1_PRESETN>,
+				 <&cpg R9A08G046_ADC1_ADRST_N>;
+			reset-names = "presetn", "adrst-n";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			channel@8 {
+				reg = <8>;
+			};
+		};
+
+		tsu: thermal@108d0000 {
+			compatible = "renesas,r9a08g046-tsu";
+			reg = <0 0x108d0000 0 0x10000>;
+			clocks = <&cpg CPG_MOD R9A08G046_TSU_PCLK>;
+			resets = <&cpg R9A08G046_TSU_PRESETN>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+			io-channels = <&adc1 0>;
+			io-channel-names = "tsu";
+		};
+
 		i2c0: i2c@100ae000 {
 			compatible = "renesas,riic-r9a08g046", "renesas,riic-r9a09g057";
 			reg = <0 0x100ae000 0 0x400>;
@@ -1382,6 +1417,37 @@ stmmac_axi_setup: stmmac-axi-config {
 		snps,blen = <16 8 4 0 0 0 0>;
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&tsu>;
+
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&cpu0 0 3>, <&cpu1 0 3>,
+							 <&cpu2 0 3>, <&cpu3 0 3>;
+					contribution = <1024>;
+				};
+			};
+
+			trips {
+				sensor_crit: sensor-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+
+				target: trip-point {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.43.0

