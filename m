From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 13 Jul 2017 15:04:09 +0100
Message-ID: <a7b74ee0-24ef-5cc8-89e6-50c705a594f4@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
 <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
 <bac850da-6256-2a92-abfe-71d229cc99dc@arm.com>
 <20170711060106.GL2928@vireshk-i7>
 <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
 <20170712040917.GG17115@vireshk-i7>
 <20170712083125.at7jic63ozoxoqap@hirez.programming.kicks-ass.net>
 <20170712092755.GD1679@vireshk-i7>
 <20170712111426.lmbwowbrvjl55aft@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170712111426.lmbwowbrvjl55aft@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org



On 12/07/17 12:14, Peter Zijlstra wrote:
> On Wed, Jul 12, 2017 at 02:57:55PM +0530, Viresh Kumar wrote:
>> On 12-07-17, 10:31, Peter Zijlstra wrote:
>>> So the problem with the thread is two-fold; one the one hand we like the
>>> scheduler to directly set frequency, but then we need to schedule a task
>>> to change the frequency, which will change the frequency and around we
>>> go.
>>>
>>> On the other hand, there's very nasty issues with PI. This thread would
>>> have very high priority (otherwise the SCHED_DEADLINE stuff won't work)
>>> but that then means this thread needs to boost the owner of the i2c
>>> mutex. And that then creates a massive bandwidth accounting hole.
>>>
>>>
>>> The advantage of using an interrupt driven state machine is that all
>>> those issues go away.
>>>
>>> But yes, whichever way around you turn things, its crap. But given the
>>> hardware its the best we can do.
>>
>> Thanks for the explanation Peter.
>>
>> IIUC, it will take more time to change the frequency eventually with
>> the interrupt-driven state machine as there may be multiple bottom
>> halves involved here, for supply, clk, etc, which would run at normal
>> priorities now. And those were boosted currently due to the high
>> priority sugov thread. And we are fine with that (from performance
>> point of view) ?
> 
> I'm not sure what you mean; bottom halves as in softirq? From what I can
> tell an i2c bus does clk_prepare_enable() on registration and from that
> point on clk_enable() is usable from atomic contexts. But afaict clk
> stuff doesn't do interrupts at all.
> 
> (with a note that I absolutely hate the clk locking)
> 

Agreed. Juri pointed out this as a blocker a while ago and when we
started implementing the new and shiny ARM SCMI specification, I dropped
the whole clock layer interaction for the CPUFreq driver. However, I
still have to deal with some mailbox locking(still experimenting currently)

> I think the interrupt driven thing can actually be faster than the
> 'regular' task waiting on the mutex. The regulator message can be
> locklessly queued (it only ever makes sense to have 1 such message
> pending, any later one will invalidate a prior one).
> 

Ah OK, I just asked the same in the other thread, you have already
answered me. Good we can ignore.

> Then the i2c interrupt can detect the availability of this pending
> message and splice it into the transfer queue at an opportune moment.
> 
> (of course, the current i2c bits don't support any of that)
> 
>> Coming back to where we started from (where should we call
>> arch_set_freq_scale() from ?).
> 
> The drivers.. the core cpufreq doesn't know when (if any) transition is
> completed.
> 
>> I think we would still need some kind of synchronization between
>> cpufreq core and the cpufreq drivers to make sure we don't start
>> another freq change before the previous one is complete. Otherwise
>> the cpufreq drivers would be required to have similar support with
>> proper locking in place.
> 
> Not sure what you mean; also not sure why. On x86 we never know, cannot
> know. So why would this stuff be any different.
> 

Good, I was under the same assumption that it's okay to override the old
request with new.

>> And if the core is going to get notified about successful freq changes
>> (which it should IMHO), then it may still be better to call
>> arch_set_freq_scale() from the core itself and not from individual
>> drivers.
> 
> I would not involve the core. All we want from the core is a unified
> interface towards requesting DVFS changes. Everything that happens after
> is not its business.
> 

The question is whether we *need* to know the completion of frequency
transition. What is the impact of absence of it ? I am considering
platforms which may take up to a ms or more to do the actual transition
in the firmware.

-- 
Regards,
Sudeep
