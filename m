From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 5/5] cpufreq: remove no longer needed CPU_FREQ_BOOST_SW config option
Date: Tue, 04 Aug 2015 03:09:11 +0200
Message-ID: <6122974.sHQrqqlTov@vostro.rjw.lan>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com> <1438368557-2352-6-git-send-email-b.zolnierkie@samsung.com> <20150801111537.GH899@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58087 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754824AbbHDAmI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 20:42:08 -0400
In-Reply-To: <20150801111537.GH899@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Saturday, August 01, 2015 04:45:37 PM Viresh Kumar wrote:
> On 31-07-15, 20:49, Bartlomiej Zolnierkiewicz wrote:
> > Remove no longer needed CPU_FREQ_BOOST_SW config option.
> > 
> > As a result scaling_boost_freqs sysfs attribute is available
> > when cpufreq-dt driver is used and boost support is enabled.
> > 
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/cpufreq/Kconfig      | 4 ----
> >  drivers/cpufreq/freq_table.c | 2 --
> >  2 files changed, 6 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index bf6d596..de00a52 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -21,10 +21,6 @@ if CPU_FREQ
> >  config CPU_FREQ_GOV_COMMON
> >  	bool
> >  
> > -config CPU_FREQ_BOOST_SW
> > -	bool
> > -	depends on THERMAL
> > -
> >  config CPU_FREQ_STAT
> >  	tristate "CPU frequency translation statistics"
> >  	default y
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> > index a8f1daf..4c5de5b 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -293,9 +293,7 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_boost_freqs);
> >  
> >  struct freq_attr *cpufreq_generic_attr[] = {
> >  	&cpufreq_freq_attr_scaling_available_freqs,
> > -#ifdef CONFIG_CPU_FREQ_BOOST_SW
> >  	&cpufreq_freq_attr_scaling_boost_freqs,
> > -#endif
> >  	NULL,
> >  };
> >  EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
> 
> So, this will start appearing for all platforms that use cpufreq_generic_attr
> and that may not be the right thing. We may only want to show boost frequencies
> only if the driver supports it.
> 
> @Rafael: What do you say?

I agree.

Thanks,
Rafael

