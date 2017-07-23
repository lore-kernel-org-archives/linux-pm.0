From: Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 06/10] clk: sunxi-ng: allow set parent clock (PLL_CPUX) for CPUX clock on H3
Date: Sun, 23 Jul 2017 18:27:45 +0800
Message-ID: <20170723102749.17323-7-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170723102749.17323-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
List-Id: linux-pm@vger.kernel.org

The CPUX clock, which is the main clock of the ARM core on Allwinner H3,
can be adjusted by changing the frequency of the PLL_CPUX clock.

Allowing setting parent clock for the CPUX clock, thus the PLL_CPUX
clock can be adjusted when adjusting the CPUX clock.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 406d0aac9fd6..4cdbc88f2783 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -135,7 +135,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
 					     "pll-cpux" , "pll-cpux" };
 static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
-		     0x050, 16, 2, CLK_IS_CRITICAL);
+		     0x050, 16, 2, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x050, 0, 2, 0);
 
-- 
2.13.0
