From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU
 offline/online locked
Date: Mon, 23 May 2016 22:47:03 +0200
Message-ID: <CAJZ5v0h-1rqishrGAJXnvzyKjxoAxMcitW64LCZqtGC6vTRmCg@mail.gmail.com>
References: <19792191.esL3UuyORb@vostro.rjw.lan>
	<5580598.s7imtWPVt5@vostro.rjw.lan>
	<20160523035703.GF2850@vireshk-i7>
	<3351136.myUMJKBnm0@vostro.rjw.lan>
	<20160523151910.GC17585@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35081 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbcEWUrG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 16:47:06 -0400
In-Reply-To: <20160523151910.GC17585@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Mon, May 23, 2016 at 5:19 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 23-05-16, 15:40, Rafael J. Wysocki wrote:
>> On Monday, May 23, 2016 09:27:03 AM Viresh Kumar wrote:
>> > On 20-05-16, 23:33, Rafael J. Wysocki wrote:
>> > > The policy rwsem is really only needed in cpufreq_stats_create_table(), because
>> > > the policy notifier is gone when _free_table() runs, so another version of the
>> > > patch goes below.
>> >
>> > Right. I saw that while reading your previous version but didn't reply
>> > because I wanted to do a more careful review.
>> >
>> > The first issue I have here is that the _init and _exit routines in
>> > cpufreq-stats aren't opposite of each other. Which shouldn't be the
>> > case.
>>
>> I'm not sure what you mean here.
>
> Sorry about that. I meant that exit() should look opposite of init() ideally,
> whereas if you look at current code, both are (un)registering the
> POLICY_NOTIFIER at the top.

That actually sort of makes sense, though, except that the code is racy. :-)

>> > I am still trying to understand why we will ever have a race here. We
>> > might have it, but I just want to know how.
>> >
>> > This is what we do in on addition of a policy:
>> > - send the CREATE notifier
>> > - Add policy to the list
>> >
>> > So, the notifiers are guaranteed to complete before the policy is
>> > present in the list.
>> >
>> > CPU 0                                   CPU 1
>> > notifier                                cpufreq_stats_init()
>> > CREATE-POLICY X                         cpufreq_stats_create_table()
>> > __cpufreq_stats_create_table()          cpufreq_cpu_get()
>> >
>> > AFAICT, whatever may happen, __cpufreq_stats_create_table() will *not*
>> > get called in parallel for the same policy.
>> >
>> > If __cpufreq_stats_create_table() is in progress on CPU0, CPU 1 will
>> > not find the policy with cpufreq_cpu_get(). And if cpufreq_cpu_get()
>> > finds a policy, the notifier would already have completed.
>> >
>> > What do you say ?
>
> Until now I thought you are trying to prevent the race where
> __cpufreq_stats_create_table() gets called in parallel for the same policy. So,
> above explains that it can't happen for sure.

Assuming that the loops are over online CPUs and not over possible
CPUs I suppose?

Anyway, if you are talking about the code without the patch (which I
guess is the case), the reason why it is racy is because, if
cpufreq_stats_init() runs in parallel with CPU online, the CPU going
online may be missed by it.  To my eyes that happens if
cpufreq_online() has already advanced beyond the point where the
notifier would have been invoked, but hasn't returned yet when the
for_each_online_cpu() loop in cpufreq_stats_init() is executed.

Worse yet, if a CPU goes offline when cpufreq_stats_exit() is running
and that happens exactly between the notifier unregistration and the
for_each_online_cpu() loop, the stats table will never be freed for
that CPU (say the policy isn't shared).

Switching over to loops over possible CPUs doesn't address those races
(at least not the second one), and I'm not really sure why I thought
it would address them, but adding CPU online/offline locking to
cpufreq_stats_init/exit() can address them, so it looks like the very
first version of my patch (ie.
https://patchwork.kernel.org/patch/9128509/) was actually correct,
because it didn't put too much code under the CPU offline/online
locking. :-)
