From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH 05/10] clk: sunxi-ng: h3: gate then ungate PLL
 CPU clk after rate change
Date: Sun, 23 Jul 2017 18:27:44 +0800
Message-ID: <20170723102749.17323-6-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBYXU2HFQKGQEVUBF5NQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170723102749.17323-1-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

This patch utilizes the new PLL clk notifier to gate then ungate the
PLL CPU clock after rate changes. This should prevent any system hangs
resulting from cpufreq changes to the clk.

Reported-by: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Tested-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 62e4f0d2b2fc..406d0aac9fd6 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -1103,6 +1103,13 @@ static const struct sunxi_ccu_desc sun50i_h5_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun50i_h5_ccu_resets),
 };
 
+static struct ccu_pll_nb sun8i_h3_pll_cpu_nb = {
+	.common	= &pll_cpux_clk.common,
+	/* copy from pll_cpux_clk */
+	.enable	= BIT(31),
+	.lock	= BIT(28),
+};
+
 static struct ccu_mux_nb sun8i_h3_cpu_nb = {
 	.common		= &cpux_clk.common,
 	.cm		= &cpux_clk.mux,
@@ -1130,6 +1137,10 @@ static void __init sunxi_h3_h5_ccu_init(struct device_node *node,
 
 	sunxi_ccu_probe(node, reg, desc);
 
+	/* Gate then ungate PLL CPU after any rate changes */
+	ccu_pll_notifier_register(&sun8i_h3_pll_cpu_nb);
+
+	/* Reparent CPU during PLL CPU rate changes */
 	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
 				  &sun8i_h3_cpu_nb);
 }
-- 
2.13.0
