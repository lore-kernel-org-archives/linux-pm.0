From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/5] sched: cpufreq: call cpufreq hook from remote CPUs
Date: Thu, 19 May 2016 23:06:14 +0200
Message-ID: <CAJZ5v0hu=6sp=p+jYXfesSC20ZfKcGL6f5fTpvC+RX1uAEbn=A@mail.gmail.com>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
	<1462828814-32530-4-git-send-email-smuckle@linaro.org>
	<CAJZ5v0iWfc=cNaCVuQ9QLK0FMLy1i5zEVcZSutOAK=+1OxaRtg@mail.gmail.com>
	<CAJZ5v0i-9QhNt1o_MN9_kEut6vs53-nwkM44dYq8hnuxynn4eQ@mail.gmail.com>
	<20160519191916.GE17223@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37700 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710AbcESVGQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 17:06:16 -0400
In-Reply-To: <20160519191916.GE17223@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Thu, May 19, 2016 at 9:19 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Thu, May 19, 2016 at 02:00:54PM +0200, Rafael J. Wysocki wrote:
>> On Thu, May 19, 2016 at 1:33 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > On Mon, May 9, 2016 at 11:20 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> >> Without calling the cpufreq hook for a remote wakeup it is possible
>> >> for such a wakeup to go unnoticed by cpufreq on the target CPU for up
>> >> to a full tick. This can occur if the target CPU is running a
>> >> CPU-bound task and preemption does not occur. If preemption does occur
>> >> then the scheduler is expected to run soon on the target CPU anyway so
>> >> invoking the cpufreq hook on the remote wakeup is not required.
>> >>
>> >> In order to avoid unnecessary interprocessor communication in the
>> >> governor for the preemption case, the existing hook (which happens
>> >> before preemption is decided) is only called when the target CPU
>> >> is within the current CPU's cpufreq policy. A new hook is added in
>> >> check_preempt_curr() to handle events outside the current CPU's
>> >> cpufreq policy where preemption does not happen.
>> >>
>> >> Some governors may opt to not receive remote CPU callbacks. This
>> >> behavior is possible by providing NULL as the new policy_cpus
>> >> parameter to cpufreq_add_update_util_hook(). Callbacks will only be
>> >> issued in this case when the target CPU and the current CPU are the
>> >> same. Otherwise policy_cpus is used to determine what is a local
>> >> vs. remote callback.
>> >
>> > I don't really like the extra complexity added by this patch.
>> >
>> > It makes the code look fragile at some places
>
> Perhaps I can improve these, can you point them out?
>
>> > and it only really matters for schedutil
>
> True. As we are trying to create an integrated scheduler+CPU frequency
> control solution I think some of this is to be expected, and should be
> worthwhile since this is hopefully the future and will eventually
> replace the need for the other governors.
>
>> > and for the fast switch case in there.
>
> Once there is a high priority context for the slow path I expect it to
> benefit from this as well.

I don't think that saving an occasional IPI would matter for that case
overall, though.

>> >
>> > Overall, it looks like a premature optimization to me.
>
> Are you referring to this new approach of avoiding duplicate IPIs,

Yes.

> or supporting updates on remote wakeups overall?

No.  I already said I would be fine with that if done properly.

> The duplicate IPI thing is admittedly not required for the problem I'm
> looking to solve but I figured at least some people would be concerned
> about it.

Avoiding IPIs that aren't necessary is fine by me in general, but
doing that at the scheduler level doesn't seem to be necessary as I
said.

> If folks can live with it for now then I can go back to the
> simpler approach I had in my first posting.

Please at least avoid introducing internal cpufreq concepts into the
scheduler uncleanly.

>> In particular, the dance with checking the policy CPUs from the
>> scheduler is questionable (the scheduler might be interested in this
>> information for other purposes too and hooking it up in an ad-hoc way
>> just for cpufreq doesn't seem to be appropriate from that perspective)
>> and also doesn't seem to be necessary.
>>
>> You can check if the current CPU is a policy one from the governor and
>> if that is the case, simply run the frequency update on it directly
>> without any IPI (because if both the target CPU and the current CPU
>> belong to the same policy, it doesn't matter which one of them will
>> run the update).
>
> The checking of policy CPUs from the scheduler was done so as to
> minimize the number of calls to the hook, given their expense.

But policy CPUs is entirely an internal cpufreq concept and adding
that to the scheduler kind of via a kitchen door doesn't look good to
me.

> In the case of a remote update the hook has to run (or not) after it is
> known whether preemption will occur so we don't do needless work or
> IPIs. If the policy CPUs aren't known in the scheduler then the early
> hook will always need to be called along with an indication that it is
> the early hook being called. If it turns out to be a remote update it
> could then be deferred to the later hook, which would only be called
> when a remote update has been deferred and preemption has not occurred.
>
> This means two hook inovcations for a remote non-preempting wakeup
> though instead of one.  Perhaps this is a good middle ground on code
> churn vs. optimization though.

I would think so.
