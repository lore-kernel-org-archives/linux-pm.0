From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: imx: update the clock switch flow to support imx6ul
Date: Mon, 05 Oct 2015 22:49:32 +0200
Message-ID: <40126314.fXMZovt841@vostro.rjw.lan>
References: <1441986065-8821-1-git-send-email-b51503@freescale.com> <20150911080741.GJ9650@linux> <55F292ED.1080000@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43593 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751115AbbJEUVD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 16:21:03 -0400
In-Reply-To: <55F292ED.1080000@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bai Ping <b51503@freescale.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, September 11, 2015 04:38:05 PM Bai Ping wrote:
> 
> On 2015/9/11 16:07, Viresh Kumar wrote:
> > On 11-09-15, 23:41, Bai Ping wrote:
> >> +	if (of_machine_is_compatible("fsl,imx6ul")) {
> >> +		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
> >> +		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
> >> +		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
> >> +			dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
> >> +			ret = -ENOENT;
> >> +			goto put_clk;
> >> +		}
> >> +	}
> >> +
> >>   	arm_reg = regulator_get(cpu_dev, "arm");
> >>   	pu_reg = regulator_get_optional(cpu_dev, "pu");
> >>   	soc_reg = regulator_get(cpu_dev, "soc");
> >> @@ -331,6 +365,10 @@ put_clk:
> >>   		clk_put(step_clk);
> >>   	if (!IS_ERR(pll2_pfd2_396m_clk))
> >>   		clk_put(pll2_pfd2_396m_clk);
> >> +	if (!IS_ERR(pll2_bus_clk))
> >> +		clk_put(pll2_bus_clk);
> >> +	if (!IS_ERR(secondary_sel_clk))
> >> +		clk_put(secondary_sel_clk);
> >>   	of_node_put(np);
> >>   	return ret;
> >>   }
> > As part of good coding practices, you should free resources in the
> > reverse order to which they were allocated. The clocks don't follow
> > that, but its not a problem with just your patch. That's how it is
> > present today. Maybe you can write another patch to fix that.
> 
> thanks for your suggestion, I will pay more attention to it in future 
> coding.
> 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!

Rafael

