From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 1/4] ARM: da850: fix infinite loop in clk_set_rate()
Date: Wed,  7 Dec 2016 16:22:15 +0100
Message-ID: <1481124138-27337-2-git-send-email-bgolaszewski@baylibre.com>
References: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-pm@vger.kernel.org

The aemif clock is added twice to the lookup table in da850.c. This
breaks the children list of pll0_sysclk3 as we're using the same list
links in struct clk. When calling clk_set_rate(), we get stuck in
propagate_rate().

Create a separate clock for nand, inheriting the rate of the aemif
clock and retrieve it in the davinci_nand module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e770c97..e9d019c 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -367,6 +367,16 @@ static struct clk aemif_clk = {
 	.flags		= ALWAYS_ENABLED,
 };
 
+/*
+ * In order to avoid adding the aemif_clk to the clock lookup table twice (and
+ * screwing up the linked list in the process) create a separate clock for
+ * nand inheriting the rate from aemif_clk.
+ */
+static struct clk aemif_nand_clk = {
+	.name		= "nand",
+	.parent		= &aemif_clk,
+};
+
 static struct clk usb11_clk = {
 	.name		= "usb11",
 	.parent		= &pll0_sysclk4,
@@ -537,7 +547,15 @@ static struct clk_lookup da850_clks[] = {
 	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
 	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
 	CLK("ti-aemif",		NULL,		&aemif_clk),
-	CLK(NULL,		"aemif",	&aemif_clk),
+	/*
+	 * The only user of this clock is davinci_nand and it get's it through
+	 * con_id. The nand node itself is created from within the aemif
+	 * driver to guarantee that it's probed after the aemif timing
+	 * parameters are configured. of_dev_auxdata is not accessible from
+	 * the aemif driver and can't be passed to of_platform_populate(). For
+	 * that reason we're leaving the dev_id here as NULL.
+	 */
+	CLK(NULL,		"aemif",	&aemif_nand_clk),
 	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
 	CLK("musb-da8xx",	"usb20",	&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-- 
2.9.3
