From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] soc: renesas: rcar-sysc: Use GENPD_FLAG_ALWAYS_ON
Date: Mon, 12 Jun 2017 14:27:58 +0200
Message-ID: <CAPDyKFrPzzK+-Re-nPvrs_S2wMLDyuNh+1w3_z3w_L7wmy7bEg@mail.gmail.com>
References: <1497259427-8299-1-git-send-email-geert+renesas@glider.be> <1497259427-8299-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1497259427-8299-2-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 June 2017 at 11:23, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Improve handling of always-on PM domains by using the
> GENPD_FLAG_ALWAYS_ON flag introduced in commit ffaa42e8a40b7f10 ("PM /
> Domains: Enable users of genpd to specify always on PM domains").
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/renesas/rcar-sysc.c | 28 ++++------------------------
>  drivers/soc/renesas/rcar-sysc.h |  2 --
>  2 files changed, 4 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
> index dcad5c42a5e81c87..7c8da3c90011422f 100644
> --- a/drivers/soc/renesas/rcar-sysc.c
> +++ b/drivers/soc/renesas/rcar-sysc.c
> @@ -181,17 +181,6 @@ static int rcar_sysc_pd_power_off(struct generic_pm_domain *genpd)
>         struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
>
>         pr_debug("%s: %s\n", __func__, genpd->name);
> -
> -       if (pd->flags & PD_NO_CR) {
> -               pr_debug("%s: Cannot control %s\n", __func__, genpd->name);
> -               return -EBUSY;
> -       }
> -
> -       if (pd->flags & PD_BUSY) {
> -               pr_debug("%s: %s busy\n", __func__, genpd->name);
> -               return -EBUSY;
> -       }
> -
>         return rcar_sysc_power_down(&pd->ch);
>  }
>
> @@ -200,12 +189,6 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
>         struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
>
>         pr_debug("%s: %s\n", __func__, genpd->name);
> -
> -       if (pd->flags & PD_NO_CR) {
> -               pr_debug("%s: Cannot control %s\n", __func__, genpd->name);
> -               return 0;
> -       }
> -
>         return rcar_sysc_power_up(&pd->ch);
>  }
>
> @@ -223,8 +206,7 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
>                  * only be turned off if the CPU is not in use.
>                  */
>                 pr_debug("PM domain %s contains %s\n", name, "CPU");
> -               pd->flags |= PD_BUSY;
> -               gov = &pm_domain_always_on_gov;
> +               genpd->flags |= GENPD_FLAG_ALWAYS_ON;
>         } else if (pd->flags & PD_SCU) {
>                 /*
>                  * This domain contains an SCU and cache-controller, and
> @@ -232,19 +214,17 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
>                  * not in use.
>                  */
>                 pr_debug("PM domain %s contains %s\n", name, "SCU");
> -               pd->flags |= PD_BUSY;
> -               gov = &pm_domain_always_on_gov;
> +               genpd->flags |= GENPD_FLAG_ALWAYS_ON;
>         } else if (pd->flags & PD_NO_CR) {
>                 /*
>                  * This domain cannot be turned off.
>                  */
> -               pd->flags |= PD_BUSY;
> -               gov = &pm_domain_always_on_gov;
> +               genpd->flags |= GENPD_FLAG_ALWAYS_ON;
>         }
>
>         if (!(pd->flags & (PD_CPU | PD_SCU))) {
>                 /* Enable Clock Domain for I/O devices */
> -               genpd->flags = GENPD_FLAG_PM_CLK;
> +               genpd->flags |= GENPD_FLAG_PM_CLK;
>                 if (has_cpg_mstp) {
>                         genpd->attach_dev = cpg_mstp_attach_dev;
>                         genpd->detach_dev = cpg_mstp_detach_dev;
> diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
> index 07edb049a401196c..1a5bebaf54ba191c 100644
> --- a/drivers/soc/renesas/rcar-sysc.h
> +++ b/drivers/soc/renesas/rcar-sysc.h
> @@ -20,8 +20,6 @@
>  #define PD_SCU         BIT(1)  /* Area contains SCU and L2 cache */
>  #define PD_NO_CR       BIT(2)  /* Area lacks PWR{ON,OFF}CR registers */
>
> -#define PD_BUSY                BIT(3)  /* Busy, for internal use only */
> -
>  #define PD_CPU_CR      PD_CPU            /* CPU area has CR (R-Car H1) */
>  #define PD_CPU_NOCR    PD_CPU | PD_NO_CR /* CPU area lacks CR (R-Car Gen2/3) */
>  #define PD_ALWAYS_ON   PD_NO_CR          /* Always-on area */
> --
> 2.7.4
>
