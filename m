From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH v3 2/2] cpufreq: schedutil: Avoid reducing frequency
 of busy CPUs prematurely
Date: Fri, 24 Mar 2017 02:39:03 +0100
Message-ID: <CAJZ5v0jTi6BkKiCXp9PLMAoHmC_rz9bobU5nZKo-OXq2dUKSeQ@mail.gmail.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan> <2997922.DidfPadJuT@aspire.rjw.lan> <58D42173.2080205@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58D42173.2080205@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Boonstoppel <pboonstoppel@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 23, 2017 at 8:26 PM, Sai Gurrappadi <sgurrappadi@nvidia.com> wrote:
> Hi Rafael,

Hi,

> On 03/21/2017 04:08 PM, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> <snip>
>
>>
>> That has been attributed to CPU utilization metric updates on task
>> migration that cause the total utilization value for the CPU to be
>> reduced by the utilization of the migrated task.  If that happens,
>> the schedutil governor may see a CPU utilization reduction and will
>> attempt to reduce the CPU frequency accordingly right away.  That
>> may be premature, though, for example if the system is generally
>> busy and there are other runnable tasks waiting to be run on that
>> CPU already.
>>
>> This is unlikely to be an issue on systems where cpufreq policies are
>> shared between multiple CPUs, because in those cases the policy
>> utilization is computed as the maximum of the CPU utilization values
>> over the whole policy and if that turns out to be low, reducing the
>> frequency for the policy most likely is a good idea anyway.  On
>
> I have observed this issue even in the shared policy case (one clock domain for many CPUs). On migrate, the actual load update is split into two updates:
>
> 1. Add to removed_load on src_cpu (cpu_util(src_cpu) not updated yet)
> 2. Do wakeup on dst_cpu, add load to dst_cpu
>
> Now if src_cpu manages to do a PELT update before 2. happens, ex: say a small periodic task woke up on src_cpu, it'll end up subtracting the removed_load from its utilization and issue a frequency update before 2. happens.
>
> This causes a premature dip in frequency which doesn't get corrected until the next util update that fires after rate_limit_us. The dst_cpu freq. update from step 2. above gets rate limited in this scenario.

Interesting, and this seems to be related to last_freq_update_time
being per-policy (which it has to be, because frequency updates are
per-policy too and that's what we need to rate-limit).

Does this happen often enough to be a real concern in practice on
those configurations, though?

The other CPUs in the policy need to be either idle (so schedutil
doesn't take them into account at all) or lightly utilized for that to
happen, so that would affect workloads with one CPU hog type of task
that is migrated from one CPU to another within a policy and that
doesn't happen too often AFAICS.

Thanks,
Rafael
