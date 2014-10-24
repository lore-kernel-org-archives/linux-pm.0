From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 03/16] clk: tegra: Add closed loop support for the
 DFLL
Date: Fri, 24 Oct 2014 18:13:30 +0300
Message-ID: <544A6C9A.9050404@mentor.com>
References: <1414161563-16812-1-git-send-email-mikko.perttunen@kapsi.fi> <1414161563-16812-4-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414161563-16812-4-git-send-email-mikko.perttunen-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 24.10.2014 17:39, Mikko Perttunen wrote:
> From: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> With closed loop support, the clock rate of the DFLL can be adjusted.
> 
> The oscillator itself in the DFLL is a free-running oscillator whose
> rate is directly determined the supply voltage. However, the DFLL
> module contains logic to compare the DFLL output rate to a fixed
> reference clock (51 MHz) and make a decision to either lower or raise
> the DFLL supply voltage. The DFLL module can then autonomously change
> the supply voltage by communicating with an off-chip PMIC via either I2C
> or PWM signals. This driver currently supports only I2C.
> 
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
> ---
>  drivers/clk/tegra/clk-dfll.c | 657 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 654 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index 358c5d4..e71f4fb 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c

[snip]

> +/**
>   * dfll_fetch_common_params - read DFLL parameters from the device tree
>   * @td: DFLL instance
>   *
> @@ -923,6 +1563,13 @@ static int dfll_fetch_common_params(struct tegra_dfll *td)
>  	bool ok = true;
>  
>  	ok &= read_dt_param(td, "nvidia,droop-ctrl", &td->droop_ctrl);
> +	ok &= read_dt_param(td, "nvidia,sample-rate", &td->sample_rate);
> +	ok &= read_dt_param(td, "nvidia,force-mode", &td->force_mode);
> +	ok &= read_dt_param(td, "nvidia,cf", &td->cf);
> +	ok &= read_dt_param(td, "nvidia,ci", &td->ci);
> +	ok &= read_dt_param(td, "nvidia,cg", &td->cg);
> +	td->cg_scale = of_property_read_bool(td->dev->of_node,
> +					     "nvidia,cg-scale");

Oh, I see here you exploit read_dt_param() intensively.

>  	if (of_property_read_string(td->dev->of_node, "clock-output-names",
>  				    &td->output_clock_name)) {
> @@ -978,6 +1625,10 @@ int tegra_dfll_register(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> +	ret = dfll_fetch_i2c_params(td);
> +	if (ret)
> +		return ret;
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!mem) {
>  		dev_err(td->dev, "no control register resource\n");
> 

--
With best wishes,
Vladimir
