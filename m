Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD93D813E;
	Mon, 14 Sep 2026 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386933; cv=none; b=GRMKdkN9T8ySjSgDgOx9D/CFaybNjc23PeVuZgi/jvofeLqYBxjjXMl19Ld4dBWrEc6Nmb15dmhUrPZzzBU+Pdyip7WNoGgNeuVGFrExp86ZQ06FPzrBtQ8mw3kd/X9YJhVWVKSB1QwbpUw7EBZJ7IJxdQ6XLvxoTqbEIkGAwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386933; c=relaxed/simple;
	bh=bbaIeF96Pj9CtX1uGYxJnaYLjhLJuafKgESDS+h1ThA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVe8TSMYPiAe8ltw4YbnmeeC6HINvc/YIkJ+DPf1/aCV3xfzZKvrST0V0XTf4lhHklYXrsv+oDMlbyrwP92ZGZd0WLehY4xskfxY5rd9ABaab8hCwW1tWUMV1phCAyjDZA3L5xfVVmH2OqK0dTv2XL9ML+rlkYFAxhcP5ltlV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRPNkTjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRPNkTjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B123D1F000FF;
	Mon, 14 Sep 2026 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386931;
	bh=XXBeEViLy7bf5ftwGeAWO3XtWxoFknzzlWqGzKWji9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cRPNkTjqjdPDiNBqOPhcqhecK1T9fRbmuRnymeUGYRbD9z5W9v9uszjhS7X9d/JhM
	 s+w5OZf4ibTywN13ApZ82nip0hhim2BkCdnNI5NZEUg0jL4rYubPjgM26+C3V/8Oix
	 FBU16g+Y1V4IPtbWKdDxC0PpcAgb8N1VkblhA+VuS2vCpIdAqC6jLMyTUixaTlZ62G
	 CpE3bKWaTZBArBIucIUqEeoCuTWJvjhC1kbddEfb1Nq9tyF2ztTEMcM3+sTpx7reAh
	 mLNRBSRNLxF8bzF/WnMDtqPXsMBBrJXxK6BUm3omXWk3LVKIe5IO7rEdviMe+lp/sz
	 NIEly2zCO9HGA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:41 +0200
Subject: [PATCH v2 13/20] ARM: dts: ux500: Add power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-13-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Add the actual power domains to all the SoC peripherals.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 70 +++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index 11fcae1904e2..afba6bee42af 100644
--- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
@@ -154,6 +154,7 @@ sram@40020000 {
 			reg = <0x40020000 0x40000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			power-domains = <&pm_domains DOMAIN_ESRAM_12>;
 			ranges = <0 0x40020000 0x40000>;
 		};
 		sram@40060000 {
@@ -162,6 +163,7 @@ sram@40060000 {
 			reg = <0x40060000 0x40000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			power-domains = <&pm_domains DOMAIN_ESRAM_34>;
 			ranges = <0 0x40060000 0x40000>;
 
 			lcla: sram@20000 {
@@ -181,7 +183,7 @@ lcla: sram@20000 {
 		ptm@801ae000 {
 			compatible = "arm,coresight-etm3x", "arm,primecell";
 			reg = <0x801ae000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU0>;
@@ -197,7 +199,7 @@ ptm0_out_port: endpoint {
 		ptm@801af000 {
 			compatible = "arm,coresight-etm3x", "arm,primecell";
 			reg = <0x801af000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU1>;
@@ -213,7 +215,7 @@ ptm1_out_port: endpoint {
 		funnel@801a6000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x801a6000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			out-ports {
@@ -249,6 +251,7 @@ replicator {
 			compatible = "arm,coresight-static-replicator";
 			clocks = <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "atclk";
+			power-domains = <&pm_domains DOMAIN_VARM>;
 
 			out-ports {
 				#address-cells = <1>;
@@ -280,7 +283,7 @@ replicator_in_port0: endpoint {
 		tpiu@80190000 {
 			compatible = "arm,coresight-tpiu", "arm,primecell";
 			reg = <0x80190000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			in-ports {
@@ -295,7 +298,7 @@ tpiu_in_port: endpoint {
 		etb@801a4000 {
 			compatible = "arm,coresight-etb10", "arm,primecell";
 			reg = <0x801a4000 0x1000>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			in-ports {
@@ -314,11 +317,13 @@ intc: interrupt-controller@a0411000 {
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
@@ -326,6 +331,7 @@ scu@a0410000 {
 		 * and various things like spin tables
 		 */
 		backupram@80150000 {
+			/* This memory is in the VSAFE (always on) power domain */
 			compatible = "ste,dbx500-backupram";
 			reg = <0x80150000 0x2000>;
 		};
@@ -334,6 +340,7 @@ L2: cache-controller {
 			compatible = "arm,pl310-cache";
 			reg = <0xa0412000 0x1000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -341,11 +348,24 @@ L2: cache-controller {
 		pmu {
 			compatible = "arm,cortex-a9-pmu";
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pm_domains DOMAIN_VARM>;
 		};
 
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
@@ -357,6 +377,7 @@ clocks {
 			reg = <0x8012f000 0x1000>, <0x8011f000 0x1000>,
 			    <0x8000f000 0x1000>, <0xa03ff000 0x1000>,
 			    <0xa03cf000 0x1000>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			prcmu_clk: prcmu-clock {
 				#clock-cells = <1>;
@@ -393,7 +414,7 @@ mtu@a03c6000 {
 			compatible = "st,nomadik-mtu";
 			reg = <0xa03c6000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			clocks = <&prcmu_clk PRCMU_TIMCLK>, <&prcc_pclk 6 6>;
 			clock-names = "timclk", "apb_pclk";
 		};
@@ -402,7 +423,7 @@ timer@a0410600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xa0410600 0x20>;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
-
+			power-domains = <&pm_domains DOMAIN_VARM>;
 			clocks = <&smp_twd_clk>;
 		};
 
@@ -410,14 +431,15 @@ watchdog@a0410620 {
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
@@ -435,6 +457,7 @@ gpio0: gpio@8012e000 {
 			gpio-bank = <0>;
 			gpio-ranges = <&pinctrl 0 0 32>;
 			clocks = <&prcc_pclk 1 9>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio1: gpio@8012e080 {
@@ -450,6 +473,7 @@ gpio1: gpio@8012e080 {
 			gpio-bank = <1>;
 			gpio-ranges = <&pinctrl 0 32 5>;
 			clocks = <&prcc_pclk 1 9>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio2: gpio@8000e000 {
@@ -465,6 +489,7 @@ gpio2: gpio@8000e000 {
 			gpio-bank = <2>;
 			gpio-ranges = <&pinctrl 0 64 32>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio3: gpio@8000e080 {
@@ -480,6 +505,7 @@ gpio3: gpio@8000e080 {
 			gpio-bank = <3>;
 			gpio-ranges = <&pinctrl 0 96 2>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio4: gpio@8000e100 {
@@ -495,6 +521,7 @@ gpio4: gpio@8000e100 {
 			gpio-bank = <4>;
 			gpio-ranges = <&pinctrl 0 128 32>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio5: gpio@8000e180 {
@@ -510,6 +537,7 @@ gpio5: gpio@8000e180 {
 			gpio-bank = <5>;
 			gpio-ranges = <&pinctrl 0 160 12>;
 			clocks = <&prcc_pclk 3 8>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio6: gpio@8011e000 {
@@ -525,6 +553,7 @@ gpio6: gpio@8011e000 {
 			gpio-bank = <6>;
 			gpio-ranges = <&pinctrl 0 192 32>;
 			clocks = <&prcc_pclk 2 11>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio7: gpio@8011e080 {
@@ -540,6 +569,7 @@ gpio7: gpio@8011e080 {
 			gpio-bank = <7>;
 			gpio-ranges = <&pinctrl 0 224 7>;
 			clocks = <&prcc_pclk 2 11>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		gpio8: gpio@a03fe000 {
@@ -555,6 +585,7 @@ gpio8: gpio@a03fe000 {
 			gpio-bank = <8>;
 			gpio-ranges = <&pinctrl 0 256 12>;
 			clocks = <&prcc_pclk 5 1>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		pinctrl: pinctrl {
@@ -570,6 +601,7 @@ usb_per5@a03e0000 {
 			reg = <0xa03e0000 0x10000>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dr_mode = "otg";
 
@@ -613,9 +645,11 @@ dma: dma-controller@801C0000 {
 			memcpy-channels = <56 57 58 59 60>;
 
 			clocks = <&prcmu_clk PRCMU_DMACLK>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
 		prcmu: prcmu@80157000 {
+			/* This peripheral is in the VSAFE (always on) power domain */
 			compatible = "stericsson,db8500-prcmu", "syscon";
 			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x1000>;
 			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
@@ -641,6 +675,10 @@ thermal: thermal@801573c0 {
 				#thermal-sensor-cells = <0>;
 			};
 
+			/*
+			 * TODO: Delete these bogus regulators and replace with power
+			 * domains.
+			 */
 			db8500-prcmu-regulators {
 				compatible = "stericsson,db8500-prcmu-regulator";
 
@@ -932,6 +970,7 @@ serial0: serial@80120000 {
 
 			clocks = <&prcc_kclk 1 0>, <&prcc_pclk 1 0>;
 			clock-names = "uart", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			resets = <&prcc_reset DB8500_PRCC_1 DB8500_PRCC_1_RESET_UART0>;
 
 			status = "disabled";
@@ -948,6 +987,7 @@ serial1: serial@80121000 {
 
 			clocks = <&prcc_kclk 1 1>, <&prcc_pclk 1 1>;
 			clock-names = "uart", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			resets = <&prcc_reset DB8500_PRCC_1 DB8500_PRCC_1_RESET_UART1>;
 
 			status = "disabled";
@@ -964,6 +1004,7 @@ serial2: serial@80007000 {
 
 			clocks = <&prcc_kclk 3 6>, <&prcc_pclk 3 6>;
 			clock-names = "uart", "apb_pclk";
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 			resets = <&prcc_reset DB8500_PRCC_3 DB8500_PRCC_3_RESET_UART2>;
 
 			status = "disabled";
@@ -1080,7 +1121,9 @@ msp0: msp@80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 31 0 0x12>, /* Logical - DevToMem - HighPrio */
 			       <&dma 31 0 0x10>; /* Logical - MemToDev - HighPrio */
@@ -1097,7 +1140,9 @@ msp1: msp@80124000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80124000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v1 */
 			dmas = <&dma 30 0 0x10>; /* Logical - MemToDev - HighPrio */
@@ -1115,7 +1160,9 @@ msp2: msp@80117000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80117000 0x1000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 14 0 0x12>, /* Logical  - DevToMem - HighPrio */
 			       <&dma 14 1 0x19>; /* Physical Chan 1 - MemToDev
@@ -1133,7 +1180,9 @@ msp3: msp@80125000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80125000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			/* TODO: delete and replace with power-domain handling */
 			v-ape-supply = <&db8500_vape_reg>;
+			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v2 */
 			dmas = <&dma 30 0 0x12>; /* Logical - DevToMem - HighPrio */
@@ -1175,14 +1224,17 @@ gpu@a0300000 {
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
2.55.0

