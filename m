From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [RFC PATCH 7/8] clk: qoriq: Expose OF clocks directly from the clockgen node
Date: Thu, 18 Jun 2015 21:49:17 -0500
Message-ID: <1434682158-7243-8-git-send-email-scottwood@freescale.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434682158-7243-1-git-send-email-scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tang Yuantian <Yuantian.Tang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Liberman Igal-B31950 <Igal.Liberman-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Bucur Madalin-Cristian-B32716 <madalin.bucur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This allows the "clocks" property to be used in the absence of
legacy nodes, and for clocks that the legacy nodes do not describe.

Signed-off-by: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/clk/clk-qoriq.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index f6aa106..e408965 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -938,6 +938,61 @@ static void __init pltfrm_pll_init(struct device_node *np)
 	legacy_pll_init(np, PLATFORM_PLL);
 }
 
+static struct clk *clockgen_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct clockgen *cg = data;
+	struct clk *clk;
+	struct clockgen_pll *pll;
+	u32 type, idx;
+
+	if (clkspec->args_count < 2) {
+		pr_err("%s: insufficient phandle args\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	type = clkspec->args[0];
+	idx = clkspec->args[1];
+
+	switch (type) {
+	case 0:
+		if (idx != 0)
+			goto bad_args;
+		clk = cg->sysclk;
+		break;
+	case 1:
+		if (idx >= ARRAY_SIZE(cg->cmux))
+			goto bad_args;
+		clk = cg->cmux[idx];
+		break;
+	case 2:
+		if (idx >= ARRAY_SIZE(cg->hwaccel))
+			goto bad_args;
+		clk = cg->hwaccel[idx];
+		break;
+	case 3:
+		if (idx >= ARRAY_SIZE(cg->fman))
+			goto bad_args;
+		clk = cg->fman[idx];
+		break;
+	case 4:
+		pll = &cg->pll[PLATFORM_PLL];
+		if (idx >= ARRAY_SIZE(pll->div))
+			goto bad_args;
+		clk = pll->div[idx].clk;
+		break;
+	default:
+		goto bad_args;
+	}
+
+	if (!clk)
+		return ERR_PTR(-ENOENT);
+	return clk;
+
+bad_args:
+	pr_err("%s: Bad phandle args %u %u\n", __func__, type, idx);
+	return ERR_PTR(-EINVAL);
+}
+
 #ifdef CONFIG_PPC
 #include <asm/mpc85xx.h>
 
@@ -982,7 +1037,7 @@ static bool __init has_erratum_a4510(void)
 
 static void __init clockgen_init(struct device_node *np)
 {
-	int i;
+	int i, ret;
 
 	clockgen.node = np;
 	clockgen.regs = of_iomap(np, 0);
@@ -1028,6 +1083,12 @@ static void __init clockgen_init(struct device_node *np)
 	if (clockgen.info.init_periph)
 		clockgen.info.init_periph(&clockgen);
 
+	ret = of_clk_add_provider(np, clockgen_clk_get, &clockgen);
+	if (ret) {
+		pr_err("%s: Couldn't register clk provider for node %s: %d\n",
+		       __func__, np->name, ret);
+	}
+
 	return;
 err:
 	iounmap(clockgen.regs);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
