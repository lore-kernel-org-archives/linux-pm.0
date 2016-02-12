From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Sat, 13 Feb 2016 00:17:13 +0100
Message-ID: <CAJZ5v0hThYZV+LZmhpg2cqLQt_+Jbd61zwTXHe4tFL9JxuiYHg@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<56B93548.9090006@linaro.org>
	<CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
	<5387313.xAhVpzgZCg@vostro.rjw.lan>
	<56BA8C29.4090905@linaro.org>
	<20160211115959.GI6357@twins.programming.kicks-ass.net>
	<56BCBF7C.2080404@linaro.org>
	<20160211173033.GP6357@twins.programming.kicks-ass.net>
	<56BCD864.6030207@linaro.org>
	<20160212141009.GT6357@twins.programming.kicks-ass.net>
	<CAJZ5v0giM=CMkQN770TLv5wgdUQ2o0D152HFG6-nX-rr483G+A@mail.gmail.com>
	<001501d165b7$1c69c790$553d56b0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001501d165b7$1c69c790$553d56b0$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 12, 2016 at 6:02 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2016.02.12 08:01 Rafael J. Wysocki wrote:
>> On Fri, Feb 12, 2016 at 3:10 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>>> On Thu, Feb 11, 2016 at 10:52:20AM -0800, Steve Muckle wrote:
>>>> On 02/11/2016 09:30 AM, Peter Zijlstra wrote:
>>>>>> My concern above is that pokes are guaranteed to keep occurring when
>>>>>> there is only RT or DL activity so nothing breaks.
>>>>>
>>>>> The hook in their respective tick handler should ensure stuff is called
>>>>> sporadically and isn't stalled.
>>>>
>>>> But that's only true if the RT/DL tasks happen to be running when the
>>>> tick arrives right?
>>>>
>>>> Couldn't we have RT/DL activity which doesn't overlap with the tick? And
>>>> if no CFS tasks happen to be executing on that CPU, we'll never trigger
>>>> the cpufreq update. This could go on for an arbitrarily long time
>>>> depending on the periodicity of the work.
>>>
>>> Possible yes, but why do we care? Such a CPU would be so much idle that
>>> cpufreq doesn't matter one way or another, right?
>
>> Well, in theory you can get 50% or so of the time active in bursts
>> that happen to fit between ticks.  If we happen to do those in the
>> lowest P-state, we may burn more energy than necessary on platforms
>> where more idle is preferred.
>
> I believe this happens considerably more often than is commonly thought,
> and is the exact reason I was opposed to the introduction of the
> "duration" method into the intel_pstate driver in the first
> place. The probability of occurrence (of a relatively busy CPU being idle
> on jiffy boundaries) is very use dependant, occurring more on desktops than
> servers, and sometime more with video frame rate based tasks. Data to support
> my claim is a couple of years old and not very complete, but I see the issue
> often on trace data acquired from desktop users on bugzilla reports.

The approach with update callbacks from the scheduler should not be
affected by this, because it takes updates not only at the tick time,
but also on other scheduler events.

Thanks,
Rafael
