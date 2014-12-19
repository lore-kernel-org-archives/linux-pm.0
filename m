From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v8] cpufreq: Add SFI based cpufreq driver support
Date: Fri, 19 Dec 2014 11:31:06 -0500
Message-ID: <CAJvTdKmPpBr_B-1Go7Cc+cBPF3RiRx7te_9ezH09s0HXUVjN6w@mail.gmail.com>
References: <20141218085900.GA31027@intel-desktop>
	<CAJvTdKkpsVGoN=v8h_=4uW=MJ=THPL1C4SKAMM9MBrQM4k30FA@mail.gmail.com>
	<20141219150832.GA21139@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:53540 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaLSQbH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 11:31:07 -0500
Received: by mail-yh0-f41.google.com with SMTP id a41so547587yho.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Dec 2014 08:31:06 -0800 (PST)
In-Reply-To: <20141219150832.GA21139@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

> * If you set the transition_latency as -1/ETERNAL, then the
> interactive and ondemand governors will not load because
> the following condition will be true in __cpufreq_governor
> and thus fallback to performance.
>
>  if (policy->governor->max_transition_latency &&
>             policy->cpuinfo.transition_latency >
>             policy->governor->max_transition_latency) {
>
> $cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_transition_latency
> 4294967295
>
> am i missing something?

Oops, I goofed.
When i saw the definition of
#define CPUFREQ_ETERNAL                 (-1)

I assumed that this was a signed comparison,
but it is UN-signed, and so you are right -- we need to
supply a positive number under 10000 to load ondemand,
and it must be under 500 to have no effect
on ondemand's sample interval.

100 meets that criteria.

thanks,
Len Brown, Intel Open Source Technology Center
