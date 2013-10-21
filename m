From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Mon, 21 Oct 2013 17:42:39 +0200
Message-ID: <20131021154239.GB23593@lunn.ch>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
 <1382186261-14482-2-git-send-email-andrew@lunn.ch>
 <52650523.80400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42902 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626Ab3JUPrA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Oct 2013 11:47:00 -0400
Content-Disposition: inline
In-Reply-To: <52650523.80400@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

> >+	if (freqs.old != freqs.new) {
> >+		local_irq_disable();
> >+
> >+		/* Mask IRQ and FIQ to CPU */
> >+		cr = readl(priv.pmu_cr);
> >+		cr |= MASK_IRQ | MASK_FIQ;
> >+		writel(cr, priv.pmu_cr);
> >+
> >+		/* Set/Clear the CPU_SLOW_EN bit */
> >+		reg = readl_relaxed(priv.dfs + DFS_CR);
> >+		reg &= ~L2_RATIO_MASK;
> >+
> >+		switch (state) {
> >+		case STATE_CPU_FREQ:
> >+			reg |= priv.xpratio;
> >+			reg &= ~CPU_SLOW_EN;
> >+			break;
> >+		case STATE_DDR_FREQ:
> >+			reg |= (priv.dpratio | CPU_SLOW_EN);
> 
> Does slow mode really (only) depend on the value written into CPUL2CR?
> Dove FS isn't that chatty about it and I cannot really test right now.
> But reading it, I think there is two CPU PLL to {L2,DDR} ratios that you
> can switch between by (de-)asserting CPU_SLOW_EN.

Hi Sebastian

The lack of details in the datasheet was very annoying. I spent many
evenings looking at a frozen up cubox. In the end i had to risk eye
cancer and look at the Marvell vendor code. It always sets these
values on each transition, and it even calculated one of the ratios
each time the frequency changed. I never actually tried setting them
once and then leaving them alone. Worth a try once i have the hardware
available.

> >+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	priv.dfs = devm_ioremap_resource(&pdev->dev, res);
> >+	if (IS_ERR(priv.dfs))
> >+		return PTR_ERR(priv.dfs);
> >+
> >+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >+	priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
> >+	if (IS_ERR(priv.pmu_cr))
> 
> Cleanup path for most of the resources here and below is kind of
> missing. 

Well, i'm using devm_ioremap_resources().  The cleanup for that should
happen automagically. And platform_get_resource() is just a lookup
function.

> Also, maybe give names to the different areas and not depend
> on ordering?

Actually, they already have names, but you probably have not go to
that patch yet. So swapping to platform_get_resource_byname() would be
simple.

Thanks
	Andrew
