From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFD PATCH 4/5] sched/cpufreq_schedutil: always consider all CPUs
 when deciding next freq
Date: Thu, 30 Mar 2017 15:21:57 +0200
Message-ID: <CAKfTPtC+FdARdK=TO_i=k_UrnZviwUb8rm_=9OW8yCXLRixMBA@mail.gmail.com>
References: <20170324140900.7334-1-juri.lelli@arm.com> <20170324140900.7334-5-juri.lelli@arm.com>
 <2348394.hDdCk9fbgK@aspire.rjw.lan> <20170330085805.GF18960@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170330085805.GF18960@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, viresh kumar <viresh.kumar@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Luca Abeni <luca.abeni@santannapisa.it>, claudio@evidence.eu.com, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>, bristot@redhat.com, Mathieu Poirier <mathieu.poirier@linaro.org>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.c>
List-Id: linux-pm@vger.kernel.org

On 30 March 2017 at 10:58, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi,
>
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

Yes. I'm working on a patch that will regularly update the blocked
load/utilization of idle CPU. This update will be done on a slow pace
to make sure that utilization and load will be decayed regularly

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
>
> Thanks,
>
> - Juri
