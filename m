From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Don't check not plugged in CPUs to avoid error
Date: Tue, 18 Jul 2017 10:05:36 +0530
Message-ID: <20170718043536.GT352@vireshk-i7>
References: <20170713122201.30048-1-waldemarx.rymarkiewicz@intel.com>
 <20170713234226.GE22780@codeaurora.org>
 <20170717071234.GK352@vireshk-i7>
 <CAHKzcEP5+btsJ1Tog4KQAynmmbBSixfWAxO9V0EFWeP5pP5M=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33724 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdGREfk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 00:35:40 -0400
Received: by mail-pf0-f170.google.com with SMTP id e26so5261849pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 21:35:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHKzcEP5+btsJ1Tog4KQAynmmbBSixfWAxO9V0EFWeP5pP5M=w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>

On 17-07-17, 15:03, Waldemar Rymarkiewicz wrote:
> Isn't that cpufreq registers only online CPUs at boot up and will add
> hot-added CPUs later on calling cpufreq_online() ~>

Yes, but its a bit complicated than that.

> cpufreq_driver->init()?

init() is called only once for a cpufreq policy and it should fill
policy->cpus with all the *possible* CPUs that share their
clock/voltage rails. i.e. it includes the CPUs which aren't hotplugged
in yet.

Later on when the CPU gets hotplugged in, we check it in existing
policies ->related_cpus field. If its their, then very minimal stuff
is done, else a new policy is created.

> this calls cpufreq_driver->init() which check for sharing CPUs. If
> that's called for online_cpus only so I guess it's OK to check only
> within online cpus for shared freq_table. If a cpu is plugged in later
>  this is called again, so we can eventually add this cpu to the mask.
> Is this right?
>
> > We will have a problem if we are going to use OPP framework on
> > platforms where CPUs are hotpluggable. The cpumask returned by this
> > function is used by the cpufreq drivers to get the related_cpus mask
> > and that will be used when a cpu is inserted in later on.

And that's why I said this.

> related_cpus bitmask is set in cpufreq_online() too,
> 
>    http://elixir.free-electrons.com/linux/v4.13-rc1/source/drivers/cpufreq/cpufreq.c#L1188
> 
> Policy->cpus is for online CPUs, so where are the offline CPUs added
> to related_cpus mask?

So policy->init() sets policy->cpus to all online+offline CPUs. That
is copied to related_cpus by core and then policy->cpus is capped to
only have online CPUs.
 
> I don't think so there is an up streamed code that uses opp framework
> in such use case. I use MIPS platform which starts with maxcpu=4 but
> it puts 2 cpus offline at boot up for some reason. Will try to check
> how cpufreq behave if I hot-add a CPU in runtime.

Ok.

-- 
viresh
