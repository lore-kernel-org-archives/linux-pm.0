Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679C2C158A;
	Sat, 18 Jul 2026 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344398; cv=none; b=ipfVPMdxqxSZhIIhQR86+dQMDpVap/67+KIc5L7as8dnV6NaUUd82qvSJHAj4gdUncFOyT0kiGo68n/4MubpbIIiHLCr/h9FGWHHOjtYdbcKd3wj5BgKrPcz56inhLutJf+zp5LeO8UJEaiyNfj8RQhWluc9o3Ds+vKNNJP8qpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344398; c=relaxed/simple;
	bh=AugLiOZZpf43n382xKWhWhjP3bM2FaMd0KmVHw7e7Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLhZxxfbuluzBzwcaoQHasDD8TpyVZExPv3z8b/OP/GHItpqZ9vlRlcLndF4DPfmLBXubuSmJNHKSFrCKzDAo9Baj8NhjvdrBywpTOzr4XXeJfmboE6XwLqVhcz+qgd4ayd2lz6mDpL1QrGKP7byOg6R/gQcaAgY/7WV9FfZG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=RZcxM6WU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TGqinDKj; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="RZcxM6WU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TGqinDKj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 21C05138032E;
	Fri, 17 Jul 2026 23:13:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 23:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784344396; x=
	1784347996; bh=RGge6AXelYw4CHxTjY9ZAudHE/paAHJpZ+SOWdc+8nE=; b=R
	ZcxM6WU3VIXmOq7vrYLmUZNX96nzQEOVoXqQLcrKkL+OOGdXtkNALg9LVFI/nPHE
	0e5a37/4rWKfzpcejprWFKd0/3LFdARpntlS01RwO/ZKHamnIL/i7KEYBEvdPB1i
	RbKlc+xG0gaNgiXK0c6AO3fOds2ZSY5DzK9WebQg/qsCg2DqQdYJBaQ9wkUi+JNF
	5ew56YT/PsVETeHFsu8Bw7shJsh2oRk8z/zpPnYZGT2qz+q5vJIKM/2kOUgvh85M
	IvkdpxFNjTfQPe1fn0SwFBlC19SDurZ6yPNAVof/66nFd91HiuR/0ZFkupqZCLWp
	aq0UqDfMjBzykbQgjVpqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784344396; x=1784347996; bh=R
	Gge6AXelYw4CHxTjY9ZAudHE/paAHJpZ+SOWdc+8nE=; b=TGqinDKjEKdcxJxIM
	IgX2EEjgZG0uJ4jl07TUfQYli/zRZWyxn8bOk8+Orj2zdLFy4QWeaCGCWAM1K1kx
	00Ai7YIpqq/J4l47e4OZP8eyxUbBcqkOUboBkuSqzqTrl8eC9ISWpzPiKgwPNQ2p
	pQ+h8Euls/0vdulgz1dfdEVIQMMW4IP9dS32avamP8uHW3HbA9tllfJ5Iab9ESTd
	6ZChr1P/wCXTqEgT9GwH8KzkXtLdP6pSRhHQCjCdXhD73FqyzYuMD2b3TlF/y1mI
	V2BkVC9XQcHksCVZaqyexfiSvAuXNjEsEZB+Ozp412h8EL4IYHlHlVn8fbtCxNmr
	JXQFA==
X-ME-Sender: <xms:S-9aakXahIZY2QFczA4_mL4KyG8h67_uLsrO-Cr4s5XfdlrMMPwcKg>
    <xme:S-9aao-hVXojizXxEqaN31GRTNzMN2_PnR9yX6Y2tvGYYF6OXdtdd_XZMbMNSJ3w1
    DNG5PcvzeMgzFm4UE0HqYxLPE-NBeX13FtLzxZQknSxFjCwZRo4AQ4p>
X-ME-Received: <xmr:S-9aaphRKnbhr3Cyr7Xmv5jIsrJtSefdOkceoYFEVyk4y-39AP6ZYW51Qvj6UX41AdHXNJq15DESjDtbNdU>
X-ME-Proxy-Cause: dmFkZTFwV1cFOfFn5PC73/ps5muOtgjuTiqxG0kSfLaiTUgsadolusDHAcJW7MRZ0220Q4
    SMNmJKHZ7mfMKOV4i7J8w8QXnOcGdfffeHBigikD4MpXc0ah12NSo3fCM8/WJtIN/YKXN9
    aVztulf1DP03Gn+B/ZVCtOW2jGWNL+h+ssR/8idEpSPgN173VWcpI+vcj73eJ98Dh/1P/3
    5j6loLj84q4dWd1YK1iT123NoLmCLNdBBsYJthF3OnzZzy0Lgcee0ajRZPjY13C5ceHuV+
    1xLeJsLOnan2miDzyccXYjseBtjodOM2p23BiYsi/OLqrt4gGc6DAGDBr3uqxUe8L+GrEF
    IYlAE7vQGkR8aklR/mYKscUCCKQBsyrvkWo73QG+QixY48Q9BPSmcbVV74nnOIFz2RTm8R
    4sNOw81zDe6nT1y87gYrvzWmfeCU2WiO2t/gvoYbguBsgaaw+2OcSsd8wwYDbRyBL8fLYR
    YTQMzX4+iDmKmOe2Uy52h6V/eWsih41fTlSR41pW0icwZNqh4njml6OR5jtWOFFuIHbY34
    OpvqNMXn4xfPpfQlj2lDYoBWj2Hmwoq8x7+gjQSfpmz/VRbC4pkHPeOBi6IVlM2t+R5arS
    KuCWRLzpIS8lnklfr1XY0t5BZL9kpasqSIcL+liSBL4SToHIGM4DfaWHPHKg
X-ME-Proxy: <xmx:S-9aavX-RPtDeFvgDjd2_Vsa_wYL_Aof-uamBLdug3Eluxae0Sj4Bw>
    <xmx:S-9aatuwexToIH7RcYCTtxuWiy4HeMugcR75xks2EeaUaBYBk2FOGg>
    <xmx:S-9aag-3LniNx_8jK6AhIdsntGOfkXZ2IEYaUnvI7sQksP7n6kN4gQ>
    <xmx:S-9aatsIVS5pKXi-C6nHEYse011ajkX22-GnLhiyxE10TnWBseXXMQ>
    <xmx:S-9aaobOw7YzdsPiA--ID67rDHTSnyqpgaKvmnEmpy4J0zf4EUb2a9tc>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 23:13:08 -0400 (EDT)
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
	ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v2 7/8] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Sat, 18 Jul 2026 15:11:45 +1200
Message-ID: <20260718031146.3368811-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718031146.3368811-1-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the RK3576 NPU: rknn_core_0/1 and rknn_mmu_0/1, with register
addresses, GIC_SPI 247/248 interrupts, clocks, resets and power-domains.

Run the full RKNN clock set (CLK_RKNN_DSU0, ACLK_RKNN0/1, HCLK_RKNN_ROOT,
ACLK/HCLK_RKNN_CBUF) during the NPU0/NPU1 power transitions and on the
MMU nodes; without the functional and CBUF clocks the block powers on but
its registers (including the IOMMU banks) read back dead. Drive the RKNN
BIU reset (SRST_A_RKNN0/1_BIU) from the power domain so it fires before
the IOMMU resumes.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 78 +++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index e12a2a0cf..5033f7628 100644
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
@@ -1804,6 +1812,72 @@ qos_npu_m1ro: qos@27f22100 {
 			reg = <0x0 0x27f22100 0x0 0x20>;
 		};
 
+		rknn_core_0: npu@27700000 {
+			compatible = "rockchip,rk3576-rknn-core";
+			reg = <0x0 0x27700000 0x0 0x1000>,
+			      <0x0 0x27701000 0x0 0x1000>,
+			      <0x0 0x27703000 0x0 0x1000>,
+			      <0x0 0x27704000 0x0 0x1000>,
+			      <0x0 0x27705000 0x0 0x1000>;
+			reg-names = "pc", "cna", "core", "dpu", "dpu_rdma";
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
+				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "hclk", "npu", "pclk",
+				      "aclk_cbuf", "hclk_cbuf";
+			resets = <&cru SRST_A_RKNN0>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU0>;
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
+			#iommu-cells = <0>;
+			power-domains = <&power RK3576_PD_NPU0>;
+			status = "disabled";
+		};
+
+		rknn_core_1: npu@27710000 {
+			compatible = "rockchip,rk3576-rknn-core";
+			reg = <0x0 0x27710000 0x0 0x1000>,
+			      <0x0 0x27711000 0x0 0x1000>,
+			      <0x0 0x27713000 0x0 0x1000>,
+			      <0x0 0x27714000 0x0 0x1000>,
+			      <0x0 0x27715000 0x0 0x1000>;
+			reg-names = "pc", "cna", "core", "dpu", "dpu_rdma";
+			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>;
+			clock-names = "aclk", "hclk", "npu", "pclk";
+			resets = <&cru SRST_A_RKNN1>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU1>;
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

