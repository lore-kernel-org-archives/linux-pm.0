Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011063.outbound.protection.outlook.com [52.101.125.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197A4FE2E9;
	Fri, 18 Sep 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744177; cv=fail; b=cSKfjLG09uTYhSh5oDqwdO5DLh7hVZjg5RjNrCF8mqXs65t/33dmm2CU3HaHGD+qP+OuT4gXNEgiDPN9m5Vp08UDqdl4s8WF+JKPxUzFsyoICOcuHJoEkjIgz2Uq9+XB5+KHRfVLRMHhqWQ7fk+oP5g3mvnR6uMV8hjYuOGEGL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744177; c=relaxed/simple;
	bh=5Jjj3sbJh4Jk33awVZDWXsKHtzMW/qrgUFbmmZemaiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8IkNjsVNEajhtPk0P/THvXP6L/rejCXEi51g5ktBf3qLV9zC7wfY9MbnVK7QLCNLcrclGwvKceK1t458u4RGKuEc8k1KyJxFinGvOdVMglfMFzXOu//rYzIVJ4Enz+vUY3vGnwNX3hjSMuoEnH9rAE8tHu6BRRREZtcRmjSeLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=likXwUyf; arc=fail smtp.client-ip=52.101.125.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="likXwUyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+xv5QkCaUBFA4L8u6W8yt51vAXaM1zNrcgyDRgUM/MAKDn4YFLymAP2YtqgA8g9ONErkygJum2x3ht+3n6OOPf0WVvwfpm6c8kgKuivIfqOWM1KkmF26CdjpQotxjQ2x0oEZeXecIFOddW37F/eD2qAwcV7HlpdrydB2uZEaVD9GjQqkC379/A0+X6/kR4tkoKqrt29lxumn1TG1ZusjdPPI9CDQirLRnepCq5j3oYPg5bHT9fekWUrLdl2qHBjHJnBvBHd/MwVp8cJBCrOB3SyWfGYzCQ8eqtwpo0ScUMvuP7bLnD04jpzc+KPJ74Zhx6RaYzW2/+qbn5A/wTi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7wFkZvnOGhhIZaHIJE4cHRGPZm/8mneBjnYMu4H3yE=;
 b=hAz/EpQLK0624+ztQoWAfVV/bvtHAAiRXSIhhWJGVBibOvh/dONw/aCpAS1r/o2WSN7fnGoVFKL++cjU71mqbgUPdfq4gByUJ3DN6NvwrcOstuhCA2DefOR9l2sy+bjbIG/Q929G2RH/cRcO9GkfcHvoRcCGoU/fmhIHJp7i1AuvH25V7jkKX9T3KjqBNX5PbDsNvAYWaTzXXXBgSmaiWar+HlpiisnRHHT8ZUhN6rwuNufI4rtaTEIqLdvg562/eUA6wjgRQau8LzBRFCNQdzRy5YnBLcGP6a18po4PVpDkXORGhm/9vgyzZRCKRLGuwqAT0HfKBEFMdZFo8cs4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7wFkZvnOGhhIZaHIJE4cHRGPZm/8mneBjnYMu4H3yE=;
 b=likXwUyfcDY7rBPP/mQhzrXq3Ci9WmgSMHI9MwRw8OALU/ki1kO5zHA849qlCImO5Mj+6kJT6fQzoJMinOzRPYCk6uMw/qCxZyEht7XdHC0JekJl6MHUTiXdIPwJmNPTFVwdJbZ6I+KhJP60JRxa1M/0Qh1T6MMwphXwTfDOG8w=
Received: from TYCPR01CA0140.jpnprd01.prod.outlook.com (2603:1096:400:2b7::10)
 by OSCPR01MB16364.jpnprd01.prod.outlook.com (2603:1096:604:349::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:09:23 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b7:cafe::73) by TYCPR01CA0140.outlook.office365.com
 (2603:1096:400:2b7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.14 via Frontend Transport; Fri,
 18 Sep 2026 15:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 15:09:23 +0000
Received: from biju-VirtualBox.adwin.renesas.com (BGR-5CG2270RS1.adwin.renesas.com [10.226.92.53])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 91FFF30007D2;
	Sat, 19 Sep 2026 00:09:15 +0900 (JST)
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
Subject: [PATCH v2 8/8] arm64: dts: renesas: r9a08g046: Enable TSU
Date: Fri, 18 Sep 2026 16:07:25 +0100
Message-ID: <20260918150730.122056-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|OSCPR01MB16364:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 264d37e5-b2f0-4596-3ba7-08df1596d2b2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QbXiHjO4iQgj5qKKq1bZ7E31Pzs7jb83XWwXymlUkDiQvhWeQIrWJJ8xUq5CO3FxfVkHHNA7DGsSx6LU7cHjfFiVCIsJOiuerdTgUlI4AqyMHSNUTpOp74K3/RdPFtJDMWP70Tn45WlXuYBKi699h+PtzpISRzIhCaoSmwkiT7qIXOTPamrf+g33R+BIFaxe5d8Ck+GYnKYxIIcmkh6DqFpwBOhUzXIjuy6ilbl7StkQ9bKuKYJyhyX44W7Pn6x3JRSEAOs9Y2NSx0bQxZDb47oo96ovKmDMxRragnambRXJVxS4hBl7kKlw2CfUYMaGfojmVAZ3PxSDchbg5HVtx2viqQqGe5kiBPshtuPsjjq2fvk7js6LNgJFYWc9U2wW/0PT7FjVaY53Z6OQsXfGqxr7r6dhZ/sz0RRuNk4G/wvPS0HAQNcoqGyaR3qv8FxscXv0LIO3yL/b0Yp9kfA7q3JxnpzvkzNXDTrSX9JjItQytgaUsD52i73GjyFl6IpJIxhl3OSokddEK31xw2StQCK1CHlEDHWmaLfAnRoYhnIg6WKepTOXDN5G8vdDi70mzFVJ00ItREt+iARI+Ultvpngjx5p3HvAMx6mfJbW+kDnxyvs4n/6M7M5hrJ81LYVWFMU+1znI2P5F9jNTwsz0Xrh+/+Fs5ApZu9x4530Qj6rNZ9tIxwiIp++B77WlE4Tjn9o1t2nD/simXJQxyQEzQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E11MNNV2MDHhsCeiI+C5JAQhM5tJK9qS7koWzYOGrheQhZacLOu3MA6IZajQHj37rdsVEl7g8OPPFidJRA5U2TUczo0nfW68LuqZDY2t9QzRba0FWjs9uRjuGDUcz1O/VbX/Otsjnr44kUbf1gClMczFTqQkb2dxoirW3q4BJ3bRpSGRyYhmKgaAuq8ygY9RbGLVkrB2f5qnMX8IUuewr5ELdmJsVqYmTr2B/4RBhopOhgBG6P3rlWnEpqwfs5TYS+6cER/d1vbx6QJLf4EMso+QYsmMPhn5N+kwJ5+l0O7Ww+YHZR4/zTF9eHOu3dBrdr3CRwSeoSIvJm9xZLVOoX1ilvwPLe1QKzVEiBJtENmtbmGMekfwiVHRBE6SvSnsOhIuX9Pe0o9uidZ7EhRDs4Ybge+OOyTT3oGJviRcpFMZCxHbNkrOK4qzonxnpxsP
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:09:23.3571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d37e5-b2f0-4596-3ba7-08df1596d2b2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16364

Add #cooling-cells to the CPU nodes, and describe the ADC1 (used
exclusively by the TSU) and TSU nodes along with a CPU thermal zone
using passive and critical trip points, with CPU frequency cooling
maps for thermal mitigation.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No Change.
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 53e68b1c3258..29ce1ab2a57f 100644
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
@@ -1570,6 +1605,37 @@ stmmac_axi_setup: stmmac-axi-config {
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

