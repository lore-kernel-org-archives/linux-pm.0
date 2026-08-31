Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809953D348C;
	Mon, 31 Aug 2026 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164538; cv=none; b=S+K3OcUETBfTFjH8hY2Aykj/Yk47KFy26jyRaPSX4yS/TjDaP43hciiSQnyO2s9vah95r8AQ6MmRcbGkVrDLSuPDhstOfvml8ADEtp7rwXBCz5tpCftSyRjDnuioklEx/R/yKx9CqBCZGXLpVfMq4gZL2oj/sMKY4l8DyhqKXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164538; c=relaxed/simple;
	bh=Q7f6h2o7wP5Hoej+DyrcZiCqR03D55viOHuUpQpfWBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DV8yBGwL1VPj3ijOdu8FafjmjP8ALK/jSSlaxuT/+3yKxCI7ylk2ChfWj0rS8OpmROCV3Q5JeVuxGk9U89zUvJ10V2PuWpjdbacc861WFVx6stK08CT1mpiTELDUvBXPsK1RdR+S6ZudbtdQfFPXpDaOJV4AL8theTbR7iAe7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=QJU39e55; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P78DHlYA; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="QJU39e55";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P78DHlYA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id DC0EF1380045;
	Mon, 31 Aug 2026 04:22:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 31 Aug 2026 04:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788164536; x=
	1788171736; bh=1rtSl7F1lXnj0NSEGIt5XoDJWgiooLMidXujnASVSco=; b=Q
	JU39e55+WQN23kDxA7nD7K5GSpe0xv/FKvrfjPS3B7o/1iI1DIUqRDj83WQcgV2j
	YfyFBNHNgKOf28giDnEyKX30zlKz+U0paA1TGjSo7b9sinql2TFRLZyBfskWB4rd
	Zp7mi8ysfGXX6BKiipmlv81cbQWPvr5FzUk39B33hLDFQLWzL1MGRJNx1QhGCkfb
	LZVbOjakZaHW0xVd8UqPYBtuRdILPxoSvMiZkQiwP8HdWvHt6lV70tqvfo0snK2u
	LBEmOGJrANczdAD3cNb+wsTYdgmdixEB2OOlU6oNXZAmKvEd3+czyLovTZdA/enM
	5EL58sQsR/BF/4U621q/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788164536; x=1788171736; bh=1
	rtSl7F1lXnj0NSEGIt5XoDJWgiooLMidXujnASVSco=; b=P78DHlYAwuLwwZyqo
	bp55NjODmFIZ6G/u3X47WRzLg0Lb+9Ia+4KUoCKgYEioBW9MLlbDiF7MC91ug6uK
	WtfNwjE6/LcKSZ+zDDFCO9wNPsL/vsEmcouWsAoj4fbjFMbNVEAscSXYbXuOHYaQ
	LR/D53qKzn+NSPYWR1bF8ZzP0LAm0YhBOvEX6vbpirFafHLTwrHusRpkrBCz99CX
	l2pShkkGGPAtNgNQfJ/F0j/747wgC5Qbz8ImH7cenzA0f3UidTZTuMbAmtcFFQ1k
	k8WQKtf8P4WNUK4+t30RzgsQHrfGn77mkzPQ7d0Bslm4uUEnjWKXkNPfR1QIKx3R
	G8lcg==
X-ME-Sender: <xms:uDmVag6az4um5-C_XCvLor7zXAbhIq1fFuKjPwWrbN-8qM5thU-g5g>
    <xme:uDmVahyrl1VVRSgqlCqAapJSatYvO29omtnVDCh7K7x3D79Xq1D-tOiWUvgdcmChQ
    NkU0QJIuGD9jEzYy6BTtPtc6x3A3KQfG0ALG_sMgqZcywTR2jyoQIkv>
X-ME-Received: <xmr:uDmVaswJ9xHXLWDtyvrv5dbhBhLDEc5tvkC7M-MhMoyBDdgehJT4-tF2Gz2FGr9Xz_XPytj2dA>
X-ME-Proxy-Cause: dmFkZTFpYZzbCorKWlZk8zdfC/L1wYqstk9pIbGHwtVsZJ9Q5h4E/ZFLSTh60i2uH6Kazz
    zW3rvA+krkpQQTNXaXejICAHOtIPIr4L4LZHub0z/CvEnTK5g2d2SRxpho9Hdbll2MX/I/
    azBrggjp+HVSQqmFmbp/f0XBWiAFeJsMzew/Bv8BpJrWG8MywYcMmECBLwLmucHaajSPyM
    av+rn0SyoTQdnlRzjyGRsPAybrAK8ZNLGpK3NvbOrenbXBx/jnRWsZKZ9CsFGKDAFIjOFS
    AJSL1wjMyVOC9UcM1mXGTm6LVMRm4ipt98vwHadJu66cqJGnSHzoQXseQ2M2bgS58mUOcH
    XSfp6Pdch7jaKJsr2shTVY4R3r4xQp9in491MH0xyOa9h/Z+jr/sRiXopgsLWCVKz8ZjkJ
    GEZilqPFiP7CBcRNPAFFqRBZ7JxxfnuEKHeOGIeLqw/ko1kzK/guw9oLxq26A8PnIHVUb+
    RhQzdbahUQ9tAMAQ7eOFEX/l+yGzO1GENKwmCgjTWA5NUY6JDCNfKMiKhriqCbUlymQ1mi
    co7N6G5zG3K7LqgQykhO8hphCi81YapwLtCbxGxShf/2FteRE02cnKnL5UjP3yKRLKDwOm
    4qOGNsOcyHDdFFEbbFyYcdO3D7Y7aCS5lSfdvfdXYiRdavsgze+Iw4dBiC3Q
X-ME-Proxy: <xmx:uDmVahUrvXDMyE2CEGukIcnzCkn7AD9pSItLi4T9TNKN58xhPE8-Lw>
    <xmx:uDmVahQLJBnpAZ7horii0fENF4m5_Ge64FLq-97IWDWEBW4tY0Pfcg>
    <xmx:uDmVaoP1lvcyYlMwDZG6SB2m7ayYPTbt8vPkWJpElz551T1XO4_Jsg>
    <xmx:uDmVamz27hgyWPZDbKv2YsqYm4jkCIujOb-Li0okWI7S098f06VDpA>
    <xmx:uDmVai9DzxCbgqrR3Xyeie57SaH5Vm-yi_xuIWQbQvWULqzsZVVyoHuq>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:22:09 -0400 (EDT)
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
Subject: [PATCH v11 13/14] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Mon, 31 Aug 2026 20:19:55 +1200
Message-ID: <20260831081956.84871-14-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831081956.84871-1-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
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

