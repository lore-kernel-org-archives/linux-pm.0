Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928240B0E2;
	Mon, 24 Aug 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569885; cv=none; b=Is6zCxmLlWhMoQIUFuyxo8rIzVtsl/LMiBVt3wxLYg76/fgCdX4QynJax1sdtJ5qIyrcmGOvOGe2ynxPct13og387jBFESMOotIHbEWDzgT9Q47iBHrhuq7uxA2fkz8l1RUF6sLFw8QZzHFpUu4X1zFWwIrwzoLcD9oRDIFNpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569885; c=relaxed/simple;
	bh=Q7f6h2o7wP5Hoej+DyrcZiCqR03D55viOHuUpQpfWBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bbfuk5HelSrRychqEAjAiOcjvVoyIHc3kqO87otkeqGocZR7xvznvp6tx5Pl+obGnmQI2joP/xOyGhl5mSXjRn3bTFApFTZLRc/uKUStnbFuSaGqf9uyyWsFRqvtkvwX3pRRYTOoKioXXkiVQ51TXLceEN4nUvbPDWLviAnbzUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=gAb7AfNH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gdhIzk8c; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="gAb7AfNH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gdhIzk8c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 3550A130005D;
	Mon, 24 Aug 2026 07:11:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 24 Aug 2026 07:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569882; x=
	1787573482; bh=1rtSl7F1lXnj0NSEGIt5XoDJWgiooLMidXujnASVSco=; b=g
	Ab7AfNHJ0GpIKgQEhN8zWUn/b4YWAZiYpD16JZyQz3m7ge156hQJq1wX+7WpE0wn
	t4dIKniENZFRKRMoV+8/QzSGGmIxoMpdIZp3PI+905jeXmi7eC7iB2utHkspgyR6
	I2+s8M5b809W/0desbG22kBUQA3zOV6V2A9GoeytRcRtYcJ6lvXiFcBLlOkhVQie
	YQsnxHs4shDKS6pgzlxLp96GNI+GdcpPzkdl19oUlm5lMVvbIuBBJqPErixvTKku
	1UUieYBLNHtfAhpYq2JDSKhurDdSJwCzEPYuLx9OmDBjQUXPB3Jbuv9UVY8Lv+Jg
	0QSTqYklfQh4lrrkbDoFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569882; x=1787573482; bh=1
	rtSl7F1lXnj0NSEGIt5XoDJWgiooLMidXujnASVSco=; b=gdhIzk8cascdyWtxY
	pwdhidzO+6uw2/34rxt/lJrOGi+vLW838M4g/G5/mElP+dh9PzpAhtB0xJtQs6/R
	m1YfsLo66I43480nuXfmlOsFPxWocrTJQmxYuESWjN7mhGNArJfGexUrSB9jF2vp
	gZXKNibZ8PLaaj8Eqb3Ll1K6F3jFoqnXaIpCCSe/6tIOCJEBzezzlg9wlVO6XzaX
	x5UQoQzNp58JQdLxveJcPWtg8CJYL7n6zIq9UHrqoXrBiQk1jRs+0HaSFEmguAbR
	kGoQXZAYyVySzSqiKykD5VsROaIqtgIqcz6OLqyPFy7QUIltp1nooU2Mj8fmlQMd
	m2SEQ==
X-ME-Sender: <xms:2SaMatc6FZoEETuqgsnO0OdKCljMRlLM7W5L5VrM2EbJE0UdquaFLw>
    <xme:2SaMarG2_X6D3ed6XWFuOye-Lb4NsmzZUNhuCMIpqPov8BMKzcXlV-tqZgzulrw7Y
    jthds02SySbdMS_a63C0PEXweonrDDeOWe7kxM2qvcFwC1Fkm_wyOzG>
X-ME-Received: <xmr:2SaMaj3WLUR_K-3Fh7ut41_vj-bSMBz6LWwi48V7jx44DLmv0d0edk2qxTt-GQ9WeGdxZskzVw>
X-ME-Proxy-Cause: dmFkZTEdm1O3I+6yUCQhEEs4EtQt+8VO6pi5vpyg6HaTYLChLltZMtW0KqcxOTRThnAFfq
    2Odn8CVRgbiOBBf0a9qI7rqOV5OU70z0PINZsuhrlAKWEQ7HTj3AwF2BGC6e4eXqtsWmgM
    ABtM/CB+/iwRE60tddV5LlUAIS+GXU0agRuJMw5RaHEpnxpI517wJc0pj0K5/mU5vAHa+4
    bnn7QF+ZXFIDrUNOAJcrFcmUWLhF5mNy4tzd1pm6IERi9logac9iAqP1avrzWoONr9En/c
    tslmUfAQGWDaSWWVDv0FVMgwKXsyNda2wRjvNQbjI2mm4YcRdpQIhaYDUMhDNUItM8EcRy
    L5nzHgeVKHGt8gkqydWsa6IuLKJzwoShLmyrMq6UUtb8DuFvH2xZo6EkLWlnGbmV8DSKp8
    eyQHreN8hOaRXM1k08cWA1tjbCnU/XGlHUQJQdywCShQWY/LoOZVba9byP7Sv76uIwonLW
    mbgt2V1b6B0f1CaWUcbg/WmwpzDOnXdm0ZYaNswmLbVZ6SYH/QuvsGWaO/j9GKlMvffkEp
    0m73z92Hlc8YFdYpT3MAcAkO/jNnqUTdwmNj0AqIdq8WzM5qqRlxO+RY2g/LGksHKncK9s
    HNbYWvUks5cH1q6up1PGfU8YAHMaI2p4AaD5jCQMxe62/oTV7Ln8wRCyWaYw
X-ME-Proxy: <xmx:2SaMajK964MkttrwPJWcSLXDf589LYC0UqJucw4H3v5fHtHJ8uSI0g>
    <xmx:2SaMam1P-vMVrv-wnNrS1JZ-wHnJGqE6EVG39ZTFhdvXfLN5KvvP9g>
    <xmx:2SaMamgFRtauoJamT_410nxHHRv5nHB7ocxkPKn8l_5Z4MZ63FP8vQ>
    <xmx:2SaMau143G7fd3vIbwHP5yYFT_juir2EumQR_pIDxQX-fJVAsCvXfQ>
    <xmx:2SaMavV7tqkU_35AyfGkSw1Xy6DK3bq1SQfxa9MHLNfViSvylljYeISQ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:11:15 -0400 (EDT)
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
	u.kleine-koenig@baylibre.com,
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
Subject: [PATCH v9 12/13] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Mon, 24 Aug 2026 23:09:01 +1200
Message-ID: <4c39fe5a956ab58a643703152adac74ac0e9acde.1787568944.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
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

