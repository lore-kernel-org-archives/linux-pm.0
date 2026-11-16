Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824295;
	b=JXGwoUQQ9SuMhe7Ay/cLnsyFqvedhlycf77C+XTtWSDoxrhRvjWLU/U1RQN4bb9VCYjz
	 ow0bnaWu5vDaS/8/Eyyc2Aknr9e5OGhWMOiNqPOdgg60XjkLxVu8CVROkaj6TkrmRoLXn
	 BAI/1fZqllja05tiisasUVSnCY5lr7uIiNBYoxj3rKonZ/YtcSk1/x5RiaWfIEoJgkik4
	 p3jKToB2oXPyufWqzhmR8kYJZ+GVHSesO+AhQerA7jNRaaKn8j+LpVB+urkSYCaWiHkWw
	 U8oIA6WEBwnJcjYDuDX7dt4F5oR0as0SVHmOosGr5cqy59ZqX9jSTIBUlS6F2Eou0+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824295;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=5H5dLA5JWxH9jgjQKpPfMMDqBctSlJOb0b9Wsg3hvNk=;
	b=1ibPmRiHlvqRQYITarHZpYJpjtClPl62lfEuBQtVcIQNQgWUf8hA0SPexEILlY25kz0I
	 N8vznilLJ2W4aumE7xLuufi/b26whs4FjCJEN7u87Sa1jab4LY4Uy/H/HgNqh6yOeuaF9
	 MaWNmTdb0OtdFACmVmjUHWTLR97u/UDU+izynKkgrKGOTSo3g3I06nemU5jS2e29YCoXF
	 7hQw/M2f1JdomFo+x1zmtSEZsgxf7QEnddZ4h9t0Qqv7ruL7p6LbSgAkGurs4Z2ZjkGAH
	 13ydgfi0KqyaU+dMGEtj0p1Cddf96SNRu1uS1ZC/RuvhQYUC2hizcMVDf9M8CQZZEnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZUkHukE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0FC606A337;
	Mon, 16 Nov 2026 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZUkHukE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0CB1F000C5;
	Mon, 16 Nov 2026 10:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824295;
	bh=5H5dLA5JWxH9jgjQKpPfMMDqBctSlJOb0b9Wsg3hvNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bZUkHukEH9XMM+EvIgudBeB75lJt6mj4Yii6R40AFOW9IBs5pjf8Crz2l83qa1x96
	 1ltrQtcg89MmYPPN9kDXzzO5v680fev0B10Xhuj2s1yJwm/FtIMDcRSTBTzxoTejSx
	 w73+IvaqXpr8xMYIR06Mcc3iN6Y0awrTy2ENWj4lhzntrfjmyqM5ZzdUFU36sZU1F8
	 f54fZTYgsuOOvYVLAYzYf2ImceS7WMOkZwbVc5eO/RNHukBNWccDl95Hql3HRoZ9tp
	 7k2g7DSDN5QaMPtK+vEK9+RFec17kRsAOO4Mmph4FTQmnLZoimBIWsOTtiL0wvApcr
	 VHb0j9YHsh95Q==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:18:08 +0100
Subject: [PATCH 2/3] ARM: dts: ux500: Add power domains
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ux500-powerdomain-dts-v1-2-e0f4459c3ab1@kernel.org>
References: <20261116-ux500-powerdomain-dts-v1-0-e0f4459c3ab1@kernel.org>
In-Reply-To: <20261116-ux500-powerdomain-dts-v1-0-e0f4459c3ab1@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
 linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Add the actual power domains to the CPUs and SoC peripherals.
Both CPUs share DOMAIN_VARM, which also supplies their PMU.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 71 +++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index 5b2b4527a472..b3b3cec69656 100644
--- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
@@ -54,6 +54,7 @@ CPU0: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x300>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_ARMSS>;
 			clock-names = "cpu";
 			clock-latency = <20000>;
@@ -63,6 +64,7 @@ CPU1: cpu@301 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0x301>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 		};
 	};
 
@@ -154,6 +156,7 @@ sram@40020000 {
 			reg = <0x40020000 0x40000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			power-domains = <&pm_domains DOMAIN_ESRAM_12>;
 			ranges = <0 0x40020000 0x40000>;
 		};
 		sram@40060000 {
@@ -162,6 +165,7 @@ sram@40060000 {
 			reg = <0x40060000 0x40000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			power-domains = <&pm_domains DOMAIN_ESRAM_34>;
 			ranges = <0 0x40060000 0x40000>;
 
 			lcla: sram@20000 {
@@ -181,7 +185,7 @@ lcla: sram@20000 {
 		ptm@801ae000 {
 			compatible = "arm,coresight-etm3x", "arm,primecell";
 			reg = <0x801ae000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU0>;
@@ -197,7 +201,7 @@ ptm0_out_port: endpoint {
 		ptm@801af000 {
 			compatible = "arm,coresight-etm3x", "arm,primecell";
 			reg = <0x801af000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU1>;
@@ -213,7 +217,7 @@ ptm1_out_port: endpoint {
 		funnel@801a6000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x801a6000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			out-ports {
@@ -249,6 +253,7 @@ replicator {
 			compatible = "arm,coresight-static-replicator";
 			clocks = <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "atclk";
+			power-domains = <&pm_domains DOMAIN_VARM>;
 
 			out-ports {
 				#address-cells = <1>;
@@ -280,7 +285,7 @@ replicator_in_port0: endpoint {
 		tpiu@80190000 {
 			compatible = "arm,coresight-tpiu", "arm,primecell";
 			reg = <0x80190000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			in-ports {
@@ -295,7 +300,7 @@ tpiu_in_port: endpoint {
 		etb@801a4000 {
 			compatible = "arm,coresight-etb10", "arm,primecell";
 			reg = <0x801a4000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			in-ports {
@@ -314,11 +319,13 @@ intc: interrupt-controller@a0411000 {
 			interrupt-controller;
 			reg = <0xa0411000 0x1000>,
 			      <0xa0410100 0x100>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 		};
 
 		scu@a0410000 {
 			compatible = "arm,cortex-a9-scu";
 			reg = <0xa0410000 0x100>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 		};
 
 		/*
@@ -326,6 +333,7 @@ scu@a0410000 {
 		 * and various things like spin tables
 		 */
 		backupram@80150000 {
+			/* This memory is in the VSAFE (always on) power domain */
 			compatible = "ste,dbx500-backupram";
 			reg = <0x80150000 0x2000>;
 		};
@@ -334,6 +342,7 @@ L2: cache-controller {
 			compatible = "arm,pl310-cache";
 			reg = <0xa0412000 0x1000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -346,6 +355,18 @@ pmu {
 		pm_domains: power-controller {
 			compatible = "stericsson,ux500-pm-domains";
 			#power-domain-cells = <1>;
+			power-domains = <&pm_domains DOMAIN_VAPE>,
+					<&pm_domains DOMAIN_VAPE>,
+					<&pm_domains DOMAIN_VAPE>,
+					<&pm_domains DOMAIN_VAPE>,
+					<&pm_domains DOMAIN_VAPE>,
+					<&pm_domains DOMAIN_VAPE>;
+			power-domains-child-ids = <DOMAIN_SVA_MMDSP>,
+						 <DOMAIN_SVA_PIPE>,
+						 <DOMAIN_SIA_MMDSP>,
+						 <DOMAIN_SIA_PIPE>,
+						 <DOMAIN_SGA>,
+						 <DOMAIN_B2R2_MCDE>;
 		};
 
 		clocks {
@@ -357,6 +378,7 @@ clocks {
 			reg = <0x8012f000 0x1000>, <0x8011f000 0x1000>,
 			    <0x8000f000 0x1000>, <0xa03ff000 0x1000>,
 			    <0xa03cf000 0x1000>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			prcmu_clk: prcmu-clock {
 				#clock-cells = <1>;
@@ -393,7 +415,7 @@ mtu@a03c6000 {
 			compatible = "st,nomadik-mtu";
 			reg = <0xa03c6000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			clocks = <&prcmu_clk PRCMU_TIMCLK>, <&prcc_pclk 6 6>;
 			clock-names = "timclk", "apb_pclk";
 		};
@@ -402,7 +424,7 @@ timer@a0410600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xa0410600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&smp_twd_clk>;
 		};
 
@@ -410,14 +432,15 @@ watchdog@a0410620 {
 			compatible = "arm,cortex-a9-twd-wdt";
 			reg = <0xa0410620 0x20>;
 			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&smp_twd_clk>;
 		};
 
 		rtc@80154000 {
+			/* This peripheral is in the VSAFE (always on) power domain */
 			compatible = "arm,pl031", "arm,primecell";
 			reg = <0x80154000 0x1000>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-
 			clocks = <&rtc_clk>;
 			clock-names = "apb_pclk";
 		};
@@ -435,6 +458,7 @@ gpio0: gpio@8012e000 {
 			gpio-bank = <0>;
 			gpio-ranges = <&pinctrl 0 0 32>;
 			clocks = <&prcc_pclk 1 9>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio1: gpio@8012e080 {
@@ -450,6 +474,7 @@ gpio1: gpio@8012e080 {
 			gpio-bank = <1>;
 			gpio-ranges = <&pinctrl 0 32 5>;
 			clocks = <&prcc_pclk 1 9>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio2: gpio@8000e000 {
@@ -465,6 +490,7 @@ gpio2: gpio@8000e000 {
 			gpio-bank = <2>;
 			gpio-ranges = <&pinctrl 0 64 32>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio3: gpio@8000e080 {
@@ -480,6 +506,7 @@ gpio3: gpio@8000e080 {
 			gpio-bank = <3>;
 			gpio-ranges = <&pinctrl 0 96 2>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio4: gpio@8000e100 {
@@ -495,6 +522,7 @@ gpio4: gpio@8000e100 {
 			gpio-bank = <4>;
 			gpio-ranges = <&pinctrl 0 128 32>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio5: gpio@8000e180 {
@@ -510,6 +538,7 @@ gpio5: gpio@8000e180 {
 			gpio-bank = <5>;
 			gpio-ranges = <&pinctrl 0 160 12>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio6: gpio@8011e000 {
@@ -525,6 +554,7 @@ gpio6: gpio@8011e000 {
 			gpio-bank = <6>;
 			gpio-ranges = <&pinctrl 0 192 32>;
 			clocks = <&prcc_pclk 2 11>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio7: gpio@8011e080 {
@@ -540,6 +570,7 @@ gpio7: gpio@8011e080 {
 			gpio-bank = <7>;
 			gpio-ranges = <&pinctrl 0 224 7>;
 			clocks = <&prcc_pclk 2 11>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio8: gpio@a03fe000 {
@@ -555,6 +586,7 @@ gpio8: gpio@a03fe000 {
 			gpio-bank = <8>;
 			gpio-ranges = <&pinctrl 0 256 12>;
 			clocks = <&prcc_pclk 5 1>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		pinctrl: pinctrl {
@@ -570,6 +602,7 @@ usb_per5@a03e0000 {
 			reg = <0xa03e0000 0x10000>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dr_mode = "otg";
 
@@ -613,9 +646,11 @@ dma: dma-controller@801C0000 {
 			memcpy-channels = <56 57 58 59 60>;
 
 			clocks = <&prcmu_clk PRCMU_DMACLK>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		prcmu: prcmu@80157000 {
+			/* This peripheral is in the VSAFE (always on) power domain */
 			compatible = "stericsson,db8500-prcmu", "syscon";
 			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x1000>;
 			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
@@ -641,6 +676,10 @@ thermal: thermal@801573c0 {
 				#thermal-sensor-cells = <0>;
 			};
 
+			/*
+			 * TODO: Delete these bogus regulators and replace with power
+			 * domains.
+			 */
 			db8500-prcmu-regulators {
 				compatible = "stericsson,db8500-prcmu-regulator";
 
@@ -932,6 +971,7 @@ serial0: serial@80120000 {
 
 			clocks = <&prcc_kclk 1 0>, <&prcc_pclk 1 0>;
 			clock-names = "uart", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			resets = <&prcc_reset DB8500_PRCC_1 DB8500_PRCC_1_RESET_UART0>;
 
 			status = "disabled";
@@ -948,6 +988,7 @@ serial1: serial@80121000 {
 
 			clocks = <&prcc_kclk 1 1>, <&prcc_pclk 1 1>;
 			clock-names = "uart", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			resets = <&prcc_reset DB8500_PRCC_1 DB8500_PRCC_1_RESET_UART1>;
 
 			status = "disabled";
@@ -964,6 +1005,7 @@ serial2: serial@80007000 {
 
 			clocks = <&prcc_kclk 3 6>, <&prcc_pclk 3 6>;
 			clock-names = "uart", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			resets = <&prcc_reset DB8500_PRCC_3 DB8500_PRCC_3_RESET_UART2>;
 
 			status = "disabled";
@@ -1076,7 +1118,9 @@ msp0: msp@80123000 {
 			#sound-dai-cells = <0>;
 			reg = <0x80123000 0x1000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 31 0 0x12>, /* Logical - DevToMem - HighPrio */
 			       <&dma 31 0 0x10>; /* Logical - MemToDev - HighPrio */
@@ -1094,7 +1138,9 @@ msp1: msp@80124000 {
 			#sound-dai-cells = <0>;
 			reg = <0x80124000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v1 */
 			dmas = <&dma 30 0 0x10>; /* Logical - MemToDev - HighPrio */
@@ -1113,7 +1159,9 @@ msp2: msp@80117000 {
 			#sound-dai-cells = <0>;
 			reg = <0x80117000 0x1000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 14 0 0x12>, /* Logical  - DevToMem - HighPrio */
 			       <&dma 14 1 0x19>; /* Physical Chan 1 - MemToDev
@@ -1132,7 +1180,9 @@ msp3: msp@80125000 {
 			#sound-dai-cells = <0>;
 			reg = <0x80125000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v2 */
 			dmas = <&dma 30 0 0x12>; /* Logical - DevToMem - HighPrio */
@@ -1174,14 +1224,17 @@ gpu@a0300000 {
 					  "combined";
 			clocks = <&prcmu_clk PRCMU_ACLK>, <&prcmu_clk PRCMU_SGACLK>;
 			clock-names = "bus", "core";
+			power-domains = <&pm_domains DOMAIN_SGA>;
+			/* TODO: delete and replace with power-domain handling */
 			mali-supply = <&db8500_sga_reg>;
-			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		mcde@a0350000 {
 			compatible = "ste,mcde";
 			reg = <0xa0350000 0x1000>;
 			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
+			/* TODO: delete and replace with power-domain handling */
 			epod-supply = <&db8500_b2r2_mcde_reg>;
 			clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
 				 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */

-- 
2.56.0

