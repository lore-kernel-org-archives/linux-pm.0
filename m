From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 38/46] sched: scheduler-driven cpu frequency
 selection
Date: Tue, 15 Sep 2015 17:22:28 +0100
Message-ID: <55F845C4.5020904@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
 <20150815123531.GE10304@worktop.programming.kicks-ass.net>
 <55E99C50.8030306@arm.com> <55F6EE6F.6070209@arm.com>
 <20150915134556.GD16853@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:7294 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751646AbbIOQVW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Sep 2015 12:21:22 -0400
In-Reply-To: <20150915134556.GD16853@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 15/09/15 14:45, Peter Zijlstra wrote:
> On Mon, Sep 14, 2015 at 04:57:35PM +0100, Juri Lelli wrote:
>> On 04/09/15 14:27, Juri Lelli wrote:
>>> So, just to recall what we discussed at LPC (I have Mike's slides
>>> at hand :-)). It seems that key points are:
>>>
>>> 1- we agreed that locking in cpufreq core has to change as we
>>>    have to access it from scheduler hot-paths; what Peter is
>>>    proposing above looks viable to me, what others (way more
>>>    confident then me with cpufreq inners) say?
> 
> Rafael had some thoughts IIRC.
>

Yep, right. Rafael, could you please refresh our memory here? Do
you foresee any problem trying to go as Peter suggested?

>>> 2- the interface has to be extended as we have to let other
>>>    scheduling classes drive freq selection too; I guess that how
>>>    we do aggregation depends on the nature of sched classes,
>>>    but we didn't really reach any sort of agreement here; is
>>>    this anyway something we can focus on after fixing locking?
> 
> Right, that's going to be interesting. Reading through that SchedTune
> thread has been educational (I really had no clue what it was on about
> on initial reading, the discussion that's on-going clarified a lot).
> 

That's good stuff yes.

> It seems that even the fair class might want to provide minimal hints
> due to that 'boost' / 'interactive' nonsense.
> 

That's basically what we are doing with the SchedDVFS + SchedTune thing.
Sometimes is helpful to be able to fake signals in order to get better
performance. The current interface already allows us to do that, but
we'll have to figure out how this need takes into account other classes
as well (like this being still best effort and others having QoS
requirements).

>>> 3- the interface should also support peripheral devices; this
>>>    seems a interesting feature to have, but how about we postpone
>>>    it after we've got previous points right?
> 
> Agreed, that's a can of worms :-) Better start with the 'simple' things.
> 

Good. :-)

> That said; ISTR a patch set on this topic recently.
> 
>   lkml.kernel.org/r/1441904972-5809-1-git-send-email-javi.merino@arm.com
> 

Yep, that has to be factored in as well eventually; we are actually
trying to keep that in our minds as we proceed further with development
(Javi sits a desk far from me ;-)), but, as you said, simpler things first.

Thanks,

- Juri

