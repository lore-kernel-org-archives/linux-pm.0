From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC][PATCH v3 2/2] cpufreq: schedutil: Avoid reducing frequency
 of busy CPUs prematurely
Date: Wed, 22 Mar 2017 18:04:25 -0700
Message-ID: <CAJWu+oqRVn3KmjQG-HEo96qo+GjgUpEVhRMfLZ+b-3_1vM31nQ@mail.gmail.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan> <2997922.DidfPadJuT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36269 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCWBE1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 21:04:27 -0400
Received: by mail-vk0-f50.google.com with SMTP id j64so124770275vkg.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2017 18:04:26 -0700 (PDT)
In-Reply-To: <2997922.DidfPadJuT@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Mar 21, 2017 at 4:08 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The way the schedutil governor uses the PELT metric causes it to
> underestimate the CPU utilization in some cases.
>
> That can be easily demonstrated by running kernel compilation on
> a Sandy Bridge Intel processor, running turbostat in parallel with
> it and looking at the values written to the MSR_IA32_PERF_CTL
> register.  Namely, the expected result would be that when all CPUs
> were 100% busy, all of them would be requested to run in the maximum
> P-state, but observation shows that this clearly isn't the case.
> The CPUs run in the maximum P-state for a while and then are
> requested to run slower and go back to the maximum P-state after
> a while again.  That causes the actual frequency of the processor to
> visibly oscillate below the sustainable maximum in a jittery fashion
> which clearly is not desirable.
>
> That has been attributed to CPU utilization metric updates on task
> migration that cause the total utilization value for the CPU to be
> reduced by the utilization of the migrated task.  If that happens,
> the schedutil governor may see a CPU utilization reduction and will
> attempt to reduce the CPU frequency accordingly right away.  That
> may be premature, though, for example if the system is generally
> busy and there are other runnable tasks waiting to be run on that
> CPU already.
>
> This is unlikely to be an issue on systems where cpufreq policies are
> shared between multiple CPUs, because in those cases the policy
> utilization is computed as the maximum of the CPU utilization values
> over the whole policy and if that turns out to be low, reducing the
> frequency for the policy most likely is a good idea anyway.  On
> systems with one CPU per policy, however, it may affect performance
> adversely and even lead to increased energy consumption in some cases.
>
> On those systems it may be addressed by taking another utilization
> metric into consideration, like whether or not the CPU whose
> frequency is about to be reduced has been idle recently, because if
> that's not the case, the CPU is likely to be busy in the near future
> and its frequency should not be reduced.
>
> To that end, use the counter of idle calls in the timekeeping code.
> Namely, make the schedutil governor look at that counter for the
> current CPU every time before its frequency is about to be reduced.
> If the counter has not changed since the previous iteration of the
> governor computations for that CPU, the CPU has been busy for all
> that time and its frequency should not be decreased, so if the new
> frequency would be lower than the one set previously, the governor
> will skip the frequency update.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Makes sense,

Reviewed-by: Joel Fernandes <joelaf@google.com>

Thanks,
Joel
