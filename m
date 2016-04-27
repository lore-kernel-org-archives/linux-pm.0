From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] clk: renesas: mstp: Use always-on governor for Clock Domain
Date: Wed, 27 Apr 2016 15:59:52 +0200
Message-ID: <CAPDyKFqApbcY9apg7dtGh=y71607c0hPHvEGDOo-skUTwCrUCg@mail.gmail.com>
References: <1461654582-668-1-git-send-email-geert+renesas@glider.be>
	<1461654582-668-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461654582-668-3-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26 April 2016 at 09:09, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> As a pure Clock Domain does not have the concept of powering the domain
> itself, the CPG/MSTP driver does not provide power_off() and power_on()
> callbacks.
> However, the genpd core may still perform a dummy power down, causing
> /sys/kernel/debug/pm_genpd/pm_genpd_summary to report the domain's
> status being "off-0".
>
> Use the always-on governor to make sure the domain is never powered
> down, and always shows up as "on" in pm_genpd_summary.

Hmm.

Hypothetically, what if the clock domain would be a subdomain, where
its master is able to power down? Using the always on governor would
prevent the master from power off as well.

I am wondering whether we should introduce some similar as
pm_runtime_no_callbacks() but for the generic PM domain instead.

What do you think?

>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/clk/renesas/clk-mstp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
> index 969fbb61ab07b9b8..5093a250650dad6d 100644
> --- a/drivers/clk/renesas/clk-mstp.c
> +++ b/drivers/clk/renesas/clk-mstp.c
> @@ -319,7 +319,7 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
>         pd->flags = GENPD_FLAG_PM_CLK;
>         pd->attach_dev = cpg_mstp_attach_dev;
>         pd->detach_dev = cpg_mstp_detach_dev;
> -       pm_genpd_init(pd, &simple_qos_governor, false);
> +       pm_genpd_init(pd, &pm_domain_always_on_gov, false);
>
>         of_genpd_add_provider_simple(np, pd);
>  }
> --
> 1.9.1
>

Kind regards
Uffe
