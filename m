From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [TEST PATCH] WIP: Test OPP multi regulator support with
 ti-opp-domain driver
Date: Wed, 16 Nov 2016 08:57:49 +0530
Message-ID: <20161116032749.GE17245@vireshk-i7>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <20161115221059.31629-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36171 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbcKPD1w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 22:27:52 -0500
Received: by mail-pg0-f54.google.com with SMTP id f188so73735329pgc.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2016 19:27:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161115221059.31629-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, robh@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>

Thanks for this Dave :)

On 15-11-16, 16:10, Dave Gerlach wrote:
> NOT FOR MERGE!
> 
> Introduce a test version of a 'ti-opp-domain' driver that will use new
> multiple regulator support introduced to the OPP core by Viresh [1].
> Tested on v4.9-rc1 with that series applied.  This is needed on TI
> platforms like DRA7/AM57 in order to control both CPU regulator and
> Adaptive Body Bias (ABB) regulator as described by Nishanth Menon here
> [2]. These regulators must be scaled in sequence during an OPP
> transition depending on whether or not the frequency is being scaled up
> or down. Based on the new functionality provided by Viresh this driver
> does the following:
> 
> * Call dev_pm_opp_set_regulators with the names of the two regulators
>   that feed the CPU:
> 	* vdd is the 'cpu-supply' commonly used for cpufreq-dt but
> 	  renamed so the cpufreq-dt driver doesn't use it directly.
> 	  Note that this is supplied in board dts as it's external to
> 	  SoC.

I think I can fix this somehow.. Lemme check.

> 	* vbb for the ABB regulator. This is provided in SoC dtsi as it
> 	  is internal to the SoC.
> * Provide a platform set_opp function using
>   dev_pm_opp_register_set_opp_helper that is called when an OPP
>   transition is requested.
> * Allow cpufreq-dt to probe which will work because no cpu-supply
>   regulator is found so the driver proceeds and calls
>   dev_pm_opp_set_rate which through the OPP core invokes the platform
>   set_opp call we provided
> * Platform set_opp call provided by this driver checks to see if we are
>   scaling frequency up or down and based on this, scales vbb before vdd
>   for up or the other way around for down.
> 
> In addition to that, this driver implements AVS Class 0 as described in
> section 18.4.6.12 of AM572x TRM [3] using the same platform set_rate
> hook added to the OPP core. There are registers that define the optimal
> voltage for that specific piece of silicon for an OPP so this driver
> simply looks up this optimal value and programs that for an OPP instead
> of the nominal value.
> 
> Missing from this is a good way to ensure that cpufreq-dt does not just
> proceed if no cpu-supply regulator is found but we were intending to
> rely on a platform set_opp and multiple regulators.
> 
> [1] https://marc.info/?l=linux-pm&m=147746362402994&w=2
> [2] https://marc.info/?l=linux-pm&m=145684495832764&w=2
> [3] http://www.ti.com/lit/ug/spruhz6g/spruhz6g.pdf
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |   2 +-
>  arch/arm/boot/dts/dra7.dtsi                     |  46 ++-
>  drivers/soc/ti/Makefile                         |   2 +
>  drivers/soc/ti/ti-opp-domain.c                  | 427 ++++++++++++++++++++++++

I would rather ask you to move this to drivers/base/power/opp/ 

-- 
viresh
