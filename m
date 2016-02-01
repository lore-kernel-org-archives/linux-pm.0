From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/16] PM / OPP: Introduce APIs to transition OPPs
Date: Mon, 1 Feb 2016 09:38:57 +0530
Message-ID: <20160201040857.GB13476@vireshk>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <20160130014842.GI4848@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35960 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbcBAEJB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jan 2016 23:09:01 -0500
Received: by mail-pf0-f178.google.com with SMTP id n128so75492240pfn.3
        for <linux-pm@vger.kernel.org>; Sun, 31 Jan 2016 20:09:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160130014842.GI4848@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 29-01-16, 17:48, Stephen Boyd wrote:
> I'll look at this early next week.

Thanks.

> Just a note for future work, I think we're going to need to add
> some sort of enable/disable into the OPP layer. At least in qcom
> designs, if a clock is off we don't want the voltage requirement
> for that clock to factor into the final voltage on the regulator.
> Furthermore, we want to disable the regulator with
> regulator_disable() if all the clocks are off.

Hmm, we need to discuss more on this, maybe in a HO sometime or at
connect :)

> This is also a problem with cpufreq-dt. The regulators and clocks
> are assumed to be enabled out of the bootloader, which may not
> even be true. Now that OPP layer is managing all the clocks and
> regulators here we're going to need to do something to make sure
> they're on and controllable.

Also, I fail to understand, how the clock of a 'online' CPU can be
off?

-- 
viresh
