From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH] PM / OPP: Don't check not plugged in CPUs to avoid error
Date: Mon, 17 Jul 2017 15:03:23 +0200
Message-ID: <CAHKzcEP5+btsJ1Tog4KQAynmmbBSixfWAxO9V0EFWeP5pP5M=w@mail.gmail.com>
References: <20170713122201.30048-1-waldemarx.rymarkiewicz@intel.com>
 <20170713234226.GE22780@codeaurora.org> <20170717071234.GK352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32851 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdGQNEF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 09:04:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id 65so3149678wmf.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 06:04:05 -0700 (PDT)
In-Reply-To: <20170717071234.GK352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>

On 17 July 2017 at 09:12, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 13-07-17, 16:42, Stephen Boyd wrote:
>> On 07/13, Waldemar Rymarkiewicz wrote:

>> Is there some way to iterate through all cpu nodes in DT without
>> using devices? I suppose some sort of loop on top of
>> of_get_cpu_node().
>
> I am looking for the same thing :)
>
>> I worry that we may have some problem where we want to know about
>> all the CPUs that are sharing a particular OPP table but they
>> haven't been physically hotplugged yet.

Isn't that cpufreq registers only online CPUs at boot up and will add
hot-added CPUs later on calling cpufreq_online() ~>
cpufreq_driver->init()?

See   cpufreq_online()

   http://elixir.free-electrons.com/linux/v4.13-rc1/source/drivers/cpufreq/cpufreq.c#L1143

this calls cpufreq_driver->init() which check for sharing CPUs. If
that's called for online_cpus only so I guess it's OK to check only
within online cpus for shared freq_table. If a cpu is plugged in later
 this is called again, so we can eventually add this cpu to the mask.
Is this right?



> We will have a problem if we are going to use OPP framework on
> platforms where CPUs are hotpluggable. The cpumask returned by this
> function is used by the cpufreq drivers to get the related_cpus mask
> and that will be used when a cpu is inserted in later on.

related_cpus bitmask is set in cpufreq_online() too,

   http://elixir.free-electrons.com/linux/v4.13-rc1/source/drivers/cpufreq/cpufreq.c#L1188

Policy->cpus is for online CPUs, so where are the offline CPUs added
to related_cpus mask?


> Do we have such users of OPP framework right now ? ARM doesn't have
> such platforms AFAIK. Does MIPS have it ?

I don't think so there is an up streamed code that uses opp framework
in such use case. I use MIPS platform which starts with maxcpu=4 but
it puts 2 cpus offline at boot up for some reason. Will try to check
how cpufreq behave if I hot-add a CPU in runtime.

>> This also raises the
>> question about what the DT looks like before and after a CPU is
>> inserted into a system. If the non-present CPU nodes are in DT
>> all the time, then it may make sense for cpufreq-dt to intersect
>> the OPP sharing mask with the cpu_present_mask.
>
> We need the related-cpus mask in cpufreq to include non-present CPUs
> as well.

Why? can you refer to the code? I'd like to see it and understand better.

/Waldek

>
> --
> viresh
