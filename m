From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Tue, 17 Dec 2013 23:06:57 +0100
Message-ID: <20131217220657.GE2281@lunn.ch>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-2-git-send-email-andrew@lunn.ch>
 <CAKohpo=cPMF+Op_EOwPy2Nn0wz=7bSepCy08DPJAvpmcN7o0AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:35035 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab3LQWHb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Dec 2013 17:07:31 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpo=cPMF+Op_EOwPy2Nn0wz=7bSepCy08DPJAvpmcN7o0AA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index ce52ed949249..af7c4947f218 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -8,6 +8,11 @@ config ARM_BIG_LITTLE_CPUFREQ
> >         help
> >           This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
> >
> > +config ARM_DOVE_CPUFREQ
> > +       def_bool ARCH_DOVE && OF
> > +       help
> > +         This adds the CPUFreq driver for Marvell Dove SoCs.
> 
> Please add this one after DT_BL one.. I know you wanted to keep
> them in alphabetical order (probably we need to rename DT_BL),
> but keeping both BIG LITTLE options makes more sense.
> 
> I will do the renaming later.

O.K, once the binding is agreed, i will make this change.
 
> >  config ARM_DT_BL_CPUFREQ
> >         tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver"
> >         depends on ARM_BIG_LITTLE_CPUFREQ && OF
> 
> > diff --git a/drivers/cpufreq/dove-cpufreq.c b/drivers/cpufreq/dove-cpufreq.c
> > +static int dove_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +       struct device *cpu_dev;
> > +       struct resource *res;
> > +       int err, irq;
> > +
> > +       memset(&priv, 0, sizeof(priv));
> > +       priv.dev = &pdev->dev;
> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +                                          "cpufreq: DFS");
> > +       priv.dfs = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(priv.dfs))
> > +               return PTR_ERR(priv.dfs);
> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +                                          "cpufreq: PMU CR");
> > +       priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(priv.pmu_cr))
> > +               return PTR_ERR(priv.pmu_cr);
> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +                                          "cpufreq: PMU Clk Div");
> > +       priv.pmu_clk_div = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(priv.pmu_clk_div))
> > +               return PTR_ERR(priv.pmu_clk_div);
> > +
> > +       cpu_dev = get_cpu_device(0);
> > +
> > +       priv.cpu_clk = devm_clk_get(cpu_dev, "cpu_clk");
> > +       if (IS_ERR(priv.cpu_clk)) {
> > +               err = PTR_ERR(priv.cpu_clk);
> > +               goto out;
> > +       }
> 
> You are doing clk_disable_unprepare in out, and you haven't enabled
> them yet. So, just return error from here.

You are missing part of the clk API, which makes this work, and keeps
the code simple. NULL is a valid clock, and enable/disable and
prepare/unprepare are NOP with a NULL clock. So the code after out:
should mostly do the right thing. However what i do have wrong is not
checking for IS_ERR() before clk_disable_unprepare(). I will fix that.

> > +
> > +       dove_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
> 
> Because you are using 0 and 1 in index for CPU and DDR freq at multiple
> places, probably makes sense to make Macros for them ?

O.K.
 
Thanks for the review,

       Andrew
