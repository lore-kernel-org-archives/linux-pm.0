Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010068.outbound.protection.outlook.com [52.101.229.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE344C9579;
	Fri, 21 Aug 2026 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324760; cv=fail; b=JjfCrHS5a9H6FLbf1lk0tc9ob4R0nTWQtegqTiL+7rQUuPSOBzG1sF1a+pGWQPjur93K8bkxtH39fahO6XZDnQoL1EO6w3jciAccUA5y0yLp61HXiNlbQcijE2xylxsUaclrRLAafUQ+KzwPnZcZ3+NSedkriMxd330Q1xF3ofA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324760; c=relaxed/simple;
	bh=qVRYGSmuI0r9x0IkpGeTMasUF99rdKCDFGr2BEnUdGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocM67ywcC3G9DRKqMaW9Fgxh99+aYVit/7N+a0WBm3Y3m7Yz+qcXS3ZEWhZNnWJinNEe2v2J4QYdWs8QIhlW7NN8cKPRHhxl0oMWCL5pftoCTM4XnWeyD+FXxmAemK1yMf5DaJUjlRpbrWcCQnyElR5kihz0gUvAg11dTa4Mqi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dsC6e+FS; arc=fail smtp.client-ip=52.101.229.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dsC6e+FS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9riHbshOhsslXxkhvjJ7hgdIlJbgozkdlv3qVEx5Z+bcLT/qo8ds1fngewdibY+4xa/dt6YFsS1gvS0fDKBfZquv/vGwatp5IGSeVVS+60N+yPUGAlGqkqXXSTOJtYr2JDiozkDX66pqk/hwdzo9tO0vVrbI+3xA9cXj6jngj2GEl5aY3X9CUCTaOl5Qt+g6RFuDyKYSrlwb0x8ljL+zYojJbhY/JOv6GWZKo4U1bcXUIYYdnHEYZ7p43uFWy77Kz4XqyuXX9UQa6kg4FlfNei8chnp3gXJoimFXCFXB2xMrsH8qYmGfosDnS5wtydiCT+8Aq3Tz+KgN+lXkivMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J251jhVniTiqeLemuzjBRU7hGmXa3k9wQTIsEFIJuaM=;
 b=dYmqTAVU9mAbZJa66waQRnC7dwzbVrS7lNcrETALO+ZD/t2apTuQcTRsprtmP63lHWZe7sEvq4dIG5drEmKFsGkzQTzMfvH9HDzGgLvLCav+DpXFEyQ/t89vHLwWyRG+OaXaAaetUCCeNYvRCq6z0YPFy/z5hd0+1aTLpSiK513mkOt07evPKIu8Sh9UBXGmzRBsAVNnFCxbTbc28C5DPwBQkJeZ0fWtO9xFSCUoDsveaj2sf0OB4hxos9Rc4YAE3r2pdOGWELrthX8EMCTER1n4qP16/v8jRKpwyJWFs4mHkZjdzmltqf4q3QVL8qEme1E0qbExBlsAF1xNJY8R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J251jhVniTiqeLemuzjBRU7hGmXa3k9wQTIsEFIJuaM=;
 b=dsC6e+FSAAMkiLMbC0D8K8sz46kKHHhq09jEUGtLqxNmyjQfmgGmOjnm408LNfJ/Bi9gOtiuz/x/AFGJ0aVCcnSwwGM64n3eC0BEORDa6RaCYBFlGfZ7ThjQza2Q3cs4DtgrAlnRb2LVDlg53jKlCT4Hd/CiuYyCb+LW0rKnm/Y=
Received: from TY6P286CA0016.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b9::13)
 by TY4PR01MB14074.jpnprd01.prod.outlook.com (2603:1096:405:20a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 15:05:51 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9:cafe::48) by TY6P286CA0016.outlook.office365.com
 (2603:1096:405:3b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 15:05:51 +0000
Received: from laptop.adwin.renesas.com (unknown [10.226.37.103])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 672D830002AE;
	Sat, 22 Aug 2026 00:05:46 +0900 (JST)
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
Subject: [PATCH 08/10] arm64: dts: renesas: Add initial SoC DTSI for RZ/G2M v3.0
Date: Fri, 21 Aug 2026 15:03:33 +0000
Message-ID: <20260821150408.73829-9-ayman.chaudhry.kc@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TY4PR01MB14074:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ae17645-b1a6-488f-c05b-08deff95b0e0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|7416014|23010399003|18002099003|22082099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	E90Gjx76s4PheLnJ8Uv7c1PghJPWWntl/JOHwmV5uB01UffrpTN1Wv7zr9w8araLSVq9+l25A/DFHG2ixRrjr1lRmI1D57v/3s8xhMhh4sUPBrHAKkQM05cVQwwFo7wFU3bvDYLcTdA68ZJEJTByDnGNNYdG6pM8TzHKkc/LvFR5qGCu5caZbbNTrSnKasd51iuS6qIn/0IoQTRWJPK0oa3EKSlq5D9PvuKNvzub74nwMGGAjXw9BPSWND+e+S4ievZgByU9yMWUo+vRYLITd5REeg1g+gkRcHiLQAmzMvdG4NTBTwnD/RBXU88U0WTSJKEKnKxZll51jO7JlrvhQ6vKeYVQpeRLfrVJPfPmwilxaKTiRw3bih64v8EGoc4HQJ2blsjjcW9tUQw/ARwRpFlqd8QoQnLLDng9uA4hqO9YoI2E5PwVGotI03WBxqcVDlDg9VMzXGPIa7bLOgZ23l1gl3nUsjF0y+t6NUA4tgoiPGhsKPXKQ4eJZLyYGqf3yvldLiL++IU95PDwVJIHYKk1gEYP/AHrZwGZ+6JOYECqZ5H8LUSpBoKsrGI+E61BmlZNY7BOdP/HesckYCcFdopxe2nhgJeqSn5ZV2OZNrsiDCF3MEzqPJ9AUOp61gKCqvoB/U5t8ck8hOPefVND+U3CDllfw2KVzhWcFHYtjKgHAhMml1cJeC3DQYcyRnDW
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+U8qQKj2p3eZx3NVMXSnY/oy+isKIfIdtnJxUTekt4ElXoIINoXHL+AMFYPlU8ifjapKs64GXaPD6RwRQMEbjcY9XJNA3lUi4KZPLgKVHNhFmD3iTXgPP2hvQTkKgVM1GaARmBwh+GxkRoZPIdTBdZcUgzL+qCU6V7obpymXrbiCQcj7ya5vmNngWbSjIS2TpS2GqL5ZOUorU10mSa3kr9cGCVBNlmwAeqTqDOCZY8hEhrkPeRExeadCJ+SW4aPUNdWAxtUAcflM0mmKJIs5zGqj9xZN98QbTDLpnvra6jRmAsDZYloiSYi1/T7EJxJPom/0DwcKAYtsEUBxHN2a703oUUAUPvfFHBiX2Js80KrG3i2gD+vMfuZU47/TvSGUMO8xe22F/xytX2XB2xtk+QXocto+5emeXJHxySO/W6fgMcQgg5ypXV87kL+dHipQ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:05:51.5416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae17645-b1a6-488f-c05b-08deff95b0e0
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14074

Add initial Device Tree Source Include (DTSI) file for the Renesas
RZ/G2M v3.0 (a.k.a. R8A774A3) SoC with basic support.

Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a3.dtsi | 302 ++++++++++++++++++++++
 1 file changed, 302 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a3.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r8a774a3.dtsi b/arch/arm64/boot/dts/renesas/r8a774a3.dtsi
new file mode 100644
index 000000000000..f60a31612b39
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774a3.dtsi
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the r8a774a3 SoC
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r8a774a3-cpg-mssr.h>
+#include <dt-bindings/power/r8a774a3-sysc.h>
+
+/ {
+	compatible = "renesas,r8a774a3";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+	};
+
+	cluster1_opp: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&a57_0>;
+				};
+				core1 {
+					cpu = <&a57_1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&a53_0>;
+				};
+				core1 {
+					cpu = <&a53_1>;
+				};
+				core2 {
+					cpu = <&a53_2>;
+				};
+				core3 {
+					cpu = <&a53_3>;
+				};
+			};
+		};
+
+		a57_0: cpu@0 {
+			compatible = "arm,cortex-a57";
+			reg = <0x0>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A774A3_PD_CA57_CPU0>;
+			next-level-cache = <&L2_CA57>;
+			enable-method = "psci";
+			dynamic-power-coefficient = <854>;
+			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
+		};
+
+		a57_1: cpu@1 {
+			compatible = "arm,cortex-a57";
+			reg = <0x1>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A774A3_PD_CA57_CPU1>;
+			next-level-cache = <&L2_CA57>;
+			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
+		};
+
+		a53_0: cpu@100 {
+			compatible = "arm,cortex-a53";
+			reg = <0x100>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A774A3_PD_CA53_CPU0>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			dynamic-power-coefficient = <277>;
+			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <560>;
+		};
+
+		a53_1: cpu@101 {
+			compatible = "arm,cortex-a53";
+			reg = <0x101>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A774A3_PD_CA53_CPU1>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <560>;
+		};
+
+		a53_2: cpu@102 {
+			compatible = "arm,cortex-a53";
+			reg = <0x102>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A774A3_PD_CA53_CPU2>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <560>;
+		};
+
+		a53_3: cpu@103 {
+			compatible = "arm,cortex-a53";
+			reg = <0x103>;
+			device_type = "cpu";
+			power-domains = <&sysc R8A774A3_PD_CA53_CPU3>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks = <&cpg CPG_CORE R8A774A3_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <560>;
+		};
+
+		L2_CA57: cache-controller-0 {
+			compatible = "cache";
+			power-domains = <&sysc R8A774A3_PD_CA57_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		L2_CA53: cache-controller-1 {
+			compatible = "cache";
+			power-domains = <&sysc R8A774A3_PD_CA53_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+		bootph-all;
+	};
+
+	extalr_clk: extalr {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+		bootph-all;
+	};
+
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a53_0>, <&a53_1>, <&a53_2>, <&a53_3>;
+	};
+
+	pmu_a57 {
+		compatible = "arm,cortex-a57-pmu";
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+			    <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a57_0>, <&a57_1>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		bootph-all;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cpg: clock-controller@e6150000 {
+			compatible = "renesas,r8a774a3-cpg-mssr";
+			reg = <0 0xe6150000 0 0x0bb0>;
+			clocks = <&extal_clk>, <&extalr_clk>;
+			clock-names = "extal", "extalr";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+			bootph-all;
+		};
+
+		rst: reset-controller@e6160000 {
+			compatible = "renesas,r8a774a3-rst";
+			reg = <0 0xe6160000 0 0x018c>;
+			bootph-all;
+		};
+
+		sysc: system-controller@e6180000 {
+			compatible = "renesas,r8a774a3-sysc";
+			reg = <0 0xe6180000 0 0x0400>;
+			#power-domain-cells = <1>;
+		};
+
+		scif2: serial@e6e88000 {
+			compatible = "renesas,scif-r8a774a3",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e88000 0 0x40>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 310>,
+				 <&cpg CPG_CORE R8A774A3_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc R8A774A3_PD_ALWAYS_ON>;
+			resets = <&cpg 310>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@f1010000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xf1010000 0 0x1000>,
+			      <0x0 0xf1020000 0 0x20000>,
+			      <0x0 0xf1040000 0 0x20000>,
+			      <0x0 0xf1060000 0 0x20000>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A774A3_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
+		};
+
+		prr: chipid@fff00044 {
+			compatible = "renesas,prr";
+			reg = <0 0xfff00044 0 4>;
+			bootph-all;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys";
+	};
+};
-- 
2.34.1

