From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Wed, 4 Dec 2013 16:27:26 +0100
Message-ID: <20131204152726.GC8062@lunn.ch>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-2-git-send-email-andrew@lunn.ch>
 <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:56684 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932254Ab3LDP1e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Dec 2013 10:27:34 -0500
Content-Disposition: inline
In-Reply-To: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

> > +static int dove_cpufreq_target(struct cpufreq_policy *policy,
> > +			       unsigned int index)
> > +{
> > +	unsigned int state = dove_freq_table[index].driver_data;
> > +	unsigned long reg, cr;
> > +
> > +	local_irq_disable();
> > +
> > +	/* Mask IRQ and FIQ to CPU */
> > +	cr = readl(priv.pmu_cr);
> > +	cr |= MASK_IRQ | MASK_FIQ;
> > +	writel(cr, priv.pmu_cr);
> > +
> > +	/* Set/Clear the CPU_SLOW_EN bit */
> > +	reg = readl_relaxed(priv.dfs + DFS_CR);
> > +	reg &= ~L2_RATIO_MASK;
> > +
> > +	switch (state) {
> > +	case STATE_CPU_FREQ:
> > +		reg |= priv.xpratio;
> > +		reg &= ~CPU_SLOW_EN;
> > +		break;
> > +	case STATE_DDR_FREQ:
> > +		reg |= (priv.dpratio | CPU_SLOW_EN);
> > +		break;
> > +	}
> > +
> > +	/* Start the DFS process */
> > +	reg |= DFS_EN;
> > +
> > +	writel(reg, priv.dfs + DFS_CR);
> > +
> > +	/* Wait-for-Interrupt, while the hardware changes frequency */
> > +	cpu_do_idle();
> > +
> > +	local_irq_enable();
> 
> Just to check -- does the PMU automatically unmask IRQ and FIQ? 

The data sheet says so, yes.

> > +static int dove_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +	struct device *cpu_dev;
> > +	struct resource *res;
> > +	int err, irq;
> > +
> > +	memset(&priv, 0, sizeof(priv));
> > +	priv.dev = &pdev->dev;
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +					   "cpufreq: DFS");
> > +	priv.dfs = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(priv.dfs))
> > +		return PTR_ERR(priv.dfs);
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +					   "cpufreq: PMU CR");
> > +	priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(priv.pmu_cr))
> > +		return PTR_ERR(priv.pmu_cr);
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +					   "cpufreq: PMU Clk Div");
> > +	priv.pmu_clk_div = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(priv.pmu_clk_div))
> > +		return PTR_ERR(priv.pmu_clk_div);
> 
> I'd very much prefer that the PMU were described in the DT, and the
> driver probed based on that.

Please see my other response. We can discuss that there.
 
> > +
> > +	cpu_dev = get_cpu_device(0);
> > +
> > +	priv.cpu_clk = devm_clk_get(cpu_dev, "cpu_clk");
> > +	if (IS_ERR(priv.cpu_clk)) {
> > +		err = PTR_ERR(priv.cpu_clk);
> > +		goto out;
> > +	}
> 
> I think it would be better to describe the clocks as being fed to the
> PMU than directly to the CPU -- the PMU selects the appropriate clock
> and feeds it to the CPU.

The wording in the data sheet is not very clear:

    The PMU initiates new clock ratio values for the CPU subsystem
    clocks generation unit.

So to me, the PMU is not the clock consumer, it just controls the
clock generation unit. There is also a block diagram which shows the
"CPU Subsystem ClockGen" as being external to the PMU.
 
> Also, the clocks could be named better with respect to their logical
> function. One is the high-frequency default, and the other is a
> low-frequency option. They're both able to feed the CPU, and the fact
> that one also feeds the DDR isn't relevant to the CPU.

The data sheet uses the terms Turbo Speed and Slow Speed modes. So i
could call them turbo and slow? However, the current names follow the
kirkwood cpufreq driver. It also can swap between a fast clock and the
DDR clock. So i thought keeping the drivers similar would help with
the maintenance burden. 

    Andrew
