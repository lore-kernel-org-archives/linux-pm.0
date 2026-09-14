Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A7442B2F;
	Mon, 14 Sep 2026 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386962; cv=none; b=pu1fUruFvP7fGtp54E9nxeLx+dvoLWQLBDmNQ8PCZRbpIbS4PQg8UV1ay17gnGuozKGL+SQRpzl0M2KagVvbiYwu0klhs1ezxJ1y/vfP9XmD1IhiCW0yHNy6v4eRC0xLdj7bvrQBK8Gq2ewmG+ScUHf6aUCwFi+Wl1lZbq6MWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386962; c=relaxed/simple;
	bh=6NEd1n0tFi8SNViiUzz5T3ubkPh6KjpVOI1j284Ycc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAdCJw/ogQTh2ICtJfWrUNLIBTLr2EdVH/bCJMSBkYOTKKnkd/y+2hX6Y50sy6MzPdUEGhrvcUhlFFHUNYLcyhmQ+y/MD0xdEgjUBs0wPV1wNYnZ5+nWHVpp/7XvdHDw7KtgXBKBjXGGN+SND+EexYgw//coGKJANt1Jcoc8qz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fawsoxt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fawsoxt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669671F00893;
	Mon, 14 Sep 2026 11:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386961;
	bh=4Z+2zo/uHLpAWrlQD4KkWCSip6n6CBKdqF6AyBBk6GM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Fawsoxt+MWnstAMEz+Elq9OO82rQr4t2DjbrUudeWjkKpJ8LZQfcy0KmTkQGAWyKD
	 zeszTYH2k8yGXD02pi3sdMgqh6BW38nKLhPK43/jZPWpU7YIncnDfTxy7NZ1dr8p2n
	 kLch/To2jhLRI39EQNj2acKfOscVRO8JuUKsJG/i2OU8QRTrGYWwD6pFwLpru4mni3
	 wWOeiKwvct0qgip4Z8KuLARRI7O/kewRa/pPqtzqIy7VKxNzTnJt44VzKFjKsebEGe
	 E3vDFYnBH6lNKTBz5P3oxL4m8KwIwwn5U91wZmfXIOsTPiRz+Pj6Yj+e5bfO/o5Q3B
	 Uc3U6nQdAx+XQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:48 +0200
Subject: [PATCH v2 20/20] ARM: dts: ux500: Remove DB8500 EPOD regulators
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-20-9d0c17e1f816@kernel.org>
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

Delete the obsolete DB8500 EPOD regulator nodes.

Keep the VAPE and VSMPS2 compatibility regulators.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 92 ------------------------------------
 1 file changed, 92 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index afba6bee42af..ef5e7b3cefea 100644
--- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
@@ -675,95 +675,15 @@ thermal: thermal@801573c0 {
 				#thermal-sensor-cells = <0>;
 			};
 
-			/*
-			 * TODO: Delete these bogus regulators and replace with power
-			 * domains.
-			 */
 			db8500-prcmu-regulators {
 				compatible = "stericsson,db8500-prcmu-regulator";
 
-				// DB8500_REGULATOR_VAPE
 				db8500_vape_reg: db8500_vape {
 					regulator-always-on;
 				};
 
-				// DB8500_REGULATOR_VARM
-				db8500_varm_reg: db8500_varm {
-				};
-
-				// DB8500_REGULATOR_VMODEM
-				db8500_vmodem_reg: db8500_vmodem {
-				};
-
-				// DB8500_REGULATOR_VPLL
-				db8500_vpll_reg: db8500_vpll {
-				};
-
-				// DB8500_REGULATOR_VSMPS1
-				db8500_vsmps1_reg: db8500_vsmps1 {
-				};
-
-				// DB8500_REGULATOR_VSMPS2
 				db8500_vsmps2_reg: db8500_vsmps2 {
 				};
-
-				// DB8500_REGULATOR_VSMPS3
-				db8500_vsmps3_reg: db8500_vsmps3 {
-				};
-
-				// DB8500_REGULATOR_VRF1
-				db8500_vrf1_reg: db8500_vrf1 {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SVAMMDSP
-				db8500_sva_mmdsp_reg: db8500_sva_mmdsp {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SVAMMDSPRET
-				db8500_sva_mmdsp_ret_reg: db8500_sva_mmdsp_ret {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SVAPIPE
-				db8500_sva_pipe_reg: db8500_sva_pipe {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SIAMMDSP
-				db8500_sia_mmdsp_reg: db8500_sia_mmdsp {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SIAMMDSPRET
-				db8500_sia_mmdsp_ret_reg: db8500_sia_mmdsp_ret {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SIAPIPE
-				db8500_sia_pipe_reg: db8500_sia_pipe {
-				};
-
-				// DB8500_REGULATOR_SWITCH_SGA
-				db8500_sga_reg: db8500_sga {
-					vin-supply = <&db8500_vape_reg>;
-				};
-
-				// DB8500_REGULATOR_SWITCH_B2R2_MCDE
-				db8500_b2r2_mcde_reg: db8500_b2r2_mcde {
-					vin-supply = <&db8500_vape_reg>;
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM12
-				db8500_esram12_reg: db8500_esram12 {
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM12RET
-				db8500_esram12_ret_reg: db8500_esram12_ret {
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM34
-				db8500_esram34_reg: db8500_esram34 {
-				};
-
-				// DB8500_REGULATOR_SWITCH_ESRAM34RET
-				db8500_esram34_ret_reg: db8500_esram34_ret {
-				};
 			};
 		};
 
@@ -1121,8 +1041,6 @@ msp0: msp@80123000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80123000 0x1000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 31 0 0x12>, /* Logical - DevToMem - HighPrio */
@@ -1140,8 +1058,6 @@ msp1: msp@80124000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80124000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v1 */
@@ -1160,8 +1076,6 @@ msp2: msp@80117000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80117000 0x1000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 14 0 0x12>, /* Logical  - DevToMem - HighPrio */
@@ -1180,8 +1094,6 @@ msp3: msp@80125000 {
 			compatible = "stericsson,ux500-msp-i2s";
 			reg = <0x80125000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v2 */
@@ -1225,8 +1137,6 @@ gpu@a0300000 {
 			clocks = <&prcmu_clk PRCMU_ACLK>, <&prcmu_clk PRCMU_SGACLK>;
 			clock-names = "bus", "core";
 			power-domains = <&pm_domains DOMAIN_SGA>;
-			/* TODO: delete and replace with power-domain handling */
-			mali-supply = <&db8500_sga_reg>;
 		};
 
 		mcde@a0350000 {
@@ -1234,8 +1144,6 @@ mcde@a0350000 {
 			reg = <0xa0350000 0x1000>;
 			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
-			/* TODO: delete and replace with power-domain handling */
-			epod-supply = <&db8500_b2r2_mcde_reg>;
 			clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
 				 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */
 				 <&prcmu_clk PRCMU_PLLDSI>; /* HDMI clock */

-- 
2.55.0

