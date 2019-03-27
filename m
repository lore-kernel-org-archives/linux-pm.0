From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [RESEND PATCH] thermal: rcar_gen3_thermal: Fix init value of
 IRQCTL register
Date: Wed, 27 Mar 2019 10:31:54 +0100
Message-ID: <20190327093154.GA23466@bigcity.dyn.berto.se>
References: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc: linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be, rui.zhang@intel.com, jslaby@suse.com, wsa+renesas@sang-engineering.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp, nv-dung@jinso.co.jp, cv-dong@jinso.co.jp
List-Id: linux-pm@vger.kernel.org

Hi Hoan,

Thanks for your work, and sorry for dropping the ball on this in v2.

On 2019-03-27 18:03:18 +0900, Nguyen An Hoan wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
> 
> Fix setting value for IRQCTL register. We are setting the last 6 bits
> of (IRQCTL) to be 1 (0x3f), this is only suitable for H3ES1.*, according
> to Hardware manual values 1 are "setting prohibited" for Gen3.
> 
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 88fa41c..2482795 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -307,7 +307,7 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
>  
>  	usleep_range(1000, 2000);
>  
> -	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
> +	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0);
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
>  	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN, IRQ_TEMPD1 | IRQ_TEMP2);
>  
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
