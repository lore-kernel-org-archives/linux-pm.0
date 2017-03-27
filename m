From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH v3 2/2] cpufreq: schedutil: Avoid reducing frequency
 of busy CPUs prematurely
Date: Mon, 27 Mar 2017 23:11:12 +0200
Message-ID: <CAJZ5v0ghzyNG-HL8gnfcPeq=t7sosd6b54rr2gQbm7FpVkUh9Q@mail.gmail.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan> <2997922.DidfPadJuT@aspire.rjw.lan>
 <58D5C47A.4060305@nvidia.com> <CAKfTPtDAVZg--KchHN9S3hdgRB9OzQKJTR7ioCh8hTksRDDekg@mail.gmail.com>
 <58D97DBE.2090508@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32846 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbdC0VLs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2017 17:11:48 -0400
In-Reply-To: <58D97DBE.2090508@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Boonstoppel <pboonstoppel@nvidia.com>

On Mon, Mar 27, 2017 at 11:01 PM, Sai Gurrappadi <sgurrappadi@nvidia.com> w=
rote:
> Hi Vincent,
>
> On 03/27/2017 12:04 AM, Vincent Guittot wrote:
>> On 25 March 2017 at 02:14, Sai Gurrappadi <sgurrappadi@nvidia.com> wrote=
:
>>> Hi Rafael,
>>>
>>> On 03/21/2017 04:08 PM, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> The way the schedutil governor uses the PELT metric causes it to
>>>> underestimate the CPU utilization in some cases.
>>>>
>>>> That can be easily demonstrated by running kernel compilation on
>>>> a Sandy Bridge Intel processor, running turbostat in parallel with
>>>> it and looking at the values written to the MSR_IA32_PERF_CTL
>>>> register.  Namely, the expected result would be that when all CPUs
>>>> were 100% busy, all of them would be requested to run in the maximum
>>>> P-state, but observation shows that this clearly isn't the case.
>>>> The CPUs run in the maximum P-state for a while and then are
>>>> requested to run slower and go back to the maximum P-state after
>>>> a while again.  That causes the actual frequency of the processor to
>>>> visibly oscillate below the sustainable maximum in a jittery fashion
>>>> which clearly is not desirable.
>>>>
>>>> That has been attributed to CPU utilization metric updates on task
>>>> migration that cause the total utilization value for the CPU to be
>>>> reduced by the utilization of the migrated task.  If that happens,
>>>> the schedutil governor may see a CPU utilization reduction and will
>>>> attempt to reduce the CPU frequency accordingly right away.  That
>>>> may be premature, though, for example if the system is generally
>>>> busy and there are other runnable tasks waiting to be run on that
>>>> CPU already.
>>>>
>>>
>>> Thinking out loud a bit, I wonder if what you really want to do is basi=
cally:
>>>
>>> schedutil_cpu_util(cpu) =3D max(cpu_rq(cpu)->cfs.util_avg, total_cpu_ut=
il_avg);
>>>
>>> Where total_cpu_util_avg tracks the average utilization of the CPU itse=
lf over time (% of time the CPU was busy) in the same PELT like manner. The=
 difference here is that it doesn't change instantaneously as tasks migrate=
 in/out but it decays/accumulates just like the per-entity util_avgs.
>>
>> But we loose the interest of immediate decrease when tasks migrate.
>
> Indeed, this is not ideal.
>
>> Instead of total_cpu_util_avg we should better track RT utilization in
>> the same manner so with ongoing work for deadline we will have :
>> total_utilization =3D cfs.util_avg + rt's util_avg + deadline's util avg
>> and we still take advantage of task migration effect
>
> I agree that we need better tracking for RT and DL tasks but that doesn't=
 solve the overloaded case with more than one CFS thread sharing a CPU.
>
> In the overloaded case, we care not just about the instant where the migr=
ate happens but also subsequent windows where the PELT metric is slowly ram=
ping up to reflect the real utilization of a task now that it has a CPU to =
itself.
>
> Maybe there are better ways to solve that though :-)

I wonder if it's viable to postpone the utilization update on both the
source and target runqueues until the task has been fully migrated?

That would make the artificial utilization reductions go away.

Thanks,
Rafael
