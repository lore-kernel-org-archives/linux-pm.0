Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2A4BD373;
	Thu, 15 Oct 2026 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050758; cv=none; b=SKqfO0Kb3943f34rgnAvZwMqJIqOq5jGcpYEqaEgYuJ39pSwUaAyAds9emXVqHnNaB9lepZWGUz9Nk7NGkzHRMJ3HwRwhuR3zZ2z5Ztm2zbOBWdNZdfwJYIHcGR1kQq4o0/6UwwtHfcywXjEiXAmQvdJClVFeOHNh/6w2juTYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050758; c=relaxed/simple;
	bh=jDBKVPY8p5IeUxs3LlwQOa+arahHhO70C4qM/zl89K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXyEAHb+iUTIj6RXAHf6GuLJdQdkTjlGiSn1QKY3Rt51CApgdb/KJIkmyaD1jgV9DWIVxkuD7fIfj4GECw+X5oS/GwY14061pLzhEsJ7LWGBc6HhQ1O46GMwfInjBTp1/K6LCSvDv36GXIcPn2XqB89qAhmNC2jjoDP/00X9FA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oKmPaUtH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oKmPaUtH"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 346422F8;
	Thu, 15 Oct 2026 09:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050625;
	bh=jDBKVPY8p5IeUxs3LlwQOa+arahHhO70C4qM/zl89K4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oKmPaUtHrdFVhgLQ7m+M6MZ+gjAdVlNHBjjv4NK0r+Wmq8thuIjhDmfgJ/5836+mC
	 HI5GZN3D4ceQVAfT1tlLjDrLgiEIU0DOXvyBvCkvQnX6dCznzN2wGU/ER+juXxzCIt
	 8VHlxk+IzpKde8l+TdvhZiQwBz8QsbM6xrvdy3sI=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:46 +0900
Subject: [PATCH DNI v3 06/15] arm64: renesas: r8a78000: Add FCPVD and VSPD
 nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-6-e052903a3832@ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
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

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

---
Changes in v3:
- Fix the mapping between VSPD and FCPVD nodes so that they all work
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 190 ++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index f90b869579d384e3fc13d0a13625b7cddaac2868..1fa4896739110de1e445bfcd631d4937bda40714 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -1000,6 +1000,196 @@ mdlc_aon: system-controller@c1338000 {
 			bootph-all;
 		};
 
+		fcpvd0: fcp@c5010000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5010000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x7e>;
+			resets = <&mdlc_vio 0x7e>;
+		};
+
+		fcpvd1: fcp@c5011000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5011000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x7f>;
+			resets = <&mdlc_vio 0x7f>;
+		};
+
+		fcpvd2: fcp@c5012000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5012000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x80>;
+			resets = <&mdlc_vio 0x80>;
+		};
+
+		fcpvd3: fcp@c5013000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5013000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x81>;
+			resets = <&mdlc_vio 0x81>;
+		};
+
+		fcpvd4: fcp@c5014000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5014000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x82>;
+			resets = <&mdlc_vio 0x82>;
+		};
+
+		fcpvd5: fcp@c5015000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5015000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x83>;
+			resets = <&mdlc_vio 0x83>;
+		};
+
+		fcpvd6: fcp@c5016000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5016000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x84>;
+			resets = <&mdlc_vio 0x84>;
+		};
+
+		fcpvd7: fcp@c5017000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5017000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x85>;
+			resets = <&mdlc_vio 0x85>;
+		};
+
+		fcpvd8: fcp@c5018000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5018000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x86>;
+			resets = <&mdlc_vio 0x86>;
+		};
+
+		fcpvd9: fcp@c5019000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5019000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x87>;
+			resets = <&mdlc_vio 0x87>;
+		};
+
+		vspd0: vsp@c4800000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc4800000 0 0x8000>;
+			interrupts = <GIC_SPI 623 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
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

