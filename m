From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RFC][PATCH v3 2/2] cpufreq: schedutil: Avoid reducing frequency
 of busy CPUs prematurely
Date: Fri, 24 Mar 2017 12:08:24 -0700
Message-ID: <58D56EA8.5050708@nvidia.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan> <3300960.HE4b3sK4dn@aspire.rjw.lan> <2997922.DidfPadJuT@aspire.rjw.lan> <58D42173.2080205@nvidia.com> <CAJZ5v0jTi6BkKiCXp9PLMAoHmC_rz9bobU5nZKo-OXq2dUKSeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1986 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934104AbdCXTKt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 15:10:49 -0400
In-Reply-To: <CAJZ5v0jTi6BkKiCXp9PLMAoHmC_rz9bobU5nZKo-OXq2dUKSeQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Boonstoppel <pboonstoppel@nvidia.com>

On 03/23/2017 06:39 PM, Rafael J. Wysocki wrote:
> On Thu, Mar 23, 2017 at 8:26 PM, Sai Gurrappadi <sgurrappadi@nvidia.com> wrote:
>> Hi Rafael,
> 
> Hi,
> 
>> On 03/21/2017 04:08 PM, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> <snip>
>>
>>>
>>> That has been attributed to CPU utilization metric updates on task
>>> migration that cause the total utilization value for the CPU to be
>>> reduced by the utilization of the migrated task.  If that happens,
>>> the schedutil governor may see a CPU utilization reduction and will
>>> attempt to reduce the CPU frequency accordingly right away.  That
>>> may be premature, though, for example if the system is generally
>>> busy and there are other runnable tasks waiting to be run on that
>>> CPU already.
>>>
>>> This is unlikely to be an issue on systems where cpufreq policies are
>>> shared between multiple CPUs, because in those cases the policy
>>> utilization is computed as the maximum of the CPU utilization values
>>> over the whole policy and if that turns out to be low, reducing the
>>> frequency for the policy most likely is a good idea anyway.  On
>>
>> I have observed this issue even in the shared policy case (one clock domain for many CPUs). On migrate, the actual load update is split into two updates:
>>
>> 1. Add to removed_load on src_cpu (cpu_util(src_cpu) not updated yet)
>> 2. Do wakeup on dst_cpu, add load to dst_cpu
>>
>> Now if src_cpu manages to do a PELT update before 2. happens, ex: say a small periodic task woke up on src_cpu, it'll end up subtracting the removed_load from its utilization and issue a frequency update before 2. happens.
>>
>> This causes a premature dip in frequency which doesn't get corrected until the next util update that fires after rate_limit_us. The dst_cpu freq. update from step 2. above gets rate limited in this scenario.
> 
> Interesting, and this seems to be related to last_freq_update_time
> being per-policy (which it has to be, because frequency updates are
> per-policy too and that's what we need to rate-limit).
> 

Correct.

> Does this happen often enough to be a real concern in practice on
> those configurations, though?
> 
> The other CPUs in the policy need to be either idle (so schedutil
> doesn't take them into account at all) or lightly utilized for that to
> happen, so that would affect workloads with one CPU hog type of task
> that is migrated from one CPU to another within a policy and that
> doesn't happen too often AFAICS.

So it is possible, even likely in some cases for a heavy CPU task to migrate on wakeup between the policy->cpus via select_idle_sibling() if the prev_cpu it was on was !idle on wakeup.

This style of heavy thread + lots of light work is a common pattern on Android (games, browsing, etc.) given how Android does its threading for ipc (Binder stuff) + its rendering/audio pipelines. 

I unfortunately don't have any numbers atm though.

-Sai
