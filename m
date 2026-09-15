Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F9492E35;
	Tue, 15 Sep 2026 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469181; cv=none; b=rLKIXBqQ5rA7o5Xr1IssuiJeMpYmZGaSo5Ro49M7CJeGIC8k3AQB4rVCT6yVFQZ/cq5WQBNgodk7/YynJqJroe5IefSqeiPCODDEYamwi3a9gJKxgb0p/XTZ5VmsKa1yFyKxwE15AfjpB03l9AOaivrFEX4M0pQrDUhJF92suZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469181; c=relaxed/simple;
	bh=bTZi84lqnDkfZfad7zQtc84YDTWWzuRD19OT0NO3jp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+19eUUaBRDtwg2/9xvTCpDNlDioSIaBQqpY7a9Xkhw5646LZL3dTPMe2tfvUQiO0X+JYJO1xGAOGSmPUcPFyMQKGndNJip5dW5O66qizKkihnxGJ77UY6xqdFfJN6kuPdX3IBzrkEqBAsKDOpYGsgk2k4j/7f0ny3CoKXS4I4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=E2aVIb+d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GO9XxQj/; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="E2aVIb+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GO9XxQj/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 68573130050E;
	Tue, 15 Sep 2026 06:46:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Sep 2026 06:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469174; x=
	1789476374; bh=6ZH2yhhWclrOGlZcOwgI16yHIaMMZoDMxlrEMqFGo8Y=; b=E
	2aVIb+dee4JLFHHK4W56LhBnLykb1jzc6oy3EdSGUkXxqGCf5So/fjIgADrlpvaE
	LCjfIbwhVxg3+ekNra22jby3DX3rcXAgp+sg8Fu7CmBdFGrrnYv1kouupcOcJjH3
	p7bWn+w9mrz4rPlZsAce1Vi6+fT/Tjo44JnpXlIcqB+bNbdaJE6lpvaDKg8AawFQ
	lgwlzWtr3xYOcPZQTiHEp/n4DckOAIXXF2cGZOUWNEU1M5vO5IOnubyiFPOA9S3O
	64dYqluqCILKegXw3apYHIrTsRadFIrAgomGx8xsQ67nCqNBqDI3lVe0vINHvCVZ
	gFYXXWwRzByaUZCHteaXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469174; x=1789476374; bh=6
	ZH2yhhWclrOGlZcOwgI16yHIaMMZoDMxlrEMqFGo8Y=; b=GO9XxQj/khu5BUHFm
	aJdUcFoSRxN9VIif0Hr9+H2N764CGXXTB/HUyEieFQ9WE6ztopOqewWw08agr4UL
	qNlH+KTYopTSIcZ4Y90U82RA7fjfx7tsZIFYYi+SlTA4R4k4UfkQItCJECR2X5kx
	pmLfldHpl7JPwabQGAlFb9c+UYF9ihMvgSrJCMODi0+sEBib3J3QXvho46rLDuY0
	yAfOpGsOh9uFFNUxIpX26zR/JoSFZ+HsQYJEJRwu1NM6Buz8RqJrVciZbH0HmkAK
	n43tO/pODy1UQ1ztyyGVPlE6GIPbSgoIBi738D4+ADFh/Cg4V4l/BjMSaa5MoxNU
	Ot42Q==
X-ME-Sender: <xms:9SGpam_Mc0gYBYU3rKU9IoSfgVxZo4ClJouCecrg5eyfSqxQMjzDaA>
    <xme:9SGpam2lVQkgX8uV_Ap7AryYJx15LefS7f7TBdZwRLgYZlv68fGYU-sNvDQKNcDPM
    JCQ98-s8ZOBczzmmmlR35i-hzkeoST_HdrnArA2Fa9JlUfWAyh9wB-C>
X-ME-Received: <xmr:9SGpap27ae34kgt32fZHksJAJs0h5OqVlHjcaPQGOnsGSEVPo5J0g2yl33U4XnnRlE-K22Zv6A>
X-ME-Proxy-Cause: dmFkZTGC7j62tXMGgajHCaYl9LRDhSVXli2vpHPtOTENmffy8Ld5NQ16KawirlQvrTExft
    1qKI73d8VGGBe6ldYvpEYhDk7nGJB2x3hhHvQe7KrdNdaOsKt8QX2IJy8nOwVc7OoBQxdr
    GjY1+iqmQdvn8Zk7yLBMwDU1Aj/or9TQqkmYa9aHQ5qlx1Ur4fYJSE8D+QtjgctyBzJQ4d
    KMzItB7ejokhvHcWczLqIjmuYQb4vNsIbJpZUHTUB8BcUIME9ULFzDYFecEiEp06cqAF8J
    w4TbrI7BG0D0BtAgtD5VP12d9ktSc8KO1eudi2Uy03TledXfu8K25SPKpiCb757wIcntfB
    TgG6P4mz6NTX8B3cNRCYMlnyFvD8nZhopJva9eJ8EpQvP88Yqys1GRT3pq3Ya6jdL/WWDc
    y10LXBdlWPdbqKMiWys8KZdrtTmH9esAwM5eHlR/3hiWT2wH33JrEVLwIZyecpSqpgA9As
    IlqQOxy1AQSqz5Lfd5bI8sZ0wnaa2J3kbCuI+K8WB7iee1MsDefiJaXZ2wRcXsqCq2R/Et
    Og/tuNNnSKwyb+uiLxHvVdDTpiFBz0H7/rD4rY6rCEzY3O6bTGWHSSMmYRlQhHTgxbMMmZ
    zuUTyYNJ1wT+O3tn/fvRgmneV4e0Jdzpj8cFbsj910CO4WzxMRbXSPO6Ge8A
X-ME-Proxy: <xmx:9SGpaisvRcOL_ddSdo2GPe3c2I8ryViaKNqgS1r2x2Y2ckFBAoGROA>
    <xmx:9SGpapZlk2xYTWOAPnMhC1ofHsheqX7kcE0SVfF9qo1PfXTC2c-Fgg>
    <xmx:9SGpaoL41BFeKnhopEx3Q2yR2WCGsGPM6ER10yGE3zww5yXF0HRm7Q>
    <xmx:9SGpaqjBPKbQJqyunGePgXFV0F4re69Z-Jlms6Qe9haqkSwQZLaVMg>
    <xmx:9iGpauTTLvgD9-vq-14Ytwqx1LJ_ST7Yx5-qXFhO2Wez7VEU2aNbXjvo>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:46:05 -0400 (EDT)
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
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
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
Subject: [PATCH v13 13/14] arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
Date: Tue, 15 Sep 2026 22:43:27 +1200
Message-ID: <20260915104328.45901-14-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
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
HCLK_RKNN_CBUF and CLK_RKNN_DSU0 belong to the block rather than to either
core, and PD_NPUTOP already lists all three. Add them to both core domains
as well, so a core domain switching state has the clocks of the path it
shares running, and give each core domain the BIU reset that the pmdomain
driver now cycles once power is on.

Each core lists both core domains, its own first, so that a core in use has
the whole block powered. Whether a single core can reach the shared path
with the sibling domain off is not something this series establishes;
listing both is the description that has been tested here. The IOMMU in
front of each core lists that core's domain only.

Label the outer PD_NPU node so a board can attach the NPU rail to the
domain that gates the block.

Clock the NPU inside the voltage its rail is given. CLK_RKNN_DSU0 clocks
both cores and the CBUF they share, nothing in mainline sets its rate, and
the block comes up at 786.432 MHz. Rockchip's OPP table for this NPU asks
800 mV of its 800 MHz step at the worst leakage bins, and nothing in
mainline sets the rail either, so a board that follows this DTS runs the
NPU above the step whose voltage it happens to boot with.

On a ROCK 4D with both cores enabled and vdd_npu_s0 at the 750 mV its PMIC
comes up with, two jobs in flight at once make the second core write single
words of its output wrong: the right value with a bit of the accumulator
set, always the same position in the array. Either core alone is exact.
Four device trees, same board, kernel and userspace, four passes of 5400
rows each, every row compared with the same multiply done one row at a
time:

  786 MHz, 750 mV    13 to 20 wrong rows a pass
  594 MHz, 750 mV    0, 0, 0, 0
  786 MHz, 800 mV    0, 0, 0, 0
  786 MHz, 850 mV    0, 0, 0, 0

594 MHz is a divider off GPLL and sits between that table's 500 and 600 MHz
steps, both of which ask 725 mV at every leakage bin, so it is inside the
voltage a board that describes no NPU rail already provides.

The trade it buys is a core against a clock, and both halves are measured.
The rate lives in the device tree, so the two clocks cannot share a boot,
which means this comparison is across boots and has to clear the noise of
one. Twenty readings of a single arm inside one boot, nothing changed
between them, span 2.5%; across boots it can only be worse. So the 4.0 to
4.2% below clears that floor by under a factor of two, and the 26 to 37%
clears it by ten. Five runs an arm, the arms alternating inside a boot,
one warm-up a model discarded, medians of five:

  decode tok/s      594 MHz   786 MHz
  Llama-3.2-1B        17.85     18.60   two cores
                      11.17     13.77   one core
  SmolLM2-135M        41.46     43.12   two cores
                      38.26     41.90   one core

Losing 192 MHz costs 4.0 to 4.2% of decode with both cores running. Losing
a core costs 26 to 37% on the 1B model, at either clock. The rate is the
cheaper of the two by six to nine times.

The two arms cross-check each other: the clock is worth 23% on ONE core
against 4% on two. With both cores running the bottleneck is no longer the
clock, which is why this configuration can afford to give up 192 MHz.

A core is worth much less on a small model, 2.8 to 7.7% on 135M, where the
second core's dispatch overhead is not repaid. TTFT moves by under 2%
either way, so none of this says anything about prefill.

An OPP table with the rail attached is the proper answer, and it wants
driver support this series does not have.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 86 +++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index d418bfc04..e9cd11b58 100644
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
@@ -1261,6 +1269,78 @@ power-domain@RK3576_PD_VO1 {
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
+			assigned-clocks = <&cru CLK_RKNN_DSU0>;
+			assigned-clock-rates = <594000000>;
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
+			assigned-clocks = <&cru CLK_RKNN_DSU0>;
+			assigned-clock-rates = <594000000>;
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

