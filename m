From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [RFC][PATCH v3 2/2] cpufreq: schedutil: Avoid reducing frequency
 of busy CPUs prematurely
Date: Mon, 8 May 2017 13:15:49 +0800
Message-ID: <CANRm+CzyTQAQRVZTWyofkusCBBJNUc5jXfnHgeO_Anv_kF-3pA@mail.gmail.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan> <2997922.DidfPadJuT@aspire.rjw.lan>
 <CANRm+Cwem_C6geyWScZhr4A62ben9fKhyL2OPd+Vdhh3bRJqKw@mail.gmail.com> <20170508040119.GA17010@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36271 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdEHFPu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 01:15:50 -0400
In-Reply-To: <20170508040119.GA17010@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

2017-05-08 12:01 GMT+08:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On 08-05-17, 11:49, Wanpeng Li wrote:
>> Hi Rafael,
>> 2017-03-22 7:08 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > The way the schedutil governor uses the PELT metric causes it to
>> > underestimate the CPU utilization in some cases.
>> >
>> > That can be easily demonstrated by running kernel compilation on
>> > a Sandy Bridge Intel processor, running turbostat in parallel with
>> > it and looking at the values written to the MSR_IA32_PERF_CTL
>> > register.  Namely, the expected result would be that when all CPUs
>> > were 100% busy, all of them would be requested to run in the maximum
>> > P-state, but observation shows that this clearly isn't the case.
>> > The CPUs run in the maximum P-state for a while and then are
>> > requested to run slower and go back to the maximum P-state after
>> > a while again.  That causes the actual frequency of the processor to
>> > visibly oscillate below the sustainable maximum in a jittery fashion
>> > which clearly is not desirable.
>> >
>> > That has been attributed to CPU utilization metric updates on task
>> > migration that cause the total utilization value for the CPU to be
>> > reduced by the utilization of the migrated task.  If that happens,
>> > the schedutil governor may see a CPU utilization reduction and will
>> > attempt to reduce the CPU frequency accordingly right away.  That
>> > may be premature, though, for example if the system is generally
>> > busy and there are other runnable tasks waiting to be run on that
>> > CPU already.
>> >
>> > This is unlikely to be an issue on systems where cpufreq policies are
>> > shared between multiple CPUs, because in those cases the policy
>> > utilization is computed as the maximum of the CPU utilization values
>>
>> Sorry for one question maybe not associated with this patch. If the
>> cpufreq policy is shared between multiple CPUs, the function
>> intel_cpufreq_target()  just updates IA32_PERF_CTL MSR of the cpu
>> which is managing this policy, I wonder whether other cpus which are
>> affected should also update their per-logical cpu's IA32_PERF_CTL MSR?
>
> The CPUs share the policy when they share their freq/voltage rails and so
> changing perf state of one CPU should result in that changing for all the CPUs
> in that policy. Otherwise, they can't be considered to be part of the same
> policy.
>
> That's why this code is changing it only for policy->cpu alone.

I see, thanks for the explanation.

Regards,
Wanpeng Li
