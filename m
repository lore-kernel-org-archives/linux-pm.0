Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121430;
	b=TZpx9wJvanh24jNwLs579RVs8ZEDNvSymLAy3oKhvNPDDuAKDC/vwK2DLHJpJcwPb7o9
	 +W3QLuvoMGAeWX5ummQuf34BVdBHJYx9SUTLeIOcCFk204rSpgnuoqu7MpaC2LcJZN275
	 hAYpQi1T1qcJaeA+LRv4bJoRraA0rbnBmZQ/44wlugIfKKAXhhVkeGiAUqq/Ed6mIrLYl
	 aEhbhyQ8nXCXcE/XZ8W+5C1VJGwlHvd3+XvnAxZxBysKWlYYNCfYeA9Sixa0JBUigxUfP
	 0hd5Ni9qd7wtPnH8z1a8c+0ydDBe/Ojs5bRRCySfP1Jwn4Gw7uz6o2LY/fgA5ywEkVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121430;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=qX2RKKhWFDWOPzJHyBa4sJ+ncRjkBMqVE/PWIC6LFUE=;
	b=0Z6EAEzB3UYiVVUv8116Ex0A0I3q7DrOVglfAKIer1ri31Aoi+gcL+ed1+e4/ON3LhYK
	 Abtja6fq1TubBGAjZ/3jAi4rmd4vH+nnX/759byB2WP28iXBcAoosmDd0qXA74PAw9Xyn
	 AYVwajFrmt9Xb/oOMHduuuYLKTwY4T/RNPmMyCclsj62+QB1Mh4ze4G57Ba5vApJBKqjT
	 IBDVyVMaIVkw5sMAZApt1msxB2x7JDtt8NFIDHf7opKdT6j6xvuRAK7GTg/yqqVP9bz/n
	 hPQQF4wFpi9mw7UgWXamoOeIKDmF26Zt93qIJ6GuKDrJcY6jxz5Yp5a31DP8rS7EHAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b="Xt7md/BU";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tAZAip87;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645B606A335
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9645B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Xt7md/BU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tAZAip87
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E9937A00F5
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:03:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 08 Nov 2026 02:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121424; x=
	1794207824; bh=qX2RKKhWFDWOPzJHyBa4sJ+ncRjkBMqVE/PWIC6LFUE=; b=X
	t7md/BUwmTquJcbPtxOJ0JE3PmpmebDH8w9Hcc6D24IRBBVVBZ+sW38ok9mOlWg4
	tDMzlSg47uRZN0dDBLv5/ptMVcR8bAsW97vMyfFS+xD7rCCtqYAiNWXMpfpvd7k5
	6jH/W4zDchtCH2IMoTp/bhXBt8/vqBEFQg9JAL8fR5ROsgAkY3dhHDgpHzuKYif5
	zx4jjH9ydioKTGG9NlU4aKKjxlKEBs5SWFm8zh4q0R7okVk/M2bNXIB+/E9C/DdD
	Je0dPUW1D023uYxHO1Cko2uAP3TIHmQwqqzr8eLebHhmF6YOKTyEGAnrGAThE6pL
	wDSqasFNEyOOXW28XE1EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121424; x=1794207824; bh=q
	X2RKKhWFDWOPzJHyBa4sJ+ncRjkBMqVE/PWIC6LFUE=; b=tAZAip87+EDpme+GY
	KTn+YzhmbBWnDvEZQZLcGqBUT12tzVepMnOKDWE2aUAuZDaU7Na5mhYWgVnq5jCe
	nejTiU4bh1t1DpM3TYfpgwwKJOOYqRd6bLs5dHfjCvrJJAz2MugJ/HZqM6OZ5Gfj
	AioN9kkXExlJzDSZiS9o+/XRC4eze/xQDQikbdgviFCTmZYf1cMOrnUcuSYDMVDh
	0cpVgp3HH2s+XfgzSVKryeaFaaRnDqw/w2NkWCj1jErxfIlUnLXZjIfu6FEi+1YF
	B2EgJSzTOu17EoYOSBMvIA7wur880PqhO45ySxil0dCQE3Kxx7+09mvmTTrkcqMm
	hyKhQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121424; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:KzAf5HoDw1SsmQ6koQeFVwpAbpo1BqOdZGtVtqtHGXp2N6b
	HfxKf8AD59ZvcI+Riqy7f+dxj1GfWatuoB4Tg10yKCCS+FCPVuDRbptDdFMn56cm
	zq91bBpLHRQVD7343WmSAXaBDvURXgg3qpK/L1bgXrHAkidqALBDY51dhhBzHfws
	fDW7eS29xwYgMNjCH7hhe3R9KcKkkhTGaVd9pFHRE4qTrUGQr12zF8mQi3h85DJB
	/ELwtXdBWGE/ttaBXQM675LCk4TNhbSaIDpdNCQ3A87agZ/W6VNNfHEiAUNLLs9Q
	W15rzB3EXq29nw3cTsic7p4Jt7FF0K4R65RuyHw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:l2b6HeoWBhislTiOKjIOraUIqchnrpCXJa+BH0AckKQ=:UVXATWgp7xCoyxl3d3NkejESHGlDu+HWrecWvV/X8Ic=;
X-ME-Sender: <xms:0B7wasHjomYN0Sr6YWaaFt-IZz8NY93LhRda3sM0-SnEXVEuYBzdcQ>
    <xme:0B7waheqxGqhKHomw4SVK_DdMi9NGZUfY7bIPLfe0z36ZuLQvak-Ng0c128hNYZvh
    aD1mDQ-7eMNrWlzTXo76jVaYirgZEi7ZKtXH00NGQNQlW-lTB6FcWQ>
X-ME-Received: <xmr:0B7wavYxFqO6aQ2cVgvzL4kTvDk8iqw_suC6Ulc5jdyrR-ywo9l_Xu9ahmLgP_Kvh2Uz-N-K>
X-ME-Proxy-Cause: dmFkZTExmkVnhUU2jNDCiAi9bm+OIvtR9ff5AdoUkJg8UXmNizbE3R/TsaS03sVLmO8Z/x
    O1u7Vo+dpMnoLUKiry2kzASeaRz2bl+KvcJD86RDYkaBSGCX9uUM7qr32xZcEhEHS9e+R0
    ON/U0jKrZA3rTIAuKs02EMZ7AOUsR7J1gtKDPdFCDco36518O/5hsLcNcp1Z6pSa9FhSiK
    IAKjAaK/HVN/fNZPxjgRrf07hCmGwcS9oNfBHi4d3AZE1qXp9PL7fvyh3E2jkpPNRqBJ/O
    4iFuUoSMFlCjvTo/D5TP/+71PsbX1J42D/dEK7Xki02zElvBNRISAWuZB/iS9zljMCsrS1
    qXveIyRieysUHHXsPN2oK9rOTLQ+KbDbgqJIsswTxjAxJNveC0hPMmGSDwJVN/TLLfoeZn
    WCHpkJs/5asC17JsYxRrj9qHPXdx090SdJfXoDypr+Ex206Q9JSlrtbbokW1VbG2Ju4kMn
    kk9tmVYoS7iNodz2YA+MOyci0Osh+PP463c3VC/55YI6BZR322w8g/yU1REoFHxu6FMn1D
    ExIBcn65E9dn6f8LiRH7SQlkoZ2HOTwbmvSTQu6jMg7Z4R6wE1E56n9NWi+cA9ist7/MN+
    P2SpVrctnTr9wonP+EQPwKYw4SLWP2isfWZUYq8NzydwRIXKl5kppjQxgF4w
X-ME-Proxy: <xmx:0B7watKuARjszg37iye7tdtpzkaQ_podLU65BhR_zhvLduBwFAUQPA>
    <xmx:0B7wamgS4FeV6KLgyF8fO22woW0hk6Y7Zvq7PBLPD9qAN2YhJvdnoA>
    <xmx:0B7wahs7s7dxaRsYOvxZJN53JcyE_HE2nG89Ch-ksfdfsV8_RKmZfQ>
    <xmx:0B7waiHvGMde-hg0L_K2eKpkPgJ9bjkQhvgoKDAz19NiBmojOix4Jg>
    <xmx:0B7wavMHzg6MIns5S2f2cFk7AArlpllbnA3WqSVySCidRFhuDJDhypbi>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:03:34 -0500 (EST)
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
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v16 15/16] arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
Date: Sun,  8 Nov 2026 19:59:16 +1300
Message-ID: <20261108065917.135194-16-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the two NPU cores and their two IOMMUs, disabled by default; boards
enable them.

Each core is on its own power domain only: core 0 on PD_NPU0, core 1 on
PD_NPU1. Measured with both cores running, the results are correct, and
the nputop and npu domains above them are powered through the domain
hierarchy.

Label PD_NPU so a board can connect the NPU supply. The IOMMUs use four
clocks.

Also set CLK_RKNN_DSU0 to 594 MHz. Mainline sets neither its rate nor the
NPU voltage. On the ROCK 4D the DSU runs at 786 MHz by default and the
rail boots at 750 mV; with both cores running, each pass of the 5400-row
test has 11 to 25 wrong words. At 594 MHz the test is all correct. In the
vendor OPP table, the 500 MHz and 600 MHz steps both need 725 mV.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 70 +++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 508ed48b7bee..667cbb6ad7b7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1131,7 +1131,7 @@ power: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				power-domain@RK3576_PD_NPU {
+				pd_npu: power-domain@RK3576_PD_NPU {
 					reg = <RK3576_PD_NPU>;
 					#power-domain-cells = <1>;
 					#address-cells = <1>;
@@ -1358,6 +1358,74 @@ power-domain@RK3576_PD_VO1 {
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
+			power-domains = <&power RK3576_PD_NPU0>;
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
+				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "iface", "aclk_cbuf", "hclk_cbuf";
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
+			power-domains = <&power RK3576_PD_NPU1>;
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
+				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "iface", "aclk_cbuf", "hclk_cbuf";
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

