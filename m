Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051003ED3D8;
	Tue, 22 Sep 2026 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051320; cv=fail; b=X28nsoY+JgQ/jrmprBHGcJWhiQIG78g4C2pltEqCbSG9Rrgvpv2BYvwm0WNWiO7dfZNyCfuAb/etlVYU5HrbiyuBr4b7Err76xt/IArJQCabfW25ZI7VyXa/8XkntbVUmMLG+Aky5+46cKIVY/f/aeiq/OjkfhWU7m9t7YHWZEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051320; c=relaxed/simple;
	bh=+n58LnchrGYvW0dcTwlaT4JGYCOnUzrXjAHFREZ5LfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NO7Nmw3+XmIRAvVKMXzKRw/TqMhGzqAIWGCoFI3ibKUPOOnQrKSQ/W4IW/upCrxZWUvuN+X2JcNnLkiYcBaXlFp0dQ+neXJpa06/mU9fvrg24DnLTghOyN3UGL4RWFlYCEThpTcbeMvTInyfeREkflOW6/D9RNN52IoNVwQS0Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iOhQWtad; arc=fail smtp.client-ip=40.107.74.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iOhQWtad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3yoTVLSnQ+8w9U6TAYThCe5YzIgwaP2gpYYqDU5QVXsCUD2qSUM14AmYgQsQWF6ueq4Mg97u94YpVpzC+SQdg6sN4aII2cQ3gL0ALq80UuAqlcaee1s+rhDoSG/zDyNrb+WEeCIjI+jY5rm/IQlGlYN/9izk+DBuWMsY2UheTIEUt1JXM4GPlRRtitUz0KBV6YG4EkoqlXLbBH4kF0HPLxoA+5m6g3iGxnDFEglX5cnvkOubbODFhIQMgreMFSmcX1sjO8PLLzijYdMzzV0tXYBXe0aIfHSJJGeOR2Kt3Fl0zzxmTGrmq/d4Y/osGGcu6elLVUBNZEojbwyI/Hr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Too+ZRngputDjsXJnKUXq2ai1fjEhgHsT+UWpCbCIM=;
 b=tOqZBO4lNjDd5YrHcd6Qv0ZiBIZT6XaNLpIJ0e/LVu5DoPKmdYhrG/A1vP1A0JgESnq9x6/aO+b721Z/B2VFQv1RgKgymjsitkMPZrGUziQiu39WzhavLHp4bIvX5+o/5BWcy7qwsxUz9MFwk+LSCMBNEXTHwVaWouub/M+DL2329fz+2zZEXDaJtrQyH1f7H4pnjN+E46BSggpclb3XsTWA/tVi6VFoGIX88jg1megcdAcfR9EoqySFKnkecYUKwYw5H9suz72lS9o5BbWozj0fbBm+8siZlkvFMsf63VAYWuAJ5WQ64z4Ldw2CrWsVfI42fq7TXfLuljsR4MylsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Too+ZRngputDjsXJnKUXq2ai1fjEhgHsT+UWpCbCIM=;
 b=iOhQWtadYwQFCGc37ev4YEBLMVObm4Wfpb+wP3meM2hLnhfU6esXRUxdZDVAYAeMeDBuxvhO6PiC1xIXa8qSqyXsL1uWevgr/TF8GzbkKxiQrq2yzpmM20DIQoKSAXAGCL/a0SqKJSKZqUSJ9B0iIvPAmuB1Lgk9XG2qaUcmHTo=
Received: from TY4P286CA0040.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2b2::19)
 by OS7PR01MB18350.jpnprd01.prod.outlook.com (2603:1096:604:4c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 04:28:35 +0000
Received: from TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2:cafe::81) by TY4P286CA0040.outlook.office365.com
 (2603:1096:405:2b2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 04:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005621.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 04:28:35 +0000
Received: from biju-VirtualBox.adwin.renesas.com (ree-0065939.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 3769A300028B;
	Tue, 22 Sep 2026 13:28:26 +0900 (JST)
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
Subject: [PATCH v3 8/8] arm64: dts: renesas: r9a08g046: Enable TSU
Date: Tue, 22 Sep 2026 05:27:00 +0100
Message-ID: <20260922042707.116378-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
References: <20260922042707.116378-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005621:EE_|OS7PR01MB18350:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 13953917-491f-4505-d5a8-08df1861f7a1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y6rwRlfliUnPr22Jm0MZSEfzbFNENEQgQ2XYj30WtDZbLeagwng5DxtoIejCKuePuy3p3U11vpkKbB+5she+31KnvrMdzipum5lhG5/jNCVkVfS+c8vb23c3Ccj8ypuHhFrqPapvC4cq3JiZxMGCEwfGTJOjvOFqaUEuLsu1LsWH7oWoDHuJGoQaUFhbXvYkRJhc+gAiOedApu2X60WXCxnSETBlDpxNNBOulu8F7B1XlgTNyFTarr8x111ZxFbv+lP9WwWsbRg6T+ir9h34q/1lJ8w75Emj4EjydLVjOT+NeZzl+26S4OehC8sz2eoJ50yf8WJSFZtlojFW+40q/1VjOnud+C+qT46Qh0IAxjc09gKG6Cu8UYcJe35YJFzdKB81h7J8IS6Gbc6xS96dGM/xemuqWzjsQjdRVw8BoiFw/1YbRn+4pYAuS/ZSe1MOnWTaRgIKihcShnTlLz6dJccbDVQCiTzZzXbZssDNgRsnl10+ZAACgilPl/daP4ZjeAs/xcpsWdy+g0aX1ARXe/S7SADmpzVxUaF3DreBVoIjjTeH0LYyhLM2YJCpEJ+qjheXs4hsofg3ps6GUIODC96VuPVqf0oPcAJogtDl8OnjWTj9cUDI9IRvOR5n612V1ZiclPb5Ht0SJZxTSBtOSS9WM//ezAkzG5B4MnVucZjSWNeCKGvatij93B0ka+MRd+2mWphCMlMUojjcYKDxIg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9qPHzNBqCaY9URFo6DLLM+2ja4l6Rj8dRz7mNQG9cEyRvRNgtLVfUHzQ7jHiCFSdNZe8R5Zj7xZ0Zj6e0Z1o0yCvh22in5NMZxxsPDEGQZETDC2ggyQHG2rL7gEqND95GHMM9BzFUhJ4xKu36sBoRdx4rv6l5Pd1uUunK/eYsgNn6vDoEdnvMt9DKwLXUHzyZudOkmnWTo3eWhC/O+Xm9oT229RDYkkyp8iI118UtCFGHrjMbJgAVTo6r4h/cWq2RK0K91wqE7DuTFqggyr28A4gdvpRP/XnCjylobl2ZHkkrUMMQMMRx9KrarB80cAuGeZDotFqjww/ctsxglSL5/TYNS3hdzAnzJabqWa6Ixt8sI4an+HhPALt5WyaloSvTE5+3V5NSNhusGoN0Y1K2tvbVTi9TCrHoT4zNk77v6eLwGvfnkqHgFVos+6ZBRNp
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 04:28:35.4872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13953917-491f-4505-d5a8-08df1861f7a1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005621.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18350

Add #cooling-cells to the CPU nodes, and describe the ADC1 (used
exclusively by the TSU) and TSU nodes along with a CPU thermal zone
using passive and critical trip points, with CPU frequency cooling
maps for thermal mitigation.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No Change.
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

