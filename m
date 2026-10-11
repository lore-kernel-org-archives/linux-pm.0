Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2BC3D9520;
	Sun, 11 Oct 2026 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744489; cv=none; b=rj3plfxz5MiOfWpkVQY5NefequIX7g6tBgvHVjWVx8Y4sZMa6H+U7Gu9yBpQ26DHUKDLU9Se/L/YmpRz7PkkPN/7WtBVbHleDGfoFach1raUN4dIAfMKOD+lOFZ9BJTFLnVLVdPGvi+r+0MbQh1cgWTiH2y5Crmw51SoJzLVn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744489; c=relaxed/simple;
	bh=mW8fO91p1c7yiaSc9+hhxtalHe+Le9+xysAE/HEbxRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8toDCUOkfK9ObWOdDuE7VhmbjX0sBKO7r8Jj9Sl0sStjw5RhkkCkXf+f83B1mrJmba2kI/uiXX/jeSLeJUzhqa9wvYaQtrn4yrF7RNaxF0LxJjwPjWZqrURsVD0xqRbxG3BJqh/UpadwNfEElmHtVHxVjKz9aKIFLcjg8VCX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=dKGI9ydS; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="dKGI9ydS"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791744484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ID1sQJD4+D4jhlXt0RHQpqbhFzYCgLIo6hNPonIZ6dM=;
	b=dKGI9ydS5mp+0q5X9IKWjLwk/JOmAWNqFNcPcxoDC96rrWEVF1zfL+rsQeaiXT9H9aW/AN
	XP7qXpUgBr2n/Z6v6ZMYmrSNAXlRpk+tQrseGGySazUPvf+8sd7cfBHxoP3MxDA7pDfFY4
	5A3+Csl1BWtEe7yttwwvDWPQySBTgMmHxnEVxHMKRiVyXh+3EoWJZGIijvft526+D+zi4J
	gVoFloxxOGGTIf/FRFJXmeehVigwnzPktsID8ucp/fXAYG0MtlZ9gY2xzncrru0bZ8XtR8
	F0TTaxFbh8QXF6i0K48iAxeLgVHSjtAP/B9NXTdbGMyuztKNIcEJN4wd9y2f/Q==
To: ulfh@kernel.org,
	angelogioacchino.delregno@collabora.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v2 4/4] arm64: dts: mediatek: mt8188: Use access-controllers in the power controller
Date: Sun, 11 Oct 2026 20:47:55 +0200
Message-ID: <20261011184755.2058017-5-michal@nozomi.space>
In-Reply-To: <20261011184755.2058017-1-michal@nozomi.space>
References: <20261011184755.2058017-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

List the blocks that the power controller accesses in access-controllers
instead of the deprecated per-domain mediatek,infracfg phandles, and add
MFGCFG, which the power controller needs to enable the GPU timestamp
counter whenever it powers MFG1 on.

Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 14a320f0c70cb..cf0da77c5fd29 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1000,6 +1000,7 @@ scpsys: syscon@10006000 {
 			/* System Power Manager */
 			spm: power-controller {
 				compatible = "mediatek,mt8188-power-controller";
+				access-controllers = <&infracfg_ao>, <&mfgcfg>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#power-domain-cells = <1>;
@@ -1016,7 +1017,6 @@ mfg1: power-domain@MT8188_POWER_DOMAIN_MFG1 {
 						clocks = <&apmixedsys CLK_APMIXED_MFGPLL>,
 							 <&topckgen CLK_TOP_MFG_CORE_TMP>;
 						clock-names = "mfg", "alt";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1077,7 +1077,6 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS0 {
 						      "ss-emi", "ss-subcmn-rdr", "ss-rsi",
 						      "ss-cmn-l4", "ss-vdec1", "ss-wpe",
 						      "ss-cvdo-ve1";
-					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
@@ -1096,7 +1095,6 @@ power-domain@MT8188_POWER_DOMAIN_VDOSYS0 {
 						clock-names = "cfgck", "cfgxo", "ss-gals",
 							      "ss-cmn", "ss-emi", "ss-iommu",
 							      "ss-larb", "ss-rsi", "ss-bus";
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1112,7 +1110,6 @@ power-domain@MT8188_POWER_DOMAIN_VPPSYS1 {
 							clock-names = "cfgck", "cfgxo",
 								      "ss-vpp1-g5", "ss-vpp1-g6",
 								      "ss-vpp1-l5", "ss-vpp1-l6";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -1120,7 +1117,6 @@ power-domain@MT8188_POWER_DOMAIN_VDEC0 {
 							reg = <MT8188_POWER_DOMAIN_VDEC0>;
 							clocks = <&vdecsys_soc CLK_VDEC1_SOC_LARB1>;
 							clock-names = "ss-vdec1-soc-l1";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -1129,7 +1125,6 @@ power-domain@MT8188_POWER_DOMAIN_VDEC1 {
 								reg = <MT8188_POWER_DOMAIN_VDEC1>;
 								clocks = <&vdecsys CLK_VDEC2_LARB1>;
 								clock-names = "ss-vdec2-l1";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -1141,7 +1136,6 @@ cam_vcore: power-domain@MT8188_POWER_DOMAIN_CAM_VCORE {
 								 <&topckgen CLK_TOP_CCU_AHB>,
 								 <&topckgen CLK_TOP_CFGREG_CLOCK_ISP_AXI_GALS>;
 							clock-names = "cam", "ccu", "bus", "cfgck";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -1156,7 +1150,6 @@ power-domain@MT8188_POWER_DOMAIN_CAM_MAIN {
 								clock-names= "ss-cam-l13", "ss-cam-l14",
 									     "ss-cam-mm0", "ss-cam-mm1",
 									     "ss-camsys";
-								mediatek,infracfg = <&infracfg_ao>;
 								#address-cells = <1>;
 								#size-cells = <0>;
 								#power-domain-cells = <1>;
@@ -1194,7 +1187,6 @@ power-domain@MT8188_POWER_DOMAIN_VDOSYS1 {
 								 <&vdosys1 CLK_VDO1_GALS>;
 							clock-names = "cfgck", "cfgxo", "ss-larb2",
 								      "ss-larb3", "ss-gals";
-							mediatek,infracfg = <&infracfg_ao>;
 							#address-cells = <1>;
 							#size-cells = <0>;
 							#power-domain-cells = <1>;
@@ -1204,19 +1196,16 @@ power-domain@MT8188_POWER_DOMAIN_HDMI_TX {
 								clocks = <&topckgen CLK_TOP_HDMI_APB>,
 									 <&topckgen CLK_TOP_HDCP_24M>;
 								clock-names = "bus", "hdcp";
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 
 							power-domain@MT8188_POWER_DOMAIN_DP_TX {
 								reg = <MT8188_POWER_DOMAIN_DP_TX>;
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 
 							power-domain@MT8188_POWER_DOMAIN_EDP_TX {
 								reg = <MT8188_POWER_DOMAIN_EDP_TX>;
-								mediatek,infracfg = <&infracfg_ao>;
 								#power-domain-cells = <0>;
 							};
 						};
@@ -1229,7 +1218,6 @@ power-domain@MT8188_POWER_DOMAIN_VENC {
 								 <&vencsys CLK_VENC1_GALS_SRAM>;
 							clock-names = "ss-ve1-larb", "ss-ve1-core",
 								      "ss-ve1-gals", "ss-ve1-sram";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -1238,7 +1226,6 @@ power-domain@MT8188_POWER_DOMAIN_WPE {
 							clocks = <&wpesys CLK_WPE_TOP_SMI_LARB7>,
 								 <&wpesys CLK_WPE_TOP_SMI_LARB7_PCLK_EN>;
 							clock-names = "ss-wpe-l7", "ss-wpe-l7pce";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -1246,7 +1233,6 @@ power-domain@MT8188_POWER_DOMAIN_WPE {
 
 				power-domain@MT8188_POWER_DOMAIN_PEXTP_MAC_P0 {
 					reg = <MT8188_POWER_DOMAIN_PEXTP_MAC_P0>;
-					mediatek,infracfg = <&infracfg_ao>;
 					clocks = <&pericfg_ao CLK_PERI_AO_PCIE_P0_FMEM>;
 					clock-names = "ss-pextp-fmem";
 					#power-domain-cells = <0>;
@@ -1270,14 +1256,12 @@ power-domain@MT8188_POWER_DOMAIN_ADSP_AO {
 					clocks = <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>,
 						 <&topckgen CLK_TOP_ADSP>;
 					clock-names = "bus", "main";
-					mediatek,infracfg = <&infracfg_ao>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
 
 					power-domain@MT8188_POWER_DOMAIN_ADSP_INFRA {
 						reg = <MT8188_POWER_DOMAIN_ADSP_INFRA>;
-						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
 						#power-domain-cells = <1>;
@@ -1286,7 +1270,6 @@ power-domain@MT8188_POWER_DOMAIN_AUDIO_ASRC {
 							reg = <MT8188_POWER_DOMAIN_AUDIO_ASRC>;
 							clocks = <&topckgen CLK_TOP_ASM_H>;
 							clock-names = "asm";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
@@ -1296,13 +1279,11 @@ power-domain@MT8188_POWER_DOMAIN_AUDIO {
 								 <&topckgen CLK_TOP_AUD_INTBUS>,
 								 <&adsp_audio26m CLK_AUDIODSP_AUDIO26M>;
 							clock-names = "a1sys", "intbus", "adspck";
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 
 						power-domain@MT8188_POWER_DOMAIN_ADSP {
 							reg = <MT8188_POWER_DOMAIN_ADSP>;
-							mediatek,infracfg = <&infracfg_ao>;
 							#power-domain-cells = <0>;
 						};
 					};
@@ -1312,7 +1293,6 @@ power-domain@MT8188_POWER_DOMAIN_ETHER {
 					reg = <MT8188_POWER_DOMAIN_ETHER>;
 					clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET_MAC>;
 					clock-names = "ethermac";
-					mediatek,infracfg = <&infracfg_ao>;
 					#power-domain-cells = <0>;
 				};
 			};
-- 
2.56.0

