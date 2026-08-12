Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED04411689;
	Wed, 12 Aug 2026 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527784; cv=none; b=UFElZ7ietEF4Ttu0ArnWPwtsfSoQSlSxISR0RFUAX/aIfbnCiLnt98K9ZBEdoU7q8LAIwYYL5ARQrqljXjQW5IqiPQ6H6is8lPxLyOrg2CKAiQze4n4sQhqTAvzl04RROB5Otgq6gXXz30MWvWL4ukMWvulnB11CxLZ8Hxm5ZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527784; c=relaxed/simple;
	bh=bRfSreLpjR5f/JeBfk/8tUDRhux1Y3bOx/ZKnvAmEko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvhCBrGHGMtThojkVzPvVA5q5w0hg8QMPFwcTnIxtHdZspEWzCCRzHnIWTr0js16BKk/YIySRikBRtENeWywEmNGGaLafa/7eNAE1cb8IIPaCWvxESf+Rm5OwWPHRp9nIMwH31TMAkgClqoVE3vo0q+HhEIPZ3/scZ1mnuRH9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=e258z2J6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AnlZ/5+J; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="e258z2J6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AnlZ/5+J"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id B0E901300277;
	Wed, 12 Aug 2026 05:43:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 05:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786527781; x=
	1786531381; bh=MCdVFBzoMQYqXVrZeC1sFHbOAswgeJFeoPQ04J47ZjA=; b=e
	258z2J6AqsmCHjc1Dop95DilQy+XR+UoPr6XkrxtyBAhLeRquhr/RZn/Y03YXF2l
	T8axbpVHu/fOyUW1IpGKZqTG2KFLQKDT23P7zQjHSCinkkpZnHa2hBRSWuPK/6gY
	eO9I0E9W50h/pf4blluCNOAtWQOlDS0FbYiU/tfP5wHUJEf2IU9Ds/SAB4LEVjsN
	4j2VeH78jTT0YXMFcF5yE5ebZZQAekM8QP/oLQ2S6hmJAcsJJh3dasZNVwuIriUs
	PTZVIBSVxu+19fv5xt9PMlQg01ukYa+zTh1qhrcyibzNQtw/xhRb7Gc4R8yU9vBO
	5zmzofluHnHVqK8++r55Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786527781; x=1786531381; bh=M
	CdVFBzoMQYqXVrZeC1sFHbOAswgeJFeoPQ04J47ZjA=; b=AnlZ/5+JyDNbx5gsz
	8oOESIQmWoetQRbPAPGauZPPjt6ik6GnPKWKbhT9HHCsD/rsfb6px2MmQjO104I7
	1GfDRwoepmIEaCOb/A+KmTPGYqOcFyAGJr3yz+zTC85VT9qxRNxWF9u+cbHsDZPN
	DehSVYAUfG8x+qVYZWQQL2X311uFu3BZcB6BuhvtXpKyQM4TIU7WzQBJqP0XBCbH
	hyFzDOKLHHvPxcrshGAVv3lorLvI5tyU539XhZ3pUJIDYc8BJLFjOKlS7sAaDXCl
	FBgzaOsiWIwgcFDaHGHtlqkFdo0saAkep/6PXCXsKmZ7TYp/gNLtMCdTfWTPKc+8
	8zaEA==
X-ME-Sender: <xms:JUB8atManVFIjjFDoFGWFtWXDxmu7JcTD6oJGvs27Ag0QziUuSoiCg>
    <xme:JUB8asEsJPMqvSvsulvGrkp1ym0ZWolk5WMgg_nw41NBQ2B0wZkaTaOHUu18eDfHY
    BuLre7GmPzRUYuHE1pvnK9Et6IqILGxMItV-R3HJ86x6PM7le687wY>
X-ME-Received: <xmr:JUB8aoHA0s6XJi1lEeVpToPDKHfjfUYSwZKEdBrvetsm6IkV0NEPuRVHsXZhS-VQhwr0nZbVaQ>
X-ME-Proxy-Cause: dmFkZTFYxnYK7Q2ECfgrFvZDLHupbKEwB0KzlHGkD4bVUz8dV5bJotNng9zomczRjzyJrI
    2Q0jwEuwUiPlDx6uthfnpWWjS0LZR7uLVOiJJSjrc/rCnI4umf2nP077Aj0HFKuzFXdOO9
    iq/wRRLw1AF2WoSq7ZjbeFNHtxmGwjkgBk+d3ju3t10sSZ6mkdvh7svM+pGmjmXD7Qap7H
    CKqt28oxZvPxroO59AJgRLBVwmC+DUtNsXlIXcAYiH7rBLa9NJaOJ2Tla671rl3Pan2a9T
    5ig8QAlu2Li8SgD2rvFRiw2W5Ipr4nP3B3+Pt6WTk56AnufdQ9sOFRYCMXpvD3CSt+86Vi
    cucoLZp2tMxa6t4wewhn3F/ApVFFprxiAPtH9eOK3mEK5JtKHmxfecIWsUaiXQqkFX7sFo
    NSdoUq+vhZWnFxTnwJWFWN9uB+SYxqL31tgJSazDiv8cTYc6Bz5TRi0U+ix72SEwuwTNUi
    dEHT0kPMg/6JAnvYRp8rLBTxL5wvNqD2Nkfl3lVCFGnOSGT0HO9HvwfUpkOHHmYtRS0Oqi
    LnpiYPzBP0A6xAeW7FCT3DABV8xWiqyee6Ih2mNp0GnPaG/r/C3Ph70yv6hqWhoc4jttHF
    fvAtxhuDvVOlT+8sqYli5u+anExVstOH9jPLIo4opw5k3ZHwiLC/5zT0abgA
X-ME-Proxy: <xmx:JUB8ajB4-FD146wbXjLr7dL7EWv3zcvpWZ6AYZ0VrwoC0XFOzSTdsQ>
    <xmx:JUB8aln9BB8Hs7VqfV_yjkS742Ia0YH_fUa-bfMFE3WS8THDwYKlMA>
    <xmx:JUB8ap7KOMa9AcMyx5ekd0fj0RKv6ryQe7_ceVWnCytZmrQkVNeyOQ>
    <xmx:JUB8akuWTD46oxF2pHE3gLmVi94fL9IxBGFqVtP34h3-Kg7mGVNNLw>
    <xmx:JUB8atT3I9vJiecM4xDf1mzl5SJ7wLwkGXO0Y6fcoXdAsfoT6BrLmkYu>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:42:54 -0400 (EDT)
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
Subject: [PATCH v7 09/10] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Wed, 12 Aug 2026 21:41:04 +1200
Message-ID: <20260812094106.1391698-10-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812094106.1391698-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
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

