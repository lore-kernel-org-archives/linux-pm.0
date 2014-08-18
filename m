From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 04/16] clk: tegra: Add library for the DFLL clock source
 (open-loop mode)
Date: Mon, 18 Aug 2014 14:05:55 +0800
Message-ID: <53F197C3.5010002@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com> <1405957142-19416-5-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405957142-19416-5-git-send-email-ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 07/21/2014 11:38 PM, Tuomas Tynkkynen wrote:
> Add shared code to support the Tegra DFLL clocksource in open-loop
> mode. This root clocksource is present on the Tegra124 SoCs. The
> DFLL is the intended primary clock source for the fast CPU cluster.
>
> This code is very closely based on a patch by Paul Walmsley from
> December (http://comments.gmane.org/gmane.linux.ports.tegra/15273),
> which in turn comes from the internal driver by originally created
> by Aleksandr Frid <afrid-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.
>
> Subsequent patches will add support for closed loop mode and drivers
> for the Tegra124 fast CPU cluster DFLL devices, which rely on this
> code.
>
> Signed-off-by: Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v2 changes:
>      - minor, moved the devm_regulator_get here
>
>   drivers/clk/tegra/Makefile   |    1 +
>   drivers/clk/tegra/clk-dfll.c | 1085 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/clk/tegra/clk-dfll.h |   55 +++
>   3 files changed, 1141 insertions(+)
>   create mode 100644 drivers/clk/tegra/clk-dfll.c
>   create mode 100644 drivers/clk/tegra/clk-dfll.h
...
> --- /dev/null
> +++ b/drivers/clk/tegra/clk-dfll.c
...
> +
> +/*
> + * Output clock scaler helpers
> + */
> +
> +/**
> + * dfll_scale_dvco_rate - calculate scaled rate from the DVCO rate
> + * @scale_bits: clock scaler value (bits in the DFLL_FREQ_REQ_SCALE field)
> + * @dvco_rate: the DVCO rate
> + *
> + * Apply the same scaling formula that the DFLL hardware uses to scale
> + * the DVCO rate.
> + */
> +static unsigned long dfll_scale_dvco_rate(int scale_bits,
> +					  unsigned long dvco_rate)
> +{
> +	return (u64)dvco_rate * (scale_bits + 1) / DFLL_FREQ_REQ_SCALE_MAX;
> +}
...
> +static u64 dfll_read_monitor_rate(struct tegra_dfll *td)
> +{
> +	u32 v, s;
> +	u64 pre_scaler_rate, post_scaler_rate;
> +
> +	if (!dfll_is_running(td))
> +		return 0;
> +
> +	v = dfll_readl(td, DFLL_MONITOR_DATA);
> +	v = (v & DFLL_MONITOR_DATA_VAL_MASK) >> DFLL_MONITOR_DATA_VAL_SHIFT;
> +	pre_scaler_rate = dfll_calc_monitored_rate(v, td->ref_rate);
> +
> +	s = dfll_readl(td, DFLL_FREQ_REQ);
> +	s = (s & DFLL_FREQ_REQ_SCALE_MASK) >> DFLL_FREQ_REQ_SCALE_SHIFT;
> +	post_scaler_rate = dfll_scale_dvco_rate(pre_scaler_rate, s);
Should be dfll_scale_dvco_rate(s, pre_scaler_rate);

Thanks,
Vince


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
