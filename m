From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 2/2] thermal: rcar_gen3_thermal: disable interrupt in
 .remove
Date: Wed, 24 Apr 2019 11:38:07 +0200
Message-ID: <8d80c874-956f-b2e2-412b-69cc26235606@linaro.org>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190424051145.23072-3-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424051145.23072-3-jiada_wang@mentor.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se, geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com, marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com, biju.das@bp.renesas.com, erosca@de.adit-jv.com, george_davis@mentor.com, joshua_frkuska@mentor.com
List-Id: linux-pm@vger.kernel.org

On 24/04/2019 07:11, Jiada Wang wrote:
> Currently IRQ remains enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> called before device is initialized.
> 
> this patch disables interrupt in .remove, to ensure irq function
> only be called after device is fully initialized.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 065e16f53285..280230951dfe 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -307,6 +307,9 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
>  static int rcar_gen3_thermal_remove(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
> +
> +	rcar_thermal_irq_set(priv, false);
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
