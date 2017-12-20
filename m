From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization update flags
Date: Wed, 20 Dec 2017 15:47:23 +0100
Message-ID: <5156588.pkDhmtr2np@aspire.rjw.lan>
References: <cover.1513158452.git.viresh.kumar@linaro.org> <20171220125546.GI19821@e110439-lin> <20171220132826.kcu5zqkva5h6nmfk@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171220132826.kcu5zqkva5h6nmfk@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, juri.lelli@redhat.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 20, 2017 2:28:26 PM CET Peter Zijlstra wrote:
> On Wed, Dec 20, 2017 at 12:55:46PM +0000, Patrick Bellasi wrote:
> > On 20-Dec 09:31, Peter Zijlstra wrote:
> 
> > > Didn't juri have patches to make DL do something sane? But yes, I think
> > > those flags are part of the problem.
> > 
> > He recently reposted them here:
> > 
> >   https://lkml.kernel.org/r/20171204102325.5110-1-juri.lelli@redhat.com
> 
> Yeah, just found them and actually munged them into my queue; did all
> the modifications you suggested too. Lets see if it comes apart.

Good, because I think that the Juri's patches should go in first.

Then we'll see what's still missing.

> > > > - From the utilization handler, we check runqueues of all three sched
> > > >   classes to see if they have some work pending (this can be done
> > > >   smartly by checking only RT first and skipping other checks if RT
> > > >   has some work).
> > > 
> > > No that's wrong. DL should provide a minimum required based on existing
> > > reservations, we can add the expected CFS average on top and request
> > > that.
> > > 
> > > And for RT all we need to know is if current is of that class, otherwise
> > > we don't care.
> > 
> > So, this:
> > 
> >    https://marc.info/?i=20171130114723.29210-3-patrick.bellasi%40arm.com
> 
> Right, I was actually looking for those patches, but I'm searching
> backwards and hit upon Juri's patches first.
> 
> > was actually going in this direction, although still working on top of
> > flags to not change the existing interface too much.
> > 
> > IMO, the advantage of flags is that they are a sort-of "pro-active"
> > approach, where the scheduler notify sensible events to schedutil.
> > But keep adding flags seems to overkilling to me too.
> > 
> > If we remove flags then we have to query the scheduler classes "on
> > demand"... but, as Peter suggests, once we have DL bits Juri posted,
> > the only issue if to know if an RT task is running.
> > This the patch above can be just good enough, with no flags at all and
> > with just a check for current being RT (or DL for the time being).
> 
> Well, we still need flags for crap like IO-WAIT IIRC. That's sugov
> internal state and not something the scheduler actually already knows.

Not only sugov to be precise, but yes.

Thanks,
Rafael
