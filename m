From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 6/8] cpufreq:exynos:Extend Exynos cpufreq driver to
 support boost framework
Date: Fri, 26 Jul 2013 13:26:17 +0200
Message-ID: <20130726132617.567f2cbf@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-7-git-send-email-l.majewski@samsung.com>
 <CAKohponC=S=3=mrTpWvPvejqSeqfndVOwb2GDkQ0jKxXXa0TOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohponC=S=3=mrTpWvPvejqSeqfndVOwb2GDkQ0jKxXXa0TOQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Jul 2013 15:56:53 +0530 Viresh Kumar wrote,
> On 25 July 2013 22:03, Lukasz Majewski <l.majewski@samsung.com> wrote:
> 
> > diff --git a/drivers/cpufreq/exynos-cpufreq.c
> > b/drivers/cpufreq/exynos-cpufreq.c index 9ae1871..175172d9 100644
> > --- a/drivers/cpufreq/exynos-cpufreq.c
> > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > @@ -270,6 +270,9 @@ static int exynos_cpufreq_cpu_exit(struct
> > cpufreq_policy *policy)
> >
> >  static struct freq_attr *exynos_cpufreq_attr[] = {
> >         &cpufreq_freq_attr_scaling_available_freqs,
> > +#ifdef CONFIG_CPU_FREQ_BOOST_SW
  	    ^^^^^^^^^^^^^^^^^^^^^^^^^ [*]
> 
> Use ARM_EXYNOS_CPU_FREQ_BOOST_SW instead.

For the reasons explained at [PATCH v6 5/8] I would prefer to leave [*]
here.

> 
> > +       &cpufreq_freq_attr_scaling_boost_freqs,
> > +#endif
> >         NULL,
> >  };
> >
> > @@ -332,6 +335,9 @@ static int __init exynos_cpufreq_probe(struct
> > platform_device *pdev)
> >
> >         locking_frequency = exynos_getspeed(0);
> >
> > +#ifdef CONFIG_CPU_FREQ_BOOST_SW
> > +       exynos_driver.boost_supported = true;
> > +#endif
> 
> So, why here and not in the definition of exynos_driver?

Right. I will move this to struct cpufreq_driver exynos_driver.

> 
> >         register_pm_notifier(&exynos_cpufreq_nb);
> >
> >         if (cpufreq_register_driver(&exynos_driver)) {
> > --
> > 1.7.10.4
> >



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
