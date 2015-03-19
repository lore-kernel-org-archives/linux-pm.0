From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 1/7] irqchip: renesas-irqc: Add more register
 documentation
Date: Thu, 19 Mar 2015 10:36:18 +0900
Message-ID: <20150319013617.GG14051@verge.net.au>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
 <1426704961-27322-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426704961-27322-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 18, 2015 at 07:55:55PM +0100, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

> ---
>  drivers/irqchip/irq-renesas-irqc.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
> index 2ea3412fdf8cc668..2ce2edf8ec8ec182 100644
> --- a/drivers/irqchip/irq-renesas-irqc.c
> +++ b/drivers/irqchip/irq-renesas-irqc.c
> @@ -30,14 +30,24 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/irq-renesas-irqc.h>
>  
> -#define IRQC_IRQ_MAX 32 /* maximum 32 interrupts per driver instance */
> +#define IRQC_IRQ_MAX	32	/* maximum 32 interrupts per driver instance */
>  
> -#define IRQC_REQ_STS 0x00
> -#define IRQC_EN_STS 0x04
> -#define IRQC_EN_SET 0x08
> +#define IRQC_REQ_STS	0x00	/* Interrupt Request Status Register */
> +#define IRQC_EN_STS	0x04	/* Interrupt Enable Status Register */
> +#define IRQC_EN_SET	0x08	/* Interrupt Enable Set Register */
>  #define IRQC_INT_CPU_BASE(n) (0x000 + ((n) * 0x10))
> -#define DETECT_STATUS 0x100
> +				/* SYS-CPU vs. RT-CPU */
> +#define DETECT_STATUS	0x100	/* IRQn Detect Status Register */
> +#define MONITOR		0x104	/* IRQn Signal Level Monitor Register */
> +#define HLVL_STS	0x108	/* IRQn High Level Detect Status Register */
> +#define LLVL_STS	0x10c	/* IRQn Low Level Detect Status Register */
> +#define S_R_EDGE_STS	0x110	/* IRQn Sync Rising Edge Detect Status Reg. */
> +#define S_F_EDGE_STS	0x114	/* IRQn Sync Falling Edge Detect Status Reg. */
> +#define A_R_EDGE_STS	0x118	/* IRQn Async Rising Edge Detect Status Reg. */
> +#define A_F_EDGE_STS	0x11c	/* IRQn Async Falling Edge Detect Status Reg. */
> +#define CHTEN_STS	0x120	/* Chattering Reduction Status Register */
>  #define IRQC_CONFIG(n) (0x180 + ((n) * 0x04))
> +				/* IRQn Configuration Register */
>  
>  struct irqc_irq {
>  	int hw_irq;
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
