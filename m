From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2] ARM: shmobile: r8a73a4: wait for completion when kicking
 the clock
Date: Wed, 22 May 2013 11:12:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305221108500.12715@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org, Simon Horman <horms@verge.net.au>
List-Id: linux-pm@vger.kernel.org

To reconfigure clocks, controlled by FRQCRA and FRQCRB, a kick bit has to
be set and to make sure the setting has taken effect, it has to be read
back repeatedly until it is cleared by the hardware. This patch adds the
waiting part, that was missing until now.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 5f7fe62..d5176d0 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -184,6 +184,21 @@ PLL_CLOCK(pll2h_clk, &main_div2_clk, pll_parent_main_extal, 3, 5, PLL2HCR, 5);
 
 SH_FIXED_RATIO_CLK(pll1_div2_clk,	pll1_clk,	div2);
 
+static int frqcr_kick_do(struct clk *clk)
+{
+	int i;
+
+	/* set KICK bit in FRQCRB to update hardware setting, check success */
+	iowrite32(ioread32(CPG_MAP(FRQCRB)) | BIT(31), CPG_MAP(FRQCRB));
+	for (i = 1000; i; i--)
+		if (ioread32(CPG_MAP(FRQCRB)) & BIT(31))
+			cpu_relax();
+		else
+			return 0;
+
+	return -ETIMEDOUT;
+}
+
 static struct clk *main_clks[] = {
 	&extalr_clk,
 	&extal1_clk,
@@ -205,12 +220,7 @@ static struct clk *main_clks[] = {
 /* DIV4 */
 static void div4_kick(struct clk *clk)
 {
-	unsigned long value;
-
-	/* set KICK bit in FRQCRB to update hardware setting */
-	value = ioread32(CPG_MAP(FRQCRB));
-	value |= (1 << 31);
-	iowrite32(value, CPG_MAP(FRQCRB));
+	frqcr_kick_do(clk);
 }
 
 static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 18, 24, 0, 36, 48, 10};
-- 
1.7.2.5

