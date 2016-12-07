From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 2/4] ARM: da850: don't add the emac clock to the clock lookup table twice
Date: Wed,  7 Dec 2016 16:22:16 +0100
Message-ID: <1481124138-27337-3-git-send-email-bgolaszewski@baylibre.com>
References: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Similarly to the aemif clock - this screws up the linked list of clock
children. Create a separate clock for mdio inheriting the rate from
emac_clk.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index e9d019c..6b1fbac 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -319,6 +319,11 @@ static struct clk emac_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk mdio_clk = {
+	.name		= "mdio",
+	.parent		= &emac_clk,
+};
+
 static struct clk mcasp_clk = {
 	.name		= "mcasp",
 	.parent		= &async3_clk,
@@ -539,7 +544,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"arm",		&arm_clk),
 	CLK(NULL,		"rmii",		&rmii_clk),
 	CLK("davinci_emac.1",	NULL,		&emac_clk),
-	CLK("davinci_mdio.0",	"fck",		&emac_clk),
+	CLK("davinci_mdio.0",	"fck",		&mdio_clk),
 	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
 	CLK("davinci-mcbsp.0",	NULL,		&mcbsp0_clk),
 	CLK("davinci-mcbsp.1",	NULL,		&mcbsp1_clk),
-- 
2.9.3
