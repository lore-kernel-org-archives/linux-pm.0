Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516D3DEFF1;
	Thu,  6 Aug 2026 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998166; cv=none; b=s0CoIeNMk8lJIAVl7iZlLoJvYZV+0hcWj/2URdFYdmzE3GNXqLSkwglaszQ2hCMrk97Uzx94jM5sz6dHanUdM2hsVGdXyaEnfLWyQOUoSq4xLOx165/K+opObynboFKHD/w3c6/PXbIRjB+9PEhrvSJyApTfhdV9bp1AAm6Mq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998166; c=relaxed/simple;
	bh=bRfSreLpjR5f/JeBfk/8tUDRhux1Y3bOx/ZKnvAmEko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqBNC90EX2sTSMkwHWmY48Olu8YJe3l28fWxoE0c5P+abbxPzRZCmJdpgaUuRZhls8gn6Q9yoFPu9oO9UOaT4ZindCu/SXbp5beybnxJvnXUuEbppuWAhtpXCUgeXgiYOkKLiJdeC0sxMfTNI6Va/xi4RtoWDTOnD0kZ8DP2KVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=MFct1n34; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NAENol+4; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="MFct1n34";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NAENol+4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 7EC2813001B6;
	Thu,  6 Aug 2026 02:35:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Aug 2026 02:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785998153; x=
	1786001753; bh=MCdVFBzoMQYqXVrZeC1sFHbOAswgeJFeoPQ04J47ZjA=; b=M
	Fct1n34Bigl9NKLfwyrt4kTWzq/T7EBnkXyQb24ycDscNG+gOHljKs41pRgdaKi3
	kM2lPXXoQOIBPNU6gCoMAly05ur98SmkAbtDyDxlDg44pzwmV4ktj3kt97EVFo5N
	WvrhWOce2U6lT93eeFZ0AogNh3oUspJplNOK8w69mn6IWEpXWPZ9bBj9hDROYtVL
	nJRFUOa/9H/wLvNxPBQv0J7BALnTXBJeOHHMmfw6/XbEW5Dke2ti0MBVF2tIG/CY
	q+jgMFDqNAzlRcEmZgtjYTO6HHYTdvkYHn2EgU/HNjAsUAhmDNP5FjuPIRABpgto
	k/G8ztaGjq5sY0Pjdnvdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785998153; x=1786001753; bh=M
	CdVFBzoMQYqXVrZeC1sFHbOAswgeJFeoPQ04J47ZjA=; b=NAENol+4BUQKRpxYS
	PoQJkQaj1IrBXeSb+94yTPQ/EOzGrC6BSiKuNhh6X9pGnaKo8i+/ToR0OtlmSmBz
	P7pU4JhIXIXSrQE8C7G3LfkQI9S086vyjj6qAhJaQ01qS17xiGAqIBNKIAltFkK6
	jWdOs4krIlAdhHTrEF7XWhh0HdQ4FWBj6guP/doQhGJyUwcy4bQ9mbZwiSPA41P9
	5ubf3gVIh4tTHo0Vk7KHZwIcs3TNxC41hNs91tgMvdzmgKXyvRirSSnc02S5OgRi
	W8yQKxl8CaytVqwWdIwEc92MGeaQZcbLQQLa3A2TH3S/W/ZgQLGmXrz4O+4haD/I
	xAELA==
X-ME-Sender: <xms:SSt0avxi10CchjxN9ZdZTUk07ZiJ6vQJrqSPAaqqbTHeSTn6IYdtjA>
    <xme:SSt0aja8lT8VpfNGkC6AOIKKWnuKTDHeDvNoHPRjpIevgXh_IFwvTljZhC2V6jVLK
    UbxoLRiZYJ-jS478kGPGrkAZgehmdG3U090ZDBfE3zQMpiUb_9MRw8>
X-ME-Received: <xmr:SSt0alLz6xfO8ThEnMoihGoydvSvkmhTLNYi_-cIv0YYtRkFxJfJYwdP82lDZiu41GiikUpS0g>
X-ME-Proxy-Cause: dmFkZTEh6EqLEron4P620rfA50oje5pogyeStsqRC64znWcm/DBV15Jp+RPu9rfpq1CYYb
    UFmLU5UCxdxDCYby+qIAZtXGI2PUlpFQNXwfYq4ttCgPHbGa62/TDDwxKwLB8tX7dfhqau
    EbUP3O00RQtnFbFjlgrSaMtfjvGvqyYuejLHQ8kaCQjYwTQGvwYjMVbSb1Jvpanl+FPpuM
    SqFyNQH/92jvSpo2kN70zd3lo4jOKuY6rGBanj09NT9Qpf7fxDVsJep1Tqo9Yuq62YMLgS
    +erfmDCU3gBbJvDrolUKAZwfNdHwfv2Y4EHW05E61S/1zu1MOw9sAC69rBYAvxBuvfJpCG
    6sqOK/dU1aOJR4IqBiZMRe50GYv94+aLZvUTfD6v2LUE8vwKws+MqoZDbp6rjd4owNJ/S7
    w178UMafEXMMmdqUBb4J4pwt/aUXVQgwk02FXNWcohSQOYNdvLacn3vkKogU1H/1GayMBg
    OHg0QkB+BzrLOqldIfhwj4pvyON4dpHwz0zPXpFruAkcDsFxjy8uy9QmY9JKA+AP3XO3bE
    6MByKHXRsq7+qI4V5YVGubCSY+hZyK6smBD4f1ib8OBLj7f4kV+BRzw+oj9qguxbCVrGA2
    tGCiy9OvfFwvk+kOhO/WQRMr0mnmmci9ZVV1u/dWk7yAP1XfGWVqw0NVaSvA
X-ME-Proxy: <xmx:SSt0ai3hBivYFLErYjGw65fX0k1yhQ1HbzGm12vjKY2ELiL81KSSQg>
    <xmx:SSt0ahL_thjeQ3LeQ6b0I3FOmCGSIK50e7xtaXTlddpytrUp4JO6pg>
    <xmx:SSt0amO8GwngRg4_PrMkcdIbs-STSUBr0L7WZWlc9CkI7H57arkscw>
    <xmx:SSt0aiyFwFVL2sadc_HYXGSwerGy6zA-9FmcA1N5TpX4pha_e84kwA>
    <xmx:SSt0ah4Klm1lcUHf1TKfo3g_9WxyQQPiUd_ItgKWJrYbUt6jZm-GB5av>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:35:45 -0400 (EDT)
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
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v6 8/9] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Thu,  6 Aug 2026 18:34:12 +1200
Message-ID: <20260806063413.350184-9-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806063413.350184-1-gahing@gahingwoo.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
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

