From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 15:58:08 +0100
Message-ID: <20170321145808.GS3093@worktop>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan>
 <CAKfTPtB0WpvSz66UNK5HNQF8W-PKCYNyRSCzz9L9WRAKNy+KYw@mail.gmail.com>
 <20170321132253.vjp7f72qkubpttmf@hirez.programming.kicks-ass.net>
 <CAKfTPtBp7GevDfnOTrOnrc79XP1mbY0onq=uh4Aw2tGu-DgHGw@mail.gmail.com>
 <20170321140325.gf64gc7eaqu335t5@hirez.programming.kicks-ass.net>
 <CAKfTPtALorn7HNpz4LOfWWSc3u+9y5iHB5byzfTHGQXDA+tVJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:57554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756757AbdCUO7R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 10:59:17 -0400
Content-Disposition: inline
In-Reply-To: <CAKfTPtALorn7HNpz4LOfWWSc3u+9y5iHB5byzfTHGQXDA+tVJQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Tue, Mar 21, 2017 at 03:16:19PM +0100, Vincent Guittot wrote:
> On 21 March 2017 at 15:03, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Mar 21, 2017 at 02:37:08PM +0100, Vincent Guittot wrote:
> > > On 21 March 2017 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > For the not overloaded case, it makes sense to immediately update to
> > > OPP to be aligned with the new utilization of the CPU even if it was
> > > not idle in the past couple of ticks
> >
> > Yeah, but we cannot know. Also, who cares?
> >
> 
> embedded system that doesn't want to stay at higest OPP if significant part
> of the utilzation has moved away as an example
> AFAICT, schedutil tries to select the best OPP according to the current
> utilization of the CPU so if the utilization decreases, the OPP should also
> decrease

Sure I get that; but given the lack of crystal ball instructions we
cannot know if this is the case or not.

And if we really dropped below 100% utilization, we should hit idle
fairly soon.
