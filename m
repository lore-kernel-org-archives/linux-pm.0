From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] sched/core: Fix up load metric exposed to cpuidle
Date: Thu, 29 Sep 2016 15:22:13 +0200
Message-ID: <1597108.oRJKXZmdK4@vostro.rjw.lan>
References: <57E5A37B.8010802@nvidia.com> <20160923220636.GG5012@twins.programming.kicks-ass.net> <57E5B047.5010700@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44453 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1754226AbcI2NPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2016 09:15:47 -0400
In-Reply-To: <57E5B047.5010700@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, Peter Boonstoppel <pboonstoppel@nvidia.com>, Colin Cross <ccross@android.com>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@vger.kernel.org

On Friday, September 23, 2016 03:44:23 PM Sai Gurrappadi wrote:
> 
> On 09/23/2016 03:06 PM, Peter Zijlstra wrote:> On Fri, Sep 23, 2016 at 02:49:47PM -0700, Sai Gurrappadi wrote:
> >> When triaging a performance degradation of ~5% on some use cases between
> >> our k3.18 and k4.4 trees, we found that the menu cpuidle governor on k4.4
> >> was way more aggressive when requesting for deeper idle states. It would
> >> often get it wrong though resulting in perf loss.
> >>
> >> The menu governor tries to bias picking shallower idle states based on the
> >> historical load on the CPU. The busier the CPU, the shallower the idle
> >> state.
> >>
> >> However, after commit "3289bdb sched: Move the loadavg code to a more
> > 
> > The normal quoting style is:
> > 
> >   3289bdb42988 ("sched: Move the loadavg code to a more obvious location")
> > 
> > Use at least 12 SHA1 characters, collisions on 7-8 char abbrevs have
> > already happened.
> > 
> > Also, that was more than a year ago, nobody noticed?
> 
> Ah, sorry. Will do next time.
> 
> > 
> >> obvious location", the load metric it looks at is rq->load.weight which is
> >> the instantaneous se->load.weight sum for top level entities on the rq
> >> which on idle entry is always 0 (for the common case at least) because
> >> there is nothing on the cfs rq.
> >>
> >> The previous metric the menu governor used was rq->cpu_load[0] which is a
> >> snap shot of the weighted_cpuload at the previous load update point so it
> >> isn't always 0 on idle entry.
> > 
> > Right, basically a 'random' number :)
> 
> Indeed. I never really understood how things worked with the cpu_load stuff
> given how random it seemed.

Well, the choice seems to be between "better performance, but we don't really
know how we get that" and "more idle and we understand how it works".

Honestly, I prefer to understand how it works in the first place.

Of course, the fact that the metric used currently is (almost) always 0 is a
problem, but it doesn't seem like going back to the old one would be a huge
improvement either.

Thanks,
Rafael

