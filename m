From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v4 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Date: Wed, 24 Apr 2019 14:09:53 +0200
Message-ID: <20190424120953.GA26640@vmlxhi-102.adit-jv.com>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424051145.23072-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, george_davis@mentor.com, joshua_frkuska@mentor.com, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 24, 2019 at 02:11:43PM +0900, Jiada Wang wrote:
> There are issues with interrupt handling in rcar_gen3_thermal driver.
> 
> Currently IRQ is remain enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> triggered but not able to clear IRQ status, thus cause system to hang.
> 
> Since the irq line isn't shared between different devices,
> so the proper interrupt type flag should be IRQF_ONESHOT.
> 
> This patch-set fix these interrupt handling retated issues.
> 
> ---
> v4: remove 'spinlock_t lock'
>     add Fixes tag in ("thermal: rcar_gen3_thermal: fix interrupt type")
>     fix typos in ("thermal: rcar_gen3_thermal: disable interrupt in .remove")
> 
> v3: fix to use correct code base
>     remove unused "flag" variable in rcar_gen3_thermal_irq
> 
> v2: use irq type IRQF_ONESHOT instead of IRQF_SHARED
>     disable interrupt in .remove
> 
> v1: initial version
> 
> Jiada Wang (2):
>   thermal: rcar_gen3_thermal: fix interrupt type
>   thermal: rcar_gen3_thermal: disable interrupt in .remove
> 
>  drivers/thermal/rcar_gen3_thermal.c | 41 +++++++----------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
> 
> -- 
> 2.19.2

For the record, below is the diff between v3 and v4 [1].
It accurately reflects my review comments in
https://patchwork.kernel.org/patch/10913165/#22601305 .

In addition, I made sure there are either false positives or
no new issues reported by:
 - sparse v0.5.2-1-ga3c4716a703a
 - smatch v0.5.0-4785-g4968bcad1c08
 - cppcheck 1.88 dev
 - make W=123
 - make coccicheck

I repeated the same test steps as described in
https://patchwork.kernel.org/cover/10913163/#22602335
and the results were the same:

Reviewed-and-Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

[1] diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index c63a86d3dac6..280230951dfe 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -14,7 +14,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/spinlock.h>
 #include <linux/sys_soc.h>
 #include <linux/thermal.h>
 
@@ -82,7 +81,6 @@ struct rcar_gen3_thermal_tsc {
 struct rcar_gen3_thermal_priv {
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	unsigned int num_tscs;
-	spinlock_t lock; /* Protect interrupts on and off */
 	void (*thermal_init)(struct rcar_gen3_thermal_tsc *tsc);
 };
 
@@ -231,8 +229,8 @@ static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
 static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 {
 	struct rcar_gen3_thermal_priv *priv = data;
-	int i;
 	u32 status;
+	int i;
 
 	for (i = 0; i < priv->num_tscs; i++) {
 		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
@@ -352,8 +350,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (soc_device_match(r8a7795es1))
 		priv->thermal_init = rcar_gen3_thermal_init_r8a7795es1;
 
-	spin_lock_init(&priv->lock);
-
 	platform_set_drvdata(pdev, priv);
 
 	/*

-- 
Best regards,
Eugeniu.
