Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231304;
	b=zcHY2fcEb2hB4/FF6Q+vDeccBEASpLCMUUDOUCjMKQ55AGmvMG7C2ZAxH+d1ovcNVj+y
	 OJr+jKm1RYmwWLDZ5KfyYHUb3cpmogcGWWuBfNTcLMubx1vh1SKQK1cVNE25G0MxzMoy4
	 xQaEZ0AKNIaJYf9L7SNOurdsOLIDe/9aqhwie+2eHGIgdmex+FTU4vzBwEC7Oq4UhTHxZ
	 J+gWqRTs3DcPI4pGarHD1TZvHQxnQ9z1IItlstiP0q693lBtCaL1+NP0maFGotHPLO+oS
	 ibDwi3oDNam0cyovuQEjE8nqbtw217NjVP/v5o+GckumXnvg0I5a1T4m4efCOyzJwuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231304;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=hCe/A8cdJAI7QPJ8p9H8f0HE8Ku8DlJR6gbdPEV4IsI=;
	b=viIk5VpQfjwnQP1zsEY7cGbUFcKJJYy261laOyLJWC1L+Di2n5yJ8Us1KiofOWfJJeEE
	 Z1uKi+R6rpnjGxXFGp6aoPhZ6OJnb+Q4srDSG3CdfQW94nSgG619JuMGjvmny9wb6HAM2
	 61tzZFNo46505V45cjodXNWl9AfMo1OcB9v708o65liYaX6Q0D/Vt16xTw4J8mc5H2nBS
	 egXLhDkDhldlRLUKYwS2B+CKXMlepnZc8bsjLhFQXoOxi1i1osg7DH6fBo4qZaDVnkh8x
	 /yUrHvYNthtaCld1bcLJfx2FX6rgHLDnOLXPVP9yvC127p2cJNs7WtVK+YB6updYlXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=JxeAtP7l;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93996606A321;
	Mon,  9 Nov 2026 13:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93996606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=JxeAtP7l
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 77614219;
	Mon,  9 Nov 2026 14:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231160;
	bh=+X9BMUD8lEUAc0B8hU94hilYEZXy69J3s41ldMUC+fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JxeAtP7l/jl0BL0HPFA3junTJIwmjDXJBJ/LvaHaoO6mdBuSpc4NaRntXtYq97t4c
	 TP//N1hxnagqLEOSYIFtPE0skS7xhdgTuYvn0jyTn6dNYoo2+UCTM8dRITDeMYGx89
	 UBOsFDcP9UGtrAnTOM40DyP7jcf4Z8tu+P5QrRI8=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:24 +0900
Subject: [PATCH v4 03/13] arm64: renesas: r8a78000: Add FCPV[BI] nodes
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
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-3-1b2072e8c37e@ideasonboard.com>
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

Add DT nodes for the FCPVB and FCPVI IP cores in the R-Car X5H SoC.

Use the SGD1 clock as it is likely to be the clock used for data flow.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

---
Changes in v4:
- change clock from SGD4 to SGD1
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 72 +++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 437e49c58ff299a05411eb3aa50a0bb0d7fdda98..5caa9ab1c83a93a606c5191b71f5172158b0cc53 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -1574,6 +1574,78 @@ mdlc_aon: system-controller@c1338000 {
 			bootph-all;
 		};
 
+		fcpvi0: fcp@c5030000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5030000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x107>;
+			resets = <&mdlc_vio 0x107>;
+		};
+
+		fcpvi1: fcp@c5031000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5031000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x108>;
+			resets = <&mdlc_vio 0x108>;
+		};
+
+		fcpvi2: fcp@c5032000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5032000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x109>;
+			resets = <&mdlc_vio 0x109>;
+		};
+
+		fcpvi3: fcp@c5033000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5033000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x10a>;
+			resets = <&mdlc_vio 0x10a>;
+		};
+
+		fcpvb0: fcp@c5038000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5038000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x102>;
+			resets = <&mdlc_vio 0x102>;
+		};
+
+		fcpvb1: fcp@c5039000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5039000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x103>;
+			resets = <&mdlc_vio 0x103>;
+		};
+
+		fcpvb2: fcp@c503a000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc503a000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x104>;
+			resets = <&mdlc_vio 0x104>;
+		};
+
+		fcpvb3: fcp@c503b000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc503b000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x105>;
+			resets = <&mdlc_vio 0x105>;
+		};
+
+		fcpvb4: fcp@c503c000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc503c000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD1_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x106>;
+			resets = <&mdlc_vio 0x106>;
+		};
+
 		mdlc_cmnn: system-controller@ca410000 {
 			compatible = "renesas,r8a78000-mdlc";
 			reg = <0 0xca410000 0 0x1000>;

-- 
2.47.3

