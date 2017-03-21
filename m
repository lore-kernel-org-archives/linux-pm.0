From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 14:25:29 +0000
Message-ID: <20170321142529.GD11054@e110439-lin>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan>
 <CAKfTPtB0WpvSz66UNK5HNQF8W-PKCYNyRSCzz9L9WRAKNy+KYw@mail.gmail.com>
 <20170321132253.vjp7f72qkubpttmf@hirez.programming.kicks-ass.net>
 <CAKfTPtBp7GevDfnOTrOnrc79XP1mbY0onq=uh4Aw2tGu-DgHGw@mail.gmail.com>
 <20170321140325.gf64gc7eaqu335t5@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170321140325.gf64gc7eaqu335t5@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 21-Mar 15:03, Peter Zijlstra wrote:
> On Tue, Mar 21, 2017 at 02:37:08PM +0100, Vincent Guittot wrote:
> > On 21 March 2017 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > For the not overloaded case, it makes sense to immediately update to
> > OPP to be aligned with the new utilization of the CPU even if it was
> > not idle in the past couple of ticks
> 
> Yeah, but we cannot know. Also, who cares?
> 
> > > does exactly that. Note that the lack of idle time is an exact
> > > equivalent of 100% utilized.
> > >
> > > So even while we cannot currently detect the 100% utilized state through
> > > the running state tracking; because averages etc.. we can detect the
> > > lack of idle time.
> > 
> > But after how much lack of idle time do we consider that we are overloaded ?
> 
> 0 :-)

If we should use "utilization" this time can be non 0 and it depends
for example on how long PELT takes to build up a utilization value
which marks the CPU as "overutilized"... thus we already have a
suitable time at least for CFS tasks.

> Note that utilization is an absolute metric, not a windowed one. That
> is, there is no actual time associated with it. Now, for practical
> purposes we end up using windowed things in many places,
> 

-- 
#include <best/regards.h>

Patrick Bellasi
