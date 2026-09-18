Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6D519926;
	Fri, 18 Sep 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751269; cv=none; b=CaJ6lspBTb/+DoDNt/KlayOyWyeV5oYqaCDmxNpZr3ijdb6XW0JaP2q3VaeGQt2kizNb1NlIQo04yYovEU9ppu7Zts7yBXQcLXRkORxJVpD2djmY0IGIWQBa0KlhSNqy4GpZ/dJtYgDrpBM28aAtDHlK9xsai9gR9xiqQwLojT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751269; c=relaxed/simple;
	bh=zAxf9n1/z0ffLFIX6ivNQZNwiLU7JZaR3J3ouxyiVPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NG9YIflzr281wE1pKedSpxfPZmqB9+PVuVPWsoDOi/twIfWSxRGmIOhd9esPNWuQwtXyE3MCL9LeuAquZoekZp8vRBXbEp2JYxf95xs7/Q5W6R5rExdGqfsOAF5D91QQ4KJ3FGdlisQHptWCqRkJqQYrGjOH6zvfC8K8baMqvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QNbzIFBm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QNbzIFBm"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e327:a298:3a5b:4b08])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C74B9417F;
	Fri, 18 Sep 2026 19:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789751162;
	bh=zAxf9n1/z0ffLFIX6ivNQZNwiLU7JZaR3J3ouxyiVPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QNbzIFBmMRk9J+AktkGFB5DuO3ql7hNm4vX3BsazIIATuEMbUDt7Cq/jZoQsNyUlF
	 5O4+jH8WJcFRO8xL7ARaLOftzWM5yUThLPInpl09fmGXzBt0673nXkyXk0ZibmwCiR
	 71ca+gpEPn7CYOqtU+Wtfr2y9OfTC058cUEC/0Y4=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Sat, 19 Sep 2026 02:07:02 +0900
Subject: [PATCH v2 05/11] arm64: renesas: r8a78000: Add VSP[BI] nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-5-dbe9236bfd22@ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
In-Reply-To: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
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

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 99 +++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 2f8886f8b6545026397fd83969882f8c62afa9d3..f90b869579d384e3fc13d0a13625b7cddaac2868 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -1072,6 +1072,105 @@ fcpvb4: fcp@c503c000 {
 			resets = <&mdlc_vio 0x106>;
 		};
 
+		vspi0: vsp@c5080000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xc5080000 0 0x8000>;
+			interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
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
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_OTHER>;
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

