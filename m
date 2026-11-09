Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231309;
	b=2AiKMIbgwAafKwj151HIac2Uq1vQNDrlbq79lC3sGUGSo8Y1ESf/CCXqKiQPrqlXtw7v
	 iIOmgO/67U+1LW9/pfNrjJvyn3cxNUlqlScyxMEGZ80ruHWZI1RfQoQ2VnD2Ptf4Rq5+j
	 8DDeQ1utRwmOhEgzVuvCgw7kQqdZ0V1IiTQ8Sbm0jLkQp4bRcNBKhcwtgOVH3joQDCFih
	 70IBqWQ8BPSLyHqqOCeQnzPo8qky1tJEeW5tEah5XZIrGW5Sw8PMaRT8JSN8y9VfTZNDt
	 PAWChA2VOb8aruvB91ujZvoy31LFBVTLeypGQOzUUnmy1J+KsJwCxT7EpDrHtv94EsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231309;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=5et8XaaCmEn01nOvfNyf5nZqOOXUaaxa5VM6+8a+de0=;
	b=rADImcG8bXRSDwnjc/g6qa/b7R/UdbPLMroya+bWpOkonWhp5TAQMEJ1MW6qRYaLYumg
	 8ieYlCemqVQdpO5yJk2GWn0LnSVwednYOKOlTGZhbG67Mi0rDETYQ0kNm9EAjahUk0AE0
	 V0Uf9ZbHSeCL0u5yrPsuMqWSFwfW39viZPladjJkzrvSH3W6Z/8Z2HssehV8ltRap84Yz
	 07i1rweU2/ypRXZ+6nWNwpdJCqj3/axbTOShYxjvvK242rEVd8iSJvUKQBxnqX1zDLkaH
	 f07u7voeBKw6zvxj7qN+KwjXLjdUsA25S6a1uPsIegiS6Xz+0Kwbdg17bZshds8qEQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KOPMDeia;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C8606A32A;
	Mon,  9 Nov 2026 13:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 221C8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KOPMDeia
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 396ADDDE;
	Mon,  9 Nov 2026 14:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231166;
	bh=ny3UDlwL1HP5bdBzQYWH1FAw8K7SExExRCAMGvyzUd0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KOPMDeiazDv5gMw93ebdE0GxllirtCbSBzGuEhT/jTCE7FQP4nJlpRzL8aKA39RkB
	 16HmNZnylEKHm2CjmO6G0KucFMGUDQBzfMF+CQhtJK2nbooVbgOrUfXzuSy+uCFHqP
	 5MNfIlAdMVhOJnL7Tdg/AtZUmRSxLKv0sYTPoKuY=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:25 +0900
Subject: [PATCH v4 04/13] arm64: renesas: r8a78000: Add VSP[BI] nodes
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-4-1b2072e8c37e@ideasonboard.com>
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
 Paul Elder <paul.elder+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add DT nodes for the VSPB and VSPI IP cores in the R-Car X5H SoC.

Use the SGD1 clock as it is likely to be the clock used for data flow.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

---
Changes in v4:
- change clock from SGD4 to SGD1
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 99 +++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 5caa9ab1c83a93a606c5191b71f5172158b0cc53..6db03112eaf3e37bb2577b286621d6825205cffe 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -1646,6 +1646,105 @@ fcpvb4: fcp@c503c000 {
 			resets = <&mdlc_vio 0x106>;
 		};
 
+		vspi0: vsp@c5080000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc5080000 0 0x8000>;
+			interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_OTHER>;
+			power-domains = <&mdlc_vio 0x07 0xfe>;
+			resets = <&mdlc_vio 0xfe>;
+
+			renesas,fcp = <&fcpvi0>;
+		};
+
+		vspi1: vsp@c5088000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc5088000 0 0x8000>;
+			interrupts = <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_OTHER>;
+			power-domains = <&mdlc_vio 0x07 0xff>;
+			resets = <&mdlc_vio 0xff>;
+
+			renesas,fcp = <&fcpvi1>;
+		};
+
+		vspi2: vsp@c5090000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc5090000 0 0x8000>;
+			interrupts = <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_OTHER>;
+			power-domains = <&mdlc_vio 0x07 0x100>;
+			resets = <&mdlc_vio 0x100>;
+
+			renesas,fcp = <&fcpvi2>;
+		};
+
+		vspi3: vsp@c5098000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc5098000 0 0x8000>;
+			interrupts = <GIC_SPI 646 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_OTHER>;
+			power-domains = <&mdlc_vio 0x07 0x101>;
+			resets = <&mdlc_vio 0x101>;
+
+			renesas,fcp = <&fcpvi3>;
+		};
+
+		vspb0: vsp@c50c0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc50c0000 0 0x8000>;
+			interrupts = <GIC_SPI 618 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_OTHER>;
+			power-domains = <&mdlc_vio 0x07 0xf9>;
+			resets = <&mdlc_vio 0xf9>;
+
+			renesas,fcp = <&fcpvb0>;
+		};
+
+		vspb1: vsp@c50c8000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc50c8000 0 0x8000>;
+			interrupts = <GIC_SPI 619 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_OTHER>;
+			power-domains = <&mdlc_vio 0x07 0xfa>;
+			resets = <&mdlc_vio 0xfa>;
+
+			renesas,fcp = <&fcpvb1>;
+		};
+
+		vspb2: vsp@c50d0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc50d0000 0 0x8000>;
+			interrupts = <GIC_SPI 620 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_OTHER>;
+			power-domains = <&mdlc_vio 0x07 0xfb>;
+			resets = <&mdlc_vio 0xfb>;
+
+			renesas,fcp = <&fcpvb2>;
+		};
+
+		vspb3: vsp@c50d8000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc50d8000 0 0x8000>;
+			interrupts = <GIC_SPI 621 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_OTHER>;
+			power-domains = <&mdlc_vio 0x07 0xfc>;
+			resets = <&mdlc_vio 0xfc>;
+
+			renesas,fcp = <&fcpvb3>;
+		};
+
+		vspb4: vsp@c50e0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc50e0000 0 0x8000>;
+			interrupts = <GIC_SPI 622 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_OTHER>;
+			power-domains = <&mdlc_vio 0x07 0xfd>;
+			resets = <&mdlc_vio 0xfd>;
+
+			renesas,fcp = <&fcpvb4>;
+		};
+
 		mdlc_cmnn: system-controller@ca410000 {
 			compatible = "renesas,r8a78000-mdlc";
 			reg = <0 0xca410000 0 0x1000>;

-- 
2.47.3

