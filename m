From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
Date: Mon, 25 Apr 2016 08:30:41 +0530
Message-ID: <20160425030041.GF22726@vireshk-i7>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <1c2cc13d812e04f231ddd4313e3ba6a54fb4632c.1461228504.git.viresh.kumar@linaro.org>
 <7576455.rVXD0283Nr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7576455.rVXD0283Nr@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, nm@ti.com, thomas.petazzoni@free-electrons.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 23-04-16, 00:42, Arnd Bergmann wrote:
> On Thursday 21 April 2016 14:29:02 Viresh Kumar wrote:
> > diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> > index 79d0a5d9da8e..f24f46776fbb 100644
> > --- a/arch/arm/mach-mvebu/pmsu.c
> > +++ b/arch/arm/mach-mvebu/pmsu.c
> > @@ -685,8 +685,6 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
> >                         dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> >                                 __func__, ret);
> >         }
> > -
> > -       platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> >         return 0;
> >  }
> >  
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 69b2a222c84e..5704a92c52dc 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -33,6 +33,8 @@ static const struct of_device_id machines[] = {
> >  
> >         { .compatible = "marvell,berlin", },
> >  
> > +       { .compatible = "marvell,armadaxp", },
> > +
> >         { .compatible = "samsung,exynos3250", },
> >         { .compatible = "samsung,exynos4210", },
> >         { .compatible = "samsung,exynos4212", },
> 
> I think to make it clear that the ordering is significant here, I would leave this
> platform_device_register_simple() in armada_xp_pmsu_cpufreq_init().
> 
> However, it might be helpful to move that function into a new file in
> drivers/cpufreq/ if that works.

We just can't get wrong with the ordering here, as this is done from
device_initcall() and so that point is out of question.

The other thing that can happen is that armada_xp_pmsu_cpufreq_init()
call can fail. In that case, most of the times cpufreq-dt ->init()
will fail as well, so even that is fine for me.

And, so I think we can keep this patch as is.

Do you agree ?

-- 
viresh
