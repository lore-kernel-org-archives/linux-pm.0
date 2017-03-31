From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFD PATCH 4/5] sched/cpufreq_schedutil: always consider all CPUs
 when deciding next freq
Date: Fri, 31 Mar 2017 11:03:36 +0200
Message-ID: <CAJZ5v0jgpLrZ1GNWSqZACrUT0NLQzo1Kktdo5wYbmaZ-vM=NcQ@mail.gmail.com>
References: <20170324140900.7334-1-juri.lelli@arm.com> <20170324140900.7334-5-juri.lelli@arm.com>
 <2348394.hDdCk9fbgK@aspire.rjw.lan> <20170330085805.GF18960@e106622-lin>
 <CAJZ5v0jyHkVg80Uk5rh4Ax1wqFk=i+nbYEUfakDNrhu8zLnRzg@mail.gmail.com> <20170331073126.GK19929@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170331073126.GK19929@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Luca Abeni <luca.abeni@santannapisa.it>, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 31, 2017 at 9:31 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> On 30/03/17 22:13, Rafael J. Wysocki wrote:
>> On Thu, Mar 30, 2017 at 10:58 AM, Juri Lelli <juri.lelli@arm.com> wrote:
>> > Hi,
>>
>> Hi,
>>
>> > On 30/03/17 00:41, Rafael J. Wysocki wrote:
>> >> On Friday, March 24, 2017 02:08:59 PM Juri Lelli wrote:
>> >> > No assumption can be made upon the rate at which frequency updates get
>> >> > triggered, as there are scheduling policies (like SCHED_DEADLINE) which
>> >> > don't trigger them so frequently.
>> >> >
>> >> > Remove such assumption from the code.
>> >>
>> >> But the util/max values for idle CPUs may be stale, no?
>> >>
>> >
>> > Right, that might be a problem. A proper solution I think would be to
>> > remotely update such values for idle CPUs, and I believe Vincent is
>> > working on a patch for that.
>> >
>> > As mid-term workarounds, changing a bit the current one, come to my
>> > mind:
>> >
>> >  - consider TICK_NSEC (continue) only when SCHED_CPUFREQ_DL is not set
>> >  - remove CFS contribution (without triggering a freq update) when a CPU
>> >    enters IDLE; this might not work well, though, as we probably want
>> >    to keep in blocked util contribution for a bit
>> >
>> > What you think is the way to go?
>>
>> Well, do we want SCHED_DEADLINE util contribution to be there even for
>> idle CPUs?
>>
>
> DEADLINE util contribution is removed, even if the CPU is idle, by the
> reclaiming mechanism when we know (applying GRUB algorithm rules [1])
> that it can't be used anymore by a task (roughly speaking). So, we
> shouldn't have this problem in the DEADLINE case.
>
> [1] https://marc.info/?l=linux-kernel&m=149029880524038

OK

Why don't you store the contributions from DL and CFS separately, then
(say, as util_dl, util_cfs, respectively) and only discard the CFS one
if delta_ns > TICK_NSEC?
