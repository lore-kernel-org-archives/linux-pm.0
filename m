Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D07595737;
	Thu, 17 Sep 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653861; cv=none; b=lTF3+nw42OUR7d+dYr4ntNpkO9r4TiLVYYjKvh7cGIfl7A/HeGbe2LH8BOvZkvxtHTdsA4k8sAf8q4rWFNFIlfV0javBd1Xw0zsxRYzW9wMsCB2eJrdK+axyPj3tcFsuUgisHQZpOtJvq9SfegGLaZihnbOrCyeEnZEAdBvIQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653861; c=relaxed/simple;
	bh=la91QlmnzQ+cMr3xbEYXMZpWQxq/64sHaIS6pJZM8PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SdHTPXeWDATxTcH5gUQa3c2mxlRjsxTMXsvubWF+r6yTm+UEAI2zM/mRDCXZDKg5RPH3s7mfN+ZBF2M2BlK7Jzpbc5sn/EbecULmvqUKw7rRfAafb9+44qiisCwD+fUnMMYP46e7X800i3DwwNFsrBcF/7ewzT+J5Evj6yTNyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nwwbpKnI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nwwbpKnI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789653858;
	bh=la91QlmnzQ+cMr3xbEYXMZpWQxq/64sHaIS6pJZM8PY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nwwbpKnIkNnZSKCOqVZpNsy/SfJVMAcsWR9LtSQQ6KPBTN+wj+Gs7Po9qKyEHUls4
	 nCeksrOY/U8DF/kMXZGZ5boPyX3OxVpF/TTrrIs6Xrt6C5PmA2JZUBhs5IFISiukx9
	 8c7lxDeHO5SFiaWHsbmvXMFNtIf5mtgOai/WTVLYrQpjHzBvYhyI+NZ8ePiIqMyoc1
	 sh5q+X23ZiEOoOqIbCxdtFgeZK02tJWUMS8/csOAa5iiIr6U2DTbjoq3IyJmoQlj8H
	 QprVGG2EjW/EJtBizpZQOIia0KPh7P5Xu6d2KSc/n6GAEm0SM/jciSe0TCoxopn4CA
	 208NlNcFj9y6Q==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E2D417E087F;
	Thu, 17 Sep 2026 16:04:18 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E587748002F; Thu, 17 Sep 2026 16:04:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 16:04:08 +0200
Subject: [PATCH 2/7] clk: rockchip: rk3576: add missing DFI clock branch
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-rockchip-dfi-rk3576-support-v1-2-a5752a29f7bd@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=jv2cP7PAalymZeRc3au2vjT1JUKCsZkY6Uv6EoH/o0k=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr82FktkXT94orgup/c43WCmAIcDc8ndErt
 0ZvdhOKI0xWSIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq/NhAAoJENju1/PI
 O/qabCAP+QEGU1rHYDnoXLzXs4Vmy2mOsll3+fdbfjsyWAvZuXSwpMrwTvGit7mvx0qp1djpQ5a
 OwmYWZ/ZwbW0o2ij1+DV4LjeMA8vlsoxaf+4uqau2LAZ1JHjvCnWyBxrgfCYNHPnbGPwnY8Nm88
 0pK7lW0F/Wv3MUbLgE1JuG30wMZOLhKGpNVVa8UNpJbYYFLyNBB5OXJl+DTXRTxtU+jrMzxWYgL
 9XJJY01rwoQQoSVd3Vk5S7jNGDl8cLOoVIBtTWeuNRy1VLdcSXzGFbLKTf/wzZvI45q1xiX8a3+
 SNMJnQSLqlnZ18OoA2HZbm4/lIJwgPkAr6A3GOflsEAWH2jg2zW+J1Ivo+EzhAX+3xzmtrQhyhm
 BY7wopdOZtxbPoqn5XUgF+inr+JiUwKetTYgeO1D2vnc/WPIspmAAxAbHmhh5uIOCSuwvWiF3Kt
 BkvT4skj69q6+o/FGU4hobixqZqClNtF0A6Kac091VJL/+iQy7z64luLYbjW2C3KUTv7hsxDJjw
 YSobTPmJ2tzqu3KdUgcezlD3TIPJerdhW6T7iKpw5qIL2QuDhv4yPwbf2yDurB5HLJAtnqPKkXM
 umpiN3F2uhSul3ZNIvu1rfndZlJFUyvlu4WbxHb80KN8Jtw+wZbviiPrKCPI4lvYHGHW5VQKuK+
 u0JmBi4egr2/DOeb2qtQy6Q==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

RK3576 DFI has one pclk for each channel's monitor. However, mainline's
clock tree does not model this second DDRMON PCLK gate, and got away
with it so far because they both default to ungated and there is no
upstream RK3576 DFI driver.

Add a clock gate branch for it, and remove the CLK_IGNORE_UNUSED flag
from its sibling. In opposite to RK3588 we can add a mandatory
requirement for a clock reference to the RK3576 DFI DT binding.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/rockchip/clk-rk3576.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3576.c b/drivers/clk/rockchip/clk-rk3576.c
index 2cdd667f4004..0c94e9db81c1 100644
--- a/drivers/clk/rockchip/clk-rk3576.c
+++ b/drivers/clk/rockchip/clk-rk3576.c
@@ -883,8 +883,10 @@ static struct rockchip_clk_branch rk3576_clk_branches[] __initdata = {
 	COMPOSITE(PCLK_DDR_ROOT, "pclk_ddr_root", gpll_cpll_24m_p, CLK_IS_CRITICAL,
 			RK3576_CLKSEL_CON(76), 5, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3576_CLKGATE_CON(21), 0, GFLAGS),
-	GATE(PCLK_DDR_MON_CH0, "pclk_ddr_mon_ch0", "pclk_ddr_root", CLK_IGNORE_UNUSED,
+	GATE(PCLK_DDR_MON_CH0, "pclk_ddr_mon_ch0", "pclk_ddr_root", 0,
 			RK3576_CLKGATE_CON(21), 1, GFLAGS),
+	GATE(PCLK_DDR_MON_CH1, "pclk_ddr_mon_ch1", "pclk_ddr_root", 0,
+			RK3576_CLKGATE_CON(21), 14, GFLAGS),
 	COMPOSITE(HCLK_DDR_ROOT, "hclk_ddr_root", gpll_cpll_p, CLK_IGNORE_UNUSED,
 			RK3576_CLKSEL_CON(77), 5, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3576_CLKGATE_CON(22), 11, GFLAGS),

-- 
2.53.0

