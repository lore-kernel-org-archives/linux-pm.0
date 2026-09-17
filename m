Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160053CA8B;
	Thu, 17 Sep 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652977; cv=none; b=MBi1HlrTPXXBHDqpalAGhlXdrEkYhB/Wqfwg9ff3rnVxkoIwA/i/fKLeG7q1Mb6UaON6nY/o87JSNG4kaak3S9CkPsXQAKInUpa+z1QOU99jfHy93VcCueFQyBAHygbdbPVZK8B0gOunC0BgBemxUxn1dhyVV7bbgimDOhO01Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652977; c=relaxed/simple;
	bh=kl8wn/r9EG1O9VsRBp0nZH0IjzQxh/DjmWyxpmzatK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8zK0lq7gFcHSr57s8lkmNp/ien3eJE8w/XIUK7SLrHqS1RmI6GVSMJRfSh22qaFMGBtob+H750Air3rcLCGSzZ47/UEdJpI5YMqiCZ3QQR0+sMspuWfmcSMDPehlOEdWX/M6AvtK+eDhxUUF7Kc6yWiiG6NbgRd3xi7Uyx7yAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IFnGPYjz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IFnGPYjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789652962;
	bh=kl8wn/r9EG1O9VsRBp0nZH0IjzQxh/DjmWyxpmzatK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IFnGPYjzhwfVNR8xr27wbsJgzCD9gWNDrYSbR/o0h6zoQKvVqhBdOLarLRSVLKGZ6
	 Z8IlpSi/KxNQFF0aJyYRF8xZuB/BccVQX6ma6tXN67wEtC06r0wMMoIX624kQ5qoPi
	 28HhpaDpqGObwUp6pfc3B21ZtRiVmw9DE9CJ3sMwpRaLUlaAAZ0DOADumsFa2KJlt2
	 0RvXJOkO1RB3bjXrPYVzCyM78yvSZwuXZyTOpRagM/gyU9KVUzk9IA45VUZuZ3ekYA
	 hBz6CwH7V+982fR6tGHeLuXTS0/SpXTFvF+IANH74bA4hVsz/yOuaCuaxYSmA9cKsM
	 3xbF5Xo2E+Csg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C09817E0D69;
	Thu, 17 Sep 2026 15:49:22 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 867F948003D; Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 15:49:20 +0200
Subject: [PATCH 8/8] arm64: dts: rockchip: add dfi clocks on RK3588
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rockchip-dfi-cleanup-v1-8-4f00a97a69a6@collabora.com>
References: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
In-Reply-To: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=yJgBEAE3Q/LF6F94kFrvAOvvsqkDjVIE3joxTI9swgE=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr7+Fs6oVWlmCUxy/SGppCEfqqfLOqAQF9Z
 ExKxA3TWTkXf4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq+/hAAoJENju1/PI
 O/qa9VcP+wSIaN4YPKWZp0R/dl6xsYEeoNVXQyw/zJl8MnnkGljfclPSjL56LnGE+6z6okczkcl
 CFSPYBpszqPJPVNAi8Y7iqPfZsbpeLjuLjlkzalMmlvZNx/tzKNMcgUi7ZjUCrziFMwDxfu2Nq/
 wlJAFWclDnWS3Ooxqt2IGOHmXEDcpD0GZZIaTT2fllQdn+XdlyeLSm7NjdHe6LfmzFIAP711Yau
 zsiFgwGR8DW5sacQGV16KSWgm5QNnqY9LuSGyfvHVgPvF6lg0wnzFZUuLpgK7wmUY5sLh2MonNR
 g4wQOY/RKir5p0LMDqcpF/dACQhRVv7ccoLpQktQAj3Jl8VAYlidl807XtkQ6ljJO0fbMh3QfWg
 TWOUed77Fj/Z6qEJYDFvla8s81KTDT7VrKs24t6gKUi44rUDWEzMNg9n8M3VCe17TGg6+e7hGTI
 bkoJKamZ74Sss2Z/Gvs+qoL6/Y4lFs7TrjtAoJMFFqBiCAZTm8dhgQ0gegF8Ca5zK5ZiI6+n8VW
 UVW9Ndc/IGUSuq7MomPjtvFvJRODtvc9ZUWd9E6w1pU//+CcoHdTCXyEAmTF3ERLRWhXUWHrihQ
 LAh5upVeK/6+IhUCfWrRcm+OcgJ/dA+aZQ6fmRUsQj3F1azJPPH35hozg0fjP/gLqoaUwzZXKZ0
 KOPn8ujipg5DR3e4iAA4o5g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The DFI clocks weren't modelled before and the binding didn't know about
them either. That has changed though, and now we actually need to
specify these clocks.

Add all four clocks for all four channels of monitoring.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 376ad04e0786..ac9299e1197b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2178,6 +2178,10 @@ qos_vop_m1: qos@fdf82200 {
 	dfi: dfi@fe060000 {
 		reg = <0x00 0xfe060000 0x00 0x10000>;
 		compatible = "rockchip,rk3588-dfi";
+		clocks = <&cru PCLK_DDR_MON_CH0>, <&cru PCLK_DDR_MON_CH1>,
+			 <&cru PCLK_DDR_MON_CH2>, <&cru PCLK_DDR_MON_CH3>;
+		clock-names = "pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1",
+			      "pclk_ddr_mon_ch2", "pclk_ddr_mon_ch3";
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,

-- 
2.53.0

