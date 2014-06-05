From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V5 2/2] cpufreq: Tegra: implement intermediate frequency callbacks
Date: Thu, 5 Jun 2014 12:51:46 -0700
Message-ID: <CAD=FV=UHWEv4WNYdDvvFZ_Ars6TB=YRWf298aKPSjECwjD6a6w@mail.gmail.com>
References: <cover.1401728994.git.viresh.kumar@linaro.org>
	<41e5e755638334388a14821a625b703a1f851185.1401728995.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41e5e755638334388a14821a625b703a1f851185.1401728995.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Viresh,

On Mon, Jun 2, 2014 at 10:19 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Tegra had always been switching to intermediate frequency (pll_p_clk) since
> ever. CPUFreq core has better support for handling notifications for these
> frequencies and so we can adapt Tegra's driver to it.
>
> Also do a WARN() if clk_set_parent() fails while moving back to pll_x as we
> should have atleast restored to earlier frequency on error.
>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/tegra-cpufreq.c | 97 ++++++++++++++++++++++++++---------------
>  1 file changed, 62 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
> index 6e774c6..a5fbc0a 100644
> --- a/drivers/cpufreq/tegra-cpufreq.c
> +++ b/drivers/cpufreq/tegra-cpufreq.c
> @@ -45,46 +45,51 @@ static struct clk *cpu_clk;
>  static struct clk *pll_x_clk;
>  static struct clk *pll_p_clk;
>  static struct clk *emc_clk;
> +static bool pll_x_prepared;
>
> -static int tegra_cpu_clk_set_rate(unsigned long rate)
> +static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
> +                                          unsigned int index)
> +{
> +       unsigned int ifreq = clk_get_rate(pll_p_clk) / 1000;
> +
> +       /*
> +        * Don't switch to intermediate freq if:
> +        * - we are already at it, i.e. policy->cur == ifreq
> +        * - index corresponds to ifreq
> +        */
> +       if ((freq_table[index].frequency == ifreq) || (policy->cur == ifreq))
> +               return 0;
> +
> +       return ifreq;
> +}
> +
> +static int tegra_target_intermediate(struct cpufreq_policy *policy,
> +                                    unsigned int index)
>  {
>         int ret;
>
>         /*
>          * Take an extra reference to the main pll so it doesn't turn
> -        * off when we move the cpu off of it
> +        * off when we move the cpu off of it as enabling it again while we
> +        * switch to it from tegra_target() would take additional time. Though
> +        * when target-freq is intermediate freq, we don't need to take this
> +        * reference.

The "Though when target-freq is intermediate freq, we don't need to
take this reference." makes me think that this function is actually
called when target-freq is intermediate freq.  I don't think it is,
right?

I don't think that's a huge deal, though and code wise this looks good to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>
