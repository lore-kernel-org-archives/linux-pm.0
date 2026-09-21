Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4847728F;
	Mon, 21 Sep 2026 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022800; cv=none; b=X66+mQfFc4C9uRw1M1qiNAs18rsbnzwYDAhGCM26nxvNsQWkrC+hL6uHVVdRdyGBLZ9WnFY0PXZudxgl5WFaXgiocUgF7nsn01OluX5i/cAUe7d83VEuniU9H4FUlzfKZaQlKJ1A57uPBWOxqAOTCJoPw3egU/Qe0q/sVW8Uyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022800; c=relaxed/simple;
	bh=VXjQmgPNcP6TxrE9fEJyZi07Hi5P0Q3culnMpUj9c98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cp/DAOEwve48E7ClXIAnATvvsiNv8dJQRiqA0MnSNfpeBgGMUQJBev6W3voWZXzZH0zIT1sz/5Ey7hAyvKyZ9dbuP7C6PLEYytx6TZYEeSR3pr3DgPzmn1vOeoSHjV6xLpjKn7QHc1Met6GlL9Of7PF0VFf9l57Lr2Q1525NQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SePGBiBi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SePGBiBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790022792;
	bh=VXjQmgPNcP6TxrE9fEJyZi07Hi5P0Q3culnMpUj9c98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SePGBiBib+WxIdXITIUybZ02U8azVh8lr8Noklr3a4VS3CpQtBYiDrC+kgj5YMJpo
	 fNPQCSr3PDZcYw9rwhNnnE8j7XL58droQwy6gcajVzaa26M/ohrZuFZCyZayumPIse
	 rEu4O1RW8g8lBdHZD5sdrGneEe5nz/InwZ+nQY9nJ2tj17N9iLCj2ziPM+DPNxFCaz
	 dDhzMTW2zP6fOKUtWStq/qd0wz++xxEnFTQ51Y/mkf5Jrr1Dm77jI+vml/xW0lmd31
	 84+RrUY04sCyFQrFaFKA3P6YYommGMeFtM82zfwCBLo6YfQqX2DceXrW9eh/+XiR9M
	 itVe2GOJYRFJA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 903AF17E0D49;
	Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id F232A480038; Mon, 21 Sep 2026 22:33:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 22:32:49 +0200
Subject: [PATCH v2 6/8] clk: rockchip: rk3588: add PCLK_DDR_MON_CH gate
 branches
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-rockchip-dfi-cleanup-v2-6-43ff34ac8599@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=WfqRSjYFz7+ljRQE5uaOc11qdMoKK31EtGs4gkDrNM4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxlIe0QrS0CLpebNH1Rg5WGyot/dW96mfTj
 Ie0nY2O+6nKXYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZSHAAoJENju1/PI
 O/qaia4QAJRJ/+eB1ujJdyhurQIJsEnNpnu5ZagFiNILWYw9G4sPIA2vq6Tvj6gAtPHPdQYJv4n
 iv63KRvxxqLt0xuyKQk16AyLhQQA8D0TfoqWGyJbxOSe+JtooXbZ79c0uJKyXDWCp7GPEF0+IeQ
 d6IPGKZ8TYhKQ0XrR012CwVXmXCv9iYZ1lDjp5IlMsWYxlSzGfE7EjBOYH4efalDH7VaEJdSgQD
 mFRbVg+mlTndcRS5Gr52zsEosKwfC1HA2LGlv0JK87tgU0VSGpeVtFEDawqNI/X1rlCk82Z3+ZJ
 uUnXKC4MY2yx7bTUFf80OCFUfBsgKtWV4wu8ZS0NWpQHVKGHU/g8TkQLQ3/ZgFwtLrJTaTsJb4g
 KjPi1Qpqv59Bhgtcu+o2bqyShoV5fri5MJzJo36l9LlzRSXJqq/uLq+FhcsGrF5K+m+agQxu+tp
 uPQBIklQVBFthHEWXkLNpkIBHuteNT1QbK4A/DEZS3onmZEA+8l4LR8eslNnQxvdWah1YyzBDLg
 5mv9ZQGyNLmLlR1B4+KdGf1pY5RVuWctgdfgUES3LseJ/Dx4+pu4PEm+6Ix0LiQ6v9h3a4OunYU
 F8kRBWne3J4vEx04VVtHwz8PAUUU9GM/h5QGhLYOZwKfLqDuXdsIkx/l1U3qNz/jSQTrd4d6SOZ
 maYVMMZIqKefCNYxdUlknGg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

On the Rockchip RK3588, each memory channel has some bandwidth
monitoring silicon (hence the "DDR_MON"), which is driven by a clock
gated by PCLK_DDR_MON_CH0/1/2/3.

These clock branches were left out of the mainline clock tree until now.

Add them, with the proper CRU reg bits, and the proper parent.  They are
given the "CLK_IGNORE_UNUSED" flag, so that older device trees with
newer kernels don't turn off the clocks because they're seen as not in
use.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/rockchip/clk-rk3588.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3588.c b/drivers/clk/rockchip/clk-rk3588.c
index 24baa0ef9bf3..0485faf27163 100644
--- a/drivers/clk/rockchip/clk-rk3588.c
+++ b/drivers/clk/rockchip/clk-rk3588.c
@@ -1349,6 +1349,14 @@ static struct rockchip_clk_branch rk3588_early_clk_branches[] __initdata = {
 	COMPOSITE(CLK_DDR_CM0_RTC, "clk_ddr_cm0_rtc", mux_24m_32k_p, CLK_IS_CRITICAL,
 			RK3588_CLKSEL_CON(166), 5, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3588_CLKGATE_CON(70), 4, GFLAGS),
+	GATE(PCLK_DDR_MON_CH0, "pclk_ddr_mon_ch0", "pclk_center_root", CLK_IGNORE_UNUSED,
+			RK3588_CLKGATE_CON(20), 1, GFLAGS),
+	GATE(PCLK_DDR_MON_CH1, "pclk_ddr_mon_ch1", "pclk_center_root", CLK_IGNORE_UNUSED,
+			RK3588_CLKGATE_CON(20), 14, GFLAGS),
+	GATE(PCLK_DDR_MON_CH2, "pclk_ddr_mon_ch2", "pclk_center_root", CLK_IGNORE_UNUSED,
+			RK3588_CLKGATE_CON(23), 1, GFLAGS),
+	GATE(PCLK_DDR_MON_CH3, "pclk_ddr_mon_ch3", "pclk_center_root", CLK_IGNORE_UNUSED,
+			RK3588_CLKGATE_CON(23), 14, GFLAGS),
 	GATE(PCLK_WDT, "pclk_wdt", "pclk_center_root", 0,
 			RK3588_CLKGATE_CON(70), 7, GFLAGS),
 	GATE(PCLK_TIMER, "pclk_timer", "pclk_center_root", 0,

-- 
2.53.0

