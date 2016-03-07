From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Mon, 7 Mar 2016 14:15:47 +0100
Message-ID: <CAJZ5v0jKXQrrpVmEd=CCek4KVWknJaoYSAmwc8rosKK=oDzkFw@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<2409306.qzzMXcm4dm@vostro.rjw.lan>
	<15684081.T4iOMUSHCY@vostro.rjw.lan>
	<56DA09B1.4010005@linaro.org>
	<CAJZ5v0jENyu8j0fq1-BhU64QwRHAjvcjQktYc2sa9QmhktoEnQ@mail.gmail.com>
	<CAJZ5v0jd6sXQnvZ87=_L1MQgu2QsBJtYb8jwn=0=m7eRdKVvhA@mail.gmail.com>
	<CAJZ5v0jh7qcmYjDXCdO3Pid4XyuuxQfsKAmWDLXYcrkx0t-phw@mail.gmail.com>
	<20160305164900.GX6356@twins.programming.kicks-ass.net>
	<CAJZ5v0je8158B9jjbMU1MMPyduZXaao7sKhAniq4TPVfTb3JQA@mail.gmail.com>
	<20160307080059.GZ6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160307080059.GZ6356@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 7, 2016 at 9:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Mar 06, 2016 at 03:17:09AM +0100, Rafael J. Wysocki wrote:
>> > Agreed, fail the stuff hard.
>> >
>> > Simply make cpufreq_register_notifier a __must_check function and add
>> > error handling to all call sites.
>>
>> Quite frankly, I don't see a compelling reason to do anything about
>> the notifications at this point.
>>
>> The ACPI driver is the only one that will support fast switching for
>> the time being and on practically all platforms that can use the ACPI
>> driver the transition notifications cannot be relied on anyway for a
>> few reasons.  First, if intel_pstate or HWP is in use, they won't be
>> coming at all.  Second, anything turbo will just change frequency at
>> will without notifying (like HWP).  Finally, if they are coming,
>> whoever receives them is notified about the frequency that is
>> requested and not the real one, which is misleading, because (a) the
>> request may just make the CPU go into the turbo range and then see
>> above or (b) if the CPU is in a platform-coordinated package, its
>> request will only be granted if it's the winning one.
>
> Sure I know all that. But that, to me, seems like an argument for why
> you should have done this a long time ago.

While I generally agree with this, I don't quite see why cleaning that
up necessarily has to be connected to the current patch series which
is my point.

> Someone registering a notifier you _know_ won't be called reliably is a
> sure sign of borkage. And you want to be notified (pun intended) of
> borkage.
>
> So the alternative option to making the registration fail, is making the
> registration WARN (and possibly disable fast support in the driver).
>
> But I do think something wants to be done here.

So here's what I can do for the "fast switch" thing.

There is the fast_switch_possible policy flag that's necessary anyway.
I can make notifier registration fail when that is set for at least
one policy and I can make the setting of it fail if at least one
notifier has already been registered.

However, without spending too much time on chasing code dependencies i
sort of suspect that it will uncover things that register cpufreq
notifiers early and it won't be possible to use fast switch without
sorting that out.  And that won't even change anything apart from
removing some code that has not worked for quite a while already and
nobody noticed.

>> > No no no, that's just horrible. Why would you want to keep this
>> > notification stuff alive? If your platform can change frequency 'fast'
>> > you don't want notifiers.
>>
>> I'm not totally sure about that.
>
> I am, per definition, if you need to call notifiers, you're not fast.
>
> I would really suggest making that a hard rule and enforcing it.

OK, but see above.

It is doable for the "fast switch" thing, but it won't help in all of
the other cases when notifications are not reliable.

>> > What's the point of a notification that says: "At some point in the
>> > random past my frequency has changed, and it likely has changed again
>> > since then, do 'something'."
>> >
>> > That's pointless. If you have dependent clock domains or whatever, you
>> > simply _cannot_ be fast.
>> >
>>
>> What about thermal?  They don't need to get very accurate information,
>> but they need to be updated on a regular basis.  It would do if they
>> get averages instead of momentary values (and may be better even).
>
> Thermal, should be an integral part of cpufreq, but if they need a
> callback from the switching hook (and here I would like to remind
> everyone that this is inside scheduler hot paths and the more code you
> stuff in the harder the performance regressions will hit you in the
> face)

Calling notifiers (or any kind of callbacks that anyone can register)
from there is out of the question.

> it can get a direct function call. No need for no stinking
> notifiers.

I'm not talking about hooks in the switching code but *some* way to
let stuff know about frequency changes.

If it changes frequently enough, it's not practical and not even
necessary to cause things like thermal to react on every change, but I
think there needs to be a way to make them reevaluate things
regularly.  Arguably, they might set a timer for that, but why would
they need a timer if they could get triggered by the code that
actually makes changes?
