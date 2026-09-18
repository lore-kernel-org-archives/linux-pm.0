Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB851C041;
	Fri, 18 Sep 2026 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751263; cv=none; b=Z+YDAVxA8dzd4qrD+Fsoq4FLoCmvNe1U1L2rBciX64QAYMihzXFVmgom76rsfsJJWdUDjTuQJ7RdplVLOSnEXOAg+lHRh4bxRpnLdTSY6TmDeIGgKtrNG2yxbwNZxZlGn+zDRddkzFEfpCvhCPt3ffUkacHflDDeSy7AQJ1q18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751263; c=relaxed/simple;
	bh=iz05zPGyXWHPp86T+SM6MxX8QkJ7/9AK+9QDpl1Ry0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjJH9BiNmFhlLeFYqOHUy0Sli8G0DmrQ7it8QXKkwamCIGjBeK1LrAvcWEtOS4jdRIbMjEu411sMvlX+Cr9Z6J2SUGJT4HWsDUzCD6Gn9cKrAZb1HgyZV2LsRLTWsjXmZaldX4OUU6Pb6IiJkP/rjLZ0oTpHtjkv+LjGyduZZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=c3meTlHH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="c3meTlHH"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e327:a298:3a5b:4b08])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 204CA4E46;
	Fri, 18 Sep 2026 19:05:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789751157;
	bh=iz05zPGyXWHPp86T+SM6MxX8QkJ7/9AK+9QDpl1Ry0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c3meTlHHZfc28QoJjzJKlYZ2gPyEWifo3GHdDG5sQGE5LxCFkxsoOsxdPWtWM3Mry
	 yIhWlP65QvGxqDqvAjofAXwEuKN4lIxiZgzcfSZBw8eZFFjiEizVFH7TItWEFD+DDE
	 oqyOWa9GXdo9Un5Z7Rg422YeLt4VpJAMklyk09WA=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Sat, 19 Sep 2026 02:07:01 +0900
Subject: [PATCH v2 04/11] arm64: renesas: r8a78000: Add FCPV[BI] nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-4-dbe9236bfd22@ideasonboard.com>
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

Add DT nodes for the FCPVB and FCPVI IP cores in the R-Car X5H SoC.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
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

