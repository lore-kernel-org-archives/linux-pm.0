Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C9737757A;
	Sat, 12 Sep 2026 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789196020; cv=none; b=mF5QxzGFKAZotN01RgNtPe3S/XVYY12oQjaBKRgD5K+Arfb1A4vvFWzvyGNF9Lp7AJcvNh/7rPtoPU6f9uezBGAZRQyMXDoRI9pOYaNMfT+aeCWJe7b1fzLmMPJgV+shiCOKZWiMVN0v+gftoZ5cYdSvEp3kE4FFch9leZq0qjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789196020; c=relaxed/simple;
	bh=H6kg6W5KJ8QXgz8YLb6qNBmV77ftxTZZb7S2KPSFr5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+ajRj3SApede50rbjfcMs6DfiBafeTHQOEXmeYpiGlN7oyOxOB1Sfz6HYZaYG4YC5a7HOYshnJWpknrWFkJ0Vxm2ambJS+IbnlwUnHcKFU+MlmtuBq+0FEWMe4g5+g/maHucfDlQL26iMmajJ0VyYt7dolGH8Sp13ogmYUMbAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=Fv9DPVFQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CW7Sibs8; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Fv9DPVFQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CW7Sibs8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AB8A01D00072;
	Sat, 12 Sep 2026 02:53:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 12 Sep 2026 02:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789196017; x=
	1789282417; bh=29kuZTOL34ZYrLuE3glr7QdIb7w/z7TETbxd0s1r3s4=; b=F
	v9DPVFQRNtxHaEWJMx1F1K9kBEsuVh6czXmO5N7fJet2UXqFKeWmRGQmeAG7IBO+
	KzUXsZP8bSQnQC/HV9m/hDjjjWu0kkOn3ha31tKIQ8VSW1piRSZJlf2tYt4XZ7H1
	x3VDFJLH7m+3QSolmClVloS3II7UyTwxdvH7c8ewsPVtn33yXG4y0JRVSipZQPNO
	qbRW/v7YlpYUgECsZneKfArFCG6KZLLR5YZzMzBPhX0zmn9BAtB+1SI5iv2HgbOa
	EsFSfbioccxbO6lsNe0f41kqj6nw0ihXIhOPw8yAaHY6KV9h0LdcEEOAEmnyeJOu
	+OzZC3F89SJJH21IebmJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789196017; x=1789282417; bh=2
	9kuZTOL34ZYrLuE3glr7QdIb7w/z7TETbxd0s1r3s4=; b=CW7Sibs8Nl6o7kNFT
	hLLBtN3ACmk9BWxRULQknYmX58qkR/CXyDUbh1LprOGy/cI2tXP6gE10jP6u3eBR
	B9z8A42Z8WZ4YG2vS8r6BjzU6Vf6h0ZTlsCapFegZILF3nQML46kFkERB8+eI2cz
	qrlFPgK6ShgKpOqzxtO1QHcZG8wSApEL/phx67ifs8OgkmkWQ3oinwVB8koJdyfI
	ZWyoxU8JU6/pOlrP21b0D1C3Gt1mz9tl2WshmLv7NCMm4JD1FCz1gqnO6K2+sz2y
	zhxb210trNL+B1jp3muH+DyQP2zjdSYLkgbxMyk672FEv88yFlankE22LSxv7LEo
	lpUmA==
X-ME-Sender: <xms:8fakasqVehBW-C-KufbTmF-aQIJImpTMiCJI681XXeDzcfgvFU5cHA>
    <xme:8fakaiwjBdctAk6qycig2WJyBGDPvogFp8kKVJ5zBusn183zn_uJ7YMLLLkTeyqpJ
    wiIh5rssiiaP45N0nUKjWrJ27ygCr6zhtYR5TSlzfvPfCRQw-lUaMg>
X-ME-Received: <xmr:8fakavDfL7psvUATpdVf-77ixuQmdYaO5BHjNXh1UFpqbn2b_jtGt8LuwMJTz5Ziv48nFdwhMw>
X-ME-Proxy-Cause: dmFkZTFdeou/rbPZ0VyQgVeeN0Gr5FPjkDs1WcHQqmznz4822R6kIGkA6M2j2vL65U0LHa
    hJMTpzNtpSPndker32EDj/av1OoTrFZCOL+/rpWrbqdHOV0wxVplOupufhBfTl2nkuCDeo
    WutOwNfhVelqRAGrUIW6Tr5x4cT+rccYeXK0sVaQXwT64DJXiZ/8JVDkwt5IzZDuPG1YG2
    3O2o3Ta2PYQVpvHs2Pp1mAygVSjtkvNJP2cZEhnK/mNXtSJIqwU6EpEGiWseBWMNb/qZaR
    5jk99FyCnnmWy6VyY4rt8MvFdKYOBQ+jg7yaVaZMXhvnhbfzgIWf0uQyPIgzQrlr0ZskBY
    NAp4y/yg4bd+gAMw4sJqBCu7I5gQc8s9jjHJG+AvOlT+FhPFkBTrqXomTr0De7kqvkU6Yg
    MkzHC6m6eCQRBqqL8X0LKVtDrlaFURsmIMugUJ+8AurJwGjthDKJy1KEHKWC3TQoZLlBeg
    fH3bRTABWEgFou1rKvr+zwsPGjCjmFWGB+tk8MfUa+1lqeQLoEl/Wq4OyCXoVnLwdpU5or
    fQ4fFd+xU3REj1c0A1As+XeLp4ah9RZKIXxsPrdE9/5i4IWmeW/1Cazm8c++ybIbgey7Bn
    kp6n3/O4nPF5ak4VdoNHrkAmZkaE2N65cONEk0EStetrio/Lpt3ZJI/paJxw
X-ME-Proxy: <xmx:8fakaoI4yW7Kh9U8m96oRl1ubkY5yBZqnZRzQLQKf4xUIwy_Am5tBA>
    <xmx:8fakaqGJYyIC-xSf7nkezn4FIfxaXfAQt4gHX53N57bOjlmsQDOKww>
    <xmx:8fakajEz-j_rTDc3pPoaqZEk7S9HNy082y_yfYsQJGe1HC8bzrGqUQ>
    <xmx:8fakaiv4I5rMgVfjzW8Gl0O4UkAaYzm6jlnzMMvKibOHxtBzFY5wrw>
    <xmx:8fakanGmMGhujU-LrW-IzVOUy7JOjxzbM1IWxKOVG-5AW5WDBavKp1GU>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:53:29 -0400 (EDT)
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
Subject: [PATCH v12 13/14] arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
Date: Sat, 12 Sep 2026 18:50:52 +1200
Message-ID: <20260912065053.1519165-14-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912065053.1519165-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
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
The rate lives in the device tree, so the two clocks cannot share a boot;
boot-to-boot drift was measured first, by booting 594 twice, and is under
1%. Five runs an arm, the arms alternating inside a boot, one warm-up a
model discarded, medians of five:

  decode tok/s      594 MHz   786 MHz
  Llama-3.2-1B        17.85     18.60   two cores
                      11.17     13.77   one core
  SmolLM2-135M        41.46     43.12   two cores
                      38.26     41.90   one core

Losing 192 MHz costs 4.0 to 4.2% of decode with both cores running. Losing
a core costs 26 to 37% on the 1B model, at either clock. The rate is the
cheaper of the two by seven to nine times.

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

