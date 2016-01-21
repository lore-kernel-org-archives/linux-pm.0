From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 17/17] cpufreq: dt: No need to allocate resources anymore
Date: Thu, 21 Jan 2016 08:06:10 +0530
Message-ID: <20160121023610.GC15981@vireshk>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <df2534b4ced57791ec3ee42eb34211e132aa423a.1450777582.git.viresh.kumar@linaro.org>
 <20160112022022.GV22188@codeaurora.org>
 <20160112073426.GP1084@ubuntu>
 <20160121011806.GE12841@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35312 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcAUCgO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 21:36:14 -0500
Received: by mail-pf0-f181.google.com with SMTP id 65so14873010pff.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 18:36:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160121011806.GE12841@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 20-01-16, 17:18, Stephen Boyd wrote:
> Yeah I don't understand why we at least can't populate the OPP
> structures and get the clocks and regulators for all the CPU
> devices before we register the dt_cpufreq_driver structure. The
> CPU devices should exist at that point, and we can wait to do
> CPUfreq transitions until the regulators/clocks for all the CPUs
> are registered. Sure we'd need to find the OPPs that are being
> shared in the cpufreq_init callback and populate the cpu
> frequency tables, etc., but that's not a big deal.

We can do this, yes. But ->init() was really the right place to fix
that, we aren't able to do it properly because we lack a cpu processor
driver for ARM.

> Making a CPU processor driver on ARM/non-ACPI systems would be to
> solve the problem of all these random things like cpuidle-arm and
> cpufreq-dt going through the list of cpu devices and hooking up
> stuff to the cpuidle, cpufreq, and thermal frameworks. That's a
> separate but related problem to probe defering the cpufreq-dt
> driver.

Yeah, I wanted to work on that sometime :)

-- 
viresh
