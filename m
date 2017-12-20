From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Wed, 20 Dec 2017 18:27:17 +0100
Message-ID: <20171220172717.GB22246@localhost.localdomain>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <20171220125546.GI19821@e110439-lin>
 <20171220132826.kcu5zqkva5h6nmfk@hirez.programming.kicks-ass.net>
 <5156588.pkDhmtr2np@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5156588.pkDhmtr2np@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 20/12/17 15:47, Rafael J. Wysocki wrote:
> On Wednesday, December 20, 2017 2:28:26 PM CET Peter Zijlstra wrote:
> > On Wed, Dec 20, 2017 at 12:55:46PM +0000, Patrick Bellasi wrote:
> > > On 20-Dec 09:31, Peter Zijlstra wrote:
> > 
> > > > Didn't juri have patches to make DL do something sane? But yes, I think
> > > > those flags are part of the problem.
> > > 
> > > He recently reposted them here:
> > > 
> > >   https://lkml.kernel.org/r/20171204102325.5110-1-juri.lelli@redhat.com
> > 
> > Yeah, just found them and actually munged them into my queue; did all
> > the modifications you suggested too. Lets see if it comes apart.
> 
> Good, because I think that the Juri's patches should go in first.
> 

Thanks Peter for taking the patches. I was actually waiting for the flag
thing to be resolved to post again. :/

Anyway, let us know how it goes and if I need to make further changes.

Best,

- Juri
