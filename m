From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/5] sched: cpufreq: call cpufreq hook from remote CPUs
Date: Thu, 19 May 2016 14:00:54 +0200
Message-ID: <CAJZ5v0i-9QhNt1o_MN9_kEut6vs53-nwkM44dYq8hnuxynn4eQ@mail.gmail.com>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
	<1462828814-32530-4-git-send-email-smuckle@linaro.org>
	<CAJZ5v0iWfc=cNaCVuQ9QLK0FMLy1i5zEVcZSutOAK=+1OxaRtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37351 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbcESMA4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 08:00:56 -0400
In-Reply-To: <CAJZ5v0iWfc=cNaCVuQ9QLK0FMLy1i5zEVcZSutOAK=+1OxaRtg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Thu, May 19, 2016 at 1:33 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, May 9, 2016 at 11:20 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> Without calling the cpufreq hook for a remote wakeup it is possible
>> for such a wakeup to go unnoticed by cpufreq on the target CPU for up
>> to a full tick. This can occur if the target CPU is running a
>> CPU-bound task and preemption does not occur. If preemption does occur
>> then the scheduler is expected to run soon on the target CPU anyway so
>> invoking the cpufreq hook on the remote wakeup is not required.
>>
>> In order to avoid unnecessary interprocessor communication in the
>> governor for the preemption case, the existing hook (which happens
>> before preemption is decided) is only called when the target CPU
>> is within the current CPU's cpufreq policy. A new hook is added in
>> check_preempt_curr() to handle events outside the current CPU's
>> cpufreq policy where preemption does not happen.
>>
>> Some governors may opt to not receive remote CPU callbacks. This
>> behavior is possible by providing NULL as the new policy_cpus
>> parameter to cpufreq_add_update_util_hook(). Callbacks will only be
>> issued in this case when the target CPU and the current CPU are the
>> same. Otherwise policy_cpus is used to determine what is a local
>> vs. remote callback.
>
> I don't really like the extra complexity added by this patch.
>
> It makes the code look fragile at some places and it only really
> matters for schedutil and for the fast switch case in there.
>
> Overall, it looks like a premature optimization to me.

In particular, the dance with checking the policy CPUs from the
scheduler is questionable (the scheduler might be interested in this
information for other purposes too and hooking it up in an ad-hoc way
just for cpufreq doesn't seem to be appropriate from that perspective)
and also doesn't seem to be necessary.

You can check if the current CPU is a policy one from the governor and
if that is the case, simply run the frequency update on it directly
without any IPI (because if both the target CPU and the current CPU
belong to the same policy, it doesn't matter which one of them will
run the update).
