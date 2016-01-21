From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 17/17] cpufreq: dt: No need to allocate resources anymore
Date: Wed, 20 Jan 2016 17:18:06 -0800
Message-ID: <20160121011806.GE12841@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <df2534b4ced57791ec3ee42eb34211e132aa423a.1450777582.git.viresh.kumar@linaro.org>
 <20160112022022.GV22188@codeaurora.org>
 <20160112073426.GP1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55784 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbcAUBSI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 20:18:08 -0500
Content-Disposition: inline
In-Reply-To: <20160112073426.GP1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 01/12, Viresh Kumar wrote:
> On 11-01-16, 18:20, Stephen Boyd wrote:
> > On 12/22, Viresh Kumar wrote:
> > > OPP layer manages it now and cpufreq-dt driver doesn't need it. But, we
> > > still need to check for availability of resources for deferred probing.
> > 
> > Why? It seems cleaner to let OPP layer return an error indicating
> > probe defer or failure when we try to initialize it. That way we
> > aren't duplicating the same logic in two places to figure out if
> > a regulator or clock is ready.
> 
> cpufreq driver's ->init() callback doesn't return the error value
> properly to the probe() function, and so it was done this way in the
> first place. The problem is in subsys framework. I tried to fix it but
> it was rejected and we need to fix it some other way:
> 
> http://marc.info/?l=linux-kernel&m=143530948918819&w=2

Yeah I don't understand why we at least can't populate the OPP
structures and get the clocks and regulators for all the CPU
devices before we register the dt_cpufreq_driver structure. The
CPU devices should exist at that point, and we can wait to do
CPUfreq transitions until the regulators/clocks for all the CPUs
are registered. Sure we'd need to find the OPPs that are being
shared in the cpufreq_init callback and populate the cpu
frequency tables, etc., but that's not a big deal.

Making a CPU processor driver on ARM/non-ACPI systems would be to
solve the problem of all these random things like cpuidle-arm and
cpufreq-dt going through the list of cpu devices and hooking up
stuff to the cpuidle, cpufreq, and thermal frameworks. That's a
separate but related problem to probe defering the cpufreq-dt
driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
