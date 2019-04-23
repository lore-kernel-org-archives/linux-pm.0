From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v3 1/2] thermal: rcar_gen3_thermal: fix interrupt type
Date: Tue, 23 Apr 2019 16:57:59 +0200
Message-ID: <20190423145759.GA29037@vmlxhi-102.adit-jv.com>
References: <20190423141414.24264-1-jiada_wang@mentor.com>
 <20190423141414.24264-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423141414.24264-2-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, george_davis@mentor.com, joshua_frkuska@mentor.com, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <rosca.eugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Jiada,

On Tue, Apr 23, 2019 at 11:14:13PM +0900, Jiada Wang wrote:
> Currently IRQF_SHARED type interrupt line is allocated, but it
> is not appropriate, as the interrupt line isn't shared between
> different devices, instead IRQF_ONESHOT is the proper type.
> 
> By changing interrupt type to IRQF_ONESHOT, now irq handler is
> no longer needed, as clear of interrupt status can be done in
> threaded interrupt context.
> 
> Because IRQF_ONESHOT type interrupt line is kept disabled until
> the threaded handler has been run, so there is no need to protect
> read/write of REG_GEN3_IRQSTR with lock.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 34 +++++------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 88fa41cf16e8..ebbaef5a3cf1 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -231,39 +231,17 @@ static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
>  static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
>  {
>  	struct rcar_gen3_thermal_priv *priv = data;
> +	int i;
>  	u32 status;
> -	int i, ret = IRQ_HANDLED;

nit: why not keeping 'int i' on the same line?

>  
> -	spin_lock(&priv->lock);
[..]
> -	spin_unlock(&priv->lock);
[..]
> -	spin_lock_irqsave(&priv->lock, flags);
[..]
> -	spin_unlock_irqrestore(&priv->lock, flags);
[..]

FWIW, after applying the patch, the 'spinlock_t lock' member of
'struct rcar_gen3_thermal_priv' is no longer used in the driver, except
to initialize it in probe. Is there any usage expected in future or
should it be zapped?

-- 
Best regards,
Eugeniu.
