Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243133624CC;
	Mon,  3 Aug 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750155; cv=none; b=R0447TzDkSj2a5yaAZ/jFgwTH93J6TH4r8yp8L4IUZTsQ72+3SFCPa3KAd+AS3N0UfH8il3HEldylD7tnjY/OZAviM0raCq4DT3NBz7KRZvbK1PTqoeeszYflsqVIgE/u67QX4XfkhVmghsu/ZqGONVumo574Y3b5g58MDlvIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750155; c=relaxed/simple;
	bh=ACaeFjiN0jCqm+CXZImxFFz7/+DH3rnisQ7ow9ZHfus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNLAyq3I/zDewiLJutiNT13Gf0sFcmzc2tHeoIz5HDz5TCFoFP7pQkW5RrzYNphmjL/VuXPMpYuxmNlpW2JFCa8l/rRUi+RP90I5OzqzKJRRK+9hLvSjg/Jpf2FpkxGJPa4f5gwFhJFY0k+CPXW+whHdIwE4YCx+cqAYrDRo/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=HhuS5De7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=msoteRdq; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="HhuS5De7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="msoteRdq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 754A8138007E;
	Mon,  3 Aug 2026 05:42:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 03 Aug 2026 05:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785750153; x=
	1785753753; bh=9rVvREo+IB67dNS/dnT90XlXCvimHsqUqxQVruTv8JE=; b=H
	huS5De7FZbPOkFmo9U/WW3xpEbgKCI2B4f8hpVqlAUPzzM9IrPtmOVzAcgvdqCSd
	fg2fOzJKXnTNjGH4nkMeaMTlhD3Gf96Fohmr2ersboNXjVFQJm1sp/PaZjgQZykA
	APWvjw1BYM4jynlgV9Qxh68E2hERkTCS60wQTozOR4m+UMGDqy9R1dA/Z3/MCJvz
	m8/DFrP24wQ9G7lWlWZX+ULLqc49aU8nx5k3Ifn5P3BLdzgzHnYrZ/02F/vmHR3C
	uN/cDJcswbHxFEG5n7qCM55WIeMWIs698Y67rIQcGZsU7hqFwcZj9KthHB5fLLTv
	9QDn7q5kuIhzNy01e/DWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785750153; x=1785753753; bh=9
	rVvREo+IB67dNS/dnT90XlXCvimHsqUqxQVruTv8JE=; b=msoteRdqPk1A0yEQA
	x2lIhsUZ4fTbJNT5eiiL+/L50WWvlo2oEutV6cxpCY8XsYwJtCdnK9STTNOGywnF
	JRCqsw47Zo3NSr4LHZ5EBf/Sj5Uk960Bou16FvXIZtsYtMawB6HtvA/oPFLMMGNA
	lcVgdeYwYcjAc0ozttxxoKEhRZkvDTfDhfqKfsRkiGdcQCe4L+ERApm312jx/rsm
	BOL+E/k1WokKqEjHlZw84mCMNvC/1j4v0GAnF/DQf6WuLhzTwb4oP5AzJTlJ6sNg
	vcjsdQaz+b2zuY4MMKFqMkjLJjE1WxPla94/Gv65xbiH0oCY2oFIXe1s80FB2T3+
	/FnJA==
X-ME-Sender: <xms:iWJwalExaaqVBL3VRpRUOq3iebapW_ftYW9ipID8VM595gLGK6nKhg>
    <xme:iWJwagznjs8eJD6kZn6hiRCqdB2rQqLDV7OvZDx9vMM4eN6aT0pFogC83As0brvRp
    0BQeYBJoFRXYW-tZJ4bm1z6dRXQrl_l43HRFeCO48U2hDw-HeJfOw>
X-ME-Received: <xmr:iWJwakrci_SkU0F5Fy0_oRJcJLlRK0N5rQJrqaz5rBaX0IrSmH2MvI58KBVA4hWUx5rVpZU6QQ>
X-ME-Proxy-Cause: dmFkZTFjY2LyPb/9LfXn4QCibSWxeeRWJF58tfvFoO1JpUYwl/f8fQT4gNNHDkwtzTG3mW
    QB9Z5E2ZaiRLdwTk7Bf1cP6j2q2LuyYXAyG5SuQy6DwnGU1S0GzExnzN4TJrhwhfA2voA2
    n2K0qQ7ZhvGfjI6tOvBvuW8sUUpow6OyrJ4H8Jm+8CF5bCgHVQ4I3VQwTEXeIHlOg0F+vh
    Iqy32CoHpA615dyPNJOIbTr8Kos0tW88p1VITCDcWhI1Pkk+5LOtOBwFm8TmwIOzW5PsEo
    tPufk9ICYRNR6HPn77DziTnrKAnrLZzqwRBloqTdNsqFLZVnL8NzKJLgMxCkSg4QeWk1Rk
    RIl/iYbPSYuTRJxSFAIrPdbVVPR8cNfSzoS7TJnonXo/16AFb+lZFwipDpvnqc2iWQDci5
    FjMVbyLZJtHSYXxs18rLpcUDnVlW9lH76TprAAMoeYrAcjdZUpWn4Z3eSxDf1eBThNADcz
    qgZEDwscRKQM4uChRR724/vYUEWhEiF4gTCNDGd5UWZlOwvDnskcDGCvAP2lEXwF0lFzk2
    fLi5rFKYyKijZk8Y3zOFpFiNPgub5txjlY/+TFX/Hng4xOmlB6KmQ+YvERcTA10DMOiMqo
    VRWUJLPDlHLfphUyFwkP0MU82vZ/qZLVfGc8BAs7EuOWi5uLvgW6uAxFbwJg
X-ME-Proxy: <xmx:iWJwajdVaYbMSP5H8xMEqiXjGz2bKtvv1yJ9ufP_m42mnR1-KNEq6Q>
    <xmx:iWJwaqhj7ru2nDxsTOSACkiF-GJpnEQKSAsDM6hbFOTuLdfMvdL64A>
    <xmx:iWJwahJjGFxqICxXnkwlqPo37Nl2TZxvSMAbb_pHpzvuxxCp7m7EFw>
    <xmx:iWJwanoCuLpMobJdhATE0mdwxR7kvR0-1fvIEGYm2ntkiumh4LhraA>
    <xmx:iWJwamet7NQvaGhGeUXDk4iJ4jnGT-rhZxvFG7KRpDcppcGqfoVeme3x>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:42:25 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org
Cc: royalnet026@gmail.com,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	krzk@kernel.org,
	will@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v4 5/6] arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
Date: Mon,  3 Aug 2026 21:41:24 +1200
Message-ID: <20260803094125.3285895-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803094125.3285895-1-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
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
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 76 +++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index b0c0d3c8b..6baed2579 100644
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
@@ -1832,6 +1840,70 @@ qos_npu_m1ro: qos@27f22100 {
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

