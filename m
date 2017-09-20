From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 1/7] PM / OPP: Add platform specific set_clk function
Date: Wed, 20 Sep 2017 15:03:43 +0800
Message-ID: <20170920070343.GA32187@b29396-OptiPlex-7040>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
 <1503504610-12880-2-git-send-email-aisheng.dong@nxp.com>
 <20170919225840.GI30848@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37945 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdITHD4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 03:03:56 -0400
Content-Disposition: inline
In-Reply-To: <20170919225840.GI30848@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com

Hi Viresh,

On Tue, Sep 19, 2017 at 03:58:40PM -0700, Viresh Kumar wrote:
> On 24-08-17, 00:10, Dong Aisheng wrote:
> > This is useful to support platforms which only the clk setting is
> > different from the generic OPP set rate but others like voltage
> > setting are still the same.
> > 
> > Users can use this function to register a custom OPP set clk helper
> > working in place of the default simple clk setting in the generic
> > dev_pm_opp_set_rate(). Then user can still use dev_pm_opp_set_rate()
> > with .set_clk() to save a lot duplicated work.
> 
> I am not inclined to add this support really. What prevents you to
> register a clock for the device (which is CPU in your case) and the
> generic clk_set_rate() will eventually call into the platform specific
> routine. That's what everyone else is doing.
> 

I've been thinking of that before.
Actually IMX already does some similar thing for MX5 (no for MX6).
See: clk_cpu_set_rate() in drivers/clk/imx/clk-cpu.c.

After some diggings, it seems MX7ULP is a bit more complicated than before
mainly due to two reasons:
1) It requires to switch to different CPU mode accordingly when setting
clocks rate. That means we need handle this in clock driver as well
which looks not quite suitable although we could do if really want.

2) It uses different clocks for different CPU mode (RUN 416M or
HSRUN 528M), and those clocks have some dependency.
e.g. when setting HSRUN clock, we need change RUN clock parent to make sure
the SPLL_PFD is got disabled before changing rate, as both CPU mode using
the same parent SPLL_PFD clock. Doing this in clock driver also make things
a bit more complicated.

The whole follow would be something like below:
static int imx7ulp_set_clk(struct device *dev, struct clk *clk,
                           unsigned long old_freq, unsigned long new_freq)
{
        u32 val;

        /*
         * Before changing the ARM core PLL, change the ARM clock soure
         * to FIRC first.
         */
        if (new_freq >= HSRUN_FREQ) {
                clk_set_parent(clks[RUN_SCS_SEL].clk, clks[FIRC].clk);

                /* switch to HSRUN mode */
                val = readl_relaxed(smc_base + SMC_PMCTRL);
                val |= (0x3 << 8);
                writel_relaxed(val, smc_base + SMC_PMCTRL);

                /* change the clock rate in HSRUN */
                clk_set_rate(clks[SPLL_PFD0].clk, new_freq);
                clk_set_parent(clks[HSRUN_SCS_SEL].clk, clks[SPLL_SEL].clk);
        } else {
                /* change the HSRUN clock to firc */
                clk_set_parent(clks[HSRUN_SCS_SEL].clk, clks[FIRC].clk);

                /* switch to RUN mode */
                val = readl_relaxed(smc_base + SMC_PMCTRL);
                val &= ~(0x3 << 8);
                writel_relaxed(val, smc_base + SMC_PMCTRL);

                clk_set_rate(clks[SPLL_PFD0].clk, new_freq);
                clk_set_parent(clks[RUN_SCS_SEL].clk, clks[SPLL_SEL].clk);
        }

        return 0;
}

That's why i thought if we can make OPP core provide a way to handle such
complicated things in platform specific cpufreq driver.

How would you suggest for this issue?

Regards
Dong Aisheng

> -- 
> viresh
