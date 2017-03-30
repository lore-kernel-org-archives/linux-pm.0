From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFD PATCH 4/5] sched/cpufreq_schedutil: always consider all CPUs
 when deciding next freq
Date: Thu, 30 Mar 2017 22:13:50 +0200
Message-ID: <CAJZ5v0jyHkVg80Uk5rh4Ax1wqFk=i+nbYEUfakDNrhu8zLnRzg@mail.gmail.com>
References: <20170324140900.7334-1-juri.lelli@arm.com> <20170324140900.7334-5-juri.lelli@arm.com>
 <2348394.hDdCk9fbgK@aspire.rjw.lan> <20170330085805.GF18960@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170330085805.GF18960@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Luca Abeni <luca.abeni@santannapisa.it>, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 30, 2017 at 10:58 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi,

Hi,

> On 30/03/17 00:41, Rafael J. Wysocki wrote:
>> On Friday, March 24, 2017 02:08:59 PM Juri Lelli wrote:
>> > No assumption can be made upon the rate at which frequency updates get
>> > triggered, as there are scheduling policies (like SCHED_DEADLINE) which
>> > don't trigger them so frequently.
>> >
>> > Remove such assumption from the code.
>>
>> But the util/max values for idle CPUs may be stale, no?
>>
>
> Right, that might be a problem. A proper solution I think would be to
> remotely update such values for idle CPUs, and I believe Vincent is
> working on a patch for that.
>
> As mid-term workarounds, changing a bit the current one, come to my
> mind:
>
>  - consider TICK_NSEC (continue) only when SCHED_CPUFREQ_DL is not set
>  - remove CFS contribution (without triggering a freq update) when a CPU
>    enters IDLE; this might not work well, though, as we probably want
>    to keep in blocked util contribution for a bit
>
> What you think is the way to go?

Well, do we want SCHED_DEADLINE util contribution to be there even for
idle CPUs?

Thanks,
Rafael
