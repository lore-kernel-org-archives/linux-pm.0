Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06103E51D2;
	Fri, 17 Jul 2026 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278504; cv=none; b=WqFMOWIbUxQ1l6NWd7caZBBRymoqIimyTOjyAgsNsbx9MzStGbjVjTCAINWJt4O/V+qZNycx7BUmpcgz41nx+qrjcUHEBhiZRzWGSg1a+V/LtMj67GIDIgi6l3btLXmfZ/VipAtpZ+zCYFRo2/ZCWEF4wa5y24rbvqDdZUNJ2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278504; c=relaxed/simple;
	bh=AugLiOZZpf43n382xKWhWhjP3bM2FaMd0KmVHw7e7Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuOq1DuZliB+4tRXYP3hTdtZDF14dHvJakQioRX7rXHidmDB6ZxDiEix0F2dkebdsYG7Fs4ddC+Q0enqw6dzwNU+ppGO26WZKk2A7Owe5DPnfajvJA7jZQhAIswzrjcG7Pwf8gluFbM6+cN4stBLK/tC3IYX3JpA24vJ6k7+wHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=Q8I9FTk/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aDYxsq8t; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Q8I9FTk/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aDYxsq8t"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id AB8BB13002E3;
	Fri, 17 Jul 2026 04:55:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 04:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784278501; x=
	1784282101; bh=RGge6AXelYw4CHxTjY9ZAudHE/paAHJpZ+SOWdc+8nE=; b=Q
	8I9FTk/YSI557MXnaI3wellQZxcA7TFXnEyTBnvAA0O62HEtytKGJY18Pa6QDzeP
	4QWMMIKUa8+ZsUO8hgk2npNjtLEzRIbKOBAGjXkHgSAAuUzVAbPaKDukGSC/a7+x
	EqvBbhuHTzgIg+lGVbCIZNPl1W5cyP4m+437QKvbHAcPck1ylMRnPaX3vEQsD/oY
	Y6SqpoEzWWSb/6uWmUXCF5GMGeczfJpjuIxUibKqGt9uB5WmRbPhaUTnuR/zGgfB
	zj5uVO1EbsbIGqLcv4Wlqku5iM3zAbRjbp6ceXFFdae8FSRHHT0O0nTmg+j3yGPl
	pW5IDLIX6DBpl6V26WZng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784278501; x=1784282101; bh=R
	Gge6AXelYw4CHxTjY9ZAudHE/paAHJpZ+SOWdc+8nE=; b=aDYxsq8tbe8PRw2WR
	dH8FI+FnghlkI/goafbeHb/wj83s/04JuqApB5WAL6UFfmqQW2fG3jUI7awwuaKQ
	5K735JsL5Kb8MDWrmfW50F7yiBrjrKtscK44nO3lBwtDan7g6/6093PgJiqaLFId
	qLxqbw0Pz2bdLCWkNm8qQ4Evyq56NGEVT3dVDvHskq8Qr9ihJ3MZVgXpUjOwL6am
	gXFXAW+Jd07xsXA/uhNu3PkQt7ifQUSKMZyhKI8wya787EUfRZWXpXNKMZPl6jzI
	zsvJ7eYb1+ndqT08XikyxTxRnwJLm6JijYgGLb7oz/YppxqV609tyi7pQoQqZTSb
	Q2P4A==
X-ME-Sender: <xms:5e1ZajVqVn3GMcN1FSvvC-RGaHMfuSOOkTBu0r8JN7vmgUHNQNtvkg>
    <xme:5e1ZanclFrzhd_tz-WrNZ2An1vxjuvA8A_XWIQPXcF8IuP5MYbyPJ-rFhRXjbW8H6
    vPeq4K6OqKQNPC_aRfNO04VwP3Bur-8zE-lypHkbGvmKvY7CpyDGx_k>
X-ME-Received: <xmr:5e1Zaq7E3r9ZzTEHcERURJSiLZZop8ZKSa6zHaawRQBji6zEXvIS3SweBGcPsdeIzdBgJRTcpOIf5bDvG3A>
X-ME-Proxy-Cause: dmFkZTFS7GW/vS+PGg3aNaRtXNWwH13wr4t6a3PsYvzLEfoa0d1tCLQMk4kuPOyqJxWYg8
    zWRgYifu3Q3qEvL/I6D+A7sONbehMF6Fzv0Jx15W8Bp0zPI2L6EoHnTvsn7KCzlmdcjq5Z
    AMiUX8pm/4UU/5q2rly/ctUYuGrpfv6aggolOMe4+7cw+YQgQv04wJ8otXu77hR4cT4fFc
    rauulgYGXJAH/ttinZ2FdpHwYOQghdgc8wZDZhtrydZHcBfVIkqxRabCZivPsjLLb49//R
    HUixI1q1RTZqMytwufV0grN2inkZxcvjyE8RnYSpDV3z9U1hNPWgMeNXqfzcYN3TNROTO3
    m2XgDeRL8h/bOgSUAAZ2VtgJ4DeG3rEfL6GsQJybJ1AFKI2GRQdxSQSwiVJhthZHSptJyZ
    BQvWLmIrmOq8N6mDQ6gyKaBMsJ9dYxxwlFNCP7T4KFOsjTr2ACESPR4nDDZOxM/whFn9Sn
    3PFxQdr1+3IDjohIXLZlXCKNwqORzJaP3UR18PanRRk+mVXMAr3Xp1TlEhl8ZWSUYbF9QL
    fx89mNcd8gYaO2N2IuBr5sF4dNqVOgM+PCDei2f7An6h1m1UGRA/giV+VV3keAHiujraiP
    syJS/ZjtPZehGqF6eVFNlCw6u2RqORzsz79OKqO65fj3pHM81dE6xK8Mkf0A
X-ME-Proxy: <xmx:5e1ZaiT8aF5AELOpFgjVsvFeUT-JR0fh2Ybhwpd96i8RgPDNSMZk1g>
    <xmx:5e1Zalds16kngpYJKqCARhnOWxv25MO81fZGuIl-rbdQklHAaxO0aQ>
    <xmx:5e1ZaqThnu6vwXbBh8QfntqiFPma7k_0UhkD4PGOIHx853_31p9bdg>
    <xmx:5e1ZamOMWZ0YVAiJb6U2pNzDvvIkLQaFF2PFMqxqkFuWRtJAFxg6tA>
    <xmx:5e1ZanGkvU78fPW8aleH6nnO192MLrq37sxOAz21_KnuC-OOWG3NzcOX>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:54:55 -0400 (EDT)
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
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH 8/9] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Fri, 17 Jul 2026 20:50:46 +1200
Message-ID: <20260717085220.3212274-9-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717085220.3212274-1-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
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

