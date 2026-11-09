Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231315;
	b=lu6hxkwCIGXPsUfNvpIUGQhcVUe9BlvKVxB2dnY7jCCwmBMqT5RKvoCV2VrxbxPL9pco
	 WkDUzQkaGXjYYPap3U/7RsWzqgap3gLnV+Ag+n09Do+VpWd43Ulb//ZAr9FI8Cqej6MuD
	 ENPbPb3FVF9R+tDXzo2lMJ2GvkpQ+mm5hBvSLnfwY17/GLlkYFU3xQCecXP+rjnqgqQaM
	 XRjAJ8LFR13i8Z9J4ICaoHk69doZOQr+/4kLR5nlMDaXc60Ph+H1kPEEDvBd7K62bcozc
	 exI3HeQ1ynrHV0GVo7sEQCR6XukMzYDFHxodY4mFp2nboudG4LTSN2dNyBv48AMRMmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231315;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=2DXaXUXr9Cvv5QW4bh6I6vGYCwASfYNKI5SmhtXEL9E=;
	b=WjLH7poIqio9HeJqw5UfuxfsPzx3uqnqOiwSjW4Y63fvDYi7Ku8YReLJHlm+000Jwe8w
	 nVbV2kU62T5DJdYlJM+sRjdBqfetxHl5smSKRwoNqkzkBANfIjz0uTJigPM8+6jtC2HJ3
	 oj8+FSY9igyeTrExsJXYi57RG7FFtsGxwvDsWXq7VuR3q4OHv3MhoUsm/43jc8J0MG0VX
	 GLEc3KLq/zHdkgWiyEZB1UsnxakBimMy1ImZRr+kiVsQaR2Sg/DaEbEGq1K1D3VnRFL5A
	 ioPHWWjx/SLVdPaSacPIb361Jz8gFA6D+A8qxBiSBsWLol+zRpw42b1oiuT1qvsOezQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=YLWEsYj7;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04701606A330;
	Mon,  9 Nov 2026 13:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04701606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=YLWEsYj7
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F2C19219;
	Mon,  9 Nov 2026 14:32:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231172;
	bh=A6hRbZgPzJhYSztAkYNx6lcxOFsh+THGJxLiUkEwyg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YLWEsYj7l/iUWI8NF7YkZgvO/kXOiwl39G/xiIKepOL2oPxlPV+lbkjm0cyCKt5HK
	 qUYcEzzQ3fsSNTdeeW3y/DNT4DPOR53fW+l8uJyYdZJKocu419nizkhq5kfC5t9j6j
	 cM/A96u3XhYBly5aToRcVA3w35hf0IMFGlbSu+BY=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:26 +0900
Subject: [PATCH v4 05/13] arm64: renesas: r8a78000: Add FCPVD and VSPD
 nodes
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
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-5-1b2072e8c37e@ideasonboard.com>
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

Add DT nodes for the FCPVD and VSPD IP cores in the R-Car X5H SoC.

Use the SGD1 clock as it is likely to be the clock used for data flow.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

---
Changes in v4:
- change clock from SGD4 to SGD1

Changes in v3:
- Fix the mapping between VSPD and FCPVD nodes so that they all work
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 190 ++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 6db03112eaf3e37bb2577b286621d6825205cffe..d62a3500790e2cbae1f9760b0eaf628e9678b355 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -1574,6 +1574,196 @@ mdlc_aon: system-controller@c1338000 {
 			bootph-all;
 		};
 
+		fcpvd0: fcp@c5010000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5010000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x7e>;
+			resets = <&mdlc_vio 0x7e>;
+		};
+
+		fcpvd1: fcp@c5011000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5011000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x7f>;
+			resets = <&mdlc_vio 0x7f>;
+		};
+
+		fcpvd2: fcp@c5012000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5012000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x80>;
+			resets = <&mdlc_vio 0x80>;
+		};
+
+		fcpvd3: fcp@c5013000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5013000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x81>;
+			resets = <&mdlc_vio 0x81>;
+		};
+
+		fcpvd4: fcp@c5014000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5014000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x82>;
+			resets = <&mdlc_vio 0x82>;
+		};
+
+		fcpvd5: fcp@c5015000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5015000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x83>;
+			resets = <&mdlc_vio 0x83>;
+		};
+
+		fcpvd6: fcp@c5016000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5016000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x84>;
+			resets = <&mdlc_vio 0x84>;
+		};
+
+		fcpvd7: fcp@c5017000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5017000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x85>;
+			resets = <&mdlc_vio 0x85>;
+		};
+
+		fcpvd8: fcp@c5018000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5018000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x86>;
+			resets = <&mdlc_vio 0x86>;
+		};
+
+		fcpvd9: fcp@c5019000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5019000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x87>;
+			resets = <&mdlc_vio 0x87>;
+		};
+
+		vspd0: vsp@c4800000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4800000 0 0x8000>;
+			interrupts = <GIC_SPI 623 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x70>;
+			resets = <&mdlc_vio 0x70>;
+
+			renesas,fcp = <&fcpvd0>;
+		};
+
+		vspd1: vsp@c4808000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4808000 0 0x8000>;
+			interrupts = <GIC_SPI 624 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x71>;
+			resets = <&mdlc_vio 0x71>;
+
+			renesas,fcp = <&fcpvd1>;
+		};
+
+		vspd2: vsp@c4810000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4810000 0 0x8000>;
+			interrupts = <GIC_SPI 625 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x72>;
+			resets = <&mdlc_vio 0x72>;
+
+			renesas,fcp = <&fcpvd4>;
+		};
+
+		vspd3: vsp@c4818000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4818000 0 0x8000>;
+			interrupts = <GIC_SPI 626 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x73>;
+			resets = <&mdlc_vio 0x73>;
+
+			renesas,fcp = <&fcpvd5>;
+		};
+
+		vspd4: vsp@c4820000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4820000 0 0x8000>;
+			interrupts = <GIC_SPI 627 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x74>;
+			resets = <&mdlc_vio 0x74>;
+
+			renesas,fcp = <&fcpvd8>;
+		};
+
+		vspdb0: vsp@c4828000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4828000 0 0x8000>;
+			interrupts = <GIC_SPI 628 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x75>;
+			resets = <&mdlc_vio 0x75>;
+
+			renesas,fcp = <&fcpvd2>;
+		};
+
+		vspdb1: vsp@c4830000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4830000 0 0x8000>;
+			interrupts = <GIC_SPI 629 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x76>;
+			resets = <&mdlc_vio 0x76>;
+
+			renesas,fcp = <&fcpvd3>;
+		};
+
+		vspdb2: vsp@c4838000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4838000 0 0x8000>;
+			interrupts = <GIC_SPI 630 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x77>;
+			resets = <&mdlc_vio 0x77>;
+
+			renesas,fcp = <&fcpvd6>;
+		};
+
+		vspdb3: vsp@c4840000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4840000 0 0x8000>;
+			interrupts = <GIC_SPI 631 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x78>;
+			resets = <&mdlc_vio 0x78>;
+
+			renesas,fcp = <&fcpvd7>;
+		};
+
+		vspdb4: vsp@c4848000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4848000 0 0x8000>;
+			interrupts = <GIC_SPI 632 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x79>;
+			resets = <&mdlc_vio 0x79>;
+
+			renesas,fcp = <&fcpvd9>;
+		};
+
 		fcpvi0: fcp@c5030000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xc5030000 0 0x1000>;

-- 
2.47.3

