From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 1/6] cpufreq: make scaling_boost_freqs sysfs attr
 available when boost is enabled
Date: Fri, 07 Aug 2015 12:34:23 +0200
Message-ID: <5184469.cOpIkgzX4h@amdc1976>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <1438868514-8814-2-git-send-email-b.zolnierkie@samsung.com>
 <20150807034128.GE6325@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150807034128.GE6325@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org


Hi,

On Friday, August 07, 2015 09:11:28 AM Viresh Kumar wrote:
> Hi,
> 
> I would suggest you sending such patches as reply to the earlier
> threads only, instead of a new chain. This will save your time.

Please explain it more.  This patch needs to be first for cpufreq-dt
switch to be complete.  scaling_boost_freqs is available currently
for exynos-cpufreq users when boost is enabled and ideally we would
like it to be available immediately after the switch to cpufreq-dt.

> For example, you will need to resend other patches unnecessarily if I
> NAK this patch :)
> 
> On 06-08-15, 15:41, Bartlomiej Zolnierkiewicz wrote:
> > Add cpufreq_boost_enabled_generic_attr table and use it in
> > cpufreq-dt driver instead of cpufreq_generic_attr one when
> > boost support is enabled.  As a result scaling_boost_freqs
> > sysfs attribute is available when cpufreq-dt driver is
> > used and boost support is enabled.
> > 
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c | 3 +++
> >  drivers/cpufreq/freq_table.c | 7 +++++++
> >  include/linux/cpufreq.h      | 1 +
> >  3 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index b9259ab..7b091c0 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -182,6 +182,8 @@ try_again:
> >  	return ret;
> >  }
> >  
> > +static struct cpufreq_driver dt_cpufreq_driver;
> > +
> >  static int cpufreq_init(struct cpufreq_policy *policy)
> >  {
> >  	struct cpufreq_frequency_table *freq_table;
> > @@ -336,6 +338,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  		ret = cpufreq_enable_boost_support();
> >  		if (ret)
> >  			goto out_free_cpufreq_table;
> > +		dt_cpufreq_driver.attr = cpufreq_boost_enabled_generic_attr;
> >  	}
> >  
> >  	policy->cpuinfo.transition_latency = transition_latency;
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> > index a8f1daf..5a00a09 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -300,6 +300,13 @@ struct freq_attr *cpufreq_generic_attr[] = {
> >  };
> >  EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
> >  
> > +struct freq_attr *cpufreq_boost_enabled_generic_attr[] = {
> > +	&cpufreq_freq_attr_scaling_available_freqs,
> > +	&cpufreq_freq_attr_scaling_boost_freqs,
> > +	NULL,
> > +};
> > +EXPORT_SYMBOL_GPL(cpufreq_boost_enabled_generic_attr);
> 
> This isn't scalable. We can't create a new generic structure every time
> a entry comes in. Rather we should leave the generic attr for

boost entry is rather generic one so I imagine that other cpufreq
drivers that add support for boost would also like to use it.

Anyway since there are no such drivers currently I agree that
making a new generic structure may be premature and I will re-do
this patch according to your request.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> cpufreq-dt and do something like this in the cpufreq-dt driver (And
> that patch should rather go via cpufreq tree and not ARM SoC)..
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index a5b6a854661f..e229258ad791 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -36,6 +36,12 @@ struct private_data {
>  	unsigned int voltage_tolerance; /* in percentage */
>  };
>  
> +static struct freq_attr *cpufreq_dt_attr[] = {
> +	&cpufreq_freq_attr_scaling_available_freqs,
> +	NULL,	/* Extra space for boost-attr if required */
> +	NULL,
> +};
> +
>  static int set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
>  	struct dev_pm_opp *opp;
> @@ -337,6 +343,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		ret = cpufreq_enable_boost_support();
>  		if (ret)
>  			goto out_free_cpufreq_table;
> +		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
>  	}
>  
>  	policy->cpuinfo.transition_latency = transition_latency;
> @@ -412,7 +419,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>  	.exit = cpufreq_exit,
>  	.ready = cpufreq_ready,
>  	.name = "cpufreq-dt",
> -	.attr = cpufreq_generic_attr,
> +	.attr = cpufreq_dt_attr,
>  };
>  
>  static int dt_cpufreq_probe(struct platform_device *pdev)
