From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFD PATCH 3/5] sched/cpufreq_schedutil: make worker kthread be SCHED_DEADLINE
Date: Tue, 28 Mar 2017 11:29:31 +0200
Message-ID: <CAKfTPtCgQQU-8fdxyq+9pywAtu-DFo7ZBugjEaFxjVVxu_pqjw@mail.gmail.com>
References: <20170324140900.7334-1-juri.lelli@arm.com> <20170324140900.7334-4-juri.lelli@arm.com>
 <20170327165011.dpip23cyolnleas6@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327165011.dpip23cyolnleas6@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, viresh kumar <viresh.kumar@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, Mathieu Poirier <mathieu.poirier@linaro.org>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 March 2017 at 18:50, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Mar 24, 2017 at 02:08:58PM +0000, Juri Lelli wrote:
>> Worker kthread needs to be able to change frequency for all other
>> threads.
>>
>> Make it special, just under STOP class.
>
> *yuck* ;-)
>
> So imagine our I2C/SPI bus is 'busy' and its mutex taken, then this
> 'soecial' task will need to boost it. Now add BWI to your thinking and
> shudder.
>
>
> On IRC broonie mentioned that:
>
>  - most PMIC operations are fire and forget (no need to wait for a
>    response).
>  - PMIC 'packets' are 'small'.
>  - SPI has the possibility to push stuff on the queue.
>
> Taken together this seems to suggest we can rework cpufreq drivers to
> function in-context, either directly push the packet on the bus if
> available, or queue it and let whoever owns it sort it without blocking.
>
> It might be possible to rework/augment I2C to also support pushing stuff
> on a queue.

But sending new voltage value to PMIC is only part of the sequence.
When cpufreq set a new opp, it does

-set new voltage
-wait for the voltage to settle down.
-set the new clock frequency

you can even have to switch to an intermediate clock source.

When such sequence is managed by the kernel, we can't easily git ride
of a kthread

>
>
> So if we can make all that work, we can do away with this horrible
> horrible kthread. Which is, IMO, a much better solution.
>
> Thoughts?
