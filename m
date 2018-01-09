From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [BUG] schedutil governor produces regular max freq spikes because
 of lockup detector watchdog threads
Date: Tue, 9 Jan 2018 02:17:33 +0100
Message-ID: <CAJZ5v0hnY+2pL0LGAeQv7xZcYN42+_azKH9cGGLvPU1iO6fmWg@mail.gmail.com>
References: <1515184652.6892.26.camel@nxp.com> <CAJZ5v0gOwgr2yB_YY8ian6GXjdic3zRUa4S9vHNmudC8Khc5cA@mail.gmail.com>
 <20180108040121.GB4003@vireshk-i7> <1515417622.3207.5.camel@nxp.com>
 <20180108151450.GA30937@e110439-lin> <1515426694.3207.28.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:42303 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932271AbeAIBRf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jan 2018 20:17:35 -0500
In-Reply-To: <1515426694.3207.28.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Mon, Jan 8, 2018 at 4:51 PM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On Mon, 2018-01-08 at 15:14 +0000, Patrick Bellasi wrote:
>> On 08-Jan 15:20, Leonard Crestez wrote:
>> > On Mon, 2018-01-08 at 09:31 +0530, Viresh Kumar wrote:
>> > > On 05-01-18, 23:18, Rafael J. Wysocki wrote:
>> > > > On Fri, Jan 5, 2018 at 9:37 PM, Leonard Crestez  wrote:
>> > > > >
>> > > > > When using the schedutil governor together with the softlockup detector
>> > > > > all CPUs go to their maximum frequency on a regular basis. This seems
>> > > > > to be because the watchdog creates a RT thread on each CPU and this
>> > > > > causes regular kicks with:
>> > > > >
>> > > > >     cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
>> > > > >
>> > > > > The schedutil governor responds to this by immediately setting the
>> > > > > maximum cpu frequency, this is very undesirable.
>> > > > >
>> > > > > The issue can be fixed by this patch from android:
>> > > > >
>> > > > > The patch stalled in a long discussion about how it's difficult for
>> > > > > cpufreq to deal with RT and how some RT users might just disable
>> > > > > cpufreq. It is indeed hard but if the system experiences regular power
>> > > > > kicks from a common debug feature they will end up disabling schedutil
>> > > > > instead.
>
>> > > > Patrick has a series of patches dealing with this problem area AFAICS,
>> > > > but we are currently integrating material from Juri related to
>> > > > deadline tasks.
>> > >
>> > > I am not sure if Patrick's patches would solve this problem at all as
>> > > we still go to max for RT and the RT task is created from the
>> > > softlockup detector somehow.
>
>> > I assume you're talking about the series starting with
>> > "[PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates"
>> >
>> > I checked and they have no effect on this particular issue (not
>> > surprising).
>
>> Yeah, that series was addressing the same issue but for one specific
>> RT thread: the one used by schedutil to change the frequency.
>> For all other RT threads the intended behavior was still to got
>> to max... moreover those patches has been superseded by a different
>> solution which has been recently proposed by Peter:
>>
>>    20171220155625.lopjlsbvss3qgb4d@hirez.programming.kicks-ass.net
>>
>> As Viresh and Rafael suggested, we should eventually consider a
>> different scheduling class and/or execution context for the watchdog.
>> Maybe a generalization of Juri's proposed SCHED_FLAG_SUGOV flag for
>> DL tasks can be useful:
>>
>>    20171204102325.5110-4-juri.lelli@redhat.com
>>
>> Although that solution is already considered "gross" and thus perhaps
>> it does not make sense to keep adding special DL tasks.
>>
>> Another possible alternative to "tag an RT task" as being special, is
>> to use an API similar to the one proposed by the util_clamp RFC:
>>
>>    20170824180857.32103-1-patrick.bellasi@arm.com
>>
>> which would allow to define what's the maximum utilization which can
>> be required by a properly configured RT task.
>
> Marking the watchdog as somehow "not important for performance" would
> probably work, I guess it will take a while to get a stable solution.
>
> BTW, in the current version it seems the kick happens *after* the RT
> task executes. It seems very likely that cpufreq will go back down
> before a RT executes again, so how does it help? Unless most of the
> workload is RT. But even in that case aren't you better off with
> regular scaling since schedutil will notice utilization is high anyway?
>
> Scaling freq up first would make more sense except such operations can
> have very high latencies anyway.

I guess what happens is that it takes time to switch the frequency and
the RT task gives the CPU away before the frequency actually changes.

That is a problem, but we don't know in advance how much time the RT
task is going to run, so it is rather hard to avoid this entirely.  It
might be possible to cancel the freq switch if the RT task goes to
sleep when it is still pending, but that's rather tricky
synchronization-wise.  It may be worth trying as a proof of concept,
though.

> Viresh suggested earlier to move watchdog to DL but apparently per-cpu
> threads are not supported. sched_setattr fails on this check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
> /kernel/sched/core.c#n4167

Actually, how often does the softlockup watchdog run?
