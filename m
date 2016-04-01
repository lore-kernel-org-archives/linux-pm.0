From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] sched/fair: call cpufreq hook in additional paths
Date: Fri, 1 Apr 2016 23:53:58 +0200
Message-ID: <20160401215358.GC2906@worktop>
References: <1458858367-2831-1-git-send-email-smuckle@linaro.org>
 <20160331075951.GG3408@twins.programming.kicks-ass.net>
 <20160331091426.GE11035@twins.programming.kicks-ass.net>
 <56FEEAD0.2040108@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48562 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbcDAVyH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 17:54:07 -0400
Content-Disposition: inline
In-Reply-To: <56FEEAD0.2040108@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Byungchul Park <byungchul.park@lge.com>

On Fri, Apr 01, 2016 at 02:40:32PM -0700, Steve Muckle wrote:
> On 03/31/2016 02:14 AM, Peter Zijlstra wrote:
> > On Thu, Mar 31, 2016 at 09:59:51AM +0200, Peter Zijlstra wrote:
> >>> > >  - passing an argument into attach_entity_load_avg() to indicate                                                 
> >>> > >    whether calling the cpufreq hook is necessary
> >>> > > 
> >>> > > Both of these are ugly in their own way but would avoid a runtime
> >>> > > cost. Opinions welcome.
> >> > 
> >> > Lemme see what this would look like while I throw the below into the bit
> >> > bucket.
> > OK, so the below looks a lot more sane; and has the surprising benefit
> > of actually shrinking the text size..
> > 
> >   43675    1226      24   44925    af7d defconfig-build/kernel/sched/fair.o.base
> >   43723    1226      24   44973    afad defconfig-build/kernel/sched/fair.o.patch
> >   43595    1226      24   44845    af2d defconfig-build/kernel/sched/fair.o.patch+
> > 
> > ---
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> 
> Cool, thanks. Shall I fold this into this patch and resend the series of
> 3? Or would you prefer to add this change separately?

I think I've got it folded into your third patch, I haven't published
the queue yet though; I'll try and sort through the stuff I have on
Monday or so.
