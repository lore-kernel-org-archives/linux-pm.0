From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 00/19] cpufreq locking cleanups and documentation
Date: Tue, 12 Jan 2016 10:46:55 +0000
Message-ID: <20160112104655.GC11451@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <2391932.X0YjLeUrXE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33353 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758791AbcALKqf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Jan 2016 05:46:35 -0500
Content-Disposition: inline
In-Reply-To: <2391932.X0YjLeUrXE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

Hi Rafael,

On 11/01/16 23:45, Rafael J. Wysocki wrote:
> On Monday, January 11, 2016 05:35:41 PM Juri Lelli wrote:
> > Hi all,
> > 
> > In the context of the ongoing discussion about introducing a simple platform
> > energy model to guide scheduling decisions (Energy Aware Scheduling [1])
> > concerns have been expressed by Peter about the component in charge of driving
> > clock frequency selection (Steve recently posted an update of such component
> > [2]): https://lkml.org/lkml/2015/8/15/141.
> > 
> > The problem is that, with this new approach, cpufreq core functions need to be
> > accessed from scheduler hot-paths and the overhead associated with the current
> > locking scheme might result to be unsustainable. 
> > 
> > Peter's proposed approach of using RCU logic to reduce locking overhead seems
> > reasonable, but things may not be so straightforward as originally thought. The
> > very first thing I actually realized when I started looking into this is that
> > it was hard for me to understand which locking mechanism was protecting which
> > data structure. As mostly a way to build a better understanding of the current
> > cpufreq locking scheme and also as preparatory work for implementing RCU logic,
> > I came up with this set of patches. In fact, at this stage, I would like each
> > patch to be considered as a question I'm asking rather than a proposed change,
> > thus the RFC tag for the series; with the intent of documenting current locking
> > scheme and modifying it a bit in order to make RCU logic implementation easier.
> > Actually, as you'll soon notice, I didn't really start from scratch. Mike
> > shared with me some patches he has been developing while looking at the same
> > problem. I've given Mike attribution for the patches that I took unchanged from
> > him, with thanks for sharing his findings with me.
> > 
> > High level description of patches:
> > 
> >  o [01-04] cleanup and move code around to make things (hopefully) cleaner
> >  o [05-14] insert lockdep assertions and fix uncovered erroneous situations
> >  o [15-18] remove overkill usage of locking mechanism
> >  o 19      adds documentation for the cleaned up locking scheme
> > 
> > With Viresh' tests [3] on both arm TC2 and arm64 Juno boards I'm not seeing
> > anything bad happening. However, coverage is really small (as is my personal
> > confidence of not breaking things for other confs :-)).
> > 
> > This set is based on top of linux-pm/linux-next as of today and it is also
> > available from here:
> 
> Due to the merge window in progress I have more urgent things to do than
> looking at this material right now.  Sorry about that.
> 

No problem, I understand that.

> I may be able to look at it towards the end of the week.
> 

Great! Viresh is already doing his review, so I have things to work on
until you get time to have a look. Looking forward to receive your
comments as well.

Best,

- Juri
