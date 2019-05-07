From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v4 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Date: Wed, 8 May 2019 01:54:03 +0200
Message-ID: <20190507235403.GA24112@bigcity.dyn.berto.se>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424051145.23072-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, erosca@de.adit-jv.com, george_davis@mentor.com, joshua_frkuska@mentor.com
List-Id: linux-pm@vger.kernel.org

Hi Jiada,

Thanks for your patches.

On 2019-04-24 14:11:43 +0900, Jiada Wang wrote:
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

I really like this series, nice work.

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

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
> 

-- 
Regards,
Niklas Söderlund
