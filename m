From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 4/4] clk: shmobile: rcar-gen2: Switch from old MSTP to new MSSR driver
Date: Tue, 22 Sep 2015 17:44:06 +0200
Message-ID: <1442936646-30362-5-git-send-email-geert+renesas@glider.be>
References: <1442936646-30362-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1442936646-30362-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/shmobile/Makefile        | 2 +-
 drivers/clk/shmobile/clk-rcar-gen2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 2525ba9608b69732..f595a028a581a271 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7778)		+= clk-r8a7778.o clk-mstp.o
 obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o clk-mstp.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
-obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o clk-mssr.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7793)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7795)		+= clk-rcar-gen3.o clk-mstp.o clk-div6.o
diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index 3f02b40b4911831c..a237d63af1ede4f6 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -431,7 +431,7 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
 
-	cpg_mstp_add_clk_domain(np);
+	cpg_mssr_add_clk_domain(np);
 }
 CLK_OF_DECLARE(rcar_gen2_cpg_clks, "renesas,rcar-gen2-cpg-clocks",
 	       rcar_gen2_cpg_clocks_init);
-- 
1.9.1

