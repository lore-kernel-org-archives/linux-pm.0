Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824297;
	b=ECF2jWbfoFuDf2+7Uas8S4NOBp2jUKceinP01jTlpH2WmLmTLRIIj5PW8kOpk/2BYig6
	 Y2kCy2y49zp6RqhQP/dD5WIxV56gnu8MbppvipTmCgsWfi9B8QK+17t4cgO0hrNEAZzE/
	 W+KEuYq71SxxqZ8HPwV7RowTYZucKiHqMXcdsdq1IeXjfPePG8GUmGyvb8+4xHnanwLRZ
	 ATrKLfd6906G9c+tLShLa230lKHenwGv/BXIF7QJs42zW943CYP1n1Ld0qXmAfJNHPvA+
	 sI54flGGsMcwSou4Ka5XSS7uCQqBrqe7RG2u7LdUuGpRPXggbGNDdx5AeUND8u2Xj5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824297;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=42WQvqgp+QaH5oQhmusBg6D+zZ/4xvV/MU8Zg3jcRsE=;
	b=UQCaWvYtqGhYWW5jjKJO9HAek6jsh5lYn2E5LoWnNosxfbpuoHiuLKQBqqzs/jOBPow/
	 TckveT6Jb88IRaZOos5ZHd4BGF1nH6YQ+a9ZEHYYm1p3aXzm+Agnj6H+/fKdk2nPMYQx+
	 Y8gOvB5RryOZLQpvUBo0XQ1dmp21feU+QRxXJaFRSLsmuTj8x4fOwiwnmEvgP8729N7u/
	 3Yb6mtdB0qcH6LvrgQ3SNm/OTOQYFJdel9zvqAh7ARY/0GI17o+Piv3ugTx4Y0Kwe4GAv
	 CMEX+bBRspBaFYAC6yKlGtPvZ8s3YX5gQ8VDb+1dm9Km35rEXmHq45RVRnzKINhh5sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehfH0CVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E55606A334;
	Mon, 16 Nov 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehfH0CVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717F81F000D3;
	Mon, 16 Nov 2026 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824297;
	bh=42WQvqgp+QaH5oQhmusBg6D+zZ/4xvV/MU8Zg3jcRsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ehfH0CVM5o5rG62dBGoLg32exqjKOmBdYlKyFSVAKPYc2zJVT42WRMYJikxUpkdLs
	 SXV8istAxHa3g9ifQsBkMGoWrXgmt9QDNWeaXw2rkeBmzQi4oQNxuoUdcahVimtB22
	 runqgVok21nmhZ/i0NUW0wsvXokBZ7eLTQF67z9eH0ZFJddlh+UqO32Ga7YJvazAZn
	 RD0amq7f3XGI0QvTzOPzNnHbH2aNAyxIZmvoPZ1lA+R4PN1qE0ioc/VkYY9sleZhVu
	 dFnv8OVpR4TErZaynDsmzj8rpxQ3tUQeQeV2cPiiVX2vkNkITzO+ZH0Vqy9SsQpLVJ
	 C3ej7lwIrW1sQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:18:09 +0100
Subject: [PATCH 3/3] ARM: dts: ux500: Remove DB8500 EPOD regulators
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
Message-Id: <20261116-ux500-powerdomain-dts-v1-3-e0f4459c3ab1@kernel.org>
References: <20261116-ux500-powerdomain-dts-v1-0-e0f4459c3ab1@kernel.org>
In-Reply-To: <20261116-ux500-powerdomain-dts-v1-0-e0f4459c3ab1@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
 linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Delete the deprecated db8500-prcmu-regulators node and all its EPOD
regulators, including VAPE and VSMPS2. Their external consumers now use
the AB8500 or AB8505 buck regulators, so no compatibility regulators
are needed.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi | 103 -----------------------------------
 1 file changed, 103 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index b3b3cec69656..967444e4a618 100644
--- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
@@ -675,97 +675,6 @@ thermal: thermal@801573c0 {
 				interrupt-names = "IRQ_HOTMON_LOW", "IRQ_HOTMON_HIGH";
 				#thermal-sensor-cells = <0>;
 			};
-
-			/*
-			 * TODO: Delete these bogus regulators and replace with power
-			 * domains.
-			 */
-			db8500-prcmu-regulators {
-				compatible = "stericsson,db8500-prcmu-regulator";
-
-				// DB8500_REGULATOR_VAPE
-				db8500_vape_reg: db8500_vape {
-					regulator-always-on;
-				};
-
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
-				db8500_vsmps2_reg: db8500_vsmps2 {
-				};
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
-			};
 		};
 
 		i2c0: i2c@80004000 {
@@ -1118,8 +1027,6 @@ msp0: msp@80123000 {
 			#sound-dai-cells = <0>;
 			reg = <0x80123000 0x1000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 31 0 0x12>, /* Logical - DevToMem - HighPrio */
@@ -1138,8 +1045,6 @@ msp1: msp@80124000 {
 			#sound-dai-cells = <0>;
 			reg = <0x80124000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v1 */
@@ -1159,8 +1064,6 @@ msp2: msp@80117000 {
 			#sound-dai-cells = <0>;
 			reg = <0x80117000 0x1000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			dmas = <&dma 14 0 0x12>, /* Logical  - DevToMem - HighPrio */
@@ -1180,8 +1083,6 @@ msp3: msp@80125000 {
 			#sound-dai-cells = <0>;
 			reg = <0x80125000 0x1000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			/* TODO: delete and replace with power-domain handling */
-			v-ape-supply = <&db8500_vape_reg>;
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 
 			/* This DMA channel only exist on DB8500 v2 */
@@ -1225,8 +1126,6 @@ gpu@a0300000 {
 			clocks = <&prcmu_clk PRCMU_ACLK>, <&prcmu_clk PRCMU_SGACLK>;
 			clock-names = "bus", "core";
 			power-domains = <&pm_domains DOMAIN_SGA>;
-			/* TODO: delete and replace with power-domain handling */
-			mali-supply = <&db8500_sga_reg>;
 		};
 
 		mcde@a0350000 {
@@ -1234,8 +1133,6 @@ mcde@a0350000 {
 			reg = <0xa0350000 0x1000>;
 			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
-			/* TODO: delete and replace with power-domain handling */
-			epod-supply = <&db8500_b2r2_mcde_reg>;
 			clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
 				 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */
 				 <&prcmu_clk PRCMU_PLLDSI>; /* HDMI clock */

-- 
2.56.0

