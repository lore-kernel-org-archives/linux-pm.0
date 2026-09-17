Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580A5519B6;
	Thu, 17 Sep 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652975; cv=none; b=s30gFEar68RNvlFvzAxdVbpPVrg+72+gdSiyQTyvKhB//fLUPdKPHwlqTGai+E4VM5R7j5C5OKX9897Y6AT4228fmbS+LBBJoHM13Vk4AvFR5iujTKnkXpt8yDQDTSSO6/oeVbatsCGIhXrBWUnyrr0snhT9ZsQWe1jZgKDovTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652975; c=relaxed/simple;
	bh=VXjQmgPNcP6TxrE9fEJyZi07Hi5P0Q3culnMpUj9c98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G09+iO00wbzqhUoCbOAphbDpdtkrHLCuJVRTfT3F3b0UTRfFv8Ui1fm3R1JGUG7s2GRPj6clcSRy8KCYtUykNcjPmo5v4PJ/ynxzDAStnHMj5GgJRBxSbSAHfmVUVLZ/Mt0mDhLdtmzReW6aZ+8RjoLkk0kf2/+D9DA/urcRgVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L/TADqrj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L/TADqrj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789652962;
	bh=VXjQmgPNcP6TxrE9fEJyZi07Hi5P0Q3culnMpUj9c98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L/TADqrjmFPk2K1ZX7k+LW5ZVhcd2vFs6kFuZZA6Jlhddudj5mKXh83EctWmN0tqt
	 5rMwd1BHGe+slfldSeYdjDPi0oWUZZCCdMgsNvPyofWih3Wgx7LpkvAednoRqRxPeE
	 aQ7sm3sRmykZOJG5NhjLapX/c6W22z6JVknnsw2SjFVJUD+KQVEa7u0fIcMzbIFdaG
	 qcDysICHQsCWfIZXY2loWh61qOZKX4NvI6AvXn475qG+ud4TBKhP/rxSOKm1r++m64
	 tpJYKsVTFVoafTpDDIs1FC3siumxQrosMrib23Jup1YdVziIgI6qI2P2jfwLiNyUv0
	 MmFc5c7eJuW+Q==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 222FB17E0D43;
	Thu, 17 Sep 2026 15:49:22 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 83215480038; Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 15:49:18 +0200
Subject: [PATCH 6/8] clk: rockchip: rk3588: add PCLK_DDR_MON_CH gate
 branches
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rockchip-dfi-cleanup-v1-6-4f00a97a69a6@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=WfqRSjYFz7+ljRQE5uaOc11qdMoKK31EtGs4gkDrNM4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr7+FXLCthP7tD49VfVvHeEO0xRiIMMWLgb
 bnWmG28Z5g7+okCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq+/hAAoJENju1/PI
 O/qaTb0P/A/x5egj1nQnkPWKzWJD+O+aQG9ru/DmIrFaBLMjgGQrkSHhtEIZ8awBiU0V3dMMoH+
 IDh/siTsRM7qE5prdXcGNwomi4yfg2uhlfSNAKfXSXMEWfA3W2dqypLAPqoepd4Nwb125f9+tU3
 NRgBy6NZRNnXfY1cdeqLtLEcuGT5xXVzS0T3xMIGRPErATCCwG826QuCv5qV0d/8dpswZW/f6fz
 K3Df5RDIa/jLXjpA262tTj+BFgz2TI+ISm9oYvLtISL1ACHRUxDTMlbZ+euWTaoySFa6XcWcbpo
 h8bgi5d8K0YkW6t7lwgCmtK4WeAGHLthgQCQa2ndYiz9mMRlrk0p6cqV9xOJwJrTJElzrt3yAeE
 E775KVtDdK+JhhFWwnSRl0drOyZOIE5khUf1KJyn/N5RA+GTNc3lcoQ3x0JWilijOiM7dQYTR/q
 RzUe+xEWItOEDnpmtfkwHo86FzBH2DHEC/ht3ZFu1hz126rDKjvK7ZHnY1SsGwuw0uiOgb0aE51
 7LbAXuouUGATBzvyJ9Hb27Kfd3bHYjDKezCA2OiI0udmD1EyTenElgTNi3G4iF+BuIRABkCB4o7
 4DLTPUSRI+LnSIOkJBKRDowlqsr6O4u/z2UMstpgKjQW3folhlQ+QT0iEUmA1HRmV043byt8Qoi
 rBK2hfyG7aKXuLpeFftkuKA==
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

