From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 38/46] sched: scheduler-driven cpu frequency
 selection
Date: Tue, 15 Sep 2015 15:45:56 +0200
Message-ID: <20150915134556.GD16853@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
 <20150815123531.GE10304@worktop.programming.kicks-ass.net>
 <55E99C50.8030306@arm.com>
 <55F6EE6F.6070209@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47426 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbbIONqI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 09:46:08 -0400
Content-Disposition: inline
In-Reply-To: <55F6EE6F.6070209@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Sep 14, 2015 at 04:57:35PM +0100, Juri Lelli wrote:
> On 04/09/15 14:27, Juri Lelli wrote:
> > So, just to recall what we discussed at LPC (I have Mike's slides
> > at hand :-)). It seems that key points are:
> > 
> > 1- we agreed that locking in cpufreq core has to change as we
> >    have to access it from scheduler hot-paths; what Peter is
> >    proposing above looks viable to me, what others (way more
> >    confident then me with cpufreq inners) say?

Rafael had some thoughts IIRC.

> > 2- the interface has to be extended as we have to let other
> >    scheduling classes drive freq selection too; I guess that how
> >    we do aggregation depends on the nature of sched classes,
> >    but we didn't really reach any sort of agreement here; is
> >    this anyway something we can focus on after fixing locking?

Right, that's going to be interesting. Reading through that SchedTune
thread has been educational (I really had no clue what it was on about
on initial reading, the discussion that's on-going clarified a lot).

It seems that even the fair class might want to provide minimal hints
due to that 'boost' / 'interactive' nonsense.

> > 3- the interface should also support peripheral devices; this
> >    seems a interesting feature to have, but how about we postpone
> >    it after we've got previous points right?

Agreed, that's a can of worms :-) Better start with the 'simple' things.

That said; ISTR a patch set on this topic recently.

  lkml.kernel.org/r/1441904972-5809-1-git-send-email-javi.merino@arm.com
