From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: sched-freq locking
Date: Tue, 19 Jan 2016 17:24:49 -0800
Message-ID: <569EE1E1.3050407@linaro.org>
References: <56984C30.8040402@linaro.org> <20160115104051.GP18603@e106622-lin>
 <569D568D.5000500@linaro.org>
 <CAEG3pNDoDHpgO7WdC8n7C8Ri+KNKZqOi9rKHMkTV0c5dkyevOw@mail.gmail.com>
 <CAKfTPtCYUWBm_=GQ-NLLZ01xJqG+83vy4uapxRLjqMx_61HSew@mail.gmail.com>
 <569E90CF.9050503@linaro.org>
 <CAEG3pND5kHqJhrvwVjsnCnfT-nSrV8SrUaNk2p=ZfEx0MmmB=A@mail.gmail.com>
 <569EB225.4040707@linaro.org>
 <CAEG3pNBgpsdX8Lk7_3nHd31_bsq2sLB_f+=4_xiFFbiAWiKsxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33537 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934258AbcATBYw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 20:24:52 -0500
Received: by mail-pf0-f172.google.com with SMTP id e65so185264711pfe.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2016 17:24:52 -0800 (PST)
In-Reply-To: <CAEG3pNBgpsdX8Lk7_3nHd31_bsq2sLB_f+=4_xiFFbiAWiKsxg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 01/19/2016 03:40 PM, Michael Turquette wrote:
> Right, this was _the_ original impetus behind the design decision to
> muck around with struct cpufreq_policy in the hot path which goes al
> the way back to v1.
> 
> An alternative thought is that we can make copies of the relevant bits
> of struct cpufreq_policy that we do not expect too change often. These
> will not require any locks as they are mostly read-only data on the
> scheduler side of the interface. Or we could even go all in and just
> make local copies of the struct directly, during the GOV_START
> perhaps, with:

I believe this is a good first step as it avoids reworking a huge amount
of locking and can get us to something functionally correct. It is what
I had proposed earlier, copying the enabled CPUs and freq table in
during the governor start callback. Unless there are objections to it
I'll add it to the next schedfreq RFC.

> 
...
> 
> Well if we're going to try an optimize out every single false-positive
> wakeup then I think that the cleanest long term solution would be
> rework the per-policy locking around struct cpufreq_policy to use a
> raw spinlock.

It would be nice if the policy lock was a spinlock but I don't know how
easy that is. From a quick look at cpufreq there's a blocking notifier
chain that's called with rwsem held, so it looks messy. Potentially long
term indeed.

>> Also it'd be good I think to avoid building in an assumption that we'll
>> never want to run solely in the fast (atomic) path. Perhaps ARM won't,
>> and x86 may never use this, but it's reasonable to think another
>> platform might come along which uses cpufreq and has the capability to
>> kick off cpufreq transitions swiftly and without sleeping. Maybe ARM
>> platforms will evolve to have that capability.
> 
> The current design of the cpufreq subsystem and its interfaces have
> made this choice for us. sched-freq is just another consumer of
> cpufreq, and until cpufreq's own locking scheme is improved then we
> have no choice.

I did not word that very well - I should have said, we should avoid
building in an assumption that we never want to try and run in the fast
path.

AFAICS, once we've calculated that a frequency change is required we can
down_write_trylock(&policy->rwsem) in the fast path and go ahead with
the transition, if the trylock succeeds and the driver supports fast
path transitions. We can fall back to the slow path (waking up the
kthread) if that fails.

> This discussion is pretty useful. Should we Cc lkml to this thread?

Done (added linux-pm, PeterZ and Rafael as well).

thanks,
Steve
