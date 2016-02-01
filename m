From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 00/16] PM / OPP: Introduce APIs to transition OPPs
Date: Mon, 1 Feb 2016 11:41:26 -0800
Message-ID: <20160201194126.GJ4848@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <20160130014842.GI4848@codeaurora.org>
 <20160201040857.GB13476@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53714 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbcBATl2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 14:41:28 -0500
Content-Disposition: inline
In-Reply-To: <20160201040857.GB13476@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 02/01, Viresh Kumar wrote:
> On 29-01-16, 17:48, Stephen Boyd wrote:
> > Just a note for future work, I think we're going to need to add
> > some sort of enable/disable into the OPP layer. At least in qcom
> > designs, if a clock is off we don't want the voltage requirement
> > for that clock to factor into the final voltage on the regulator.
> > Furthermore, we want to disable the regulator with
> > regulator_disable() if all the clocks are off.
> 
> Hmm, we need to discuss more on this, maybe in a HO sometime or at
> connect :)

Sure.

> 
> > This is also a problem with cpufreq-dt. The regulators and clocks
> > are assumed to be enabled out of the bootloader, which may not
> > even be true. Now that OPP layer is managing all the clocks and
> > regulators here we're going to need to do something to make sure
> > they're on and controllable.
> 
> Also, I fail to understand, how the clock of a 'online' CPU can be
> off?
> 

Hmm right. The problem is the clock and regulator frameworks
aren't aware that they're enabled already. In the case of the
clocks, if we switch a mux from one source to another while
frequency switching and the framework doesn't know the clock is
on, it won't turn on the new source for the CPU, effectively
killing the CPU.

In the regulator case I ran into a problem with qcom's RPM
regulator implementation where the voltage isn't sent when the
regulator is disabled (the driver has some check for that case).

I suppose in both cases these could be fixed in the frameworks if
they detected on/off state at boot. That's fine, but it doesn't
seem like that will work for things like GPU where the clock may
not be on in the first place. If we don't want to clk_get() and
regulator_get() in two places (OPP and drivers) then we'll need
on/off in OPP code.

In the CPU case, we've turned clocks on and off when CPUs are
hotplugged in and out on qcom platforms so that we can drop the
clock and voltage requirements of a particular CPU. If we had
that CPU driver on ARM platforms it would be similar to the GPU
case then. We could get the clocks and regulators in two places
and we could put the clock/regulator on/off code in the CPU
driver instead of the OPP layer.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
