From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
Date: Mon, 25 Apr 2016 14:53:49 +0200
Message-ID: <6893237.FoNPbfW3DC@wuerfel>
References: <cover.1461228504.git.viresh.kumar@linaro.org> <7576455.rVXD0283Nr@wuerfel> <20160425030041.GF22726@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:52391 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbcDYMye (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 08:54:34 -0400
In-Reply-To: <20160425030041.GF22726@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, nm@ti.com, Andrew Lunn <andrew@lunn.ch>, linaro-kernel@lists.linaro.org, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, sboyd@codeaurora.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, thomas.petazzoni@free-electrons.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Monday 25 April 2016 08:30:41 Viresh Kumar wrote:
> On 23-04-16, 00:42, Arnd Bergmann wrote:
> > On Thursday 21 April 2016 14:29:02 Viresh Kumar wrote:
> > > diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> > > index 79d0a5d9da8e..f24f46776fbb 100644
> > > --- a/arch/arm/mach-mvebu/pmsu.c
> > > +++ b/arch/arm/mach-mvebu/pmsu.c
> > > @@ -685,8 +685,6 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
> > >                         dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> > >                                 __func__, ret);
> > >         }
> > > -
> > > -       platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> > >         return 0;
> > >  }
> > >  
> > > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > index 69b2a222c84e..5704a92c52dc 100644
> > > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > @@ -33,6 +33,8 @@ static const struct of_device_id machines[] = {
> > >  
> > >         { .compatible = "marvell,berlin", },
> > >  
> > > +       { .compatible = "marvell,armadaxp", },
> > > +
> > >         { .compatible = "samsung,exynos3250", },
> > >         { .compatible = "samsung,exynos4210", },
> > >         { .compatible = "samsung,exynos4212", },
> > 
> > I think to make it clear that the ordering is significant here, I would leave this
> > platform_device_register_simple() in armada_xp_pmsu_cpufreq_init().
> > 
> > However, it might be helpful to move that function into a new file in
> > drivers/cpufreq/ if that works.
> 
> We just can't get wrong with the ordering here, as this is done from
> device_initcall() and so that point is out of question.

I realize that the ordering is fixed through the way that the kernel
is linked, my worry is more about someone changing the code in some
way because it's not obvious from reading the code that the
dependency exists. If either the armada_xp_pmsu_cpufreq_init()
initcall gets changed so it does not always get called, or the
cpufreq_dt_platdev_init() initcall gets changed so it comes a little
earlier, things will break.

> The other thing that can happen is that armada_xp_pmsu_cpufreq_init()
> call can fail. In that case, most of the times cpufreq-dt ->init()
> will fail as well, so even that is fine for me.
> 
> And, so I think we can keep this patch as is.

What are the downsides of moving armada_xp_pmsu_cpufreq_init()
into drivers/cpufreq?

	Arnd
