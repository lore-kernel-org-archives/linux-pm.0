Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E523408032;
	Mon, 17 Aug 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966687; cv=none; b=j/zEs4l6e4d6ToH9iMGl4cLZKcXXzKsbSNvLmcTauN/c/zRQ45PLawzVLWigXXBcOewytbu56K7c/Kr2+0oOb680sCP8nHipTOKllj/GPOGm8wiN5K5PsplIjjXo0W32a8RALR435461BR2o2EhAnJxjATyEQ77x14bVy5vYQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966687; c=relaxed/simple;
	bh=Q7f6h2o7wP5Hoej+DyrcZiCqR03D55viOHuUpQpfWBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzrJ2gWFxz7J8mV6j++gdU+fPNpm+pKeLJUM+NJAUEU9Nz9O9cq9tw0A4qM/nKY9NyfddVi34XJemShCOf9xilTI5fpJdRiazZXLr6TDnALo2TIYCXlKVgz848eDGNWT9v3jJNSaP38/TwyWzXPwj4wLUOnEeUz9wM0XBcLpNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=cDGBl3Cg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4yK5i7M; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="cDGBl3Cg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4yK5i7M"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 8C4DC138014E;
	Mon, 17 Aug 2026 07:38:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 17 Aug 2026 07:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786966685; x=
	1786970285; bh=1rtSl7F1lXnj0NSEGIt5XoDJWgiooLMidXujnASVSco=; b=c
	DGBl3CgldzV7ZDJX1EqdbvVOponoNZU4FOCFHtV6LMeRJy29gLL2r+a4E9SpUb+6
	6v/hhhHPXQP7E/a4I2GBh71FIbknibpyjKZhIFlQ0XIGwInR4PsD25T8CPZI5y+Y
	Usf7nXfmeJL7defo0860+8w9GoLj4vnvYVpnDVZ0vKMDfQhehCBvy/8bSmXslhzA
	FpNDy+csiohFnmHdSz5AKE/YCgsxagWvQwQn7QwQhatW9gg4Q4OWM348POx97vbx
	undsAVcg8tNS+TpbFhC7lFz2ZHJEwt5DvM354p5bcWpaSRLhI/Hg11R9/nB1EOKS
	rUJJfDMjwEKIrtky/r22g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786966685; x=1786970285; bh=1
	rtSl7F1lXnj0NSEGIt5XoDJWgiooLMidXujnASVSco=; b=P4yK5i7Mg5/cyQGE0
	4YOev11trkJphkoPZCjcDXT4/P7quWW9blU3UKYT48RuBS2yddw76OIovOy9BXjy
	E89YoXB6o69R54Ps098jDBkquKsvIzr/ZdMk2wCGEVC2lk6o1NJp6Wt1SPGFsSfq
	05nmayl/f83nK7jWxzwbFi52qpk3+tWqhjnChDDT7YYeg6A4NHTzNnoo3dySr2MB
	o23fWGMti9Ne6Gft56VvGLCmb3GQKdQuSGhBUGxsp16NNVB0IV6Ho27LOEyvoz3u
	Y48zy6QTRHySiwkbrIhJhoWEFp6oZEUg4lI/4A8b+U8BDzJ+pp09ya2cYXD2yLcM
	G6dTA==
X-ME-Sender: <xms:nfKCat4hKur6xsc6Qu6cBixpMGxejMf-PBF1T9igwWWYnAsTURXHqw>
    <xme:nfKCanAOqKNHtuXrEN3e7hryN6y4fN5YDlLgabjz615QHJSEIPotuh8NIfz3KHwfT
    JnDNU0jqBpuSBZ_QOBrxzTIrN7BW0V1m_W1GZmnb9tGle4PiJZmYuI>
X-ME-Received: <xmr:nfKCagQSEUPErzug2rWiXDrKE6jMCUgu6G4tqLkJsXniALtBtNKyzyrmWYEp5GHZ0rDuCNj-HA>
X-ME-Proxy-Cause: dmFkZTFJpbjkSDT6AcryrIHhgbEVj8SvkD3tgmT76I8WU6lQDo3YUCdtzXxAeg/zKqpB+E
    Srz/I8ZJc3N7HCrgkTkwyaBZdvHNOdURxqLv8+rxKpfV73gGv9LWiSebktKgvlTsmvhDvl
    7z8e7P5tVZXD1XfHmjG3x7RlOqfrClYofT98201dsDsGzeGalaNI/cy87SBMyHKVxLpD1H
    cf8c4VtlmLV27PNqhGPBVow9iGRSY0ganIZ7M7ursi5UKI38krV8lOdP4K1YQOgw9wIEpu
    SQtDihQpP3WqB+Si6LCioT5pFEw0karkUBJswAF2S4IqKtJUmYgRgB9BVHgg2tCz+ac+jl
    Cd9+w80YqekiwlvnMrGpllIAi9is8PzL3IBJ50yh6PNrCWGjlcL0x7mG/1585vYOrPOy/E
    3lsc5GaqfK60KjS5ikTbWDNSmJr7xMVglvvYTs/ssAcgeQFAHtCtDVgWTF2L/JOGLppzQP
    pc9KtGDDI2yqC1Tl5muHm+NDgijq/0DswyQmqelL7WmL6LvhCk9uxEDAGWyDW8lv+eYM4J
    Nr6Ct7a0fHPOwrB7Cof2FWF7ss4JGanMLojObQ4JXSf/LuwxdsalKMyiBYNOslK93N9kDf
    nFup9/TUGIDBMtZTbdRP5xBFtNMW7mvMTlgigLEkkzKRa5jRs7/hhGcImUNw
X-ME-Proxy: <xmx:nfKCavfegItGNZdelFhklnbCM_5UJL5cSh-hWlZH539QxUHxM6p7JQ>
    <xmx:nfKCahSK4-hYGZRgc9el95scAVJEET88hG1A__K0lBz5-xFS-wXmow>
    <xmx:nfKCaj24zpLKXuFKYqkWu6EfAo22sNLoN3qlIIc_jqHzD7EcL2GUuQ>
    <xmx:nfKCav6cM_5aK4EU4Lnqn1Q07HUkWnyeTt3A9XjVFffri_9jgu-LNQ>
    <xmx:nfKCakDLsPW7JuUlhwqSM2bD9GQUav1haxfVgX3u0UvcZh6S7K29YAfO>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:37:58 -0400 (EDT)
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
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v8 11/12] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Mon, 17 Aug 2026 23:36:02 +1200
Message-ID: <20260817113603.1436067-12-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the two RKNN cores and their IOMMUs. Both cores are disabled by
default; boards enable what they wire up.

PD_NPU0 and PD_NPU1 are siblings under PD_NPUTOP and hold one core each,
but the convolution buffer and the DSU sit above them: ACLK_RKNN_CBUF,
HCLK_RKNN_CBUF and CLK_RKNN_DSU0 belong to the block rather than to
either core, and PD_NPUTOP already lists all three. Add them to both
core domains as well, so a core domain switching state has the clocks of
the path it shares running, and give each core domain the BIU reset that
the pmdomain driver now cycles once power is on.

Each core lists both core domains, its own first, so that a core in use
has the whole block powered. Whether a single core can reach the shared
path with the sibling domain off is not something this series
establishes; listing both is the description that has been tested here.
The IOMMU in front of each core lists that core's domain only.

Label the outer PD_NPU node so a board can attach the NPU rail to the
domain that gates the block.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 82 +++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index b0c0d3c8b..2d0133cdf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1042,7 +1042,7 @@ power: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				power-domain@RK3576_PD_NPU {
+				pd_npu: power-domain@RK3576_PD_NPU {
 					reg = <RK3576_PD_NPU>;
 					#power-domain-cells = <1>;
 					#address-cells = <1>;
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
@@ -1261,6 +1269,74 @@ power-domain@RK3576_PD_VO1 {
 			};
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
+			compatible = "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";
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
+			compatible = "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";
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
 		gpu: gpu@27800000 {
 			compatible = "rockchip,rk3576-mali", "arm,mali-bifrost";
 			reg = <0x0 0x27800000 0x0 0x20000>;
-- 
2.43.0

