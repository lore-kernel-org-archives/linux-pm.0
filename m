Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75673DAAAF;
	Wed,  5 Aug 2026 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911984; cv=none; b=dFX29LqRI+oFF0UoECbIxFRKzS1LX3TjGiQi+ViHvf/L/pJSm7jYGFZ3XAB0Hg0oZehwyO5WAF/G5W9eREYxuLvWy961l/58qDk7IsZBKs9JMZoB2BlRRMtP2vqsPXnGjHzeO9ofCHUtvsend26SW3sAcqCL1vc792kzckS9C+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911984; c=relaxed/simple;
	bh=bRfSreLpjR5f/JeBfk/8tUDRhux1Y3bOx/ZKnvAmEko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmLZiXJCud7xmSjBFJm00tKYa90B5921KYGvcoi2Vsi78KgM/fYPaI12mgtRidnTpubRN/1viUubKLXdYJrXF70lxT/14x416Y0r9K+TYa8jSzyG8tTPwsv0xVq3r76U+4OGmDIB947amOIMRFdVEwFcR1qOVNJYQjlPfk+6zww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=j1ZeqOP4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UmcEj8Zp; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="j1ZeqOP4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UmcEj8Zp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 3722613802B4;
	Wed,  5 Aug 2026 02:39:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 02:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785911981; x=
	1785915581; bh=MCdVFBzoMQYqXVrZeC1sFHbOAswgeJFeoPQ04J47ZjA=; b=j
	1ZeqOP4rfkMoeC7brYov08d9RhRzvpCtOYU3Xg+dHyscSehctOuZfUpCqSW4zbp4
	DI5PQPtGzJDqPFyXJ32/F7VQrdYgR+z6YOAYi0q7dAVOZyWCeSOrmn/ifgPOWP1e
	6IomDHLKl3a2Y/4E5OyrvhNaMYNsYL77K13y7QS3/t/IKqTTgNnbhX9EuVAI71S5
	rjqBAQqn3KnorJQ5Wies3HozKtJrSvFVUCHH9ctZK7dFvjPC+uLFXODIacvagGKb
	05/zfWwQYeH1GIKKADTlWgzVZTxRgWZ6FeRBx63l3DBXRXVJgg01bjm5sfl0VHOx
	NySngkooYGxGPtAoIaRew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785911981; x=1785915581; bh=M
	CdVFBzoMQYqXVrZeC1sFHbOAswgeJFeoPQ04J47ZjA=; b=UmcEj8Zp071yco1kQ
	2tPnVQzj3BFIlDJtIlNKQ2vOnXcRDbUXZG1MHzYhBx1PxhjpK7dHh+KiCcfJ9feG
	N8JPEMuey5zgTZJ3XEwY9HQbWFFeu+2er5QXcwwrFY5wNWVDFZvJzEfZXU9sAyQi
	/tbf2Yp8FgqBOoMqbBGTy4DE5daAeY3fHcpbA9qhC58qNOpr3AdfF6Us1NLWhLnt
	5j35ymIfX3E7beJnytGnW6M7b31cRman7wyzgJ0ejtLVBW01MnRSDpTyOMgf2hXL
	/lL2Vh0aCQO+//4+kfahp0Hz3toceJfvG61PfqCvrgGE5/r/ze10G4mSH+u4oUbr
	QT2WQ==
X-ME-Sender: <xms:rdpyavfm9mn9d-ojgdALEF9UeRcNU6YwgLLnNxBv3EkpY_CJZoJJNQ>
    <xme:rdpyapKIgN0kblrv7d_WUewyKnTEcNgCz70oj6TKnDjHNNs89_T2pj0xHaR_ltcIk
    foti4xVwU1xNY20Cr_Cx-WoOVNdlSjKZt8_Bhy0L7OtBpIvnnnLwKI>
X-ME-Received: <xmr:rdpyahCSwpWhdUT5OHLpZ_kpUEoAf6PkxYtk3IzJLNdHKKGPHfbNJOIh4nzcsNqDGN_e9Iu1Sw>
X-ME-Proxy-Cause: dmFkZTGXEDL04vcK2sDnKk1CmvKU/eZmnC/t9ja4KZoFmKHOCdBsKmXq25MbtfK3Z/feDx
    gqOrpGCep9R5Bgz3tQcnjrsQirYkze8tJuxPPRflm80YpbZ++jUZBCUs57zIffUj729f63
    dEDMo6xiiT/i5snVuBBlJb94jfjddPiipleSLEI67lNed4EM//QTtnrIVHxOn/PTf7Up+X
    PkSN+hf7QV5xXvQ0GMs3tfCYbfm3jHsaVNFu2CE/bROOE4H2ZAOEXcZbCLVXYkR/+oe++q
    siB2fOwbnTG33hR+OcfE0MUb9cavFe+MBMC+/N1A1Y9zwgQwsPopanh88MXFGqyMXaC8K1
    q83yxC+u1msjHDb445feZjKBg97aUfeJFDTqX5CfhDn0GtuC4Jh9RE6TE+v+hnAh0j8jLt
    69QKVbuO0dOl4WIZFIbLuyML4eJp5iZWaYEywYrl0bGXqvoiwA3NoiyWwMGzcCI6gDWzp0
    ISE2DJ4jW4YFawjwN8V16E37dETdIwLmHc9R3KZHE4XiHXe3+aBGEZGt3zgEVUvObroYDW
    318Tlt+vCj0QxNt97ocmdg/nlsxroNSQqQOUbsk0O+06zf168McCQRLbgbogYRWQd8g5zH
    2hI+UQ8Vv+E5RZVsUzh3FFCFZocq5xsDawHM2TMEDRauWGdKZSoxLtx2QFWw
X-ME-Proxy: <xmx:rdpyaqihrosZ2PA-WjKACoUGemSWIxfMHtPNiK_Ki3gceOD1w1kPDg>
    <xmx:rdpyajMXQOSEWIGTR7vhcq8aFT0uDcvtPP2HZMmXxIokv435OQAgow>
    <xmx:rdpyapbEbmB7ZpVWR9VtSRs592ooZVNxyhcY5KFq94ENjcCRdzT_oA>
    <xmx:rdpyag-eATKMEWee5eE_zT2WedNVKuyITQjxcSPhtLBe_tUzMmNOSQ>
    <xmx:rdpyamPrD_5XqDq6g5FUW5MICyDvWvsKNPNeMx6vD0clcKvOYe8nTrGo>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:39:34 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v5 v5 7/8] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Wed,  5 Aug 2026 18:38:25 +1200
Message-ID: <20260805063826.95682-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063826.95682-1-gahing@gahingwoo.com>
References: <20260805063826.95682-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the two RKNN cores and their IOMMUs, plus the NPU power-domain
resets the pmdomain driver now cycles on power-on. Both cores are
disabled by default; boards enable what they wire up.

Each core lists both NPU power domains, its own first. The compute path
needs NPU1 powered even when only core 0 runs, and a node with a single
domain would be auto-attached by the driver core before the driver can
attach the list itself. The IOMMUs keep one domain each, since they rely
on that same auto-attach.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 80 +++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index b0c0d3c8b..1e6dd039f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1070,14 +1070,22 @@ power-domain@RK3576_PD_NPUTOP {
 						power-domain@RK3576_PD_NPU0 {
 							reg = <RK3576_PD_NPU0>;
 							clocks = <&cru HCLK_RKNN_ROOT>,
-								 <&cru ACLK_RKNN0>;
+								 <&cru ACLK_RKNN0>,
+								 <&cru CLK_RKNN_DSU0>,
+								 <&cru ACLK_RKNN_CBUF>,
+								 <&cru HCLK_RKNN_CBUF>;
+							resets = <&cru SRST_A_RKNN0_BIU>;
 							pm_qos = <&qos_npu_m0>;
 							#power-domain-cells = <0>;
 						};
 						power-domain@RK3576_PD_NPU1 {
 							reg = <RK3576_PD_NPU1>;
 							clocks = <&cru HCLK_RKNN_ROOT>,
-								 <&cru ACLK_RKNN1>;
+								 <&cru ACLK_RKNN1>,
+								 <&cru CLK_RKNN_DSU0>,
+								 <&cru ACLK_RKNN_CBUF>,
+								 <&cru HCLK_RKNN_CBUF>;
+							resets = <&cru SRST_A_RKNN1_BIU>;
 							pm_qos = <&qos_npu_m1>;
 							#power-domain-cells = <0>;
 						};
@@ -1832,6 +1840,74 @@ qos_npu_m1ro: qos@27f22100 {
 			reg = <0x0 0x27f22100 0x0 0x20>;
 		};
 
+		rknn_core_0: npu@27700000 {
+			compatible = "rockchip,rk3576-rknn-core";
+			reg = <0x0 0x27700000 0x0 0x1000>,
+			      <0x0 0x27701000 0x0 0x1000>,
+			      <0x0 0x27703000 0x0 0x1000>;
+			reg-names = "pc", "cna", "core";
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
+				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "hclk", "npu", "pclk",
+				      "aclk_cbuf", "hclk_cbuf";
+			resets = <&cru SRST_A_RKNN0>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;
+			iommus = <&rknn_mmu_0>;
+			status = "disabled";
+		};
+
+		rknn_mmu_0: iommu@27702000 {
+			compatible = "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x27702000 0x0 0x100>,
+			      <0x0 0x27702100 0x0 0x100>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
+				 <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "iface", "npu",
+				      "aclk_cbuf", "hclk_cbuf";
+			#iommu-cells = <0>;
+			power-domains = <&power RK3576_PD_NPU0>;
+			status = "disabled";
+		};
+
+		rknn_core_1: npu@27708000 {
+			compatible = "rockchip,rk3576-rknn-core";
+			reg = <0x0 0x27708000 0x0 0x1000>,
+			      <0x0 0x27709000 0x0 0x1000>,
+			      <0x0 0x2770b000 0x0 0x1000>;
+			reg-names = "pc", "cna", "core";
+			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
+				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "hclk", "npu", "pclk",
+				      "aclk_cbuf", "hclk_cbuf";
+			resets = <&cru SRST_A_RKNN1>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU1>, <&power RK3576_PD_NPU0>;
+			iommus = <&rknn_mmu_1>;
+			status = "disabled";
+		};
+
+		rknn_mmu_1: iommu@2770a000 {
+			compatible = "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x2770a000 0x0 0x100>,
+			      <0x0 0x2770a100 0x0 0x100>;
+			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
+				 <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "iface", "npu",
+				      "aclk_cbuf", "hclk_cbuf";
+			#iommu-cells = <0>;
+			power-domains = <&power RK3576_PD_NPU1>;
+			status = "disabled";
+		};
+
 		gmac0: ethernet@2a220000 {
 			compatible = "rockchip,rk3576-gmac", "snps,dwmac-4.20a";
 			reg = <0x0 0x2a220000 0x0 0x10000>;
-- 
2.43.0

