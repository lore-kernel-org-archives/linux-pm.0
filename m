Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C454DE725;
	Thu, 17 Sep 2026 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646751; cv=none; b=gEKX/iDZU/W77R3vbcKJ/PWwr7FHL/zeSaomgRwGxz8wf8vqurxE9u13IA5ZGIXlI0uu37ceoJ1FOYC6VWKSOULZwUqHTR5eAe/qTf4viykn5r6XK18nNbswyTLsZjC/nZ014hiZ88icDrLDWK7WUTKQfQvDc2MATR32Qo03oTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646751; c=relaxed/simple;
	bh=/xeWOj5dek4jxrDyjHT7DXjxtpoopoHHuxPIY9Z+o9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nggoSNzfWKkUA+0+kC0cI+BflSinmtdviwtzB1/Uyw9q0/nBDpjhjRudUFwMMVyITxG6Q4taQbfhpHKw03/NYaUZR82YNIIZrcJalv34C42fconB2SXh9KOm9qpuISXwzEpGdB+mgr65iZI4Lb0mEK6Tll0fjdSVEkeREe4gzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=l+uslcCv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="l+uslcCv"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:a4f1:7e05:2192:a835])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 21691C51;
	Thu, 17 Sep 2026 14:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789646623;
	bh=/xeWOj5dek4jxrDyjHT7DXjxtpoopoHHuxPIY9Z+o9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l+uslcCv929hnUUwuIMdX1Wy7j75b0SH1bFyUAnEMOkDWpLJZVNFr10TT7Ea2d3Rn
	 zLCwfzF+k3gPOwnfzJ7l3vzvd7moV1eDU4i2MrRH5CNopI0tNV/5V72VcJM0iw5OBc
	 lExkev5IhD6JsVd4zBC5wTLoH3XCkPM34y7J6ODI=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 17 Sep 2026 21:04:43 +0900
Subject: [PATCH 04/10] arm64: renesas: r8a78000: Add FCPV[BI] nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-4-4c72d4e086dd@ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
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

Add DT nodes for the FCPVB and FCPVI IP cores in the R-Car X5H Soc.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 72 +++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 9a07753b221541ed49a975e0c95f2f5d1fdc6ac2..2f8886f8b6545026397fd83969882f8c62afa9d3 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -1000,6 +1000,78 @@ mdlc_aon: system-controller@c1338000 {
 			bootph-all;
 		};
 
+		fcpvi0: fcp@c5030000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5030000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x107>;
+			resets = <&mdlc_vio 0x107>;
+		};
+
+		fcpvi1: fcp@c5031000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5031000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x108>;
+			resets = <&mdlc_vio 0x108>;
+		};
+
+		fcpvi2: fcp@c5032000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5032000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x109>;
+			resets = <&mdlc_vio 0x109>;
+		};
+
+		fcpvi3: fcp@c5033000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5033000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x10a>;
+			resets = <&mdlc_vio 0x10a>;
+		};
+
+		fcpvb0: fcp@c5038000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5038000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x102>;
+			resets = <&mdlc_vio 0x102>;
+		};
+
+		fcpvb1: fcp@c5039000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc5039000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x103>;
+			resets = <&mdlc_vio 0x103>;
+		};
+
+		fcpvb2: fcp@c503a000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc503a000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x104>;
+			resets = <&mdlc_vio 0x104>;
+		};
+
+		fcpvb3: fcp@c503b000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc503b000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x105>;
+			resets = <&mdlc_vio 0x105>;
+		};
+
+		fcpvb4: fcp@c503c000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xc503c000 0 0x1000>;
+			clocks = <&cpg R8A78000_CPG_SGD4_VIO_DP_TX>;
+			power-domains = <&mdlc_vio 0x07 0x106>;
+			resets = <&mdlc_vio 0x106>;
+		};
+
 		mdlc_cmnn: system-controller@ca410000 {
 			compatible = "renesas,r8a78000-mdlc";
 			reg = <0 0xca410000 0 0x1000>;

-- 
2.47.3

