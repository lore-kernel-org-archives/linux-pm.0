Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F037595740;
	Thu, 17 Sep 2026 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653862; cv=none; b=Akwhfrdv0HgrTvbM9Ga9zQbZTu3ZD5dHKOParVuLJ89tV8y/yQhAVK0qOLnXlLEHrc8lqkAhbXU+Fch17pGEDIRuaKDrGN2gCDRxklFgEBJZpqirEXLXCBDdFYqqPvE17PmUgE6ru9OslJ9BbYCkZaGaVDCxINWk7EAkWVDbdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653862; c=relaxed/simple;
	bh=vMgJeIbDY4gfZKXLLhtV9STSMmBqMwbwlOznf1gK9P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1k6QcxvCQOAzSMpEkYOrDFM8LLCj5zQUwm98hTXsYWfQIek5FZOcH6kfR6B2LXA7opaCUU6h4nIrSM8afohcp9zJ5yLyytJ3bzw8XipB9bdP0ofUv8Jay/jCgJrAsEgP44Q0Ym7iHojPDO/jQGxDuLHW/5Kln4R9LIlRmHH3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mq5lEHqq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mq5lEHqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789653858;
	bh=vMgJeIbDY4gfZKXLLhtV9STSMmBqMwbwlOznf1gK9P0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mq5lEHqqKN9k4SnqWL0ROBoGrQITCdZtrIOS+C219lTGh38WfibxB99vBbzxng5bv
	 sZfslvnhpbi6DcWxueZj++3pkw0BoVUTno5wf5BsVe6QORpgXgf92rParLUHAVi8/4
	 ZdzVmWhEFfqACG/SyH9eQaIFUtoANxZLloRrRX3+kZ2Z9klHT3tNFbOPh/W7zrisqc
	 yvTb0oICpAZhxEuqayMqrdcvenkT80zYAukwLcQnAvsyu1u2bAKb/czcy3lHD/bRvE
	 gEDFOcGAGo44Sp+UxmO+fH6rCCxiIT++IZaSq9eTQO5kDy3QuWUg9gOn08ZU66/ZzL
	 nP3UYXFzS1EXg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3350117E0C7E;
	Thu, 17 Sep 2026 16:04:18 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E902C480031; Thu, 17 Sep 2026 16:04:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 16:04:10 +0200
Subject: [PATCH 4/7] arm64: dts: rockchip: add DFI node to RK3576
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-rockchip-dfi-rk3576-support-v1-4-a5752a29f7bd@collabora.com>
References: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
In-Reply-To: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=TXuERcBa3lyF5yru0hC/lwhYh6FDQ895W7w6eKt3Ed8=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr82EIl+BsIL24IfiuW4c4yZ4tq0kfphkbA
 JI27g4p/2HJt4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq/NhAAoJENju1/PI
 O/qaGJUP/3yufEr5zX51XBnayXqJXHfhkp+/bGSX1GDixamcNn+or8LJXRfnGElPdx/RX8AjoUJ
 b83dcf2sM0cCgeWgUotHvFLMpk2ussnkfVcDM/I+c0POLInkjoT4i10bjhNgAFvVWhej2qdFnbA
 jAA/UHjFmfVCyQgGMq2CIMe2bOGSXhLQyJSsHDGDDsauE2ZQzev/TvoFIgw7DVzyAk49gl0jwmU
 kBnT0/YoadcVhE6a+Z3j8E/rAMO0u71Em5NSuMLGUvshvEh8SdyG04oloIUaW4cYEsysd2AUMhL
 C94VKVMCl+m8RTEerEGWF4cxeHnJyRB/vTIVEfLvJwVO28SPFqxbQPuEedMaf/e74OJ1BHBJ8g7
 L04ZWiXqNW86EN01YETmiwqvepGYW6Z0nui9Tqnky+YMjDN148p/tfdAB20klocZ0AGyGDCD+8u
 MHa3ihdzhWCvSZr//U9nPTUNQ2rnFpEpVLPBBqlM8D4O4jpKp8+uRSVuqLCarL6ezX6bY8/oeSH
 EaKK2v5Ysjy5JSTs+CgYxgtqchBjJCpOoLL32cJJ7zhU3cEcxa05ZFVntWTeEoaWOObeSMOnIw2
 CM6nApRxvts4+J9j+9E0AFOx8y//a35K3ZaUSiVYc+R6w63HL71Y6X9H3fkAKTefv2qAwI+Mpmk
 3/KbIHfahNLH9rnSOlZ4xkw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Like previous Rockchip SoCs RK3576 has DFI hardware to measure DDR
bandwidth utilisation. Add the node for it to the SoC's DT.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index b0c0d3c8b1b1..197b8c3b76b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1832,6 +1832,17 @@ qos_npu_m1ro: qos@27f22100 {
 			reg = <0x0 0x27f22100 0x0 0x20>;
 		};
 
+		dfi: dfi@2a000000 {
+			compatible = "rockchip,rk3576-dfi";
+			reg = <0x0 0x2a000000 0x0 0x20000>;
+			clocks = <&cru PCLK_DDR_MON_CH0>,
+				 <&cru PCLK_DDR_MON_CH1>;
+			clock-names = "pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1";
+			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+			rockchip,pmu = <&pmu1_grf>;
+		};
+
 		gmac0: ethernet@2a220000 {
 			compatible = "rockchip,rk3576-gmac", "snps,dwmac-4.20a";
 			reg = <0x0 0x2a220000 0x0 0x10000>;

-- 
2.53.0

