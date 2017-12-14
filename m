From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] clk: renesas: mstp: Keep wakeup sources active
 during system suspend
Date: Thu, 14 Dec 2017 15:10:52 +0100
Message-ID: <CAPDyKFq7dBHk9AhyMc1x+dJPmDJQ0osR4WkbT0wUR=hZMBScyw@mail.gmail.com>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be> <1510234022-29442-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1510234022-29442-2-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 9 November 2017 at 14:27, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> If a device is part of the CPG/MSTP Clock Domain and to be used as a
> wakeup source, it must be kept active during system suspend.
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
>   - Integrate "clk: renesas: mstp: Use GENPD_FLAG_ACTIVE_WAKEUP",
> ---
>  drivers/clk/renesas/clk-mstp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
> index 500a9e4e03c48957..0b222197a4576fd7 100644
> --- a/drivers/clk/renesas/clk-mstp.c
> +++ b/drivers/clk/renesas/clk-mstp.c
> @@ -344,7 +344,7 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
>                 return;
>
>         pd->name = np->name;
> -       pd->flags = GENPD_FLAG_PM_CLK;
> +       pd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
>         pd->attach_dev = cpg_mstp_attach_dev;
>         pd->detach_dev = cpg_mstp_detach_dev;
>         pm_genpd_init(pd, &pm_domain_always_on_gov, false);
> --
> 2.7.4
>
