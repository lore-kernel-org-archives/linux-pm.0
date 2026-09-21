Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEC47F794;
	Mon, 21 Sep 2026 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022800; cv=none; b=Cpby7DidnyBxjtzTQposb4n+/Y0J965gGl/DF2uVFfGuHP78a9VYFtMq5Zg2nMfBsMNfjNaAqkdgZQOcnSzXEq6oTD7/p7OaPcVoOQZT+Qw+0eymnz/RVWxI8ntHHrx10QhXlCx7M7iy9kcNtPn+HuviBF3UK8geach2W5oFkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022800; c=relaxed/simple;
	bh=kl8wn/r9EG1O9VsRBp0nZH0IjzQxh/DjmWyxpmzatK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKz/duwSenc6kClfRSRoMkqNbtuLuMmmESX2vSoZVFXXeeLKwpQTmHvfJ/tWdfpWPeVEZplhr8+wvmKHzm5syy6Z0t5jvveHqJ8ik0Ts+wcHURqqH1+tyEHCvAosOy++ZJ5ij9hmCebfwy4DPR7zjAEcloWvh7FmF2QXJjxhBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rji7PbvH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rji7PbvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790022792;
	bh=kl8wn/r9EG1O9VsRBp0nZH0IjzQxh/DjmWyxpmzatK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rji7PbvHbdPfvL7M7W5xwKaK9dfM75OVFXx+/rumstL0S0jyqVBpfZU7Pz1a/Ng5j
	 5y7kRZHUvd0/B65aU4bGUTSWIS8bUHUn7iH8EuGskzxNuSA0uITsEORpjLNeng+eU1
	 tUlA+pFzx+6EUMyy+/4vvqX+Al+/VGdI/0kLjBtGfMSOxZYGe1ILgcD02uSeZx4kIo
	 f1T7LPyyKtRlKOqU7ttPhoTl39H2WCB0WA55q32GCqTGQ2NMaNpLtxRGDAUf/ZHYFy
	 kSkvA6wRr3qefsUplmonqiZ7hyVGlYyeIgr7LwrK18QcF0A1elj53+PhJd3wvXxvax
	 ZNKHuO6cxRVSQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 97E7917E0D69;
	Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0169D48003D; Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 22:32:51 +0200
Subject: [PATCH v2 8/8] arm64: dts: rockchip: add dfi clocks on RK3588
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-rockchip-dfi-cleanup-v2-8-43ff34ac8599@collabora.com>
References: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
In-Reply-To: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
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
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxlIdT7oBl7xnlQ8+qAoOVONj4+II2ywgJW
 yCDcKSJVEMM0okCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZSHAAoJENju1/PI
 O/qaKuoQAI141LAMUadx9gzf314SwZtTFWdETwiH4mdeam4VMwWKefPaQsfo/0eZLlTRoR3Rago
 r9xiQED2IliIVyGOy7irShUoOsEYjQL7OzT1SZqTvOw3paWsYVZzfgePk7nfGtkm+Gqsf4JlfpR
 2MvSm6XMJH4HZeAebkY6VIZUiVl/biFU9gVVL45Yl6a97GguuHdr69bGCmRvywtSRPT9Zn2fRCI
 AP0D3ZTTL9hRuRc1Wyz++t0fBHE4v1nJxcwTYLEuVbbB+JqwrW0P8abUb8w3XsDbpSYrr861dME
 TZ5xedtmnR/Qnkj0xBm32HFQEp/y1U7zdkgnMy7hZD6aS7ToTkS7dl7zvir0n42WwP2Pol7STPl
 3LxI+Pu2/jpb3WDJZhIv9zgiG9fnyBMuJ774rOh+VKGQ4qDZgKxAiiKhTuwIy9STEi8raZ43AjK
 lgvyMdsApVI+7uMcscZ0vqDhYRd97UwbTiqCCXWTpEbuDTBBlsB+bLGCQTojPDay7a2/kMt2iy9
 Mck1SSC0sz+IAf6OYpuaJaTP/1hQbxElRfjrDPM9mzdO/Rbp7qMUQDehWU47Vt/SVWHRpMpImtK
 AyExaoAHVhD96oAzEbBJNR77Pr2PhfAk4cfTFFri69eePxLhh0te8XJECDFOyDxhOZEcWp3W2SD
 yWdUTvFNBHT3Pgkk6aXsuVA==
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

