From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 195/228] cpufreq: kirkwood: remove calls to
 cpufreq_notify_transition()
Date: Fri, 13 Sep 2013 18:18:20 +0200
Message-ID: <20130913161820.GM19363@lunn.ch>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <0a512914fd48b2d6db685446f88b9a096eff79a1.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:53178 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715Ab3IMQV0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 13 Sep 2013 12:21:26 -0400
Content-Disposition: inline
In-Reply-To: <0a512914fd48b2d6db685446f88b9a096eff79a1.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>

On Fri, Sep 13, 2013 at 06:32:21PM +0530, Viresh Kumar wrote:

> -	if (freqs.old != freqs.new) {
> -		local_irq_disable();
> -
> -		/* Disable interrupts to the CPU */
> -		reg = readl_relaxed(priv.base);
> -		reg |= CPU_SW_INT_BLK;
> -		writel_relaxed(reg, priv.base);
> -
> -		switch (state) {
> -		case STATE_CPU_FREQ:
> -			clk_disable(priv.powersave_clk);
> -			break;
> -		case STATE_DDR_FREQ:
> -			clk_enable(priv.powersave_clk);
> -			break;
> -		}

Hi Viresh

I see you removed the test that the old and the new frequency are
different. Is this guaranteed by the core? Because if not, you can
lockup the CPU. The call to cpu_do_idle() will never return.

	Thanks
		Andrew
