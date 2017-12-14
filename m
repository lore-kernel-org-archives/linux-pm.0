From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/3] soc: renesas: rcar-sysc: Keep wakeup sources
 active during system suspend
Date: Thu, 14 Dec 2017 15:11:39 +0100
Message-ID: <CAPDyKFrxaghoAcWJN1R7d7k5b=QwMpusGFuohVZpTaWngf3aiw@mail.gmail.com>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be> <1510234022-29442-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1510234022-29442-4-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 9 November 2017 at 14:27, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> If an R-Car SYSC slave device is part of the CPG/MSTP or CPG/MSSR Clock
> Domain and to be used as a wakeup source, it must be kept active during
> system suspend.
>
> Currently this is handled in device-specific drivers by explicitly
> increasing the use count of the module clock when the device is
> configured as a wakeup source.  However, the proper way to prevent the
> device from being stopped is to inform this requirement to the genpd
> core, by setting the GENPD_FLAG_ACTIVE_WAKEUP flag.
>
> Note that this will only affect devices configured as wakeup sources.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v2:
>   - Integrate "soc: renesas: rcar-sysc: Use GENPD_FLAG_ACTIVE_WAKEUP",
> ---
>  drivers/soc/renesas/rcar-sysc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
> index c8406e81640f6560..ac4df1c43b2fbdbe 100644
> --- a/drivers/soc/renesas/rcar-sysc.c
> +++ b/drivers/soc/renesas/rcar-sysc.c
> @@ -224,7 +224,7 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
>
>         if (!(pd->flags & (PD_CPU | PD_SCU))) {
>                 /* Enable Clock Domain for I/O devices */
> -               genpd->flags |= GENPD_FLAG_PM_CLK;
> +               genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
>                 if (has_cpg_mstp) {
>                         genpd->attach_dev = cpg_mstp_attach_dev;
>                         genpd->detach_dev = cpg_mstp_detach_dev;
> --
> 2.7.4
>
