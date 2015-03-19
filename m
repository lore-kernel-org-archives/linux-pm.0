From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 2/7] irqchip: renesas-irqc: Add minimal runtime PM support
Date: Thu, 19 Mar 2015 10:37:48 +0900
Message-ID: <20150319013748.GH14051@verge.net.au>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
 <1426704961-27322-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426704961-27322-3-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 18, 2015 at 07:55:56PM +0100, Geert Uytterhoeven wrote:
> This is just enough to let pm_clk_*() enable the functional clock, and
> manage it for suspend/resume, if present.
> Before, it was assumed enabled by the bootloader or reset state.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

> ---
>  drivers/irqchip/irq-renesas-irqc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
> index 2ce2edf8ec8ec182..718f01cd1aea19f6 100644
> --- a/drivers/irqchip/irq-renesas-irqc.c
> +++ b/drivers/irqchip/irq-renesas-irqc.c
> @@ -29,6 +29,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/irq-renesas-irqc.h>
> +#include <linux/pm_runtime.h>
>  
>  #define IRQC_IRQ_MAX	32	/* maximum 32 interrupts per driver instance */
>  
> @@ -180,6 +181,9 @@ static int irqc_probe(struct platform_device *pdev)
>  	p->pdev = pdev;
>  	platform_set_drvdata(pdev, p);
>  
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
>  	/* get hold of manadatory IOMEM */
>  	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!io) {
> @@ -260,6 +264,8 @@ err3:
>  err2:
>  	iounmap(p->iomem);
>  err1:
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  	kfree(p);
>  err0:
>  	return ret;
> @@ -275,6 +281,8 @@ static int irqc_remove(struct platform_device *pdev)
>  
>  	irq_domain_remove(p->irq_domain);
>  	iounmap(p->iomem);
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  	kfree(p);
>  	return 0;
>  }
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
